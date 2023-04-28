|%
++  default-theme
  ^-  @t
  '''
  h1, h2, h3, h4, h5, h6 {
    color : black;
    text-align: center;
  }
  p {
    text-align: justify;
  }
  img {
    margin: auto;
    max-height: 300px;
    display: block;
  }
  body {
    margin : 7vw;
    font-size : 3vh;
    color: #393939;
    background-color: white;
  }
  '''
::
++  add-style
  |=  css=@t
  ^-  @t
  (cat 3 (cat 3 '<style>' css) '<style/>')
::
++  http-response-cards
  |=  [id=@tas hed=response-header:http data=(unit octs)]
  ^-  (list card:agent:gall)
  =/  paths  [/http-response/[id]]~
  :~  [%give %fact paths %http-response-header !>(hed)]
      [%give %fact paths %http-response-data !>(data)]
      [%give %kick paths ~]
  ==
++  build-rss
  |=  [files=(map path [html=@t md=@t theme=@tas]) our=@p]
  %-  crip
  ^-  tape
  ;:  weld
      "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\0a"
      "<rss version=\"2.0\">\0a"
      "<channel>\0a"
      ::
      "<title>{<our>}'s Blog</title>\0a"
      "<description>RSS Feed</description>\0a"
      "<link>https://{<`tape`(slag 1 (scow %p our))>}.arvo.network/</link>\0a"
      ::
      ^-  tape
      %-  zing
      %+  turn  ~(tap by files)
      |=  [=path html=@t md=@t theme=@tas]
      ;:  weld
          "<item>\0a"
          "<title>{<(grab-title path)>}</title>\0a"
          "<description>{<(grab-desc html md)>}</description>\0a"
          "<link>https://{<`tape`(slag 1 (scow %p our))>}.arvo.network/{<path>}</link>\0a"
          "<author>{<our>}</author>\0a"
          "</item>\0a"
      ==
      ::
      "</channel>\0a"
      "</rss>\0a"
  ==
++  grab-title
  |=  =path
  ^-  tape
  ::  XXX this is a hack
  (trip (snag (dec (lent path)) path))
++  grab-desc
  |=  [html=@t md=@t]
  ^-  tape
  ::  XXX this is a hack
  =/  text  %-  trip  ?~  html  md  html
  =/  index  (find "\0a" text)
  ?~  index  "Blog Post"
  (scag (need index) text)
  ::=/  text  %-  trip  ?~  html  md  html
  ::=/  index  (find "\0a" text)
  ::?~  index  "No description provided."
  ::=/  endex  (find "." (slag (need index) text))
  ::?~  endex  "No description provided."
  ::(scag (need endex) (slag (need index) text))
--

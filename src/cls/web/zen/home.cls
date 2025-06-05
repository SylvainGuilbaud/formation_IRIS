Class web.zen.home Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "web.zen.app";

/// Displayed name of this page.
Parameter PAGENAME = "My Home Page";

/// Domain used for localization.
Parameter DOMAIN;

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
    /* style for title bar */
    #title {
      background: #C5D6D6;
      color: black;
      font-family: Verdana;
      font-size: 1.5em;
      font-weight: bold;
      padding: 5px;
      border-bottom: 1px solid black;
      text-align: center;
      }
    </style>
}

/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="">
      <html id="title">home</html>
      <vgroup width="100%">
        <!-- put page contents here -->
      </vgroup>
    </page>
}

}

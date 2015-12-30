<xsl:stylesheet version='1.0'
 xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
 xmlns='http://www.w3.org/1999/xhtml'>

  <xsl:param name="name"/>
  <xsl:param name="username"/>
  <xsl:param name="picture"/>
  <xsl:param name="secret"/> <!-- zachB's edit: If this has the value of the user password, then the user's password should be displayed in the popup. -->

  <xsl:template name="site">
    <xsl:param name="css"/>
    <xsl:param name="js"/>
    <xsl:param name="onload"/>
    <xsl:param name="secret"/>

    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#10;</xsl:text>
    <html>
      <head>
        <title>Copyleft Games | Google Code-In 2015</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width"/>
        <link rel="icon" type="image/x-icon" href="/favicon.ico"/>
        <link rel="stylesheet" type="text/css"
              href="https://media.copyleftgames.org/css/site.css"/>
        <link rel="stylesheet" type="text/css" href="home.css"/>
        <xsl:copy-of select="$css"/>
        <script type="text/javascript">
          <xsl:text disable-output-escaping='yes'>
          //  &lt;![CDATA[
            var dimmingMask = null;
            window.onload () {
                dimmingMask = document.getElementById("dimming-mask");
            };

            function openPopup() {
                dimmingMask.className = "dimming-mask-active";
            }

            function closePopup() {
                dimmingMask.className = "";
            }

            function closeDimMask(event) {
                if (event.target === dimmingMask) {
                    closePopup();
                }
            }

            function scrollTest() {
              var sc = window.pageYOffset;
              if (sc &lt; 192) {
                document.body.className = "stickynav";
              } else {
                document.body.className = "";
                var gear = document.getElementById("gcilogogear");
                gear.setAttribute("transform", "rotate(" + sc * -1.75 + " 28 28)");
              }
            }
            function start() {
              rehash();
            }
            function rehash() {
              var hash = window.location.hash
              var match = false;
              var tabs = document.getElementById("navmenu").childNodes;
              for (i = 0; i &lt; tabs.length; i++) {
                var tab = tabs[i].id;
                if ("#" + tab == hash) {
                  match = true;
                  var main = document.getElementById(tab + "-main");
                  if (main) main.className = "active";
                }
                else {
                  var main = document.getElementById(tab + "-main");
                  if (main) main.className = "hidden";
                }
              }
              if (!match) window.location.hash = "home";
            }

             ]]&lt;
          </xsl:text>
        </script>

        <xsl:copy-of select="$js"/>

      </head>
      <body onscroll="scrollTest()" onhashchange="rehash();" class="">
        <xsl:if test="$onload != ''">
          <xsl:attribute name="onload">
            <xsl:value-of select="$onload"/>
          </xsl:attribute>
        </xsl:if>

        <header>
          <div id="logo">
            <a href="https://www.copyleftgames.org/">
              <img src="https://media.copyleftgames.org/img/cgg-logo-64.png"
                   alt="" width='32' height='32'/>
              <span id="logotext">
                <xsl:text>Copyleft Games</xsl:text>
              </span>
            </a>
          </div>
          <xsl:choose>
            <xsl:when test="$username=''">
              <div id="login">
                <a href="/login">LOGIN</a>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <!-- zachB's edit: Added an onclick function so you can click your photo to open the popup -->
              <img id="userpic" src="{$picture}?sz=32" width="32" height="32" alt="{$name}" onclick="openPopup()"/>
              <div id="userinfo">
                <div class="jid">
                  <span class="jid-user">
                    <xsl:value-of select="$username"/>
                  </span>
                  <span class="jid-host">
                    <xsl:text>@gci.copyleftgames.org</xsl:text>
                  </span>
                </div>

                <!-- zachB's edit: Added an element to open the popup -->
                <span id="view-user-info" onclick="openPopup()">
                  <xsl:text>User Info</xsl:text>
                </span>

                <a href="/logout">Logout</a>               
              </div>

            </xsl:otherwise>
          </xsl:choose>
        </header>
        <nav>
          <header>
            <a href="https://developers.google.com/open-source/gci/"
               style="position: relative; z-index: 1;">
              <svg id="gcilogo" width="345" height="56" viewBox="0 0 345 56" version="1.1">
                <circle r="28" cy="28" cx="28" style="fill:#ffffff;"/>
                <path id="gcilogogear" style="fill:#00aaff" d="m 22.7,12.1 c -0.7,0.3 -1.5,0.6 -2.2,0.9 0.6,4.2 -3.5,7.9 -7.5,7.5 -0.3,0.7 -0.6,1.4 -0.9,2.2 3.3,2.6 3.1,8.0 0.0,10.6 0.3,0.7 0.6,1.4 0.9,2.2 4.2,-0.6 7.9,3.5 7.5,7.5 0.7,0.3 1.4,0.6 2.1,0.9 2.6,-3.4 8.0,-3.1 10.6,-0.0 0.7,-0.3 1.4,-0.6 2.2,-0.9 -0.6,-4.2 3.5,-7.9 7.5,-7.5 0.3,-0.7 0.6,-1.4 0.9,-2.1 -3.4,-2.6 -3.1,-8.0 -0.0,-10.6 -0.3,-0.7 -0.6,-1.4 -0.9,-2.2 -4.2,0.6 -7.9,-3.5 -7.5,-7.5 -0.7,-0.3 -1.4,-0.6 -2.1,-0.9 -2.6,3.3 -7.9,3.3 -10.5,-0.0 z"/>
                <circle style="fill:#ffffff;" cx="28" cy="28" r="7.5"/>
                <circle style="fill:#ff8800;" cx="28" cy="28" r="4.5"/>
                <path id="gcilogotext" style="fill:#ddeeff" d="m 219.6,42.93 c -4.79,-1.29 -8.49,-4.8 -10.07,-9.56 -1.82,-5.47 -0.29,-11.58 3.88,-15.5 2.89,-2.72 5.87,-3.86 10.09,-3.87 2.69,0.0 4.4,0.38 6.44,1.45 1.41,0.74 3.33,2.48 3.75,2.96 l -2.31,2.39 -1.06,-0.99 c -3.98,-3.72 -11.22,-3.21 -15.07,1.07 -3.04,3.38 -3.66,9.02 -1.48,13.42 0.79,1.6 2.92,3.71 4.54,4.49 1.41,0.68 3.72,1.24 5.14,1.25 2.52,0.01 5.58,-1.2 7.55,-2.98 l 1.18,-1.06 2.49,2.49 -1.14,1.05 c -1.49,1.38 -3.18,2.39 -5.18,3.09 -2.26,0.79 -6.38,0.93 -8.75,0.29 z m 23.5,0.0 c -5.81,-1.86 -8.46,-8.74 -5.65,-14.7 2.83,-6.0 11.35,-7.25 15.94,-2.34 4.23,4.52 3.49,12.39 -1.49,15.83 -2.34,1.61 -5.98,2.11 -8.8,1.21 z m 4.54,-2.96 c 2.63,-0.62 4.33,-2.59 4.85,-5.61 0.47,-2.76 -0.53,-5.42 -2.65,-7.04 -1.2,-0.91 -2.45,-1.25 -4.13,-1.12 -3.2,0.25 -5.54,2.82 -5.79,6.36 -0.25,3.55 1.69,6.58 4.76,7.41 1.33,0.36 1.46,0.36 2.96,0.01 z m 16.88,2.87 c -1.81,-0.76 -2.95,-1.61 -3.91,-2.89 -1.65,-2.22 -2.22,-3.93 -2.23,-6.68 -0.01,-3.48 0.99,-5.91 3.34,-8.08 3.37,-3.12 8.73,-3.07 11.6,0.11 0.42,0.46 0.82,0.84 0.82,0.84 l -0.1,-11.7 3.58,0.0 0.0,28.47 -3.31,0.0 0.0,-2.95 c -1.33,2.65 -6.61,4.19 -9.79,2.86 z m 5.94,-3.21 c 1.39,-0.61 2.4,-1.64 3.1,-3.15 0.55,-1.2 0.63,-1.66 0.64,-3.37 0.0,-1.68 -0.09,-2.18 -0.57,-3.22 -1.18,-2.54 -2.87,-3.63 -5.6,-3.62 -2.0,0.01 -3.03,0.42 -4.23,1.69 -1.41,1.5 -1.73,2.46 -1.73,5.15 0.0,2.08 0.07,2.58 0.5,3.44 1.55,3.15 4.83,4.43 7.9,3.08 z m 17.43,3.44 c -4.37,-1.45 -6.95,-5.11 -6.95,-9.86 0.0,-5.84 4.11,-10.37 9.38,-10.37 1.51,0.0 3.78,0.56 4.89,1.22 2.74,1.6 4.49,4.85 4.49,8.31 l 0.0,1.51 -7.64,0.0 -7.64,0.0 0.16,0.94 c 0.25,1.49 0.95,2.74 2.14,3.81 0.6,0.54 1.51,1.11 2.02,1.26 2.36,0.7 5.23,-0.07 6.45,-1.73 0.34,-0.47 0.69,-0.93 0.77,-1.03 0.2,-0.25 3.08,0.97 3.08,1.3 0.0,0.15 -0.4,0.8 -0.89,1.45 -0.96,1.28 -2.84,2.67 -4.15,3.08 -1.26,0.39 -5.08,0.47 -6.11,0.13 z m 8.06,-12.62 c -0.41,-2.85 -3.04,-4.09 -5.24,-4.25 -2.93,-0.24 -5.36,2.16 -6.02,4.47 z m 24.73,-6.95 3.53,0.0 0.0,19.43 -3.53,0.0 z m 7.65,19.43 -0.15,-19.43 3.37,0.0 0.05,2.65 c 0.06,0.0 0.51,-0.43 0.99,-0.96 0.52,-0.57 1.46,-1.23 2.27,-1.6 1.19,-0.55 1.64,-0.64 3.26,-0.63 2.32,0.01 3.78,0.59 5.08,2.01 1.84,1.99 1.79,2.08 1.8,10.52 l 0.0,7.46 -3.21,-0.03 -0.14,-6.94 c -0.15,-7.47 -0.12,-7.48 -1.49,-8.78 -0.77,-0.73 -1.75,-1.04 -3.27,-1.04 -1.46,0.0 -2.87,0.72 -3.79,1.94 -1.25,1.66 -1.39,2.54 -1.39,9.03 l 0.0,5.81 z m -25.09,-13.91 12.58,0.0 0.0,3.09 -12.58,0.0 z m 18.21,-9.92 c -0.59,-0.24 -1.13,-0.86 -1.43,-1.64 -0.33,-0.87 0.04,-1.94 0.93,-2.69 0.97,-0.81 2.41,-0.67 3.3,0.33 0.72,0.81 0.84,2.25 0.25,3.08 -0.62,0.89 -2.08,1.32 -3.06,0.92 z m -147.25,23.84 4.61,0.0 0.0,-30.86 -4.61,0.0 z m 16.46,-20.35 c -5.31,0.0 -9.77,4.22 -9.77,10.46 0.0,6.6 4.97,10.51 10.28,10.51 4.43,0.0 7.15,-2.42 8.77,-4.6 l -3.62,-2.41 c -0.94,1.46 -2.51,2.88 -5.13,2.88 -2.94,0.0 -4.3,-1.61 -5.14,-3.17 l 14.04,-5.83 -0.73,-1.71 c -1.36,-3.34 -4.52,-6.14 -8.71,-6.14 z m 0.18,4.03 c 1.91,0.0 3.29,1.02 3.88,2.24 l -9.38,3.92 c -0.4,-3.03 2.47,-6.16 5.5,-6.16 z M 161.1,22.64 c -5.63,0.0 -10.05,4.93 -10.05,10.46 0.0,6.3 5.13,10.48 9.96,10.48 2.98,0.0 4.57,-1.18 5.74,-2.54 l 0.0,2.07 c 0.0,3.61 -2.19,5.78 -5.51,5.78 -3.2,0.0 -4.8,-2.38 -5.36,-3.73 l -4.03,1.68 C 153.28,49.85 156.15,53.0 161.27,53.0 c 5.6,0.0 9.86,-3.53 9.86,-10.92 l 0.0,-18.82 -4.39,0.0 0.0,1.77 c -1.35,-1.45 -3.2,-2.4 -5.65,-2.4 z m 0.41,4.11 c 2.76,0.0 5.59,2.36 5.59,6.38 0.0,4.09 -2.83,6.35 -5.66,6.35 -3.0,0.0 -5.79,-2.44 -5.79,-6.31 0.0,-4.02 2.9,-6.42 5.85,-6.42 z m -22.87,-4.12 c -6.13,0.0 -10.53,4.79 -10.53,10.39 0.0,5.67 4.26,10.56 10.6,10.56 5.74,0.0 10.44,-4.38 10.44,-10.44 0.0,-6.94 -5.47,-10.51 -10.51,-10.51 z m 0.06,4.11 c 3.02,0.0 5.87,2.44 5.87,6.37 0.0,3.85 -2.85,6.35 -5.89,6.35 -3.34,0.0 -5.98,-2.68 -5.98,-6.38 0.0,-3.63 2.6,-6.34 5.99,-6.34 z m -22.96,-4.12 c -6.13,0.0 -10.53,4.79 -10.53,10.39 0.0,5.67 4.26,10.56 10.6,10.56 5.74,0.0 10.44,-4.38 10.44,-10.44 0.0,-6.94 -5.47,-10.51 -10.51,-10.51 z m 0.06,4.11 c 3.02,0.0 5.87,2.44 5.87,6.37 0.0,3.85 -2.85,6.35 -5.89,6.35 -3.34,0.0 -5.98,-2.68 -5.98,-6.38 0.0,-3.63 2.6,-6.34 5.99,-6.34 z m -12.31,-0.9 -14.95,0.0 0.0,4.44 10.6,0.0 c -0.52,6.22 -5.7,8.87 -10.58,8.87 -6.25,0.0 -11.7,-4.92 -11.7,-11.81 0.0,-6.71 5.2,-11.88 11.72,-11.88 5.03,0.0 7.99,3.21 7.99,3.21 l 3.11,-3.22 C 99.68,15.44 95.69,11.0 88.42,11.0 79.16,11.0 72.0,18.81 72.0,27.25 c 0.0,8.27 6.74,16.33 16.66,16.33 8.72,0.0 15.11,-5.98 15.11,-14.81 0.0,-1.86 -0.27,-2.94 -0.27,-2.94 z"/>
              </svg>
            </a>
          </header>
          <menu id="navmenu">
            <li id="home"><a href="#home">Home</a></li>
            <li id="tasks"><a href="#tasks">Tasks</a></li>
            <li id="console"><a href="#console">Console</a></li>
            <li id="editor"><a href="#editor">Editor</a></li>
            <li id="desktop"><a href="#desktop">Desktop</a></li>
          </menu>
        </nav>
        <xsl:call-template name="main"/>

        <!-- zachB's edit: Popup code -->
        <div id="dimming-mask" onclick="closeDimMask(event)">
        <section class="user-info-popup">
          <div class="popup-content">
            <span id="exit-btn" onclick="closePopup()">X</span>
            <br/>

            <div class="popup-header">
              <img id="userpic" src="{$picture}?sz=32" width="32" height="32" alt="{$name}"/>
              <h2 class="full-name">
                <xsl:value-of select="$name"/>
              </h2>
            </div>
            <hr/>

            <h3 class="chat-title">Chat Info</h3>

            <div class="user-chat-info">
              <div class="username-container">
                <h4 class="u-info-title">
                  <xsl:text>Username &#58;</xsl:text>
                </h4>
                <span class="jid-user">
                  <xsl:value-of select="$username"/>
                </span>
                <span class="jid-host">
                  <xsl:text>@gci.copyleftgames.org</xsl:text>
                </span>
              </div>

              <div class="password-container">
                <h4 class="u-info-title">
                  <xsl:text>Password &#58;</xsl:text>
                </h4>
                <span class="password">
                  <xsl:value-of select="$secret"/>
                </span>
              </div>
            </div>

          </div>
        </section>
        </div>
            
        <footer>
          <nav>
            <section>
             <h1>Engines</h1>
             <a href="http://www.pysoy.org/">PySoy</a><br/>
             <a href="http://www.vox.gl/">VoxGL</a><br/>
            </section>
            <section>
             <h1>Tools</h1>
            </section>
            <section>
             <h1>Libraries</h1>
             <a href="http://www.lightmelody.org/">LightMelody</a>
            </section>
          </nav>
          This site is licensed under the <a rel="license" href="http://www.gnu.org/licenses/agpl-3.0.en.html">GNU Affero General Public License 3.0</a>
        </footer>
        <xsl:call-template name="bottom"/>
      </body>
     </html>
   </xsl:template>
</xsl:stylesheet>

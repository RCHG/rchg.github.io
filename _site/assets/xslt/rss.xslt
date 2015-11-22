<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output method="html" encoding="utf-8" />
<xsl:template match="/rss">
	<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html &gt;</xsl:text>
	<html>
	<head>
		<xsl:text disable-output-escaping="yes"><![CDATA[
			<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>RSS Feed (Styled)</title>
	<link rel="stylesheet" type="text/css" href="http://localhost:4000/assets/css/styles_feeling_responsive.css" />
	<script src="http://localhost:4000/assets/js/modernizr.min.js"></script>
	
  <script src="https://ajax.googleapis.com/ajax/libs/webfont/1.5.18/webfont.js"></script>
  <script>
    WebFont.load({
      google: {
        families: [ 'Lato:400,700,400italic:latin', 'Volkhov::latin' ] 
      }
    });
  </script>

  <noscript>
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700,400italic|Volkhov' rel='stylesheet' type='text/css' />
  </noscript>
  
  
	
	<meta name="description" content="Academic and personal webpage build with Jekyll on Github." />
	
	

	



	
	<link rel="icon" sizes="32x32" href="http://localhost:4000/assets/img/favicon-32x32.png" />




	
	<link rel="icon" sizes="192x192" href="http://localhost:4000/assets/img/touch-icon-192x192.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="180x180" href="http://localhost:4000/assets/img/apple-touch-icon-180x180-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="152x152" href="http://localhost:4000/assets/img/apple-touch-icon-152x152-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="http://localhost:4000/assets/img/apple-touch-icon-144x144-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="120x120" href="http://localhost:4000/assets/img/apple-touch-icon-120x120-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="http://localhost:4000/assets/img/apple-touch-icon-114x114-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="76x76" href="http://localhost:4000/assets/img/apple-touch-icon-76x76-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="http://localhost:4000/assets/img/apple-touch-icon-72x72-precomposed.png" />




	
	<link rel="apple-touch-icon-precomposed" href="http://localhost:4000/assets/img/apple-touch-icon-precomposed.png" />	




	
	<meta name="msapplication-TileImage" content="http://localhost:4000/assets/img/msapplication_tileimage.png" />




	
	<meta name="msapplication-TileColor" content="#fabb00" />



	<!-- Facebook Optimization -->
	<meta property="og:locale" content="en_EN" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="RSS Feed (Styled)" />
	<meta property="og:description" content="Academic and personal webpage build with Jekyll on Github." />
	<meta property="og:url" content="http://localhost:4000//assets/xslt/rss.xslt" />
	<meta property="og:site_name" content="R. Checa-Garcia" />
	

	

	<!-- Search Engine Optimization -->
	

	<link type="text/plain" rel="author" href="http://localhost:4000/humans.txt" />

	
</head>
		]]></xsl:text>
	</head>
	<body id="top-of-page">
		<xsl:text disable-output-escaping="yes"><![CDATA[
		
<div id="navigation" class="sticky">
  <nav class="top-bar" role="navigation" data-topbar>
    <ul class="title-area">
      <li class="name">
      <h1 class="show-for-small-only"><a href="http://localhost:4000" class="icon-tree"> R. Checa-Garcia</a></h1>
    </li>
       <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
      <li class="toggle-topbar menu-icon"><a href="#"><span>Navigation</span></a></li>
    </ul>
    <section class="top-bar-section">

      <ul class="right">
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
        

              
                
              

          
          
            
            
              <li class="divider"></li>
              <li><a href="http://localhost:4000/search/">Search</a></li>

            
            
          
        

              
                
              

          
          
            
            
              <li class="divider"></li>
              <li><a href="http://localhost:4000/contact/">Contact</a></li>

            
            
          
        
        
      </ul>

      <ul class="left">
        

              
                
              

          
          

            
            
              <li><a href="http://localhost:4000/index.html">Start</a></li>
              <li class="divider"></li>

            
            
          
        

              
                
              

          
          

            
            
              <li><a href="http://localhost:4000/about">About</a></li>
              <li class="divider"></li>

            
            
          
        

              
                
              

          
          

            
            

              <li class="has-dropdown">
                <a href="http://localhost:4000/research/index_re">Research</a>

                  <ul class="dropdown">
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/research/overview">Overview</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/research/my-codes/">My codes</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/research/reviews/">Reviews</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/research/resources/">Resources</a></li>
                    
                  </ul>
                  
              </li>
              <li class="divider"></li>
            
          
        

              
                
              

          
          

            
            

              <li class="has-dropdown">
                <a href="http://localhost:4000/teaching/index_te/">Teaching</a>

                  <ul class="dropdown">
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/teaching/overview/">Overview</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/teaching/resources/">Resources</a></li>
                    
                  </ul>
                  
              </li>
              <li class="divider"></li>
            
          
        

              
                
              

          
          

            
            

              <li class="has-dropdown">
                <a href="http://localhost:4000/blog/archive">Academic Blog</a>

                  <ul class="dropdown">
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive_science/">Science Blog</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive_computing/">Computing Blog</a></li>
                    
                  </ul>
                  
              </li>
              <li class="divider"></li>
            
          
        

              
                
              

          
          

            
            

              <li class="has-dropdown">
                <a href="http://localhost:4000/blog/">Personal blog</a>

                  <ul class="dropdown">
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive_personal/">Opinion</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive_stories/">Stories</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive/">Blog Archive</a></li>
                    

                      
                        
                      

                      <li><a href="http://localhost:4000/blog/archive_tags/">Blog Tags</a></li>
                    
                  </ul>
                  
              </li>
              <li class="divider"></li>
            
          
        

              
                
              

          
          

            
            
              <li><a href="http://localhost:4000/blog/open_letters/">Open Letters</a></li>
              <li class="divider"></li>

            
            
          
        

              
                
              

          
          
        

              
                
              

          
          
        
        
      </ul>
    </section>
  </nav>
</div><!-- /#navigation -->

		

<div id="masthead-no-image-header">
	<div class="row">
		<div class="small-12 columns">
			<a id="logo" href="http://localhost:4000" title="R. Checa-Garcia – ">
				<img src="http://localhost:4000/assets/img/logo.png" alt="R. Checa-Garcia – ">
			</a>
		</div><!-- /.small-12.columns -->
	</div><!-- /.row -->
</div><!-- /#masthead -->








		


<div class="alert-box warning radius text-center"><p>This <a href="https://en.wikipedia.org/wiki/RSS" target="_blank">RSS feed</a> is meant to be used by <a href="https://en.wikipedia.org/wiki/Template:Aggregators" target="_blank">RSS reader applications and websites</a>.</p>
</div>



		]]></xsl:text>
		<header class="t30 row">
	<p class="subheadline"><xsl:value-of select="channel/description" disable-output-escaping="yes" /></p>
	<h1>
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="channel/link" />
			</xsl:attribute>
			<xsl:value-of select="channel/title" disable-output-escaping="yes" />
		</xsl:element>
	</h1>
</header>
<ul class="accordion row" data-accordion="">
	<xsl:for-each select="channel/item">
		<li class="accordion-navigation">
			<xsl:variable name="slug-id">
				<xsl:call-template name="slugify">
					<xsl:with-param name="text" select="guid" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="concat('#', $slug-id)"/></xsl:attribute>
				<xsl:value-of select="title"/>
				<br/>
				<small><xsl:value-of select="pubDate"/></small>
			</xsl:element>
			<xsl:element name="div">
				<xsl:attribute name="id"><xsl:value-of select="$slug-id"/></xsl:attribute>
				<xsl:attribute name="class">content</xsl:attribute>
				<h1>
					<xsl:element name="a">
						<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
						<xsl:value-of select="title"/>
					</xsl:element>
				</h1>
				<xsl:value-of select="description" disable-output-escaping="yes" />
			</xsl:element>
		</li>
	</xsl:for-each>
</ul>

		<xsl:text disable-output-escaping="yes"><![CDATA[
		    <div id="up-to-top" class="row">
      <div class="small-12 columns" style="text-align: right;">
        <a class="iconfont" href="#top-of-page">&#xf108;</a>
      </div><!-- /.small-12.columns -->
    </div><!-- /.row -->


    <footer id="footer-content" class="bg-grau">
      <div id="footer">
        <div class="row">
          <div class="medium-6 large-5 columns">
            <h5 class="shadow-black">About This Site</h5>

            <p class="shadow-black">
              Academic and personal webpage build with Jekyll on Github.
              <a href="http://localhost:4000/info/">More ›</a>
            </p>
          </div><!-- /.large-6.columns -->


          <div class="small-6 medium-3 large-3 large-offset-1 columns">
            
              
                <h5 class="shadow-black">Services</h5>
              
            
              
            
              
            
              
            
              
              <ul class="no-bullet shadow-black">
              
                
                  <li >
                    <a href=""  title=""></a>
                  </li>
              
                
                  <li >
                    <a href="/feed.xml"  title="Subscribe to RSS Feed">RSS</a>
                  </li>
              
                
                  <li >
                    <a href="/atom.xml"  title="Subscribe to Atom Feed">Atom</a>
                  </li>
              
                
                  <li >
                    <a href="/sitemap.xml"  title="Sitemap for Google Webmaster Tools">sitemap.xml</a>
                  </li>
              
              </ul>
          </div><!-- /.large-4.columns -->


          <div class="small-6 medium-3 large-3 columns">
            
              
                <h5 class="shadow-black">Thank you!</h5>
              
            
              
            
              
            
              
            <ul class="no-bullet shadow-black">
            
              
                <li >
                  <a href=""  title=""></a>
                </li>
            
              
                <li class="network-entypo" >
                  <a href="http://sareidia.deviantart.com/" target="_blank"  title="Pictures by Sareidia">Few Pictures by Sareidia</a>
                </li>
            
              
                <li class="web-link" >
                  <a href="https://storybird.com/members/zuzol/reposts/" target="_blank"  title="Pictures by ZUZOL">Few Pictures by ZUZOL</a>
                </li>
            
            </ul>
          </div><!-- /.large-3.columns -->
        </div><!-- /.row -->

      </div><!-- /#footer -->


      <div id="subfooter">
        <nav class="row">
          <section id="subfooter-left" class="b30 small-12 medium-6 columns credits">
            <p>
              Created with &hearts;
              by&nbsp;<a href="http://rchg.github.io/">rchg</a>
              with&nbsp;<a href="http://jekyllrb.com/" target="_blank">Jekyll</a>
              based&nbsp;on&nbsp;<a href="http://phlow.github.io/feeling-responsive/">Feeling&nbsp;Responsive</a>.
            </p>
          </section>

          <section id="subfooter-right" class="small-12 medium-6 columns social-icons">
            <ul class="inline-list">
            
              <li><a href="http://github.com/rchg" target="_blank" class="icon-home" title="Working here..."></a></li>
            
              <li><a href="http://github.com/rchg" target="_blank" class="icon-github" title="My GitHub site..."></a></li>
            
              <li><a href="http://sourceforge.net/u/rchecagarcia/profile/" target="_blank" class="icon-sourceforge" title="My SourceForge site..."></a></li>
            
              <li><a href="http://bitbucket.org/rchecagarcia" target="_blank" class="icon-bitbucket" title="My bitbucket site..."></a></li>
            
              <li><a href="https://scholar.google.de/citations?user=9X_DoXYAAAAJ&hl=en&oi=ao" target="_blank" class="icon-paper-plane" title="My Google Scholar..."></a></li>
            
              <li><a href="http://www.researchgate.net/profile/Ramiro_Checa-Garcia" target="_blank" class="icon-paperclip" title="My ResearchGate..."></a></li>
            
            </ul>
          </section>
        </nav>
      </div><!-- /#subfooter -->
    </footer>

		<script src="http://localhost:4000/assets/js/javascript.min.js"></script>












		]]></xsl:text>
	</body>
	</html>
</xsl:template>
<xsl:template name="slugify">
	<xsl:param name="text" select="''" />
	<xsl:variable name="dodgyChars" select="' ,.#_-!?*:;=+|&amp;/\\'" />
	<xsl:variable name="replacementChar" select="'-----------------'" />
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:variable name="lowercased"><xsl:value-of select="translate( $text, $uppercase, $lowercase )" /></xsl:variable>
	<xsl:variable name="escaped"><xsl:value-of select="translate( $lowercased, $dodgyChars, $replacementChar )" /></xsl:variable>
	<xsl:value-of select="$escaped" />
</xsl:template>
</xsl:stylesheet>

---
layout: page-fullwidth
subheadline: "Scientific Publications"
permalink: "/research/publications/"
header:
    title: Scientific Publications
    pattern: pattern_jquery-dark-grey-tile.png
breadcrumb: true
---
<div class="row">
<div class="medium-4 medium-push-8 columns" markdown="1">
<div class="panel radius" markdown="1">
### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>

<div class="panel radius" markdown="1">

  {% include alert info=' <a href="/research/my-codes/">Software codes</a>' %}
  {% include alert info=' <a href="/research/resources/">Resources and Links</a>' %}

</div>

</div><!-- /.medium-4.columns -->
<div class="medium-8 medium-pull-4 columns" markdown="1">

<ul>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2020</h2>
<ul>
<li style="margin: 8px 0"><b>Direct Radiative Effect by Mineral Dust Aerosols Constrained by New Microphysical and Spectral Optical Data</b>.  <span style="color:#900">C. Di Biagio, Y. Balkanski, S. Albani, O. Boucher, and P. Formenti</span>.  <span style="color:#666666">Geophysical Research Letters</span>, <span style="color:#666666">Jan 2020</span>.  [<a href=https://doi.org/10.1029%2F2019gl086186 style="color:#1772d0">Paper</a>]</li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2019</h2>
<ul>
<li style="margin: 8px 0"><b>Impact of Multiscale Variability on Last 6,000 Years Indian and West African Monsoon Rain</b>.  <span style="color:#900">P. Braconnot, J. Crétat, O. Marti, Y. Balkanski, A. Caubel, A. Cozic, M. -A. Foujols, and S. Sanogo</span>.  <span style="color:#666666">Geophysical Research Letters</span>, <span style="color:#666666">Dec 2019</span>.  [<a href=https://doi.org/10.1029%2F2019gl084797 style="color:#1772d0">Paper</a>]</li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2014</h2>
<ul>
<li style="margin: 8px 0"><b>A global model simulation of present and future nitrate aerosols and their direct radiative forcing of climate</b>.  <span style="color:#900">D. A. Hauglustaine, Y. Balkanski, and M. Schulz</span>.  <span style="color:#666666">Atmospheric Chemistry & Physics</span>, <span style="color:#666666">2014</span>.  [<a href=www.atmos-chem-phys.net/14/11031/2014/ style="color:#1772d0">Paper</a>]</li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2013</h2>
<ul>
<li style="margin: 8px 0"><b>Aerosol and ozone changes as forcing for climate evolution between 1850 and 2100</b>.  <span style="color:#900">S. Szopa, Y. Balkanski, M. Schulz, S. Bekki, D. Cugnet, A. Fortems-Cheiney, S. Turquety, A. Cozic, C. Déandreis, D. Hauglustaine, A. Idelkadi, J. Lathière, F. Lefevre, M. Marchand, R. Vuolo, N. Yan, and J.-L. Dufresne</span>.  <span style="color:#666666">Climate Dynamics</span>, <span style="color:#666666">2013</span>.  [<a href=http://adsabs.harvard.edu/abs/2013ClDy...40.2223S style="color:#1772d0">Paper</a>]</li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2010</h2>
<ul>
<li style="margin: 8px 0"><b>Sensitivity of isoprene emissions from the terrestrial biosphere to 20th century changes in atmospheric CO2 concentration, climate, and land use</b>.  <span style="color:#900">J. Lathière, C. N. Hewitt, and D. J. Beerling</span>.  <span style="color:#666666">Global Biogeochemical Cycles</span>, <span style="color:#666666">2010</span>.  [<a href=https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2009GB003548 style="color:#1772d0">Paper</a>]</li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">2009</h2>
<ul>
<li style="margin: 8px 0"><b>LMDzT-INCA dust forecast model developments and associated validation efforts</b>.  <span style="color:#900">M Schulz, A Cozic, and S Szopa</span>.  <span style="color:#666666">IOP Conference Series: Earth and Environmental Science</span>, <span style="color:#666666">2009</span></li>
</ul>
<h2 style="text-align:center; background-color:powderblue;">1998</h2>
<ul>
<li style="margin: 8px 0"><b>Uncertainties in assessing radiative forcing by mineral dust</b>.  <span style="color:#900">T. Claquin, M. Schulz, Y. Balkanski, and O. Boucher</span>.  <span style="color:#666666">Tellus Series B Chemical and Physical Meteorology B</span>, <span style="color:#666666">1998</span>.  [<a href=http://adsabs.harvard.edu/abs/1998TellB..50..491C style="color:#1772d0">Paper</a>]</li>
</ul>

<script type="text/javascript">
<!--
// QuickSearch script for JabRef HTML export 
// Version: 3.0
//
// Copyright (c) 2006-2011, Mark Schenk
//
// This software is distributed under a Creative Commons Attribution 3.0 License
// http://creativecommons.org/licenses/by/3.0/
//
// Features:
// - intuitive find-as-you-type searching
//    ~ case insensitive
//    ~ ignore diacritics (optional)
//
// - search with/without Regular Expressions
// - match BibTeX key
//

// Search settings
var searchAbstract = true;	// search in abstract
var searchComment = true;	// search in comment

var noSquiggles = true; 	// ignore diacritics when searching
var searchRegExp = false; 	// enable RegExp searches


if (window.addEventListener) {
	window.addEventListener("load",initSearch,false); }
else if (window.attachEvent) {
	window.attachEvent("onload", initSearch); }

function initSearch() {
	// check for quick search table and searchfield
	if (!document.getElementById('qs_table')||!document.getElementById('quicksearch')) { return; }

	// load all the rows and sort into arrays
	loadTableData();
	
	//find the query field
	qsfield = document.getElementById('qs_field');

	// previous search term; used for speed optimisation
	prevSearch = '';

	//find statistics location
	stats = document.getElementById('stat');
	setStatistics(-1);
	
	// set up preferences
	initPreferences();

	// shows the searchfield
	document.getElementById('quicksearch').style.display = 'block';
	document.getElementById('qs_field').onkeyup = quickSearch;
}

function loadTableData() {
	// find table and appropriate rows
	searchTable = document.getElementById('qs_table');
	var allRows = searchTable.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

	// split all rows into entryRows and infoRows (e.g. abstract, comment, bibtex)
	entryRows = new Array(); infoRows = new Array(); absRows = new Array(); revRows = new Array();

	// get data from each row
	entryRowsData = new Array(); absRowsData = new Array(); revRowsData = new Array(); 
	
	BibTeXKeys = new Array();
	
	for (var i=0, k=0, j=0; i<allRows.length;i++) {
		if (allRows[i].className.match(/entry/)) {
			entryRows[j] = allRows[i];
			entryRowsData[j] = stripDiacritics(getTextContent(allRows[i]));
			allRows[i].id ? BibTeXKeys[j] = allRows[i].id : allRows[i].id = 'autokey_'+j;
			j ++;
		} else {
			infoRows[k++] = allRows[i];
			// check for abstract/comment
			if (allRows[i].className.match(/abstract/)) {
				absRows.push(allRows[i]);
				absRowsData[j-1] = stripDiacritics(getTextContent(allRows[i]));
			} else if (allRows[i].className.match(/comment/)) {
				revRows.push(allRows[i]);
				revRowsData[j-1] = stripDiacritics(getTextContent(allRows[i]));
			}
		}
	}
	//number of entries and rows
	numEntries = entryRows.length;
	numInfo = infoRows.length;
	numAbs = absRows.length;
	numRev = revRows.length;
}

function quickSearch(){
	
	tInput = qsfield;

	if (tInput.value.length == 0) {
		showAll();
		setStatistics(-1);
		qsfield.className = '';
		return;
	} else {
		t = stripDiacritics(tInput.value);

		if(!searchRegExp) { t = escapeRegExp(t); }
			
		// only search for valid RegExp
		try {
			textRegExp = new RegExp(t,"i");
			closeAllInfo();
			qsfield.className = '';
		}
			catch(err) {
			prevSearch = tInput.value;
			qsfield.className = 'invalidsearch';
			return;
		}
	}
	
	// count number of hits
	var hits = 0;

	// start looping through all entry rows
	for (var i = 0; cRow = entryRows[i]; i++){

		// only show search the cells if it isn't already hidden OR if the search term is getting shorter, then search all
		if(cRow.className.indexOf('noshow')==-1 || tInput.value.length <= prevSearch.length){
			var found = false; 

			if (entryRowsData[i].search(textRegExp) != -1 || BibTeXKeys[i].search(textRegExp) != -1){ 
				found = true;
			} else {
				if(searchAbstract && absRowsData[i]!=undefined) {
					if (absRowsData[i].search(textRegExp) != -1){ found=true; } 
				}
				if(searchComment && revRowsData[i]!=undefined) {
					if (revRowsData[i].search(textRegExp) != -1){ found=true; } 
				}
			}
			
			if (found){
				cRow.className = 'entry show';
				hits++;
			} else {
				cRow.className = 'entry noshow';
			}
		}
	}

	// update statistics
	setStatistics(hits)
	
	// set previous search value
	prevSearch = tInput.value;
}


// Strip Diacritics from text
// http://stackoverflow.com/questions/990904/javascript-remove-accents-in-strings

// String containing replacement characters for stripping accents 
var stripstring = 
    'AAAAAAACEEEEIIII'+
    'DNOOOOO.OUUUUY..'+
    'aaaaaaaceeeeiiii'+
    'dnooooo.ouuuuy.y'+
    'AaAaAaCcCcCcCcDd'+
    'DdEeEeEeEeEeGgGg'+
    'GgGgHhHhIiIiIiIi'+
    'IiIiJjKkkLlLlLlL'+
    'lJlNnNnNnnNnOoOo'+
    'OoOoRrRrRrSsSsSs'+
    'SsTtTtTtUuUuUuUu'+
    'UuUuWwYyYZzZzZz.';

function stripDiacritics(str){

    if(noSquiggles==false){
        return str;
    }

    var answer='';
    for(var i=0;i<str.length;i++){
        var ch=str[i];
        var chindex=ch.charCodeAt(0)-192;   // Index of character code in the strip string
        if(chindex>=0 && chindex<stripstring.length){
            // Character is within our table, so we can strip the accent...
            var outch=stripstring.charAt(chindex);
            // ...unless it was shown as a '.'
            if(outch!='.')ch=outch;
        }
        answer+=ch;
    }
    return answer;
}

// http://stackoverflow.com/questions/3446170/escape-string-for-use-in-javascript-regex
// NOTE: must escape every \ in the export code because of the JabRef Export...
function escapeRegExp(str) {
  return str.replace(/[-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
}

function toggleInfo(articleid,info) {

	var entry = document.getElementById(articleid);
	var abs = document.getElementById('abs_'+articleid);
	var rev = document.getElementById('rev_'+articleid);
	var bib = document.getElementById('bib_'+articleid);
	
	if (abs && info == 'abstract') {
		abs.className.indexOf('noshow') == -1?abs.className = 'abstract noshow':abs.className = 'abstract show';
	} else if (rev && info == 'comment') {
		rev.className.indexOf('noshow') == -1?rev.className = 'comment noshow':rev.className = 'comment show';
	} else if (bib && info == 'bibtex') {
		bib.className.indexOf('noshow') == -1?bib.className = 'bibtex noshow':bib.className = 'bibtex show';
	} else { 
		return;
	}

	// check if one or the other is available
	var revshow; var absshow; var bibshow;
	(abs && abs.className.indexOf('noshow') == -1)? absshow = true: absshow = false;
	(rev && rev.className.indexOf('noshow') == -1)? revshow = true: revshow = false;	
	(bib && bib.className.indexOf('noshow') == -1)? bibshow = true: bibshow = false;
	
	// highlight original entry
	if(entry) {
		if (revshow || absshow || bibshow) {
		entry.className = 'entry highlight show';
		} else {
		entry.className = 'entry show';
		}
	}
	
	// When there's a combination of abstract/comment/bibtex showing, need to add class for correct styling
	if(absshow) {
		(revshow||bibshow)?abs.className = 'abstract nextshow':abs.className = 'abstract';
	} 
	if (revshow) {
		bibshow?rev.className = 'comment nextshow': rev.className = 'comment';
	}	
	
}

function setStatistics (hits) {
	if(hits < 0) { hits=numEntries; }
	if(stats) { stats.firstChild.data = hits + '/' + numEntries}
}

function getTextContent(node) {
	// Function written by Arve Bersvendsen
	// http://www.virtuelvis.com
	
	if (node.nodeType == 3) {
	return node.nodeValue;
	} // text node
	if (node.nodeType == 1 && node.className != "infolinks") { // element node
	var text = [];
	for (var chld = node.firstChild;chld;chld=chld.nextSibling) {
		text.push(getTextContent(chld));
	}
	return text.join("");
	} return ""; // some other node, won't contain text nodes.
}

function showAll(){
	closeAllInfo();
	for (var i = 0; i < numEntries; i++){ entryRows[i].className = 'entry show'; }
}

function closeAllInfo(){
	for (var i=0; i < numInfo; i++){
		if (infoRows[i].className.indexOf('noshow') ==-1) {
			infoRows[i].className = infoRows[i].className + ' noshow';
		}
	}
}

function clearQS() {
	qsfield.value = '';
	showAll();
}

function redoQS(){
	showAll();
	quickSearch(qsfield);
}

function updateSetting(obj){
	var option = obj.id;
	var checked = obj.value;

	switch(option)
	 {
	 case "opt_searchAbs":
	   searchAbstract=!searchAbstract;
	   redoQS();
	   break;
	 case "opt_searchComment":
	   searchComment=!searchComment;
	   redoQS();
	   break;
	 case "opt_useRegExp":
	   searchRegExp=!searchRegExp;
	   redoQS();
	   break;
	 case "opt_noAccents":
	   noSquiggles=!noSquiggles;
	   loadTableData();
	   redoQS();
	   break;
	 }
}

function initPreferences(){
	if(searchAbstract){document.getElementById("opt_searchAbs").checked = true;}
	if(searchComment){document.getElementById("opt_searchComment").checked = true;}
	if(noSquiggles){document.getElementById("opt_noAccents").checked = true;}
	if(searchRegExp){document.getElementById("opt_useRegExp").checked = true;}
	
	if(numAbs==0) {document.getElementById("opt_searchAbs").parentNode.style.display = 'none';}
	if(numRev==0) {document.getElementById("opt_searchComment").parentNode.style.display = 'none';}	
}

function toggleSettings(){
	var togglebutton = document.getElementById('showsettings');
	var settings = document.getElementById('settings');
	
	if(settings.className == "hidden"){
		settings.className = "show";
		togglebutton.innerText = "close settings";
		togglebutton.textContent = "close settings";
	}else{
		settings.className = "hidden";
		togglebutton.innerText = "settings...";		
		togglebutton.textContent = "settings...";
	}
}

-->
</script>

<style type="text/css">
<!-- body { background-color: white; font-family: Arial, sans-serif; font-size: 13px; line-height: 1.2; padding: 1em; color: #2E2E2E; width: 50em; margin: auto auto; } -->

form#quicksearch { width: auto; border-style: solid; border-color: gray; border-width: 1px 0px; padding: 0.7em 0.5em; display:none; position:relative; }
span#searchstat {padding-left: 1em;}

div#settings { margin-top:0.7em; /* border-bottom: 1px transparent solid; background-color: #efefef; border: 1px grey solid; */ }
div#settings ul {margin: 0; padding: 0; }
div#settings li {margin: 0; padding: 0 1em 0 0; display: inline; list-style: none; }
div#settings li + li { border-left: 2px #efefef solid; padding-left: 0.5em;}
div#settings input { margin-bottom: 0px;}

div#settings.hidden {display:none;}

#showsettings { border: 1px grey solid; padding: 0 0.5em; float:right; line-height: 1.6em; text-align: right; }
#showsettings:hover { cursor: pointer; }

.invalidsearch { background-color: red; }
input[type="button"] { background-color: #efefef; border: 1px #2E2E2E solid;}

table { border: 1px gray none; width: 100%; empty-cells: show; border-spacing: 0em 0.1em; margin: 1em 0em; }
th, td { border: none; padding: 0.5em; vertical-align: top; text-align: justify; }

td a { color: navy; text-decoration: none; }
td a:hover  { text-decoration: underline; }

tr.noshow { display: none;}
tr.highlight td { background-color: #EFEFEF; border-top: 2px #2E2E2E solid; font-weight: bold; }
tr.abstract td, tr.comment td, tr.bibtex td { background-color: #EFEFEF; text-align: justify; border-bottom: 2px #2E2E2E solid; }
tr.nextshow td { border-bottom-style: none; }

tr.bibtex pre { width: 100%; overflow: auto; white-space: pre-wrap;}
p.infolinks { margin: 0.3em 0em 0em 0em; padding: 0px; }

@media print {
	p.infolinks, #qs_settings, #quicksearch, t.bibtex { display: none !important; }
	tr { page-break-inside: avoid; }
}
</style>

<form action="" id="quicksearch">
<input type="text" id="qs_field" autocomplete="off" placeholder="Type to search..." /> <input type="button" onclick="clearQS()" value="clear" />
<span id="searchstat">Matching entries: <span id="stat">0</span></span>
<div id="showsettings" onclick="toggleSettings()">settings...</div>
<div id="settings" class="hidden">
<ul>
<li><input type="checkbox" class="search_setting" id="opt_searchAbs" onchange="updateSetting(this)"><label for="opt_searchAbs"> include abstract</label></li>
<li><input type="checkbox" class="search_setting" id="opt_searchComment" onchange="updateSetting(this)"><label for="opt_searchComment"> include comment</label></li>
<li><input type="checkbox" class="search_setting" id="opt_useRegExp" onchange="updateSetting(this)"><label for="opt_useRegExp"> use RegExp</label></li>
<li><input type="checkbox" class="search_setting" id="opt_noAccents" onchange="updateSetting(this)"><label for="opt_noAccents"> ignore accents</label></li>
</ul>
</div>
</form>
<table id="qs_table" border="1">
<tbody>
<tr id="ButzEtAl_AMT_2015a" class="entry">
	<td>Butz A, Orphal J, Checa-Garcia R, Friedl-Vallon F, von Clarmann T, Bovensmann H, Hasekamp O, Landgraf J, Knigge T, Weise D, Sqalli-Houssini O and Kemper D (2015), <i>"Geostationary Emission Explorer for Europe (G3E): mission concept and initial performance assessment"</i>, Atmospheric Measurement Techniques.  Vol. 8(11), pp. 4719-4734. Copernicus GmbH.
	<p class="infolinks"> [<a href="javascript:toggleInfo('ButzEtAl_AMT_2015a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/amt-8-4719-2015" target="_blank">DOI</a>] [<a href="http://www.atmos-meas-tech.net/8/4719/2015/" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_ButzEtAl_AMT_2015a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{ButzEtAl_AMT_2015a,
  author = {Butz, A. and Orphal, J. and Checa-Garcia, R and Friedl-Vallon, F. and von Clarmann, T. and Bovensmann, H. and Hasekamp, O. and Landgraf, J. and Knigge, T. and Weise, D. and Sqalli-Houssini, O. and Kemper, D.},
  title = {Geostationary Emission Explorer for Europe (G3E): mission concept and initial performance assessment},
  journal = {Atmospheric Measurement Techniques},
  publisher = {Copernicus GmbH},
  year = {2015},
  volume = {8},
  number = {11},
  pages = {4719--4734},
  url = {http://www.atmos-meas-tech.net/8/4719/2015/},
  doi = {10.5194/amt-8-4719-2015}
}
</pre></td>
</tr>
<tr id="ChecaEtAl_PRE_2004a" class="entry">
	<td>Checa-Garcia R, Chacon E and Tarazona P (2004), <i>"Density functional study of layering at liquid surfaces"</i>, Physical Review E.  Vol. 70(6), pp. 061601. American Physical Society (APS).
	<p class="infolinks"> [<a href="javascript:toggleInfo('ChecaEtAl_PRE_2004a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1103/PhysRevE.70.061601" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_ChecaEtAl_PRE_2004a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{ChecaEtAl_PRE_2004a,
  author = {Checa-Garcia, R. and Chacon, E. and Tarazona, P.},
  title = {Density functional study of layering at liquid surfaces},
  journal = {Physical Review E},
  publisher = {American Physical Society (APS)},
  year = {2004},
  volume = {70},
  number = {6},
  pages = {061601},
  doi = {10.1103/PhysRevE.70.061601}
}
</pre></td>
</tr>
<tr id="Checa-GarciaEtAl_AMT_2015a" class="entry">
	<td>Checa-Garcia R, Landgraf J, Galli A, Hase F, Velazco VA, Tran H, Boudon V, Alkemade F and Butz A (2015), <i>"Mapping spectroscopic uncertainties into prospective methane retrieval errors from Sentinel-5 and its precursor"</i>, Atmospheric Measurement Techniques.  Vol. 8(9), pp. 3617-3629. Copernicus GmbH.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Checa-GarciaEtAl_AMT_2015a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/amt-8-3617-2015" target="_blank">DOI</a>] [<a href="http://www.atmos-meas-tech.net/8/3617/2015/" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Checa-GarciaEtAl_AMT_2015a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Checa-GarciaEtAl_AMT_2015a,
  author = {Checa-Garcia, R and Landgraf, J. and Galli, A. and Hase, F. and Velazco, V. A. and Tran, H. and Boudon, V. and Alkemade, F. and Butz, A.},
  title = {Mapping spectroscopic uncertainties into prospective methane retrieval errors from Sentinel-5 and its precursor},
  journal = {Atmospheric Measurement Techniques},
  publisher = {Copernicus GmbH},
  year = {2015},
  volume = {8},
  number = {9},
  pages = {3617--3629},
  url = {http://www.atmos-meas-tech.net/8/3617/2015/},
  doi = {10.5194/amt-8-3617-2015}
}
</pre></td>
</tr>
<tr id="Checa-GarciaEtAl_AMTD_2014a" class="entry">
	<td>Checa-Garcia R, Tokay A and Tapiador FJ (2014), <i>"Binning effects on in-situ raindrop size distribution measurements"</i>, Atmospheric Measurement Techniques Discussions.  Vol. 7(3), pp. 2339-2379. Copernicus GmbH.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Checa-GarciaEtAl_AMTD_2014a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/amtd-7-2339-2014" target="_blank">DOI</a>] [<a href="https://www.atmos-meas-tech-discuss.net/7/2339/2014/amtd-7-2339-2014.pdf" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Checa-GarciaEtAl_AMTD_2014a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Checa-GarciaEtAl_AMTD_2014a,
  author = {R. Checa-Garcia and A. Tokay and F. J. Tapiador},
  title = {Binning effects on in-situ raindrop size distribution measurements},
  journal = {Atmospheric Measurement Techniques Discussions},
  publisher = {Copernicus GmbH},
  year = {2014},
  volume = {7},
  number = {3},
  pages = {2339--2379},
  url = {https://www.atmos-meas-tech-discuss.net/7/2339/2014/amtd-7-2339-2014.pdf},
  doi = {10.5194/amtd-7-2339-2014}
}
</pre></td>
</tr>
<tr id="Checa-GarciaEtAl_ERL_2016a" class="entry">
	<td>Checa-Garcia R, Shine KP and Hegglin MI (2016), <i>"The contribution of greenhouse gases to the recent slowdown in global-mean temperature trends"</i>, Environmental Research Letters.  Vol. 11(9), pp. 094018. IOP Publishing.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Checa-GarciaEtAl_ERL_2016a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1088/1748-9326/11/9/094018" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_Checa-GarciaEtAl_ERL_2016a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Checa-GarciaEtAl_ERL_2016a,
  author = {R Checa-Garcia and K P Shine and M I Hegglin},
  title = {The contribution of greenhouse gases to the recent slowdown in global-mean temperature trends},
  journal = {Environmental Research Letters},
  publisher = {IOP Publishing},
  year = {2016},
  volume = {11},
  number = {9},
  pages = {094018},
  doi = {10.1088/1748-9326/11/9/094018}
}
</pre></td>
</tr>
<tr id="Checa-GarciaEtAl_GRL_2018a" class="entry">
	<td>Checa-Garcia R, Hegglin MI, Kinnison D, Plummer DA and Shine KP (2018), <i>"Historical Tropospheric and Stratospheric Ozone Radiative Forcing Using the CMIP6 Database"</i>, Geophysical Research Letters., apr, 2018.  Vol. 45(7), pp. 3264-3273. American Geophysical Union (AGU).
	<p class="infolinks">[<a href="javascript:toggleInfo('Checa-GarciaEtAl_GRL_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Checa-GarciaEtAl_GRL_2018a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1002/2017GL076770" target="_blank">DOI</a>] [<a href="https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1002/2017GL076770" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="abs_Checa-GarciaEtAl_GRL_2018a" class="abstract noshow">
	<td><b>Abstract</b>: Abstract We calculate ozone radiative forcing (RF) and stratospheric temperature adjustments for the period 1850–2014 using the newly available Coupled Model Intercomparison Project phase 6 (CMIP6) ozone data set. The CMIP6 total ozone RF (1850s to 2000s) is 0.28 ± 0.17 W m−2 (which is 80% higher than our CMIP5 estimation), and 0.30 ± 0.17 W m−2 out to the present day (2014). The total ozone RF grows rapidly until the 1970s, slows toward the 2000s, and shows a renewed growth thereafter. Since the 1990s the shortwave RF exceeds the longwave RF. Global stratospheric ozone RF is positive between 1930 and 1970 and then turns negative but remains positive in the Northern Hemisphere throughout. Derived stratospheric temperature changes show a localized cooling in the subtropical lower stratosphere due to tropospheric ozone increases and cooling in the upper stratosphere due to ozone depletion by more than 1 K already prior to the satellite era (1980) and by more than 2 K out to the present day (2014).</td>
</tr>
<tr id="bib_Checa-GarciaEtAl_GRL_2018a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Checa-GarciaEtAl_GRL_2018a,
  author = {Checa-Garcia, Ramiro and Hegglin, Michaela I. and Kinnison, Douglas and Plummer, David A. and Shine, Keith P.},
  title = {Historical Tropospheric and Stratospheric Ozone Radiative Forcing Using the CMIP6 Database},
  journal = {Geophysical Research Letters},
  publisher = {American Geophysical Union (AGU)},
  year = {2018},
  volume = {45},
  number = {7},
  pages = {3264-3273},
  url = {https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1002/2017GL076770},
  doi = {10.1002/2017GL076770}
}
</pre></td>
</tr>
<tr id="ChecaTapiador_E_2011a" class="entry">
	<td>Checa-Garcia R and Tapiador FJ (2011), <i>"A Maximum Entropy Modelling of the Rain Drop Size Distribution"</i>, Entropy.  Vol. 13(12), pp. 293-315. MDPI AG.
	<p class="infolinks"> [<a href="javascript:toggleInfo('ChecaTapiador_E_2011a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.3390/e13020293" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_ChecaTapiador_E_2011a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{ChecaTapiador_E_2011a,
  author = {Ramiro Checa-Garcia and Francisco J. Tapiador},
  title = {A Maximum Entropy Modelling of the Rain Drop Size Distribution},
  journal = {Entropy},
  publisher = {MDPI AG},
  year = {2011},
  volume = {13},
  number = {12},
  pages = {293--315},
  doi = {10.3390/e13020293}
}
</pre></td>
</tr>
<tr id="Gli2020" class="entry">
	<td>Gliss J, Mortier A, Schulz M, Andrews E, Balkanski Y, Bauer SE, Benedictow AMK, Bian H, Checa-Garcia R, Chin M, Ginoux P, Griesfeller JJ, Heckel A, Kipling Z, Kirkevaag A, Kokkola H, Laj P, Sager PL, Lund MT, Myhre CL, Matsui H, Myhre G, Neubauer D, van Noije T, North P, Olivie DJL, Sogacheva L, Takemura T, Tsigaridis K and Tsyro SG (2020), <i>"Multi-model evaluation of aerosol optical properties in the AeroCom phase III Control experiment, using ground and space based columnar observations from AERONET, MODIS, AATSR and a merged satellite product as well as surface in-situ observations from GAW sites"</i>, Atmospheric Chemistry and Physics., March, 2020.  Copernicus.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Gli2020','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2019-1214" target="_blank">DOI</a>] [<a href="https://doi.org/10.5194/acp-2019-1214" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Gli2020" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Gli2020,
  author = {Jonas Gliss and Augustin Mortier and Michael Schulz and Elisabeth Andrews and Yves Balkanski and Susanne E. Bauer and Anna M. K. Benedictow and Huisheng Bian and Ramiro Checa-Garcia and Mian Chin and Paul Ginoux and Jan J. Griesfeller and Andreas Heckel and Zak Kipling and Alf Kirkevaag and Harri Kokkola and Paolo Laj and Philippe Le Sager and Marianne Tronstad Lund and Cathrine Lund Myhre and Hitoshi Matsui and Gunnar Myhre and David Neubauer and Twan van Noije and Peter North and Dirk J. L. Olivie and Larisa Sogacheva and Toshihiko Takemura and Kostas Tsigaridis and Svetlana G. Tsyro},
  title = {Multi-model evaluation of aerosol optical properties in the AeroCom phase III Control experiment, using ground and space based columnar observations from AERONET, MODIS, AATSR and a merged satellite product as well as surface in-situ observations from GAW sites},
  journal = {Atmospheric Chemistry and Physics},
  publisher = {Copernicus},
  year = {2020},
  url = {https://doi.org/10.5194/acp-2019-1214},
  doi = {10.5194/acp-2019-1214}
}
</pre></td>
</tr>
<tr id="Keeble2020" class="entry">
	<td>Keeble J, Hassler B, Banerjee A, Checa-Garcia R, Chiodo G, Davis S, Eyring V, Griffiths PT, Morgenstern O, Nowack P, Zeng G, Zhang J, Bodeker G, Cugnet D, Danabasoglu G, Deushi M, Horowitz LW, Li L, Michou M, Mills MJ, Nabat P, Park S and Wu T (2020), <i>"Evaluating stratospheric ozone and water vapor changes in CMIP6 models from 1850-2100"</i>, Atmospheric Chemistry and Physics., February, 2020.  Copernicus.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Keeble2020','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2019-1202" target="_blank">DOI</a>] [<a href="https://doi.org/10.5194/acp-2019-1202" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Keeble2020" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Keeble2020,
  author = {James Keeble and Birgit Hassler and Antara Banerjee and Ramiro Checa-Garcia and Gabriel Chiodo and Sean Davis and Veronika Eyring and Paul T. Griffiths and Olaf Morgenstern and Peer Nowack and Guang Zeng and Jiankai Zhang and Greg Bodeker and David Cugnet and Gokhan Danabasoglu and Makoto Deushi and Larry W. Horowitz and Lijuan Li and Martine Michou and Michael J. Mills and Pierre Nabat and Sungsu Park and Tongwen Wu},
  title = {Evaluating stratospheric ozone and water vapor changes in CMIP6 models from 1850-2100},
  journal = {Atmospheric Chemistry and Physics},
  publisher = {Copernicus},
  year = {2020},
  url = {https://doi.org/10.5194/acp-2019-1202},
  doi = {10.5194/acp-2019-1202}
}
</pre></td>
</tr>
<tr id="TapiadorEtAl_EES_2011a" class="entry">
	<td>Tapiador FJ, Hou AY, de Castro M, Checa-Garcia R, Cuartero F and Barros AP (2011), <i>"Precipitation estimates for hydroelectricity"</i>, Energy &amp; Environmental Science.  Vol. 4(11), pp. 4435. Royal Society of Chemistry (RSC).
	<p class="infolinks">[<a href="javascript:toggleInfo('TapiadorEtAl_EES_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('TapiadorEtAl_EES_2011a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1039/c1ee01745d" target="_blank">DOI</a>] [<a href="http://dx.doi.org/10.1039/C1EE01745D" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="abs_TapiadorEtAl_EES_2011a" class="abstract noshow">
	<td><b>Abstract</b>: Hydroelectric plants require precise and timely estimates of rain, snow and other hydrometeors for operations. However, it is far from being a trivial task to measure and predict precipitation. This paper presents the linkages between precipitation science and hydroelectricity, and in doing so it provides insight into current research directions that are relevant for this renewable energy. Methods described include radars, disdrometers, satellites and numerical models. Two recent advances that have the potential of being highly beneficial for hydropower operations are featured: the Global Precipitation Measuring (GPM) mission, which represents an important leap forward in precipitation observations from space, and high performance computing (HPC) and grid technology, that allows building ensembles of numerical weather and climate models.</td>
</tr>
<tr id="bib_TapiadorEtAl_EES_2011a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{TapiadorEtAl_EES_2011a,
  author = {Francisco J. Tapiador and Arthur Y. Hou and Manuel de Castro and Ramiro Checa-Garcia and Fernando Cuartero and Ana P. Barros},
  title = {Precipitation estimates for hydroelectricity},
  journal = {Energy &amp; Environmental Science},
  publisher = {Royal Society of Chemistry (RSC)},
  year = {2011},
  volume = {4},
  number = {11},
  pages = {4435},
  url = {http://dx.doi.org/10.1039/C1EE01745D},
  doi = {10.1039/c1ee01745d}
}
</pre></td>
</tr>
<tr id="TapiadorEtAl_GRL_2010a" class="entry">
	<td>Tapiador FJ, Checa-Garcia R and de Castro M (2010), <i>"An experiment to measure the spatial variability of rain drop size distribution using sixteen laser disdrometers"</i>, Geophysical Research Letters.  Vol. 37(16), pp. L16803. Wiley-Blackwell.
	<p class="infolinks"> [<a href="javascript:toggleInfo('TapiadorEtAl_GRL_2010a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1029/2010gl044120" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_TapiadorEtAl_GRL_2010a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{TapiadorEtAl_GRL_2010a,
  author = {Tapiador, F.&nbsp;J. and Checa-Garcia, R. and de Castro, M.},
  title = {An experiment to measure the spatial variability of rain drop size distribution using sixteen laser disdrometers},
  journal = {Geophysical Research Letters},
  publisher = {Wiley-Blackwell},
  year = {2010},
  volume = {37},
  number = {16},
  pages = {L16803},
  doi = {10.1029/2010gl044120}
}
</pre></td>
</tr>
<tr id="TarazonaEtAl_PRL_2007a" class="entry">
	<td>Tarazona P, Checa-Garcia R and Chacon E (2007), <i>"Critical Analysis of the Density Functional Theory Prediction of Enhanced Capillary Waves"</i>, Physical Review Letters.  Vol. 99(19), pp. 196101. American Physical Society (APS).
	<p class="infolinks"> [<a href="javascript:toggleInfo('TarazonaEtAl_PRL_2007a','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.1103/PhysRevLett.99.196101" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_TarazonaEtAl_PRL_2007a" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{TarazonaEtAl_PRL_2007a,
  author = {Tarazona, P. and Checa-Garcia, R. and Chacon, E.},
  title = {Critical Analysis of the Density Functional Theory Prediction of Enhanced Capillary Waves},
  journal = {Physical Review Letters},
  publisher = {American Physical Society (APS)},
  year = {2007},
  volume = {99},
  number = {19},
  pages = {196101},
  doi = {10.1103/PhysRevLett.99.196101}
}
</pre></td>
</tr>
<tr id="Thornhill2020" class="entry">
	<td>Thornhill G, Collins W, Olivie D, Archibald A, Bauer S, Checa-Garcia R, Fiedler S, Folberth G, Gjermundsen A, Horowitz L, Lamarque J-F, Michou M, Mulcahy J, Nabat P, Naik V, O'Connor FM, Paulot F, Schulz M, Scott CE, Seferian R, Smith C, Takemura T, Tilmes S and Weber J (2020), <i>"Climate-driven chemistry and aerosol feedbacks in CMIP6 Earth system models"</i>, Atmospheric Chemistry and Physics., February, 2020.  Copernicus.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Thornhill2020','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2019-1207" target="_blank">DOI</a>] [<a href="https://doi.org/10.5194/acp-2019-1207" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Thornhill2020" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Thornhill2020,
  author = {Gillian Thornhill and William Collins and Dirk Olivie and Alex Archibald and Susanne Bauer and Ramiro Checa-Garcia and Stephanie Fiedler and Gerd Folberth and Ada Gjermundsen and Larry Horowitz and Jean-Francois Lamarque and Martine Michou and Jane Mulcahy and Pierre Nabat and Vaishali Naik and Fiona M. O'Connor and Fabien Paulot and Michael Schulz and Catherine E. Scott and Roland Seferian and Chris Smith and Toshihiko Takemura and Simone Tilmes and James Weber},
  title = {Climate-driven chemistry and aerosol feedbacks in CMIP6 Earth system models},
  journal = {Atmospheric Chemistry and Physics},
  publisher = {Copernicus},
  year = {2020},
  url = {https://doi.org/10.5194/acp-2019-1207},
  doi = {10.5194/acp-2019-1207}
}
</pre></td>
</tr>
<tr id="Thornhill2020b" class="entry">
	<td>Thornhill GD, Collins WJ, Kramer RJ, Olivié D, O'Connor F, Abraham NL, Checa-Garcia R, Bauer SE, Deushi M, Emmons L, Forster P, Horowitz L, Johnson B, Keeble J, Lamarque J-F, Michou M, Mills M, Mulcahy J, Myhre G, Nabat P, Naik V, Oshima N, Schulz M, Smith C, Takemura T, Tilmes S, Wu T, Zeng G and Zhang J (2020), <i>"Effective Radiative forcing from emissions of reactive gases and aerosols – a multimodel comparison"</i>, Atmospheric Chemistry and Physics Discussions.  Vol. 2020, pp. 1–29.
	<p class="infolinks"> [<a href="javascript:toggleInfo('Thornhill2020b','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2019-1205" target="_blank">DOI</a>] [<a href="https://acp.copernicus.org/preprints/acp-2019-1205/" target="_blank">URL</a>]</p>
	</td>
</tr>
<tr id="bib_Thornhill2020b" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{Thornhill2020b,
  author = {Thornhill, G. D. and Collins, W. J. and Kramer, R. J. and Olivié, D. and O'Connor, F. and Abraham, N. L. and Checa-Garcia, R. and Bauer, S. E. and Deushi, M. and Emmons, L. and Forster, P. and Horowitz, L. and Johnson, B. and Keeble, J. and Lamarque, J.-F. and Michou, M. and Mills, M. and Mulcahy, J. and Myhre, G. and Nabat, P. and Naik, V. and Oshima, N. and Schulz, M. and Smith, C. and Takemura, T. and Tilmes, S. and Wu, T. and Zeng, G. and Zhang, J.},
  title = {Effective Radiative forcing from emissions of reactive gases and aerosols – a multimodel comparison},
  journal = {Atmospheric Chemistry and Physics Discussions},
  year = {2020},
  volume = {2020},
  pages = {1–29},
  url = {https://acp.copernicus.org/preprints/acp-2019-1205/},
  doi = {10.5194/acp-2019-1205}
}
</pre></td>
</tr>
<tr id="" class="entry">
	<td>Kok J, Adebiyi A, Albani S, Balkanski Y and Checa-Garcia Rea (2020), <i>"Improved representation of the global dust cycle using observational constraints on dust properties and abundance"</i>, Atmospheric Chemistry and Physics. 
	<p class="infolinks"> [<a href="javascript:toggleInfo('','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2020-1131" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{,
  author = {Kok, J. and Adebiyi, A. and Albani, S. and Balkanski, Y. and Checa-Garcia, R. et al},
  title = {Improved representation of the global dust cycle using observational constraints on dust properties and abundance},
  journal = {Atmospheric Chemistry and Physics},
  year = {2020},
  doi = {10.5194/acp-2020-1131}
}
</pre></td>
</tr>
<tr id="" class="entry">
	<td>Checa-Garcia R, Balkanski Y, Albani S, Bergman T, Van Noije T, Cozic A, Marticorena B, Olivié D, O'Connor F, Michou M, Nabat P and Schulz M (2020), <i>"Evaluation of natural aerosols in CRESCENDO-ESMs: Mineral Dust"</i>, Atmospheric Chemistry and Physics. 
	<p class="infolinks"> [<a href="javascript:toggleInfo('','bibtex')">BibTeX</a>] [<a href="https://doi.org/10.5194/acp-2020-1147" target="_blank">DOI</a>]</p>
	</td>
</tr>
<tr id="bib_" class="bibtex noshow">
<td><b>BibTeX</b>:
<pre>
@article{,
  author = {Checa-Garcia, R. and Balkanski, Y. and Albani, S. and Bergman, T. and Van Noije, T. and Cozic, A. and Marticorena, B. and Olivié, D. and O'Connor, F. and  Michou, M. and Nabat, P.  and Schulz, M.},
  title = {Evaluation of natural aerosols in CRESCENDO-ESMs: Mineral Dust},
  journal = {Atmospheric Chemistry and Physics},
  year = {2020},
  doi = {10.5194/acp-2020-1147}
}
</pre></td>
</tr>
</tbody>
</table>


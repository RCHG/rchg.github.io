---
layout: page
sidebar: right
subheadline: Tips
title: "Key references of Atmospheric Mineral Dust"
excerpt: "Step by Step "
teaser: "List of bibtex references about Atmospheric Dust."
breadcrumb: true
tags: [books]
categories:
    - science-blog
header:
    title: List of Atmospheric Dust References
    pattern: pattern_jquery-dark-grey-tile.png
---

<head>
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
	 case "opt_searchRev":
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
	if(searchComment){document.getElementById("opt_searchRev").checked = true;}
	if(noSquiggles){document.getElementById("opt_noAccents").checked = true;}
	if(searchRegExp){document.getElementById("opt_useRegExp").checked = true;}
	
	if(numAbs==0) {document.getElementById("opt_searchAbs").parentNode.style.display = 'none';}
	if(numRev==0) {document.getElementById("opt_searchRev").parentNode.style.display = 'none';}
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
<!-- body { background-color: white; font-family: Arial, sans-serif; font-size: 10px; line-height: 1.1; padding: 1em; color: #2E2E2E; margin: auto 2em; } -->

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

table { width: 95%; empty-cells: show; border-spacing: 0em 0.2em; margin: 1em 0em; border-style: none;  font-size: 8px; font-family: Arial}
th, td { border: 1px gray solid; border-width: 1px 1px; padding: 0.5em; vertical-align: top; text-align: left; }
th { background-color: #efefef; }
td + td, th + th { border-left: none; }

td a { color: navy; text-decoration: none; }
td a:hover  { text-decoration: underline; }

tr.noshow { display: none;}
tr.highlight td { background-color: #EFEFEF; border-top: 2px #2E2E2E solid; font-weight: bold; }
tr.abstract td, tr.comment td, tr.bibtex td { background-color: #EFEFEF; text-align: justify; border-bottom: 2px #2E2E2E solid; }
tr.nextshow td { border-bottom: 1px gray solid; }

tr.bibtex pre { width: 95%; overflow: auto; white-space: pre-wrap;}
p.infolinks { margin: 0.3em 0em 0em 0em; padding: 0px; }

@media print {
	p.infolinks, #qs_settings, #quicksearch, t.bibtex { display: none !important; }
	tr { page-break-inside: avoid; }
}
</style>
</head>
<body>

<form action="" id="quicksearch">
<input type="text" id="qs_field" autocomplete="off" placeholder="Type to search..." /> <input type="button" onclick="clearQS()" value="clear" />
<span id="searchstat">Matching entries: <span id="stat">0</span></span>
<div id="showsettings" onclick="toggleSettings()">settings...</div>
<div id="settings" class="hidden">
<ul>
<li><input type="checkbox" class="search_setting" id="opt_searchAbs" onchange="updateSetting(this)"><label for="opt_searchAbs"> include abstract</label></li>
<li><input type="checkbox" class="search_setting" id="opt_searchRev" onchange="updateSetting(this)"><label for="opt_searchRev"> include comment</label></li>
<li><input type="checkbox" class="search_setting" id="opt_useRegExp" onchange="updateSetting(this)"><label for="opt_useRegExp"> use RegExp</label></li>
<li><input type="checkbox" class="search_setting" id="opt_noAccents" onchange="updateSetting(this)"><label for="opt_noAccents"> ignore accents</label></li>
</ul>
</div>
</form>
<table id="qs_table" border="1">
<thead><tr><th width="25%"; font-size="7px">Author</th><th width="30%">Title</th><th width="5%">Year</th><th width="20%">Journal </th><th width="5%">Reftype</th><th width="5%">DOI/URL</th></tr></thead>
<tbody><tr id="Baddock_etal__2016a" class="entry">
	<td>Baddock, M.C., Ginoux, P., Bullard, J.E. and Gill, T.E.</td>
	<td>Do MODIS-defined dust sources have a geomorphological signature? <p class="infolinks">[<a href="javascript:toggleInfo('Baddock_etal__2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Baddock_etal__2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>grl<br/>Vol. 43, pp. 2606-2613&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015GL067327">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016GeoRL..43.2606B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Baddock_etal__2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The preferential dust source (PDS) scheme enables large-scale mapping of geomorphology in terms of importance for dust emissions but has not been independently tested other than at local scales. We examine the PDS qualitative conceptual model of surface emissivity alongside a quantitative measurement of dust loading from Moderate Resolution Imaging Spectroradiometer (MODIS) Deep Blue Collection 6 for the Chihuahuan Desert. The predicted ranked importance of each geomorphic type for dust emissions is compared with the actual ranked importance as determined from the satellite-derived dust loading. For this region, the predicted variability and magnitude of dust emissions from most surface types present coincides with the observed characteristics demonstrating the significance of geomorphological controls on emission. The exception is for areas of low magnitude but persistent emissions such as alluvial surfaces where PDS overpredicts dustiness. As PDS is a good predictor of emissions and incorporates surface dynamics it could improve models of future dust emissions.</td>
</tr>
<tr id="bib_Baddock_etal__2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Baddock_etal__2016a,
  author = {Baddock, M. C. and Ginoux, P. and Bullard, J. E. and Gill, T. E.},
  title = {Do MODIS-defined dust sources have a geomorphological signature?},
  journal = {grl},
  year = {2016},
  volume = {43},
  pages = {2606-2613},
  url = {http://adsabs.harvard.edu/abs/2016GeoRL..43.2606B},
  doi = {https://doi.org/10.1002/2015GL067327}
}
</pre></td>
</tr>
<tr id="Carslaw_etal__2013a" class="entry">
	<td>Carslaw, K.S., Lee, L.A., Reddington, C.L., Pringle, K.J., Rap, A., Forster, P.M., Mann, G.W., Spracklen, D.V., Woodhouse, M.T., Regayre, L.A. and Pierce, J.R.</td>
	<td>Large contribution of natural aerosols to uncertainty in indirect forcing <p class="infolinks">[<a href="javascript:toggleInfo('Carslaw_etal__2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Carslaw_etal__2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>nat<br/>Vol. 503, pp. 67-71&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/nature12674">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013Natur.503...67C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Carslaw_etal__2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The effect of anthropogenic aerosols on cloud droplet concentrations and radiative properties is the source of one of the largest uncertainties in the radiative forcing of climate over the industrial period. This uncertainty affects our ability to estimate how sensitive the climate is to greenhouse gas emissions. Here we perform a sensitivity analysis on a global model to quantify the uncertainty in cloud radiative forcing over the industrial period caused by uncertainties in aerosol emissions and processes. Our results show that 45 per cent of the variance of aerosol forcing since about 1750 arises from uncertainties in natural emissions of volcanic sulphur dioxide, marine dimethylsulphide, biogenic volatile organic carbon, biomass burning and sea spray. Only 34 per cent of the variance is associated with anthropogenic emissions. The results point to the importance of understanding pristine pre-industrial-like environments, with natural aerosols only, and suggest that improved measurements and evaluation of simulated aerosols in polluted present-day conditions will not necessarily result in commensurate reductions in the uncertainty of forcing estimates.</td>
</tr>
<tr id="bib_Carslaw_etal__2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Carslaw_etal__2013a,
  author = {Carslaw, K. S. and Lee, L. A. and Reddington, C. L. and Pringle, K. J. and Rap, A. and Forster, P. M. and Mann, G. W. and Spracklen, D. V. and Woodhouse, M. T. and Regayre, L. A. and Pierce, J. R.},
  title = {Large contribution of natural aerosols to uncertainty in indirect forcing},
  journal = {nat},
  year = {2013},
  volume = {503},
  pages = {67-71},
  url = {http://adsabs.harvard.edu/abs/2013Natur.503...67C},
  doi = {https://doi.org/10.1038/nature12674}
}
</pre></td>
</tr>
<tr id="Delmas_etal__1999a" class="entry">
	<td>Delmas, R.A., Druilhet, A., Cros, B., Durand, P., Delon, C., Lacaux, J.P., Brustet, J.M., Ser&cedil; cA, D., Affre, C., Guenther, A., Greenberg, J., Baugh, W., Harley, P., Klinger, L., Ginoux, P., Brasseur, G., Zimmerman, P.R., Gr&eacute;Goire, J.M., Janodet, E., Tournier, A., Perros, P., Marion, T., Gaudichet, A., Cachier, H., Ruellan, S., Masclet, P., Cautenet, S., Poulet, D., Biona, C.B., Nganga, D., Tathy, J.P., Minga, A., Loemba-Ndembi, J. and Ceccato, P.</td>
	<td>Experiment for Regional Sources and Sinks of Oxidants (EXPRESSO): An overview <p class="infolinks">[<a href="javascript:toggleInfo('Delmas_etal__1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Delmas_etal__1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>jgr<br/>Vol. 104, pp. 30&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999JD900291">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999JGR...10430609D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Delmas_etal__1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper presents an overview of the Experiment for Regional Sources and Sinks of Oxidents (EXPRESSO) including the objectives of the project, a detailed description of the characteristics of the experimental region and of field instrumentation deployed, and a summary of the main results of all components of the experiment. EXPRESSO is an international, multidisciplinary effort to quantify and better understand the processes controlling surface fluxes of photochemical precursors emitted by vegetation and biomass burning along a tropical forest to savanna gradient in central Africa. The experiment was conducted at the beginning of the dry season in November-December 1996. Three main research tools were deployed during this period: (1) the French research aircraft (Avion de Recherche Atmosph&eacute;rique et de T&eacute;l&eacute;d&eacute;tection, Fokker 27), instrumented for chemistry and flux measurements (CNRS- France), (2) two satellite receivers for in situ acquisition of National Oceanic and Atmospheric Administration-advanced very high resolution radiometer (NOAA-AVHRR) imagery for fire detection (EC-JRC, Ispra, Italy), and (3) a 65-m walkup tower installed at a tropical forest site in the Republic of Congo (National Center for Atmospheric Research, Boulder, Colorado). Average dynamic and turbulence characteristics over savanna and forest ecosystems were retrieved from aircraft measurements. They illustrate the complex atmospheric circulation occurring in this region in the vicinity of the Intertropical Convergence Zone. Satellite receivers were operated three times a day to produce maps of fire distribution. Statistics and mapping of burned surfaces from NOAA-AVHRR and ERS-Along Track Scanning Radiometer space systems have been developed. The influence of biogenic and biomass burning sources on the chemical composition of the lower atmosphere was studied through both aircraft and tower measurements. The EXPRESSO field campaign was followed by modeling efforts (regional and global scales) in which model components are evaluated using the experimental data.</td>
</tr>
<tr id="bib_Delmas_etal__1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Delmas_etal__1999a,
  author = {Delmas, R. A. and Druilhet, A. and Cros, B. and Durand, P. and Delon, C. and Lacaux, J. P. and Brustet, J. M. and Ser&cedil; cA, D. and Affre, C. and Guenther, A. and Greenberg, J. and Baugh, W. and Harley, P. and Klinger, L. and Ginoux, P. and Brasseur, G. and Zimmerman, P. R. and Gr&eacute;Goire, J. M. and Janodet, E. and Tournier, A. and Perros, P. and Marion, T. and Gaudichet, A. and Cachier, H. and Ruellan, S. and Masclet, P. and Cautenet, S. and Poulet, D. and Biona, C. B. and Nganga, D. and Tathy, J. P. and Minga, A. and Loemba-Ndembi, J. and Ceccato, P.},
  title = {Experiment for Regional Sources and Sinks of Oxidants (EXPRESSO): An overview},
  journal = {jgr},
  year = {1999},
  volume = {104},
  pages = {30},
  url = {http://adsabs.harvard.edu/abs/1999JGR...10430609D},
  doi = {https://doi.org/10.1029/1999JD900291}
}
</pre></td>
</tr>
<tr id="Erickson_etal__2003a" class="entry">
	<td>Erickson, D.J., Hernandez, J.L., Ginoux, P., Gregg, W.W., McClain, C. and Christian, J.</td>
	<td>Atmospheric iron delivery and surface ocean biological activity in the Southern Ocean and Patagonian region <p class="infolinks">[<a href="javascript:toggleInfo('Erickson_etal__2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Erickson_etal__2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>grl<br/>Vol. 30, pp. 1609&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003GL017241">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003GeoRL..30.1609E">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Erickson_etal__2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Iron is a limiting nutrient for biologic activity in much of the world ocean. We present a method to quantitatively address the response of surface ocean biology to inputs of atmospheric Fe associated with atmospheric dust. We merge two enabling technologies, global models of Earth system processes and satellite derived chlorophyll concentrations to assess the importance of Fe in oceanic biogeochemistry. We present an objective correlation analysis to elucidate the spatial response of chlorophyll to iron flux considering the ocean surface meridional center of mass in areas with high correlation. Several regions between 40degS and 60degS show correlations from 0.6 to 0.95, significant at the 0.05 level, particularly the Patagonian region. Surface chlorophyll and iron flux follow similar patterns, however chlorophyll may be displaced to different latitudes than where Fe input occurs due to meridional ocean transport.</td>
</tr>
<tr id="bib_Erickson_etal__2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Erickson_etal__2003a,
  author = {Erickson, D. J. and Hernandez, J. L. and Ginoux, P. and Gregg, W. W. and McClain, C. and Christian, J.},
  title = {Atmospheric iron delivery and surface ocean biological activity in the Southern Ocean and Patagonian region},
  journal = {grl},
  year = {2003},
  volume = {30},
  pages = {1609},
  url = {http://adsabs.harvard.edu/abs/2003GeoRL..30.1609E},
  doi = {https://doi.org/10.1029/2003GL017241}
}
</pre></td>
</tr>
<tr id="Evans_etal__2016a" class="entry">
	<td>Evans, S., Ginoux, P., Malyshev, S. and Shevliakova, E.</td>
	<td>Climate-vegetation interaction and amplification of Australian dust variability <p class="infolinks">[<a href="javascript:toggleInfo('Evans_etal__2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Evans_etal__2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>grl<br/>Vol. 43, pp. 11&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2016GL071016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016GeoRL..4311823E">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Evans_etal__2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Observations show that Australian dust activity varies by a factor of 4 on decadal timescales. General circulation models, however, typically fail to simulate this variability. Here we introduce a new dust parameterization into the NOAA/Geophysical Fluid Dynamics Laboratory climate model CM3 that represents land surface processes controlling dust sources including soil water and ice, snow cover, vegetation characteristics, and land type. In an additional novel step, we couple this new dust parameterization to the dynamic vegetation model LM3. In Australia, the new parameterization amplifies the magnitude and timescale of dust variability and better simulates the El Ni&ntilde;o-Southern Oscillation-dust relationship by more than doubling its strength. We attribute these improvements primarily to the slow response time of vegetation to precipitation anomalies and show that vegetation changes account for approximately 50&#37; of enhanced dust emission during El Ni&ntilde;o events. The amplified dust leads to radiative forcing over Australia greater than -1 and -20 W/m^2 at top of atmosphere and surface, respectively.</td>
</tr>
<tr id="bib_Evans_etal__2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Evans_etal__2016a,
  author = {Evans, S. and Ginoux, P. and Malyshev, S. and Shevliakova, E.},
  title = {Climate-vegetation interaction and amplification of Australian dust variability},
  journal = {grl},
  year = {2016},
  volume = {43},
  pages = {11},
  url = {http://adsabs.harvard.edu/abs/2016GeoRL..4311823E},
  doi = {https://doi.org/10.1002/2016GL071016}
}
</pre></td>
</tr>
<tr id="Ganguly_etal__2009a" class="entry">
	<td>Ganguly, D., Ginoux, P., Ramaswamy, V., Winker, D.M., Holben, B.N. and Tripathi, S.N.</td>
	<td>Retrieving the composition and concentration of aerosols over the Indo-Gangetic basin using CALIOP and AERONET data <p class="infolinks">[<a href="javascript:toggleInfo('Ganguly_etal__2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ganguly_etal__2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>grl<br/>Vol. 36, pp. L13806&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009GL038315">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009GeoRL..3613806G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ganguly_etal__2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Most GCMs (General Circulation Models) fail to reproduce the AOD (aerosol optical depth) peak over the Indo-Gangetic basin (IGB) as noticed through satellite observations. Insufficient data on aerosol composition makes it difficult to improve GCM results over this source region. In this work, we retrieve the composition and concentration of aerosols over the IGB region, to a first order approximation, by combining the spectral measurements of AOD, single scattering albedo and size distribution available from AERONET (Aerosol Robotic Network) and the extinction profile of aerosols from CALIOP (Cloud-Aerosol Lidar with Orthogonal Polarization). Comparison of our results with AM2 (Atmospheric GCM) simulations reveal that AM2 is largely underestimating organics and black carbon concentrations over this region during all months. Sulfate is also underestimated during most months but, there is an overestimation from May to September. There is a compelling need for improving the aerosol inventories and dust sources over the region in order to make realistic assessment of the impacts of aerosols on the south Asian monsoon.</td>
</tr>
<tr id="bib_Ganguly_etal__2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ganguly_etal__2009a,
  author = {Ganguly, D. and Ginoux, P. and Ramaswamy, V. and Winker, D. M. and Holben, B. N. and Tripathi, S. N.},
  title = {Retrieving the composition and concentration of aerosols over the Indo-Gangetic basin using CALIOP and AERONET data},
  journal = {grl},
  year = {2009},
  volume = {36},
  pages = {L13806},
  url = {http://adsabs.harvard.edu/abs/2009GeoRL..3613806G},
  doi = {https://doi.org/10.1029/2009GL038315}
}
</pre></td>
</tr>
<tr id="Ginoux_etal__2001a" class="entry">
	<td>Ginoux, P., Chin, M., Tegen, I., Prospero, J.M., Holben, B., Dubovik, O. and Lin, S.-J.</td>
	<td>Sources and distributions of dust aerosols simulated with the GOCART model <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal__2001a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal__2001a','bibtex')">BibTeX</a>]</p></td>
	<td>2001</td>
	<td>jgr<br/>Vol. 106, pp. 20&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2000JD000053">DOI</a> <a href="http://adsabs.harvard.edu/abs/2001JGR...10620255G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal__2001a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The global distribution of dust aerosol is simulated with the Georgia Tech/Goddard Global Ozone Chemistry Aerosol Radiation and Transport (GOCART) model. In this model all topographic lows with bare ground surface are assumed to have accumulated sediments which are potential dust sources. The uplifting of dust particles is expressed as a function of surface wind speed and wetness. The GOCART model is driven by the assimilated meteorological fields from the Goddard Earth Observing System Data Assimilation System (GEOS DAS) which facilitates direct comparison with observations. The model includes seven size classes of mineral dust ranging from 0.1-6 &mu;m radius. The total annual emission is estimated to be between 1604 and 1960 Tg yr^-1 in a 5-year simulation. The model has been evaluated by comparing simulation results with ground-based measurements and satellite data. The evaluation has been performed by comparing surface concentrations, vertical distributions, deposition rates, optical thickness, and size distributions. The comparisons show that the model results generally agree with the observations without the necessity of invoking any contribution from anthropogenic disturbances to soils. However, the model overpredicts the transport of dust from the Asian sources to the North Pacific. This discrepancy is attributed to an overestimate of small particle emission from the Asian sources.</td>
</tr>
<tr id="bib_Ginoux_etal__2001a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal__2001a,
  author = {Ginoux, P. and Chin, M. and Tegen, I. and Prospero, J. M. and Holben, B. and Dubovik, O. and Lin, S.-J.},
  title = {Sources and distributions of dust aerosols simulated with the GOCART model},
  journal = {jgr},
  year = {2001},
  volume = {106},
  pages = {20},
  url = {http://adsabs.harvard.edu/abs/2001JGR...10620255G},
  doi = {https://doi.org/10.1029/2000JD000053}
}
</pre></td>
</tr>
<tr id="Greenberg_etal__1999a" class="entry">
	<td>Greenberg, J.P., Guenther, A.B., Madronich, S., Baugh, W., Ginoux, P., Druilhet, A., Delmas, R. and Delon, C.</td>
	<td>Biogenic volatile organic compound emissions in central Africa during the Experiment for the Regional Sources and Sinks of Oxidants (EXPRESSO) biomass burning season <p class="infolinks">[<a href="javascript:toggleInfo('Greenberg_etal__1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Greenberg_etal__1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>jgr<br/>Vol. 104, pp. 30&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999JD900475">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999JGR...10430659G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Greenberg_etal__1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The recent aircraft and ground-based Experiment for the Regional Sources and Sinks of Oxidants (EXPRESSO) campaign in central Africa studied atmospheric trace gases and aerosols during the biomass burning season. Isoprene, emitted from vegetation, was the most abundant nonmethane hydrocarbon observed over the forest and savanna, even though intense biomass burning activity was occurring several hundred kilometers to the north. The isoprene flux, measured directly from midmorning to noon by a relaxed eddy accumulation technique, was approximately 890 &mu;g isoprene m^-2 h^-1 from the tropical rain forest and semideciduous forest landscapes and 570 &mu;g isoprene m^-2 h^-1 from transitional and degraded woodland landscapes. Model estimates derived from satellite landscape characterization coupled with leaf enclosure emission measurements conducted during EXPRESSO compared well with these measured fluxes. Isoprene concentrations and fluxes were used to determine the oxidant balance over the forest and savanna. Radiative transfer calculations indicate that the observed strong vertical gradient of the NO_2 photolysis rate coefficient could be explained by the presence of substantial amounts of absorbing aerosols, probably from biomass burning. Chemical (box) model simulations of the planetary boundary layer (PBL), constrained by measured isoprene emission fluxes and concentrations, show that this suppression of photolytic radiation lowers OH concentrations by about a factor of 2 relative to aerosol-free conditions. Consequently, the direct contribution of PBL photochemistry to ozone production, especially from biogenic isoprene, is small.</td>
</tr>
<tr id="bib_Greenberg_etal__1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Greenberg_etal__1999a,
  author = {Greenberg, J. P. and Guenther, A. B. and Madronich, S. and Baugh, W. and Ginoux, P. and Druilhet, A. and Delmas, R. and Delon, C.},
  title = {Biogenic volatile organic compound emissions in central Africa during the Experiment for the Regional Sources and Sinks of Oxidants (EXPRESSO) biomass burning season},
  journal = {jgr},
  year = {1999},
  volume = {104},
  pages = {30},
  url = {http://adsabs.harvard.edu/abs/1999JGR...10430659G},
  doi = {https://doi.org/10.1029/1999JD900475}
}
</pre></td>
</tr>
<tr id="Gregg_etal__2003a" class="entry">
	<td>Gregg, W.W., Conkright, M.E., Ginoux, P., O'Reilly, J.E. and Casey, N.W.</td>
	<td>Ocean primary production and climate: Global decadal changes <p class="infolinks">[<a href="javascript:toggleInfo('Gregg_etal__2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Gregg_etal__2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>grl<br/>Vol. 30, pp. 1809&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003GL016889">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003GeoRL..30.1809G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Gregg_etal__2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Satellite-in situ blended ocean chlorophyll records indicate that global ocean annual primary production has declined more than 6&#37; since the early 1980's. Nearly 70&#37; of the global decadal decline occurred in the high latitudes. In the northern high latitudes, these reductions in primary production corresponded with increases in sea surface temperature and decreases in atmospheric iron deposition to the oceans. In the Antarctic, the reductions were accompanied by increased wind stress. Three of four low latitude basins exhibited decadal increases in annual primary production. These results indicate that ocean photosynthetic uptake of carbon may be changing as a result of climatic changes and suggest major implications for the global carbon cycle.</td>
</tr>
<tr id="bib_Gregg_etal__2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Gregg_etal__2003a,
  author = {Gregg, W. W. and Conkright, M. E. and Ginoux, P. and O'Reilly, J. E. and Casey, N. W.},
  title = {Ocean primary production and climate: Global decadal changes},
  journal = {grl},
  year = {2003},
  volume = {30},
  pages = {1809},
  url = {http://adsabs.harvard.edu/abs/2003GeoRL..30.1809G},
  doi = {https://doi.org/10.1029/2003GL016889}
}
</pre></td>
</tr>
<tr id="Grousset_etal__2003a" class="entry">
	<td>Grousset, F.E., Ginoux, P., Bory, A. and Biscaye, P.E.</td>
	<td>Case study of a Chinese dust plume reaching the French Alps <p class="infolinks">[<a href="javascript:toggleInfo('Grousset_etal__2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Grousset_etal__2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>grl<br/>Vol. 30, pp. 1277&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002GL016833">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003GeoRL..30.1277G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Grousset_etal__2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: By combining reconstruction of airmass back-trajectories from dust deposition sites in Europe and measurements of the (Nd) isotopic composition of deposited dust particles, potential sources of different Saharan dust events can be identified. The study of ``red dust'' events collected in France allowed us to identify distinct North African source areas (e.g. Lybia vs. Mauritania). Surprisingly, the airmass trajectory of one dust event (March 6, 1990) was distinct from the others, and revealed a Chinese origin. The Nd isotopic composition of this dust was consistent with the range of isotopic compositions of Chinese loess. Moreover, an atmospheric global model simulation reveals that a dust plume left China before February 25, 1990, flew over North America around the February/March transition and reached the French Alps by March 6, 1990, revealing that intercontinental dust and pollutant transport may occur across the Pacific Ocean and the North Atlantic at the Westerlies latitudes.</td>
</tr>
<tr id="bib_Grousset_etal__2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Grousset_etal__2003a,
  author = {Grousset, F. E. and Ginoux, P. and Bory, A. and Biscaye, P. E.},
  title = {Case study of a Chinese dust plume reaching the French Alps},
  journal = {grl},
  year = {2003},
  volume = {30},
  pages = {1277},
  url = {http://adsabs.harvard.edu/abs/2003GeoRL..30.1277G},
  doi = {https://doi.org/10.1029/2002GL016833}
}
</pre></td>
</tr>
<tr id="Guo_etal__2015a" class="entry">
	<td>Guo, H., Golaz, J.-C., Donner, L.J., Wyman, B., Zhao, M. and Ginoux, P.</td>
	<td>CLUBB as a unified cloud parameterization: Opportunities and challenges <p class="infolinks">[<a href="javascript:toggleInfo('Guo_etal__2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Guo_etal__2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>grl<br/>Vol. 42, pp. 4540-4547&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015GL063672">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015GeoRL..42.4540G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Guo_etal__2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: CLUBB (Cloud Layers Unified by Binormals) is a higher-order closure (HOC) method with an assumed joint probability density function (PDF) for the subgrid variations in vertical velocity, temperature, and moisture. CLUBB has been implemented in the atmospheric component (AM3) of the Geophysical Fluid Dynamics Laboratory general circulation model AM3-CLUBB and successfully unifies the treatment of shallow convection, resolved clouds, and planetary boundary layer (PBL). In this study, we further explore the possibility for CLUBB to unify the deep convection in a new configuration referred as AM3-CLUBB+. AM3-CLUBB+ simulations with prescribed sea surface temperature are discussed. Cloud, radiation, and precipitation fields compare favorably with observations and reanalyses. AM3-CLUBB+ successfully captures the transition from stratocumulus to deep convection and the modulated response of liquid water path to aerosols. Simulations of tropical variability and the Madden-Julian oscillation (MJO) are also improved. Deficiencies include excessive tropical water vapor and insufficient ice clouds in the midlatitudes.</td>
</tr>
<tr id="bib_Guo_etal__2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guo_etal__2015a,
  author = {Guo, H. and Golaz, J.-C. and Donner, L. J. and Wyman, B. and Zhao, M. and Ginoux, P.},
  title = {CLUBB as a unified cloud parameterization: Opportunities and challenges},
  journal = {grl},
  year = {2015},
  volume = {42},
  pages = {4540-4547},
  url = {http://adsabs.harvard.edu/abs/2015GeoRL..42.4540G},
  doi = {https://doi.org/10.1002/2015GL063672}
}
</pre></td>
</tr>
<tr id="Hauglustaine_etal__1999a" class="entry">
	<td>Hauglustaine, D.A., Madronich, S., Ridley, B.A., Flocke, S.J., Cantrell, C.A., Eisele, F.L., Shetter, R.E., Tanner, D.J., Ginoux, P. and Atlas, E.L.</td>
	<td>Photochemistry and budget of ozone during the Mauna Loa Observatory Photochemistry Experiment (MLOPEX 2) <p class="infolinks">[<a href="javascript:toggleInfo('Hauglustaine_etal__1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Hauglustaine_etal__1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>jgr<br/>Vol. 104, pp. 30&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999JD900441">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999JGR...10430275H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Hauglustaine_etal__1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: During the Mauna Loa Observatory Photochemistry Experiment (MLOPEX 2), simultaneous measurements of a large number of photochemical species were measured during different seasons at Mauna Loa Observatory (MLO), Hawaii. In this study, these measurements are used to constrain a detailed photochemical box model and evaluate our understanding of the tropospheric photochemistry in this region of the Pacific. The simulations generally reproduce satisfactorily the NO/NO_2 photostationary state, which controls the ozone production rate. However, the model fails in simulating the concentration of peroxy radicals (PO_2) during all seasons and of hydroxyl radical (OH) during summer. Several hypotheses are considered to assess this discrepancy, including the removal of radicals by unidentified mechanisms and the potential impact of biogenic organic compounds. None of the tested hypotheses give satisfactorily results in terms of OH, PO_2 and NO/NO_2 simultaneously. Although experimental uncertainties are large for radicals, this issue constitutes a major inconsistency between measurements and model results during MLOPEX. Another disagreement arises from the simulation of peroxides for free tropospheric conditions. The model tends to overestimate H_2O_2 and CH_3OOH by a factor of 1.5-2.5. On the other hand, a fair agreement is achieved in simulating formaldehyde when CH_3OOH is constrained in the model. Finally, we find that the gross ozone production and destruction rates are nearly in balance in this region of the Pacific troposphere. The net production is slightly negative, ranging from nearly 0 in winter to about -1.4 ppbv/d during summer. In contrast, the NO_x budget shows a severe imbalance. Our results indicate that an additional source of NO_x ranging from 18 to 48 pptv/d (in winter and summer, respectively) would be required to sustain the 30 pptv of NO_x measured on average at the site during free tropospheric conditions. Acetone has little effect on the budget of HO_x at the altitude of MLO (3.4 km). However, including this species in the model induces an even larger imbalance in the NO_x budget through the production of peroxyacetylnitrate.</td>
</tr>
<tr id="bib_Hauglustaine_etal__1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hauglustaine_etal__1999a,
  author = {Hauglustaine, D. A. and Madronich, S. and Ridley, B. A. and Flocke, S. J. and Cantrell, C. A. and Eisele, F. L. and Shetter, R. E. and Tanner, D. J. and Ginoux, P. and Atlas, E. L.},
  title = {Photochemistry and budget of ozone during the Mauna Loa Observatory Photochemistry Experiment (MLOPEX 2)},
  journal = {jgr},
  year = {1999},
  volume = {104},
  pages = {30},
  url = {http://adsabs.harvard.edu/abs/1999JGR...10430275H},
  doi = {https://doi.org/10.1029/1999JD900441}
}
</pre></td>
</tr>
<tr id="Lamarque_etal__2005a" class="entry">
	<td>Lamarque, J.-F., Kiehl, J.T., Hess, P.G., Collins, W.D., Emmons, L.K., Ginoux, P., Luo, C. and Tie, X.X.</td>
	<td>Response of a coupled chemistry-climate model to changes in aerosol emissions: Global impact on the hydrological cycle and the tropospheric burdens of OH, ozone, and NO_x <p class="infolinks">[<a href="javascript:toggleInfo('Lamarque_etal__2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Lamarque_etal__2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>grl<br/>Vol. 32, pp. L16809&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005GL023419">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005GeoRL..3216809L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Lamarque_etal__2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: In this study, we analyze the response of the coupled chemistry-climate system to changes in aerosol emissions in fully coupled atmospheric chemistry-climate-slab ocean model simulations; only the direct radiative effect of aerosols and their uptake of chemical species are considered in this study. We show that, at the global scale, a decrease in emissions of the considered aerosols (or their precursors) produces a warmer and moister climate. In addition, the tropospheric burdens of OH and ozone increase when aerosol emissions are decreased. The ozone response is a combination of the impact of reduced heterogeneous uptake of N_2O_5 and increased ozone loss in a moister atmosphere. Under reduced aerosol emissions, the tropospheric burden of NO_x (NO + NO_2) is strongly reduced by an increase in nitric acid formation but also increased by the reduced N_2O_5 uptake. Finally, we discuss the significant difference found between the combined impact of all aerosols emissions and the sum of their individual contributions.</td>
</tr>
<tr id="bib_Lamarque_etal__2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Lamarque_etal__2005a,
  author = {Lamarque, J.-F. and Kiehl, J. T. and Hess, P. G. and Collins, W. D. and Emmons, L. K. and Ginoux, P. and Luo, C. and Tie, X. X.},
  title = {Response of a coupled chemistry-climate model to changes in aerosol emissions: Global impact on the hydrological cycle and the tropospheric burdens of OH, ozone, and NO_x},
  journal = {grl},
  year = {2005},
  volume = {32},
  pages = {L16809},
  url = {http://adsabs.harvard.edu/abs/2005GeoRL..3216809L},
  doi = {https://doi.org/10.1029/2005GL023419}
}
</pre></td>
</tr>
<tr id="LiOsada__2007a" class="entry">
	<td>Li, J. and Osada, K.</td>
	<td>Preferential settling of elongated mineral dust particles in the atmosphere <p class="infolinks">[<a href="javascript:toggleInfo('LiOsada__2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('LiOsada__2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>grl<br/>Vol. 34, pp. L17807&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2007GL030262">DOI</a> <a href="http://adsabs.harvard.edu/abs/2007GeoRL..3417807L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_LiOsada__2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Positions of particles' centers of gravity and folding centers were analyzed for individual dust particles in snow on a high mountain in Japan. Bias of dust particles' centers of gravity was observed: L1 (the longest distance from the center of gravity to the boundary of particles) is 5&#37; (of L1, on average) longer than L2 (1/2 of the longest axis of particles), suggesting that a preferential orientation exists for particles settling heavy side down. Applying that preferential orientation of settling particles to Ginoux's model, the settling velocity for ellipsoids with Reynolds numbers lower than 2 was estimated. The results show that, for long-range transport particles, settling velocity of spherical particles is lower than that of ellipsoids with equal surface area. Our results also indicate that, away from the source regions, dust particles are essentially spherical, which considerably simplify the calculation of settling velocity in transport and of radiative transfer models.</td>
</tr>
<tr id="bib_LiOsada__2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{LiOsada__2007a,
  author = {Li, J. and Osada, K.},
  title = {Preferential settling of elongated mineral dust particles in the atmosphere},
  journal = {grl},
  year = {2007},
  volume = {34},
  pages = {L17807},
  url = {http://adsabs.harvard.edu/abs/2007GeoRL..3417807L},
  doi = {https://doi.org/10.1029/2007GL030262}
}
</pre></td>
</tr>
<tr id="Paulot_etal__2017a" class="entry">
	<td>Paulot, F., Paynter, D., Ginoux, P., Naik, V., Whitburn, S., Van Damme, M., Clarisse, L., Coheur, P.-F. and Horowitz, L.W.</td>
	<td>Gas-aerosol partitioning of ammonia in biomass burning plumes: Implications for the interpretation of spaceborne observations of ammonia and the radiative forcing of ammonium nitrate <p class="infolinks">[<a href="javascript:toggleInfo('Paulot_etal__2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Paulot_etal__2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>grl<br/>Vol. 44, pp. 8084-8093&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2017GL074215">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017GeoRL..44.8084P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Paulot_etal__2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Satellite-derived enhancement ratios of NH_3 relative to CO column burden (ERNH3/CO) in fires over Alaska, the Amazon, and South Equatorial Africa are 35, 45, and 70&#37; lower than the corresponding ratio of their emissions factors (EFNH3/CO) from biomass burning derived from in situ observations. Simulations performed using the Geophysical Fluid Dynamics Laboratory AM3 global chemistry-climate model show that these regional differences may not entirely stem from an overestimate of NH_3 emissions but rather from changes in the gas-aerosol partitioning of NH_3 to NH4+. Differences between ERNH3/CO and EFNH3/CO are largest in regions where EFNOx/NH3 is high, consistent with the production of NH_4NO_3. Biomass burning is estimated to contribute 11-23&#37; of the global burden and direct radiative effect (DRE) of NH_4NO_3 (-15 to -28 mW m^-2), despite accounting for less than 6&#37; of the global source of NH_3. Production of NH_4NO_3 is largely concentrated over the Amazon and South Equatorial Africa, where its DRE can reach -1.9 W m^-2 during the biomass burning season.</td>
</tr>
<tr id="bib_Paulot_etal__2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Paulot_etal__2017a,
  author = {Paulot, F. and Paynter, D. and Ginoux, P. and Naik, V. and Whitburn, S. and Van Damme, M. and Clarisse, L. and Coheur, P.-F. and Horowitz, L. W.},
  title = {Gas-aerosol partitioning of ammonia in biomass burning plumes: Implications for the interpretation of spaceborne observations of ammonia and the radiative forcing of ammonium nitrate},
  journal = {grl},
  year = {2017},
  volume = {44},
  pages = {8084-8093},
  url = {http://adsabs.harvard.edu/abs/2017GeoRL..44.8084P},
  doi = {https://doi.org/10.1002/2017GL074215}
}
</pre></td>
</tr>
<tr id="Petty__2006a" class="entry">
	<td>Petty, G.W.</td>
	<td>A First Course in Atmospheric Radiation (2nd Ed.) <p class="infolinks">[<a href="javascript:toggleInfo('Petty__2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Petty__2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Paperback&nbsp;</td>
	<td>book</td>
	<td>&nbsp;</td>
</tr>
<tr id="abs_Petty__2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This textbook covers the essentials of atmospheric radiation at a level appropriate to advanced undergraduates and first-year graduate students. It was written specifically to be readable and technically accessible to students having no prior background i
<br>n the subject area and who may or may not intend to continue with more advanced study of radiation or remote sensing. The author emphasizes physical insight, first and foremost, but backed by the essential mathematical relationships.    The second edition adds new exercis
<br>es, improved figures, a table of symbols, and discussions of new topics, such as the Poynting vector and the energy balance within the atmosphere.    The book web page includes additional resources for courses taught using this book, including downloadable/printable PDF f
<br>igures as well as solutions to most problems (for instructors of recognized courses only).</td>
</tr>
<tr id="bib_Petty__2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@book{Petty__2006a,
  author = {Petty, Grant W.},
  title = {A First Course in Atmospheric Radiation (2nd Ed.)},
  publisher = {Sundog Publishing},
  year = {2006}
}
</pre></td>
</tr>
<tr id="Slingo_etal__2006a" class="entry">
	<td>Slingo, A., Ackerman, T.P., Allan, R.P., Kassianov, E.I., McFarlane, S.A., Robinson, G.J., Barnard, J.C., Miller, M.A., Harries, J.E., Russell, J.E. and Dewitte, S.</td>
	<td>Observations of the impact of a major Saharan dust storm on the atmospheric radiation balance <p class="infolinks">[<a href="javascript:toggleInfo('Slingo_etal__2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Slingo_etal__2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>grl<br/>Vol. 33, pp. L24817&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2006GL027869">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006GeoRL..3324817S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Slingo_etal__2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Saharan dust storms have often been observed from space, but the full impact on the Earth's radiation balance has been difficult to assess, due to limited observations from the surface. We present the first simultaneous observations from space and from a comprehensive new mobile facility in Niamey, Niger, of a major dust storm in March 2006. The results indicate major perturbations to the radiation balance both at the top of the atmosphere and at the surface. Combining the satellite and surface data, we also estimate the impact on the radiation balance of the atmosphere itself. Using independent data from the mobile facility, we derive the optical properties of the dust and input these and other information into two radiation models to simulate the radiative fluxes. We show that the radiation models underestimate the observed absorption of solar radiation in the dusty atmosphere.</td>
</tr>
<tr id="bib_Slingo_etal__2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Slingo_etal__2006a,
  author = {Slingo, A. and Ackerman, T. P. and Allan, R. P. and Kassianov, E. I. and McFarlane, S. A. and Robinson, G. J. and Barnard, J. C. and Miller, M. A. and Harries, J. E. and Russell, J. E. and Dewitte, S.},
  title = {Observations of the impact of a major Saharan dust storm on the atmospheric radiation balance},
  journal = {grl},
  year = {2006},
  volume = {33},
  pages = {L24817},
  url = {http://adsabs.harvard.edu/abs/2006GeoRL..3324817S},
  doi = {https://doi.org/10.1029/2006GL027869}
}
</pre></td>
</tr>
<tr id="Wang_etal__2016a" class="entry">
	<td>Wang, J., Krejci, R., Giangrande, S., Kuang, C., Barbosa, H.M.J., Brito, J., Carbone, S., Chi, X., Comstock, J., Ditas, F., Lavric, J., Manninen, H.E., Mei, F., Moran-Zuloaga, D., P&ouml;hlker, C., P&ouml;hlker, M.L., Saturno, J., Schmid, B., Souza, R.A.F., Springston, S.R., Tomlinson, J.M., Toto, T., Walter, D., Wimmer, D., Smith, J.N., Kulmala, M., Machado, L.A.T., Artaxo, P., Andreae, M.O., Pet&auml;j&auml;, T. and Martin, S.T.</td>
	<td>Amazon boundary layer aerosol concentration sustained by vertical transport during rainfall <p class="infolinks">[<a href="javascript:toggleInfo('Wang_etal__2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Wang_etal__2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>nat<br/>Vol. 539, pp. 416-419&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/nature19819">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016Natur.539..416W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Wang_etal__2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The nucleation of atmospheric vapours is an important source of new aerosol particles that can subsequently grow to form cloud condensation nuclei in the atmosphere. Most field studies of atmospheric aerosols over continents are influenced by atmospheric vapours of anthropogenic origin (for example, ref. 2) and, in consequence, aerosol processes in pristine, terrestrial environments remain poorly understood. The Amazon rainforest is one of the few continental regions where aerosol particles and their precursors can be studied under near-natural conditions, but the origin of small aerosol particles that grow into cloud condensation nuclei in the Amazon boundary layer remains unclear. Here we present aircraft- and ground-based measurements under clean conditions during the wet season in the central Amazon basin. We find that high concentrations of small aerosol particles (with diameters of less than 50 nanometres) in the lower free troposphere are transported from the free troposphere into the boundary layer during precipitation events by strong convective downdrafts and weaker downward motions in the trailing stratiform region. This rapid vertical transport can help to maintain the population of particles in the pristine Amazon boundary layer, and may therefore influence cloud properties and climate under natural conditions.</td>
</tr>
<tr id="bib_Wang_etal__2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Wang_etal__2016a,
  author = {Wang, J. and Krejci, R. and Giangrande, S. and Kuang, C. and Barbosa, H. M. J. and Brito, J. and Carbone, S. and Chi, X. and Comstock, J. and Ditas, F. and Lavric, J. and Manninen, H. E. and Mei, F. and Moran-Zuloaga, D. and P&ouml;hlker, C. and P&ouml;hlker, M. L. and Saturno, J. and Schmid, B. and Souza, R. A. F. and Springston, S. R. and Tomlinson, J. M. and Toto, T. and Walter, D. and Wimmer, D. and Smith, J. N. and Kulmala, M. and Machado, L. A. T. and Artaxo, P. and Andreae, M. O. and Pet&auml;j&auml;, T. and Martin, S. T.},
  title = {Amazon boundary layer aerosol concentration sustained by vertical transport during rainfall},
  journal = {nat},
  year = {2016},
  volume = {539},
  pages = {416-419},
  url = {http://adsabs.harvard.edu/abs/2016Natur.539..416W},
  doi = {https://doi.org/10.1038/nature19819}
}
</pre></td>
</tr>
<tr id="Washington_etal__2006a" class="entry">
	<td>Washington, R., Todd, M.C., Lizcano, G., Tegen, I., Flamant, C., Koren, I., Ginoux, P., Engelstaedter, S., Bristow, C.S., Zender, C.S., Goudie, A.S., Warren, A. and Prospero, J.M.</td>
	<td>Links between topography, wind, deflation, lakes and dust: The case of the Bod&eacute;l&eacute; Depression, Chad <p class="infolinks">[<a href="javascript:toggleInfo('Washington_etal__2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Washington_etal__2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>grl<br/>Vol. 33, pp. L09401&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2006GL025827">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006GeoRL..33.9401W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Washington_etal__2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Bod&eacute;l&eacute; Depression, Chad is the planet's largest single source of dust. Deflation from the Bod&eacute;l&eacute; could be seen as a simple coincidence of two key prerequisites: strong surface winds and a large source of suitable sediment. But here we hypothesise that long term links between topography, winds, deflation and dust ensure the maintenance of the dust source such that these two apparently coincidental key ingredients are connected by land-atmosphere processes with topography acting as the overall controlling agent. We use a variety of observational and numerical techniques, including a regional climate model, to show that: 1) contemporary deflation from the Bod&eacute;l&eacute; is delineated by topography and a surface wind stress maximum; 2) the Tibesti and Ennedi mountains play a key role in the generation of the erosive winds in the form of the Bod&eacute;l&eacute; Low Level Jet (LLJ); 3) enhanced deflation from a stronger Bod&eacute;l&eacute; LLJ during drier phases, for example, the Last Glacial Maximum, was probably sufficient to create the shallow lake in which diatoms lived during wetter phases, such as the Holocene pluvial. Winds may therefore have helped to create the depression in which erodible diatom material accumulated. Instead of a simple coincidence of nature, dust from the world's largest source may result from the operation of long term processes on paleo timescales which have led to ideal conditions for dust generation in the world's largest dust source. Similar processes plausibly operate in other dust hotspots in topographic depressions.</td>
</tr>
<tr id="bib_Washington_etal__2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Washington_etal__2006a,
  author = {Washington, R. and Todd, M. C. and Lizcano, G. and Tegen, I. and Flamant, C. and Koren, I. and Ginoux, P. and Engelstaedter, S. and Bristow, C. S. and Zender, C. S. and Goudie, A. S. and Warren, A. and Prospero, J. M.},
  title = {Links between topography, wind, deflation, lakes and dust: The case of the Bod&eacute;l&eacute; Depression, Chad},
  journal = {grl},
  year = {2006},
  volume = {33},
  pages = {L09401},
  url = {http://adsabs.harvard.edu/abs/2006GeoRL..33.9401W},
  doi = {https://doi.org/10.1029/2006GL025827}
}
</pre></td>
</tr>
<tr id="BalkanskiJacob_TSBCaPMB_1990a" class="entry">
	<td>Balkanski, Y.J. and Jacob, D.J.</td>
	<td>Transport of continental air to the subantarctic Indian Ocean <p class="infolinks">[<a href="javascript:toggleInfo('BalkanskiJacob_TSBCaPMB_1990a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('BalkanskiJacob_TSBCaPMB_1990a','bibtex')">BibTeX</a>]</p></td>
	<td>1990</td>
	<td>Tellus Series B Chemical and Physical Meteorology B<br/>Vol. 42, pp. 62&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1034/j.1600-0889.1990.00008.x">DOI</a> <a href="http://adsabs.harvard.edu/abs/1990TellB..42...62B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_BalkanskiJacob_TSBCaPMB_1990a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The occurrence of high levels of atmospheric ^222Rn (radonic
<br>storms) at 3 subantarctic islands in the Indian Ocean is simulated with
<br>a 3-d chemical tracer model (CTM) based on the meteorology of the GISS
<br>general circulation model (GCM). Radon-222 (half-life 3.8days) is a
<br>sensitive tracer of continental air over the oceans. The CTM simulates
<br>well the observed intensities of the radonic storms at the islands,
<br>their seasonal frequency (highest in winter), and their periodicity (25
<br>28days). The storms are due to fast boundary layer advection of air from
<br>South Africa, made possible by the conjunction of a subtropical high SE
<br>of Madagascar (Mascarene High) and a mid-latitudes low off the southern
<br>tip of the African continent. Transit times of air from South Africa to
<br>the islands range from 1 to 5days. The Mascarene high is a
<br>semi-permanent feature of the circulation from May to October, and is
<br>responsible for the seasonal frequency of the radonic storms. The low is
<br>transient but exhibits an oscillation of period 23 28days which appears
<br>to be responsible for the observed periodicity of the storms. Transport
<br>to the subantarctic Indian Ocean is the principal mechanism for
<br>ventilation of South Africa in the CTM, but most of this transport takes
<br>place in the free troposphere following deep convection over the
<br>continent. The boundary layer advection mechanism associated with
<br>radonic storms accounts for only a small fraction of the total
<br>continental air exported to the subantarctic Indian Ocean.
<br></td>
</tr>
<tr id="bib_BalkanskiJacob_TSBCaPMB_1990a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{BalkanskiJacob_TSBCaPMB_1990a,
  author = {Balkanski, Y. J. and Jacob, D. J.},
  title = {Transport of continental air to the subantarctic Indian Ocean},
  journal = {Tellus Series B Chemical and Physical Meteorology B},
  year = {1990},
  volume = {42},
  pages = {62},
  url = {http://adsabs.harvard.edu/abs/1990TellB..42...62B},
  doi = {https://doi.org/10.1034/j.1600-0889.1990.00008.x}
}
</pre></td>
</tr>
<tr id="Claquin_etal_TSBCaPMB_1998a" class="entry">
	<td>Claquin, T., Schulz, M., Balkanski, Y. and Boucher, O.</td>
	<td>Uncertainties in assessing radiative forcing by mineral dust <p class="infolinks">[<a href="javascript:toggleInfo('Claquin_etal_TSBCaPMB_1998a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Claquin_etal_TSBCaPMB_1998a','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Tellus Series B Chemical and Physical Meteorology B<br/>Vol. 50, pp. 491&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1034/j.1600-0889.1998.t01-2-00007.x">DOI</a> <a href="http://adsabs.harvard.edu/abs/1998TellB..50..491C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Claquin_etal_TSBCaPMB_1998a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The assessment of the climatic effects of an aerosol with a large
<br>variability like mineral dust requires some approximations whose
<br>validity is investigated in this paper. Calculations of direct radiative
<br>forcing by mineral dust (short-wave, long-wave and net) are performed
<br>with a single-column radiation model for two standard cases in clear sky
<br>condition: a desert case and an oceanic case. Surface forcing result
<br>from a large diminution of the short-wave fluxes and of the increase in
<br>down-welling long-wave fluxes. Top of the atmosphere (TOA) forcing is
<br>negative when short-wave backscattering dominates, for instance above
<br>the ocean, and positive when short-wave or long-wave absorption
<br>dominates, which occurs above deserts. We study here the sensitivity of
<br>these mineral forcings to different treatments of the aerosol complex
<br>refractive index and size distribution. We also describe the importance
<br>of the dust vertical profile, ground temperature, emissivity and albedo.
<br>Among these parameters, the aerosol complex refractive index has been
<br>identified as a critical parameter given the paucity and the incertitude
<br>associated with it. Furthermore, the imaginary part of the refractive
<br>index is inadequate if spectrally averaged. Its natural variability
<br>(linked to mineralogical characteristics) lead to variations of up to
<br>plusmn 40&#37; in aerosol forcing calculations. A proper representation of
<br>the size distribution when modelling mineral aerosols is required since
<br>dust optical properties are very sensitive to the presence of small
<br>particles. In addition we demonstrate that LW forcing imply a
<br>non-negligible sensitivity to the vertical profiles of temperature and
<br>dust, the latter being an important constraint for dust effect
<br>calculations.
<br></td>
</tr>
<tr id="bib_Claquin_etal_TSBCaPMB_1998a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Claquin_etal_TSBCaPMB_1998a,
  author = {Claquin, T. and Schulz, M. and Balkanski, Y. and Boucher, O.},
  title = {Uncertainties in assessing radiative forcing by mineral dust},
  journal = {Tellus Series B Chemical and Physical Meteorology B},
  year = {1998},
  volume = {50},
  pages = {491},
  url = {http://adsabs.harvard.edu/abs/1998TellB..50..491C},
  doi = {https://doi.org/10.1034/j.1600-0889.1998.t01-2-00007.x}
}
</pre></td>
</tr>
<tr id="Denning_etal_TSBCaPMB_1999a" class="entry">
	<td>Denning, A.S., Holzer, M., Gurney, K.R., Heimann, M., Law, R.M., Rayner, P.J., Fung, I.Y., Fan, S.-M., Taguchi, S., Friedlingstein, P., Balkanski, Y., Taylor, J., Maiss, M. and Levin, I.</td>
	<td>Three-dimensional transport and concentration of SF_6. A model intercomparison study (TransCom 2) <p class="infolinks">[<a href="javascript:toggleInfo('Denning_etal_TSBCaPMB_1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Denning_etal_TSBCaPMB_1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>Tellus Series B Chemical and Physical Meteorology B<br/>Vol. 51, pp. 266&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1034/j.1600-0889.1999.00012.x">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999TellB..51..266D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Denning_etal_TSBCaPMB_1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Sulfur hexafluoride (SF_6) is an excellent tracer of
<br>large-scale atmospheric transport, because it has slowly increasing
<br>sources mostly confined to northern midlatitudes, and has a lifetime of
<br>thousands of years. We have simulated the emissions, transport, and
<br>concentration of SF_6 for a 5-year period, and compared the
<br>results with atmospheric observations. In addition, we have performed an
<br>intercomparison of interhemispheric transport among 11 models to
<br>investigate the reasons for the differences among the simulations. Most
<br>of the models are reasonably successful at simulating the observed
<br>meridional gradient of SF_6 in the remote marine boundary
<br>layer, though there is less agreement at continental sites. Models that
<br>compare well to observations in the remote marine boundary layer tend to
<br>systematically overestimate SF_6 at continental locations in
<br>source regions, suggesting that vertical trapping rather than meridional
<br>transport may be a dominant control on the simulated meridional
<br>gradient. The vertical structure of simulated SF_6 in the
<br>models supports this interpretation. Some of the models perform quite
<br>well in terms of the simulated seasonal cycle at remote locations, while
<br>others do not. Interhemispheric exchange time varies by a factor of 2
<br>when estimated from 1-dimensional meridional profiles at the surface, as
<br>has been done for observations. The agreement among models is better
<br>when the global surface mean mole fraction is used, and better still
<br>when the full 3-dimensional mean mixing ratio is used. The ranking of
<br>the interhemispheric exchange time among the models is not sensitive to
<br>the change from station values to surface means, but is very sensitive
<br>to the change from surface means to the full 3-dimensional tracer
<br>fields. This strengthens the argument that vertical redistribution
<br>dominates over interhemispheric transport in determining the meridional
<br>gradient at the surface. Vertically integrated meridional transport in
<br>the models is divided roughly equally into transport by the mean motion,
<br>the standing eddies, and the transient eddies. The vertically integrated
<br>mass flux is a good index of the degree to which resolved advection vs.
<br>parameterized diffusion accomplishes the meridional transport of
<br>SF_6. Observational programs could provide a much better
<br>constraint on simulated chemical tracer transport if they included
<br>regular sampling of vertical profiles of nonreactive trace gases over
<br>source regions and meridional profiles in the middle to upper
<br>troposphere. Further analysis of the SF_6 simulations will
<br>focus on the subgrid-scale parameterized transports.
<br></td>
</tr>
<tr id="bib_Denning_etal_TSBCaPMB_1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Denning_etal_TSBCaPMB_1999a,
  author = {Denning, A. S. and Holzer, M. and Gurney, K. R. and Heimann, M. and Law, R. M. and Rayner, P. J. and Fung, I. Y. and Fan, S.-M. and Taguchi, S. and Friedlingstein, P. and Balkanski, Y. and Taylor, J. and Maiss, M. and Levin, I.},
  title = {Three-dimensional transport and concentration of SF_6. A model intercomparison study (TransCom 2)},
  journal = {Tellus Series B Chemical and Physical Meteorology B},
  year = {1999},
  volume = {51},
  pages = {266},
  url = {http://adsabs.harvard.edu/abs/1999TellB..51..266D},
  doi = {https://doi.org/10.1034/j.1600-0889.1999.00012.x}
}
</pre></td>
</tr>
<tr id="Knippertz_etal_TSBCaPMB_2009a" class="entry">
	<td>Knippertz, P., Ansmann, A., Althausen, D., M&uuml;ller, D., Tesche, M., Bierwirth, E., Dinter, T., M&uuml;ller, T., von Hoyningen-Huene, W., Schepanski, K., Wendisch, M., Heinold, B., Kandler, K., Petzold, A., Sch&uuml;tz, L. and Tegen, I.</td>
	<td>Dust mobilization and transport in the northern Sahara during SAMUM 2006 - a meteorological overview <p class="infolinks">[<a href="javascript:toggleInfo('Knippertz_etal_TSBCaPMB_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Knippertz_etal_TSBCaPMB_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Tellus Series B Chemical and Physical Meteorology B<br/>Vol. 61, pp. 12-31&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1111/j.1600-0889.2008.00380.x">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009TellB..61...12K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Knippertz_etal_TSBCaPMB_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: ABSTRACT The SAMUM field campaign in southern Morocco in May/June 2006
<br>provides valuable data to study the emission, and the horizontal and
<br>vertical transports of mineral dust in the Northern Sahara. Radiosonde
<br>and lidar observations show differential advection of air masses with
<br>different characteristics during stable nighttime conditions and up to
<br>5-km deep vertical mixing in the strongly convective boundary layer
<br>during the day. Lagrangian and synoptic analyses of selected dust
<br>periods point to a topographic channel from western Tunisia to central
<br>Algeria as a dust source region. Significant emission events are related
<br>to cold surges from the Mediterranean in association with eastward
<br>passing upper-level waves and lee cyclogeneses south of the Atlas
<br>Mountains. Other relevant events are local emissions under a distinct
<br>cut-off low over northwestern Africa and gust fronts associated with dry
<br>thunderstorms over the Malian and Algerian Sahara. The latter are badly
<br>represented in analyses from the European Centre for Medium-Range
<br>Weather Forecasts and in a regional dust model, most likely due to
<br>problems with moist convective dynamics and a lack of observations in
<br>this region. This aspect needs further study. The meteorological source
<br>identification is consistent with estimates of optical and mineralogical
<br>properties of dust samples.
<br></td>
</tr>
<tr id="bib_Knippertz_etal_TSBCaPMB_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Knippertz_etal_TSBCaPMB_2009a,
  author = {Knippertz, P. and Ansmann, A. and Althausen, D. and M&uuml;ller, D. and Tesche, M. and Bierwirth, E. and Dinter, T. and M&uuml;ller, T. and von Hoyningen-Huene, W. and Schepanski, K. and Wendisch, M. and Heinold, B. and Kandler, K. and Petzold, A. and Sch&uuml;tz, L. and Tegen, I.},
  title = {Dust mobilization and transport in the northern Sahara during SAMUM 2006 - a meteorological overview},
  journal = {Tellus Series B Chemical and Physical Meteorology B},
  year = {2009},
  volume = {61},
  pages = {12-31},
  url = {http://adsabs.harvard.edu/abs/2009TellB..61...12K},
  doi = {https://doi.org/10.1111/j.1600-0889.2008.00380.x}
}
</pre></td>
</tr>
<tr id="Rasch_etal_TSBCaPMB_2000a" class="entry">
	<td>Rasch, P.J., Feichter, J., Law, K., Mahowald, N., Penner, J., Benkovitz, C., Genthon, C., Giannakopoulos, C., Kasibhatla, P., Koch, D., Levy, H., Maki, T., Prather, M., Roberts, D.L., Roelofs, G.J., Stevenson, D., Stockwell, Z., Taguchi, S., Kritz, M., Chipperfield, M., Baldocchi, D., McMurry, P., Barrie, L., Balkanski, Y., Chatfield, R., Kjellstrom, E., Lawrence, M., Lee, H.N., Lelieveld, J., Noone, K.J., Seinfeld, J., Stenchikov, G., Schwartz, S., Walcek, C. and Williamson, D.</td>
	<td>A comparison of scavenging and deposition processes in global models: results from the WCRP Cambridge Workshop of 1995 <p class="infolinks">[<a href="javascript:toggleInfo('Rasch_etal_TSBCaPMB_2000a','bibtex')">BibTeX</a>]</p></td>
	<td>2000</td>
	<td>Tellus Series B Chemical and Physical Meteorology B<br/>Vol. 52, pp. 1025&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1034/j.1600-0889.2000.00980.x">DOI</a> <a href="http://adsabs.harvard.edu/abs/2000TellB..52.1025R">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Rasch_etal_TSBCaPMB_2000a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Rasch_etal_TSBCaPMB_2000a,
  author = {Rasch, P. J. and Feichter, J. and Law, K. and Mahowald, N. and Penner, J. and Benkovitz, C. and Genthon, C. and Giannakopoulos, C. and Kasibhatla, P. and Koch, D. and Levy, H. and Maki, T. and Prather, M. and Roberts, D. L. and Roelofs, G. J. and Stevenson, D. and Stockwell, Z. and Taguchi, S. and Kritz, M. and Chipperfield, M. and Baldocchi, D. and McMurry, P. and Barrie, L. and Balkanski, Y. and Chatfield, R. and Kjellstrom, E. and Lawrence, M. and Lee, H. N. and Lelieveld, J. and Noone, K. J. and Seinfeld, J. and Stenchikov, G. and Schwartz, S. and Walcek, C. and Williamson, D.},
  title = {A comparison of scavenging and deposition processes in global models: results from the WCRP Cambridge Workshop of 1995},
  journal = {Tellus Series B Chemical and Physical Meteorology B},
  year = {2000},
  volume = {52},
  pages = {1025},
  url = {http://adsabs.harvard.edu/abs/2000TellB..52.1025R},
  doi = {https://doi.org/10.1034/j.1600-0889.2000.00980.x}
}
</pre></td>
</tr>
<tr id="FRIEDLINGSTEIN_etal_TB_2003a" class="entry">
	<td>FRIEDLINGSTEIN, P., DUFRESNE, J.-L., P. M., COX and RAYNER, P.</td>
	<td>How positive is the feedback between climate change and the carbon cycle? <p class="infolinks">[<a href="javascript:toggleInfo('FRIEDLINGSTEIN_etal_TB_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Tellus B<br/>Vol. 55(2), pp. 692-700&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1034/j.1600-0889.2003.01461.x">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_FRIEDLINGSTEIN_etal_TB_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{FRIEDLINGSTEIN_etal_TB_2003a,
  author = {P. FRIEDLINGSTEIN and J.-L. DUFRESNE and P. M. COX and P. RAYNER},
  title = {How positive is the feedback between climate change and the carbon cycle?},
  journal = {Tellus B},
  publisher = {Informa UK Limited},
  year = {2003},
  volume = {55},
  number = {2},
  pages = {692--700},
  doi = {https://doi.org/10.1034/j.1600-0889.2003.01461.x}
}
</pre></td>
</tr>
<tr id="PuGinoux_SR_2017a" class="entry">
	<td>Pu, B. and Ginoux, P.</td>
	<td>Projection of American dustiness in the late 21^st century due to climate change <p class="infolinks">[<a href="javascript:toggleInfo('PuGinoux_SR_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('PuGinoux_SR_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Scientific Reports<br/>Vol. 7, pp. 5553&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/s41598-017-05431-9">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017NatSR...7.5553P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_PuGinoux_SR_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Climate models project rising drought risks over the southwestern and central U.S. in the twenty-first century due to increasing greenhouse gases. The projected drier regions largely overlay the major dust sources in the United States. However, whether dust activity in U.S. will increase in the future is not clear, due to the large uncertainty in dust modeling. This study found that changes of dust activity in the U.S. in the recent decade are largely associated with the variations of precipitation, soil bareness, and surface winds speed. Using multi-model output under the Representative Concentration Pathways 8.5 scenario, we project that climate change will increase dust activity in the southern Great Plains from spring to fall in the late half of the twenty-first century - largely due to reduced precipitation, enhanced land surface bareness, and increased surface wind speed. Over the northern Great Plains, less dusty days are expected in spring due to increased precipitation and reduced bareness. Given the large negative economic and societal consequences of severe dust storms, this study complements the multi-model projection on future dust variations and may help improve risk management and resource planning.</td>
</tr>
<tr id="bib_PuGinoux_SR_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{PuGinoux_SR_2017a,
  author = {Pu, B. and Ginoux, P.},
  title = {Projection of American dustiness in the late 21^st century due to climate change},
  journal = {Scientific Reports},
  year = {2017},
  volume = {7},
  pages = {5553},
  url = {http://adsabs.harvard.edu/abs/2017NatSR...7.5553P},
  doi = {https://doi.org/10.1038/s41598-017-05431-9}
}
</pre></td>
</tr>
<tr id="Schwarz_etal_SR_2013a" class="entry">
	<td>Schwarz, J.P., Gao, R.S., Perring, A.E., Spackman, J.R. and Fahey, D.W.</td>
	<td>Black carbon aerosol size in snow <p class="infolinks">[<a href="javascript:toggleInfo('Schwarz_etal_SR_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Schwarz_etal_SR_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Scientific Reports<br/>Vol. 3, pp. 1356&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/srep01356">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013NatSR...3E1356S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Schwarz_etal_SR_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The effect of anthropogenic black carbon (BC) aerosol on snow is of enduring interest due to its consequences for climate forcing. Until now, too little attention has been focused on BC's size in snow, an important parameter affecting BC light absorption in snow. Here we present first observations of this parameter, revealing that BC can be shifted to larger sizes in snow than are typically seen in the atmosphere, in part due to the processes associated with BC removal from the atmosphere. Mie theory analysis indicates a corresponding reduction in BC absorption in snow of 40 making BC size in snow the dominant source of uncertainty in BC's absorption properties for calculations of BC's snow albedo climate forcing. The shift reduces estimated BC global mean snow forcing by 30 and has scientific implications for our understanding of snow albedo and the processing of atmospheric BC aerosol in snowfall.</td>
</tr>
<tr id="bib_Schwarz_etal_SR_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schwarz_etal_SR_2013a,
  author = {Schwarz, J. P. and Gao, R. S. and Perring, A. E. and Spackman, J. R. and Fahey, D. W.},
  title = {Black carbon aerosol size in snow},
  journal = {Scientific Reports},
  year = {2013},
  volume = {3},
  pages = {1356},
  url = {http://adsabs.harvard.edu/abs/2013NatSR...3E1356S},
  doi = {https://doi.org/10.1038/srep01356}
}
</pre></td>
</tr>
<tr id="Evan_etal_S_2009a" class="entry">
	<td>Evan, A.T., Vimont, D.J., Heidinger, A.K., Kossin, J.P. and Bennartz, R.</td>
	<td>The Role of Aerosols in the Evolution of Tropical North Atlantic Ocean Temperature Anomalies <p class="infolinks">[<a href="javascript:toggleInfo('Evan_etal_S_2009a','comment')">Comment</a>] [<a href="javascript:toggleInfo('Evan_etal_S_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Science<br/>Vol. 324(5928), pp. 778-781&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1126/science.1167404">DOI</a> &nbsp;</td>
</tr>
<tr id="rev_Evan_etal_S_2009a" class="comment noshow">
	<td colspan="6"><b>Comment</b>: - Role of mineral dust / aerosols in temperature changes
<br></td>
</tr>
<tr id="bib_Evan_etal_S_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Evan_etal_S_2009a,
  author = {A. T. Evan and D. J. Vimont and A. K. Heidinger and J. P. Kossin and R. Bennartz},
  title = {The Role of Aerosols in the Evolution of Tropical North Atlantic Ocean Temperature Anomalies},
  journal = {Science},
  publisher = {American Association for the Advancement of Science (AAAS)},
  year = {2009},
  volume = {324},
  number = {5928},
  pages = {778--781},
  doi = {https://doi.org/10.1126/science.1167404}
}
</pre></td>
</tr>
<tr id="Hansen_etal_S_2005a" class="entry">
	<td>Hansen, J., Nazarenko, L., Ruedy, R., Sato, M., Willis, J., Del Genio, A., Koch, D., Lacis, A., Lo, K., Menon, S., Novakov, T., Perlwitz, J., Russell, G., Schmidt, G.A. and Tausnev, N.</td>
	<td>Earth's Energy Imbalance: Confirmation and Implications <p class="infolinks">[<a href="javascript:toggleInfo('Hansen_etal_S_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Hansen_etal_S_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Science<br/>Vol. 308, pp. 1431-1435&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1126/science.1110252">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005Sci...308.1431H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Hansen_etal_S_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Our climate model, driven mainly by increasing human-made greenhouse
<br>gases and aerosols, among other forcings, calculates that Earth is now
<br>absorbing 0.85 +/- 0.15 watts per square meter more energy from the Sun
<br>than it is emitting to space. This imbalance is confirmed by precise
<br>measurements of increasing ocean heat content over the past 10 years.
<br>Implications include (i) the expectation of additional global warming of
<br>about 0.6degC without further change of atmospheric composition; (ii)
<br>the confirmation of the climate system's lag in responding to forcings,
<br>implying the need for anticipatory actions to avoid any specified level
<br>of climate change; and (iii) the likelihood of acceleration of ice sheet
<br>disintegration and sea level rise.
<br></td>
</tr>
<tr id="bib_Hansen_etal_S_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hansen_etal_S_2005a,
  author = {Hansen, J. and Nazarenko, L. and Ruedy, R. and Sato, M. and Willis, J. and Del Genio, A. and Koch, D. and Lacis, A. and Lo, K. and Menon, S. and Novakov, T. and Perlwitz, J. and Russell, G. and Schmidt, G. A. and Tausnev, N.},
  title = {Earth's Energy Imbalance: Confirmation and Implications},
  journal = {Science},
  year = {2005},
  volume = {308},
  pages = {1431-1435},
  url = {http://adsabs.harvard.edu/abs/2005Sci...308.1431H},
  doi = {https://doi.org/10.1126/science.1110252}
}
</pre></td>
</tr>
<tr id="Ginoux_etal_RoG_2012a" class="entry">
	<td>Ginoux, P., Prospero, J.M., Gill, T.E., Hsu, N.C. and Zhao, M.</td>
	<td>Global-scale attribution of anthropogenic and natural dust sources and their emission rates based on MODIS Deep Blue aerosol products <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal_RoG_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal_RoG_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Reviews of Geophysics<br/>Vol. 50, pp. RG3005&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2012RG000388">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012RvGeo..50.3005G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal_RoG_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Our understanding of the global dust cycle is limited by a dearth of information about dust sources, especially small-scale features which could account for a large fraction of global emissions. Here we present a global-scale high-resolution (0.1deg) mapping of sources based on Moderate Resolution Imaging Spectroradiometer (MODIS) Deep Blue estimates of dust optical depth in conjunction with other data sets including land use. We ascribe dust sources to natural and anthropogenic (primarily agricultural) origins, calculate their respective contributions to emissions, and extensively compare these products against literature. Natural dust sources globally account for 75&#37; of emissions; anthropogenic sources account for 25%. North Africa accounts for 55&#37; of global dust emissions with only 8&#37; being anthropogenic, mostly from the Sahel. Elsewhere, anthropogenic dust emissions can be much higher (75&#37; in Australia). Hydrologic dust sources (e.g., ephemeral water bodies) account for 31&#37; worldwide; 15&#37; of them are natural while 85&#37; are anthropogenic. Globally, 20&#37; of emissions are from vegetated surfaces, primarily desert shrublands and agricultural lands. Since anthropogenic dust sources are associated with land use and ephemeral water bodies, both in turn linked to the hydrological cycle, their emissions are affected by climate variability. Such changes in dust emissions can impact climate, air quality, and human health. Improved dust emission estimates will require a better mapping of threshold wind velocities, vegetation dynamics, and surface conditions (soil moisture and land use) especially in the sensitive regions identified here, as well as improved ability to address small-scale convective processes producing dust via cold pool (haboob) events frequent in monsoon regimes.</td>
</tr>
<tr id="bib_Ginoux_etal_RoG_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal_RoG_2012a,
  author = {Ginoux, P. and Prospero, J. M. and Gill, T. E. and Hsu, N. C. and Zhao, M.},
  title = {Global-scale attribution of anthropogenic and natural dust sources and their emission rates based on MODIS Deep Blue aerosol products},
  journal = {Reviews of Geophysics},
  year = {2012},
  volume = {50},
  pages = {RG3005},
  url = {http://adsabs.harvard.edu/abs/2012RvGeo..50.3005G},
  doi = {https://doi.org/10.1029/2012RG000388}
}
</pre></td>
</tr>
<tr id="JamesOlivier_RoG_a" class="entry">
	<td>James, H. and Olivier, B.</td>
	<td>Estimates of the direct and indirect radiative forcing due to tropospheric aerosols: A review <p class="infolinks">[<a href="javascript:toggleInfo('JamesOlivier_RoG_a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('JamesOlivier_RoG_a','bibtex')">BibTeX</a>]</p></td>
	<td>2000</td>
	<td>Reviews of Geophysics<br/>Vol. 38(4), pp. 513-543&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999RG000078">DOI</a> &nbsp;</td>
</tr>
<tr id="abs_JamesOlivier_RoG_a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper reviews the many developments in estimates of the direct and indirect global annual mean radiative forcing due to present-day concentrations of anthropogenic tropospheric aerosols since Intergovernmental Panel on Climate Change [1996]. The range of 
<br>estimates of the global mean direct radiative forcing due to six distinct aerosol types is presented. Additionally, the indirect effect is split into two components corresponding to the radiative forcing due to modification of the radiative properties of clouds (cloud alb
<br>edo effect) and the effects of anthropogenic aerosols upon the lifetime of clouds (cloud lifetime effect). The radiative forcing for anthropogenic sulphate aerosol ranges from −0.26 to −0.82 W m−2. For fossil fuel black carbon the radiative forcing ranges from +0.16 W m−2
<br> for an external mixture to +0.42 W m−2 for where the black carbon is modeled as internally mixed with sulphate aerosol. For fossil fuel organic carbon the two estimates of the likely weakest limit of the direct radiative forcing are −0.02 and −0.04 W m−2. For biomass-bur
<br>ning sources of black carbon and organic carbon the combined radiative forcing ranges from −0.14 to −0.74 W m−2. Estimates of the radiative forcing due to mineral dust vary widely from +0.09 to −0.46 W m−2; even the sign of the radiative forcing is not well established du
<br>e to the competing effects of solar and terrestrial radiative forcings. A single study provides a very tentative estimate of the radiative forcing of nitrates to be −0.03 W m−2. Estimates of the cloud albedo indirect radiative forcing range from −0.3 to approximately −1.8
<br> W m−2. Although the cloud lifetime effect is identified as a potentially important climate forcing mechanism, it is difficult to quantify in the context of the present definition of radiative forcing of climate change and current model simulations. This is because its es
<br>timation by general circulation models necessarily includes some level of cloud and water vapor feedbacks, which affect the hydrological cycle and the dynamics of the atmosphere. Available models predict that the radiative flux perturbation associated with the cloud lifet
<br>ime effect is of a magnitude similar to that of the cloud albedo effect.</td>
</tr>
<tr id="bib_JamesOlivier_RoG_a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{JamesOlivier_RoG_a,
  author = {Haywood James and Boucher Olivier},
  title = {Estimates of the direct and indirect radiative forcing due to tropospheric aerosols: A review},
  journal = {Reviews of Geophysics},
  year = {2000},
  volume = {38},
  number = {4},
  pages = {513-543},
  doi = {https://doi.org/10.1029/1999RG000078}
}
</pre></td>
</tr>
<tr id="KnippertzTodd_RoG_2012a" class="entry">
	<td>Knippertz, P. and Todd, M.C.</td>
	<td>Mineral dust aerosols over the Sahara: Meteorological controls on emission and transport and implications for modeling <p class="infolinks">[<a href="javascript:toggleInfo('KnippertzTodd_RoG_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('KnippertzTodd_RoG_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Reviews of Geophysics<br/>Vol. 50, pp. RG1007&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2011RG000362">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012RvGeo..50.1007K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_KnippertzTodd_RoG_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Atmospheric mineral dust has recently become an important research field
<br>in Earth system science because of its impacts on radiation, clouds,
<br>atmospheric dynamics and chemistry, air quality, and biogeochemical
<br>cycles. Studying and modeling dust emission and transport over the
<br>world's largest source region, the Sahara, is particularly challenging
<br>because of the complex meteorology and a very sparse observational
<br>network. Recent advances in satellite retrievals together with ground-
<br>and aircraft-based field campaigns have fostered our understanding of
<br>the spatiotemporal variability of the dust aerosol and its atmospheric
<br>drivers. We now have a more complete picture of the key processes in the
<br>atmosphere associated with dust emission. These cover a range of scales
<br>from (1) synoptic scale cyclones in the northern sector of the Sahara,
<br>harmattan surges and African easterly waves, through (2) low-level jets
<br>and cold pools of mesoscale convective systems (particularly over the
<br>Sahel), to (3) microscale dust devils and dusty plumes, each with its
<br>own pronounced diurnal and seasonal characteristics. This paper
<br>summarizes recent progress on monitoring and analyzing the dust
<br>distribution over the Sahara and discusses implications for numerical
<br>modeling. Among the key challenges for the future are a better
<br>quantification of the relative importance of single processes and a more
<br>realistic representation of the effects of the smaller-scale
<br>meteorological features in dust models. In particular, moist convection
<br>has been recognized as a major limitation to our understanding because
<br>of the inability of satellites to observe dust under clouds and the
<br>difficulties of numerical models to capture convective organization.
<br></td>
</tr>
<tr id="bib_KnippertzTodd_RoG_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{KnippertzTodd_RoG_2012a,
  author = {Knippertz, P. and Todd, M. C.},
  title = {Mineral dust aerosols over the Sahara: Meteorological controls on emission and transport and implications for modeling},
  journal = {Reviews of Geophysics},
  year = {2012},
  volume = {50},
  pages = {RG1007},
  url = {http://adsabs.harvard.edu/abs/2012RvGeo..50.1007K},
  doi = {https://doi.org/10.1029/2011RG000362}
}
</pre></td>
</tr>
<tr id="Kremser_etal_RoG_2016a" class="entry">
	<td>Kremser, S., Thomason, L.W., von Hobe, M., Hermann, M., Deshler, T., Timmreck, C., Toohey, M., Stenke, A., Schwarz, J.P., Weigel, R., Fueglistaler, S., Prata, F.J., Vernier, J.-P., Schlager, H., Barnes, J.E., Antu&ntilde;a-Marrero, J.-C., Fairlie, D., Palm, M., Mahieu, E., Notholt, J., Rex, M., Bingen, C., Vanhellemont, F., Bourassa, A., Plane, J.M.C., Klocke, D., Carn, S.A., Clarisse, L., Trickl, T., Neely, R., James, A.D., Rieger, L., Wilson, J.C. and Meland, B.</td>
	<td>Stratospheric aerosolmdashObservations, processes, and impact on climate <p class="infolinks">[<a href="javascript:toggleInfo('Kremser_etal_RoG_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kremser_etal_RoG_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Reviews of Geophysics<br/>Vol. 54, pp. 278-335&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015RG000511">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016RvGeo..54..278K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kremser_etal_RoG_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Interest in stratospheric aerosol and its role in climate have increased over the last decade due to the observed increase in stratospheric aerosol since 2000 and the potential for changes in the sulfur cycle induced by climate change. This review provides an overview about the advances in stratospheric aerosol research since the last comprehensive assessment of stratospheric aerosol was published in 2006. A crucial development since 2006 is the substantial improvement in the agreement between in situ and space-based inferences of stratospheric aerosol properties during volcanically quiescent periods. Furthermore, new measurement systems and techniques, both in situ and space based, have been developed for measuring physical aerosol properties with greater accuracy and for characterizing aerosol composition. However, these changes induce challenges to constructing a long-term stratospheric aerosol climatology. Currently, changes in stratospheric aerosol levels less than 20&#37; cannot be confidently quantified. The volcanic signals tend to mask any nonvolcanically driven change, making them difficult to understand. While the role of carbonyl sulfide as a substantial and relatively constant source of stratospheric sulfur has been confirmed by new observations and model simulations, large uncertainties remain with respect to the contribution from anthropogenic sulfur dioxide emissions. New evidence has been provided that stratospheric aerosol can also contain small amounts of nonsulfate matter such as black carbon and organics. Chemistry-climate models have substantially increased in quantity and sophistication. In many models the implementation of stratospheric aerosol processes is coupled to radiation and/or stratospheric chemistry modules to account for relevant feedback processes.</td>
</tr>
<tr id="bib_Kremser_etal_RoG_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kremser_etal_RoG_2016a,
  author = {Kremser, S. and Thomason, L. W. and von Hobe, M. and Hermann, M. and Deshler, T. and Timmreck, C. and Toohey, M. and Stenke, A. and Schwarz, J. P. and Weigel, R. and Fueglistaler, S. and Prata, F. J. and Vernier, J.-P. and Schlager, H. and Barnes, J. E. and Antu&ntilde;a-Marrero, J.-C. and Fairlie, D. and Palm, M. and Mahieu, E. and Notholt, J. and Rex, M. and Bingen, C. and Vanhellemont, F. and Bourassa, A. and Plane, J. M. C. and Klocke, D. and Carn, S. A. and Clarisse, L. and Trickl, T. and Neely, R. and James, A. D. and Rieger, L. and Wilson, J. C. and Meland, B.},
  title = {Stratospheric aerosolmdashObservations, processes, and impact on climate},
  journal = {Reviews of Geophysics},
  year = {2016},
  volume = {54},
  pages = {278-335},
  url = {http://adsabs.harvard.edu/abs/2016RvGeo..54..278K},
  doi = {https://doi.org/10.1002/2015RG000511}
}
</pre></td>
</tr>
<tr id="Prospero_etal_RoG_2002a" class="entry">
	<td>Prospero, J.M., Ginoux, P., Torres, O., Nicholson, S.E. and Gill, T.E.</td>
	<td>Environmental Characterization of GLOBALlt/line-breakgt Sources of Atmospheric Soil DUSTlt/line-breakgt Identified with the NIMBUS 7 Total OZONElt/line-breakgt Mapping SPECTROMETERlt/line-breakgt (toms) Absorbing Aerosol Product <p class="infolinks">[<a href="javascript:toggleInfo('Prospero_etal_RoG_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Prospero_etal_RoG_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Reviews of Geophysics<br/>Vol. 40, pp. 1002&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2000RG000095">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002RvGeo..40.1002P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Prospero_etal_RoG_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We use the Total Ozone Mapping Spectrometer (TOMS) sensor on the Nimbus 7 satellite to map the global distribution of major atmospheric dust sources with the goal of identifying common environmental characteristics. The largest and most persistent sources are located in the Northern Hemisphere, mainly in a broad ``dust belt'' that extends from the west coast of North Africa, over the Middle East, Central and South Asia, to China. There is remarkably little large-scale dust activity outside this region. In particular, the Southern Hemisphere is devoid of major dust activity. Dust sources, regardless of size or strength, can usually be associated with topographical lows located in arid regions with annual rainfall under 200-250 mm. Although the source regions themselves are arid or hyperarid, the action of water is evident from the presence of ephemeral streams, rivers, lakes, and playas. Most major sources have been intermittently flooded through the Quaternary as evidenced by deep alluvial deposits. Many sources are associated with areas where human impacts are well documented, e.g., the Caspian and Aral Seas, Tigris-Euphrates River Basin, southwestern North America, and the loess lands in China. Nonetheless, the largest and most active sources are located in truly remote areas where there is little or no human activity. Thus, on a global scale, dust mobilization appears to be dominated by natural sources. Dust activity is extremely sensitive to many environmental parameters. The identification of major sources will enable us to focus on critical regions and to characterize emission rates in response to environmental conditions. With such knowledge we will be better able to improve global dust models and to assess the effects of climate change on emissions in the future. It will also facilitate the interpretation of the paleoclimate record based on dust contained in ocean sediments and ice cores.</td>
</tr>
<tr id="bib_Prospero_etal_RoG_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Prospero_etal_RoG_2002a,
  author = {Prospero, J. M. and Ginoux, P. and Torres, O. and Nicholson, S. E. and Gill, T. E.},
  title = {Environmental Characterization of GLOBALlt/line-breakgt Sources of Atmospheric Soil DUSTlt/line-breakgt Identified with the NIMBUS 7 Total OZONElt/line-breakgt Mapping SPECTROMETERlt/line-breakgt (toms) Absorbing Aerosol Product},
  journal = {Reviews of Geophysics},
  year = {2002},
  volume = {40},
  pages = {1002},
  url = {http://adsabs.harvard.edu/abs/2002RvGeo..40.1002P},
  doi = {https://doi.org/10.1029/2000RG000095}
}
</pre></td>
</tr>
<tr id="Shrivastava_etal_RoG_2017a" class="entry">
	<td>Shrivastava, M., Cappa, C.D., Fan, J., Goldstein, A.H., Guenther, A.B., Jimenez, J.L., Kuang, C., Laskin, A., Martin, S.T., Ng, N.L., Petaja, T., Pierce, J.R., Rasch, P.J., Roldin, P., Seinfeld, J.H., Shilling, J., Smith, J.N., Thornton, J.A., Volkamer, R., Wang, J., Worsnop, D.R., Zaveri, R.A., Zelenyuk, A. and Zhang, Q.</td>
	<td>Recent advances in understanding secondary organic aerosol: Implications for global climate forcing <p class="infolinks">[<a href="javascript:toggleInfo('Shrivastava_etal_RoG_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Shrivastava_etal_RoG_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Reviews of Geophysics<br/>Vol. 55, pp. 509-559&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2016RG000540">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017RvGeo..55..509S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Shrivastava_etal_RoG_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Anthropogenic emissions and land use changes have modified atmospheric aerosol concentrations and size distributions over time. Understanding preindustrial conditions and changes in organic aerosol due to anthropogenic activities is important because these features (1) influence estimates of aerosol radiative forcing and (2) can confound estimates of the historical response of climate to increases in greenhouse gases. Secondary organic aerosol (SOA), formed in the atmosphere by oxidation of organic gases, represents a major fraction of global submicron-sized atmospheric organic aerosol. Over the past decade, significant advances in understanding SOA properties and formation mechanisms have occurred through measurements, yet current climate models typically do not comprehensively include all important processes. This review summarizes some of the important developments during the past decade in understanding SOA formation. We highlight the importance of some processes that influence the growth of SOA particles to sizes relevant for clouds and radiative forcing, including formation of extremely low volatility organics in the gas phase, acid-catalyzed multiphase chemistry of isoprene epoxydiols, particle-phase oligomerization, and physical properties such as volatility and viscosity. Several SOA processes highlighted in this review are complex and interdependent and have nonlinear effects on the properties, formation, and evolution of SOA. Current global models neglect this complexity and nonlinearity and thus are less likely to accurately predict the climate forcing of SOA and project future climate sensitivity to greenhouse gases. Efforts are also needed to rank the most influential processes and nonlinear process-related interactions, so that these processes can be accurately represented in atmospheric chemistry-climate models.</td>
</tr>
<tr id="bib_Shrivastava_etal_RoG_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Shrivastava_etal_RoG_2017a,
  author = {Shrivastava, M. and Cappa, C. D. and Fan, J. and Goldstein, A. H. and Guenther, A. B. and Jimenez, J. L. and Kuang, C. and Laskin, A. and Martin, S. T. and Ng, N. L. and Petaja, T. and Pierce, J. R. and Rasch, P. J. and Roldin, P. and Seinfeld, J. H. and Shilling, J. and Smith, J. N. and Thornton, J. A. and Volkamer, R. and Wang, J. and Worsnop, D. R. and Zaveri, R. A. and Zelenyuk, A. and Zhang, Q.},
  title = {Recent advances in understanding secondary organic aerosol: Implications for global climate forcing},
  journal = {Reviews of Geophysics},
  year = {2017},
  volume = {55},
  pages = {509-559},
  url = {http://adsabs.harvard.edu/abs/2017RvGeo..55..509S},
  doi = {https://doi.org/10.1002/2016RG000540}
}
</pre></td>
</tr>
<tr id="Ghan_etal_PotNAoS_2016a" class="entry">
	<td>Ghan, S., Wang, M., Zhang, S., Ferrachat, S., Gettelman, A., Griesfeller, J., Kipling, Z., Lohmann, U., Morrison, H., Neubauer, D., Partridge, D.G., Stier, P., Takemura, T., Wang, H. and Zhang, K.</td>
	<td>Challenges in constraining anthropogenic aerosol effects on cloud radiative forcing using present-day spatiotemporal variability <p class="infolinks">[<a href="javascript:toggleInfo('Ghan_etal_PotNAoS_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ghan_etal_PotNAoS_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Proceedings of the National Academy of Science<br/>Vol. 113, pp. 5804-5811&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1073/pnas.1514036113">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016PNAS..113.5804G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ghan_etal_PotNAoS_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A large number of processes are involved in the chain from emissions of aerosol precursor gases and primary particles to impacts on cloud radiative forcing. Those processes are manifest in a number of relationships that can be expressed as factors dlnX/dlnY driving aerosol effects on cloud radiative forcing. These factors include the relationships between cloud condensation nuclei (CCN) concentration and emissions, droplet number and CCN concentration, cloud fraction and droplet number, cloud optical depth and droplet number, and cloud radiative forcing and cloud optical depth. The relationship between cloud optical depth and droplet number can be further decomposed into the sum of two terms involving the relationship of droplet effective radius and cloud liquid water path with droplet number. These relationships can be constrained using observations of recent spatial and temporal variability of these quantities. However, we are most interested in the radiative forcing since the preindustrial era. Because few relevant measurements are available from that era, relationships from recent variability have been assumed to be applicable to the preindustrial to present-day change. Our analysis of Aerosol Comparisons between Observations and Models (AeroCom) model simulations suggests that estimates of relationships from recent variability are poor constraints on relationships from anthropogenic change for some terms, with even the sign of some relationships differing in many regions. Proxies connecting recent spatial/temporal variability to anthropogenic change, or sustained measurements in regions where emissions have changed, are needed to constrain estimates of anthropogenic aerosol impacts on cloud radiative forcing.</td>
</tr>
<tr id="bib_Ghan_etal_PotNAoS_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ghan_etal_PotNAoS_2016a,
  author = {Ghan, S. and Wang, M. and Zhang, S. and Ferrachat, S. and Gettelman, A. and Griesfeller, J. and Kipling, Z. and Lohmann, U. and Morrison, H. and Neubauer, D. and Partridge, D. G. and Stier, P. and Takemura, T. and Wang, H. and Zhang, K.},
  title = {Challenges in constraining anthropogenic aerosol effects on cloud radiative forcing using present-day spatiotemporal variability},
  journal = {Proceedings of the National Academy of Science},
  year = {2016},
  volume = {113},
  pages = {5804-5811},
  url = {http://adsabs.harvard.edu/abs/2016PNAS..113.5804G},
  doi = {https://doi.org/10.1073/pnas.1514036113}
}
</pre></td>
</tr>
<tr id="Kok_PotNAoS_2011a" class="entry">
	<td>Kok, J.F.</td>
	<td>A scaling theory for the size distribution of emitted dust aerosols suggests climate models underestimate the size of the global dust cycle <p class="infolinks">[<a href="javascript:toggleInfo('Kok_PotNAoS_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kok_PotNAoS_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Proceedings of the National Academy of Science<br/>Vol. 108, pp. 1016-1021&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1073/pnas.1014798108">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011PNAS..108.1016K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kok_PotNAoS_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral dust aerosols impact Earth's radiation budget through
<br>interactions with clouds, ecosystems, and radiation, which constitutes a
<br>substantial uncertainty in understanding past and predicting future
<br>climate changes. One of the causes of this large uncertainty is that the
<br>size distribution of emitted dust aerosols is poorly understood. The
<br>present study shows that regional and global circulation models (GCMs)
<br>overestimate the emitted fraction of clay aerosols
<br>(lt 2 &mu;m diameter) by a factor of tilde2-8 relative to
<br>measurements. This discrepancy is resolved by deriving a simple
<br>theoretical expression of the emitted dust size distribution that is in
<br>excellent agreement with measurements. This expression is based on the
<br>physics of the scale-invariant fragmentation of brittle materials, which
<br>is shown to be applicable to dust emission. Because clay aerosols
<br>produce a strong radiative cooling, the overestimation of the clay
<br>fraction causes GCMs to also overestimate the radiative cooling of a
<br>given quantity of emitted dust. On local and regional scales, this
<br>affects the magnitude and possibly the sign of the dust radiative
<br>forcing, with implications for numerical weather forecasting and
<br>regional climate predictions in dusty regions. On a global scale, the
<br>dust cycle in most GCMs is tuned to match radiative measurements, such
<br>that the overestimation of the radiative cooling of a given quantity of
<br>emitted dust has likely caused GCMs to underestimate the global dust
<br>emission rate. This implies that the deposition flux of dust and its
<br>fertilizing effects on ecosystems may be substantially larger than
<br>thought.
<br></td>
</tr>
<tr id="bib_Kok_PotNAoS_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kok_PotNAoS_2011a,
  author = {Kok, J. F.},
  title = {A scaling theory for the size distribution of emitted dust aerosols suggests climate models underestimate the size of the global dust cycle},
  journal = {Proceedings of the National Academy of Science},
  year = {2011},
  volume = {108},
  pages = {1016-1021},
  url = {http://adsabs.harvard.edu/abs/2011PNAS..108.1016K},
  doi = {https://doi.org/10.1073/pnas.1014798108}
}
</pre></td>
</tr>
<tr id="Zhang_etal_PotNAoS_2008a" class="entry">
	<td>Zhang, R., Khalizov, A.F., Pagels, J., Zhang, D., Xue, H. and McMurry, P.H.</td>
	<td>Variability in morphology, hygroscopicity, and optical properties of soot aerosols during atmospheric processing <p class="infolinks">[<a href="javascript:toggleInfo('Zhang_etal_PotNAoS_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhang_etal_PotNAoS_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Proceedings of the National Academy of Science<br/>Vol. 105, pp. 10291-10296&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1073/pnas.0804860105">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008PNAS..10510291Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhang_etal_PotNAoS_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The atmospheric effects of soot aerosols include interference with radiative transfer, visibility impairment, and alteration of cloud formation and are highly sensitive to the manner by which soot is internally mixed with other aerosol constituents. We present experimental studies to show that soot particles acquire a large mass fraction of sulfuric acid during atmospheric aging, considerably altering their properties. Soot particles exposed to subsaturated sulfuric acid vapor exhibit a marked change in morphology, characterized by a decreased mobility-based diameter but an increased fractal dimension and effective density. These particles experience large hygroscopic size and mass growth at subsaturated conditions (lt90&#37; relative humidity) and act efficiently as cloud-condensation nuclei. Coating with sulfuric acid and subsequent hygroscopic growth enhance the optical properties of soot aerosols, increasing scattering by ap10-fold and absorption by nearly 2-fold at 80&#37; relative humidity relative to fresh particles. In addition, condensation of sulfuric acid is shown to occur at a similar rate on ambient aerosols of various types of a given mobility size, regardless of their chemical compositions and microphysical structures. Representing an important mechanism of atmospheric aging, internal mixing of soot with sulfuric acid has profound implications on visibility, human health, and direct and indirect climate forcing.</td>
</tr>
<tr id="bib_Zhang_etal_PotNAoS_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhang_etal_PotNAoS_2008a,
  author = {Zhang, R. and Khalizov, A. F. and Pagels, J. and Zhang, D. and Xue, H. and McMurry, P. H.},
  title = {Variability in morphology, hygroscopicity, and optical properties of soot aerosols during atmospheric processing},
  journal = {Proceedings of the National Academy of Science},
  year = {2008},
  volume = {105},
  pages = {10291-10296},
  url = {http://adsabs.harvard.edu/abs/2008PNAS..10510291Z},
  doi = {https://doi.org/10.1073/pnas.0804860105}
}
</pre></td>
</tr>
<tr id="Pelosse_etal_PO_2013a" class="entry">
	<td>Pelosse, P., Kribs-Zaleta, C.M., Ginoux, M., Rabinovich, J.E., Gourbi&egrave;re, S. and Menu, F.</td>
	<td>Influence of Vectors' Risk-Spreading Strategies and Environmental Stochasticity on the Epidemiology and Evolution of Vector-Borne Diseases: The Example of Chagas' Disease <p class="infolinks">[<a href="javascript:toggleInfo('Pelosse_etal_PO_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>PLoS ONE<br/>Vol. 8, pp. e70830&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1371/journal.pone.0070830">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013PLoSO...870830P">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Pelosse_etal_PO_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Pelosse_etal_PO_2013a,
  author = {Pelosse, P. and Kribs-Zaleta, C. M. and Ginoux, M. and Rabinovich, J. E. and Gourbi&egrave;re, S. and Menu, F.},
  title = {Influence of Vectors' Risk-Spreading Strategies and Environmental Stochasticity on the Epidemiology and Evolution of Vector-Borne Diseases: The Example of Chagas' Disease},
  journal = {PLoS ONE},
  year = {2013},
  volume = {8},
  pages = {e70830},
  url = {http://adsabs.harvard.edu/abs/2013PLoSO...870830P},
  doi = {https://doi.org/10.1371/journal.pone.0070830}
}
</pre></td>
</tr>
<tr id="Dubovik_etal__2004a" class="entry">
	<td>Dubovik, O., Lapyonok, T., Kaufman, Y.J., Chin, M., Ginoux, P., Remer, L.A. and Holben, B.N.</td>
	<td>Retrieving sources of fine aerosols from MODIS and AERONET observations by inverting GOCART model <p class="infolinks">[<a href="javascript:toggleInfo('Dubovik_etal__2004a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dubovik_etal__2004a','bibtex')">BibTeX</a>]</p></td>
	<td>2004</td>
	<td><br/>Vol. 5652Passive Optical Remote Sensing of the Atmosphere and Clouds IV, pp. 66-75&nbsp;</td>
	<td>inproceedings</td>
	<td><a href="https://doi.org/10.1117/12.579069">DOI</a> <a href="http://adsabs.harvard.edu/abs/2004SPIE.5652...66D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dubovik_etal__2004a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The knowledge of the global distribution of tropospheric aerosols is important for studying effects of natural aerosols on global climate. Chemical transport models relying on assimilated meteorological fields and accounting for aerosol advection by winds and removal processes can simulate such distribution of atmospheric aerosols. However, the accuracy of global aerosol modeling is yet limited. The uncertainty in location and strength of the aerosol emission sources is a major factor limiting accuracy of global aerosol transport modeling. This paper describes an effort to retrieve global sources of fine mode aerosol from global satellite observations by inverting GOCART aerosol transport model. The method uses an adjoint operation to the aerosol transport model that allows performing inversion with original space (2 x 2.5 degrees) and time (20-60 minutes) resolution of GOCART model. The approach is illustrated by numerical tests and applied to the retrieval global aerosol sources (location and strength) from a combination of MODIS and AERONET observations.</td>
</tr>
<tr id="bib_Dubovik_etal__2004a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@inproceedings{Dubovik_etal__2004a,
  author = {Dubovik, O. and Lapyonok, T. and Kaufman, Y. J. and Chin, M. and Ginoux, P. and Remer, L. A. and Holben, B. N.},
  title = {Retrieving sources of fine aerosols from MODIS and AERONET observations by inverting GOCART model},
  booktitle = {Passive Optical Remote Sensing of the Atmosphere and Clouds IV},
  year = {2004},
  volume = {5652},
  pages = {66-75},
  url = {http://adsabs.harvard.edu/abs/2004SPIE.5652...66D},
  doi = {https://doi.org/10.1117/12.579069}
}
</pre></td>
</tr>
<tr id="Ginoux_NG_2017a" class="entry">
	<td>Ginoux, P.</td>
	<td>Warming or cooling dust? <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_NG_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Nature Geoscience<br/>Vol. 10(4), pp. 246-248&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/ngeo2923">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Ginoux_NG_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_NG_2017a,
  author = {Paul Ginoux},
  title = {Warming or cooling dust?},
  journal = {Nature Geoscience},
  publisher = {Springer Nature},
  year = {2017},
  volume = {10},
  number = {4},
  pages = {246--248},
  doi = {https://doi.org/10.1038/ngeo2923}
}
</pre></td>
</tr>
<tr id="Kok_etal_NG_2017a" class="entry">
	<td>Kok, J.F., Ridley, D.A., Zhou, Q., Miller, R.L., Zhao, C., Heald, C.L., Ward, D.S., Albani, S. and Haustein, K.</td>
	<td>Smaller desert dust cooling effect estimated from analysis of dust size and abundance <p class="infolinks">[<a href="javascript:toggleInfo('Kok_etal_NG_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Nature Geoscience<br/>Vol. 10(4), pp. 274-278&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/ngeo2912">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Kok_etal_NG_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kok_etal_NG_2017a,
  author = {Jasper F. Kok and David A. Ridley and Qing Zhou and Ron L. Miller and Chun Zhao and Colette L. Heald and Daniel S. Ward and Samuel Albani and Karsten Haustein},
  title = {Smaller desert dust cooling effect estimated from analysis of dust size and abundance},
  journal = {Nature Geoscience},
  publisher = {Springer Nature},
  year = {2017},
  volume = {10},
  number = {4},
  pages = {274--278},
  doi = {https://doi.org/10.1038/ngeo2912}
}
</pre></td>
</tr>
<tr id="Li_etal_N_2016a" class="entry">
	<td>Li, B., Gasser, T., Ciais, P., Piao, S., Tao, S., Balkanski, Y., Hauglustaine, D., Boisier, J.-P., Chen, Z., Huang, M., Li, L.Z., Li, Y., Liu, H., Liu, J., Peng, S., Shen, Z., Sun, Z., Wang, R., Wang, T., Yin, G., Yin, Y., Zeng, H., Zeng, Z. and Zhou, F.</td>
	<td>The contribution of Chinarsquos emissions to global climate forcing <p class="infolinks">[<a href="javascript:toggleInfo('Li_etal_N_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Li_etal_N_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Nature<br/>Vol. 531, pp. 357-361&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1038/nature17165">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016Natur.531..357L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Li_etal_N_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Knowledge of the contribution that individual countries have made to
<br>global radiative forcing is important to the implementation of the
<br>agreement on ldquocommon but differentiated responsibilitiesrdquo
<br>reached by the United Nations Framework Convention on Climate Change.
<br>Over the past three decades, China has experienced rapid economic
<br>development, accompanied by increased emission of greenhouse gases,
<br>ozone precursors and aerosols, but the magnitude of the associated
<br>radiative forcing has remained unclear. Here we use a global coupled
<br>biogeochemistry-climate model and a chemistry and transport model
<br>to quantify Chinarsquos present-day contribution to global radiative
<br>forcing due to well-mixed greenhouse gases, short-lived atmospheric
<br>climate forcers and land-use-induced regional surface albedo changes. We
<br>find that China contributes 10\thinspplusmnthinsp4&#37; of the current
<br>global radiative forcing. Chinarsquos relative contribution to the
<br>positive (warming) component of global radiative forcing, mainly induced
<br>by well-mixed greenhouse gases and black carbon aerosols, is
<br>12\thinspplusmnthinsp2%. Its relative contribution to the negative
<br>(cooling) component is 15\thinspplusmnthinsp6 dominated by the
<br>effect of sulfate and nitrate aerosols. Chinarsquos strongest
<br>contributions are 0.16thinspplusmnthinsp0.02 watts per square
<br>metre for CO_2 from fossil fuel burning,
<br>0.13thinspplusmnthinsp0.05 watts per square metre for
<br>CH_4, -0.11thinspplusmnthinsp0.05 watts per square
<br>metre for sulfate aerosols, and 0.09thinspplusmnthinsp0.06 watts
<br>per square metre for black carbon aerosols. Chinarsquos eventual goal
<br>of improving air quality will result in changes in radiative forcing in
<br>the coming years: a reduction of sulfur dioxide emissions would drive a
<br>faster future warming, unless offset by larger reductions of radiative
<br>forcing from well-mixed greenhouse gases and black carbon.
<br></td>
</tr>
<tr id="bib_Li_etal_N_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Li_etal_N_2016a,
  author = {Li, B. and Gasser, T. and Ciais, P. and Piao, S. and Tao, S. and Balkanski, Y. and Hauglustaine, D. and Boisier, J.-P. and Chen, Z. and Huang, M. and Li, L. Z. and Li, Y. and Liu, H. and Liu, J. and Peng, S. and Shen, Z. and Sun, Z. and Wang, R. and Wang, T. and Yin, G. and Yin, Y. and Zeng, H. and Zeng, Z. and Zhou, F.},
  title = {The contribution of Chinarsquos emissions to global climate forcing},
  journal = {Nature},
  year = {2016},
  volume = {531},
  pages = {357-361},
  url = {http://adsabs.harvard.edu/abs/2016Natur.531..357L},
  doi = {https://doi.org/10.1038/nature17165}
}
</pre></td>
</tr>
<tr id="PennerZhang_NSTRN_2003a" class="entry">
	<td>Penner, J. and Zhang, S.</td>
	<td>Modeling the Absorbing Aerosol Index <p class="infolinks">[<a href="javascript:toggleInfo('PennerZhang_NSTRN_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('PennerZhang_NSTRN_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>NASA STI/Recon Technical Report N<br/>Vol. 3&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2003STIN...0305686P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_PennerZhang_NSTRN_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We propose a scheme to model the absorbing aerosol index and improve the biomass carbon inventories by optimizing the difference between TOMS aerosol index (AI) and modeled AI with an inverse model. Two absorbing aerosol types are considered, including biomass carbon and mineral dust. A priori biomass carbon source was generated by Liousse et al 1996. Mineral dust emission is parameterized according to surface wind and soil moisture using the method developed by Ginoux 2000. In this initial study, the coupled CCM1 and GRANTOUR model was used to determine the aerosol spatial and temporal distribution. With modeled aerosol concentrations and optical properties, we calculate the radiance at the top of the atmosphere at 340 nm and 380 nm with a radiative transfer model. The contrast of radiance at these two wavelengths will be used to calculate AI. Then we compare the modeled AI with TOMS AI. This paper reports our initial modeling for AI and its comparison with TOMS Nimbus 7 AI. For our follow-on project we will model the global AI with aerosol spatial and temporal distribution recomputed from the IMPACT model and DAO GEOS-1 meteorology fields. Then we will build an inverse model, which applies a Bayesian inverse technique to optimize the agreement of between model and observational data. The inverse model will tune the biomass burning source strength to reduce the difference between modelled AI and TOMS AI. Further simulations with a posteriori biomass carbon sources from the inverse model will be carried out. Results will be compared to available observations such as surface concentration and aerosol optical depth.</td>
</tr>
<tr id="bib_PennerZhang_NSTRN_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{PennerZhang_NSTRN_2003a,
  author = {Penner, J. and Zhang, S.},
  title = {Modeling the Absorbing Aerosol Index},
  journal = {NASA STI/Recon Technical Report N},
  year = {2003},
  volume = {3},
  url = {http://adsabs.harvard.edu/abs/2003STIN...0305686P}
}
</pre></td>
</tr>
<tr id="Myhre_etal_MZ_2009a" class="entry">
	<td>Myhre, G., Kvalev&aring;g, M., R&auml;del, G., Cook, J., Shine, K.P., Clark, H., Karcher, F., Markowicz, K., Kardas, A., Wolkenberg, P., Balkanski, Y., Ponater, M., Forster, P., Rap, A. and de Leon, R.R.</td>
	<td>Intercomparison of radiative forcing calculations of stratospheric water vapour and contrails <p class="infolinks">[<a href="javascript:toggleInfo('Myhre_etal_MZ_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Meteorologische Zeitschrift<br/>Vol. 18, pp. 585-596&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1127/0941-2948/2009/0411">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009MetZe..18..585M">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Myhre_etal_MZ_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Myhre_etal_MZ_2009a,
  author = {Myhre, G. and Kvalev&aring;g, M. and R&auml;del, G. and Cook, J. and Shine, K. P. and Clark, H. and Karcher, F. and Markowicz, K. and Kardas, A. and Wolkenberg, P. and Balkanski, Y. and Ponater, M. and Forster, P. and Rap, A. and de Leon, R. R.},
  title = {Intercomparison of radiative forcing calculations of stratospheric water vapour and contrails},
  journal = {Meteorologische Zeitschrift},
  year = {2009},
  volume = {18},
  pages = {585-596},
  url = {http://adsabs.harvard.edu/abs/2009MetZe..18..585M},
  doi = {https://doi.org/10.1127/0941-2948/2009/0411}
}
</pre></td>
</tr>
<tr id="Lundgren_K_2011a" class="entry">
	<td>Lundgren, K.</td>
	<td>Direct Radiative Effects of Sea Salt on the Regional Scale <p class="infolinks">[<a href="javascript:toggleInfo('Lundgren_K_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>KIT-Thesis&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5445/ksp/1000024937">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Lundgren_K_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Lundgren_K_2011a,
  author = {Lundgren, Kristina},
  title = {Direct Radiative Effects of Sea Salt on the Regional Scale},
  journal = {KIT-Thesis},
  publisher = {KIT Scientific Publishing},
  year = {2011},
  doi = {https://doi.org/10.5445/ksp/1000024937}
}
</pre></td>
</tr>
<tr id="Ventelon_etal_JoNM_2012a" class="entry">
	<td>Ventelon, L., Willaime, F., Fu, C.-C., Heran, M. and Ginoux, I.</td>
	<td>Ab initio investigation of radiation defects in tungsten: Structure of self-interstitials and specificity of di-vacancies compared to other bcc transition metals <p class="infolinks">[<a href="javascript:toggleInfo('Ventelon_etal_JoNM_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ventelon_etal_JoNM_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Journal of Nuclear Materials<br/>Vol. 425, pp. 16-21&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.jnucmat.2011.08.024">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012JNuM..425...16V">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ventelon_etal_JoNM_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The results of DFT calculations on radiation point defects in tungsten are presented. The lowest energy configuration of the self-interstitial has exactly the lt1 1 1gt orientation and no tilt from this direction is observed when using appropriate cell geometry and pseudopotential. The present DFT calculations confirm that in pure tungsten the interactions between two vacancies are unexpectedly repulsive until the fifth nearest-neighbor and that the second nearest-neighbor di-vacancy is the most repulsive. The electronic entropy contribution to the free energy makes the nearest-neighbor configuration attractive at high temperature. A comparison with other bcc metals shows that the binding energies between two vacancies are strongly metal dependent and that tungsten leads to the largest deviation from empirical potential predictions. In tungsten, the effect on vacancy properties of alloying by tantalum and rhenium has been investigated using the Virtual Crystal Approximation (VCA). The effect of these alloying elements is essentially to change the filling of the d-band and the vacancy formation energy is found to be maximal and the relaxation to be minimal when the Fermi level is at the minimum of the pseudo-gap, as predicted by previous tight-binding calculations. Di-vacancies are shown to become attractive at first and second nearest-neighbor upon tantalum alloying and even more repulsive upon rhenium alloying.</td>
</tr>
<tr id="bib_Ventelon_etal_JoNM_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ventelon_etal_JoNM_2012a,
  author = {Ventelon, L. and Willaime, F. and Fu, C.-C. and Heran, M. and Ginoux, I.},
  title = {Ab initio investigation of radiation defects in tungsten: Structure of self-interstitials and specificity of di-vacancies compared to other bcc transition metals},
  journal = {Journal of Nuclear Materials},
  year = {2012},
  volume = {425},
  pages = {16-21},
  url = {http://adsabs.harvard.edu/abs/2012JNuM..425...16V},
  doi = {https://doi.org/10.1016/j.jnucmat.2011.08.024}
}
</pre></td>
</tr>
<tr id="Guo_etal_JoGRA_2013a" class="entry">
	<td>Guo, Y., Tian, B., Kahn, R.A., Kalashnikova, O., Wong, S. and Waliser, D.E.</td>
	<td>Tropical Atlantic dust and smoke aerosol variations related to the Madden-Julian Oscillation in MODIS and MISR observations <p class="infolinks">[<a href="javascript:toggleInfo('Guo_etal_JoGRA_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Journal of Geophysical Research: Atmospheres<br/>Vol. 118(10), pp. 4947-4963&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/jgrd.50409">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Guo_etal_JoGRA_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guo_etal_JoGRA_2013a,
  author = {Yanjuan Guo and Baijun Tian and Ralph A. Kahn and Olga Kalashnikova and Sun Wong and Duane E. Waliser},
  title = {Tropical Atlantic dust and smoke aerosol variations related to the Madden-Julian Oscillation in MODIS and MISR observations},
  journal = {Journal of Geophysical Research: Atmospheres},
  publisher = {American Geophysical Union (AGU)},
  year = {2013},
  volume = {118},
  number = {10},
  pages = {4947--4963},
  doi = {https://doi.org/10.1002/jgrd.50409}
}
</pre></td>
</tr>
<tr id="Prospero_JoGRA_1999a" class="entry">
	<td>Prospero, J.M.</td>
	<td>Long-term measurements of the transport of African mineral dust to the southeastern United States: Implications for regional air quality <p class="infolinks">[<a href="javascript:toggleInfo('Prospero_JoGRA_1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>Journal of Geophysical Research: Atmospheres<br/>Vol. 104(D13), pp. 15917-15927&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999jd900072">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Prospero_JoGRA_1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Prospero_JoGRA_1999a,
  author = {Joseph M. Prospero},
  title = {Long-term measurements of the transport of African mineral dust to the southeastern United States: Implications for regional air quality},
  journal = {Journal of Geophysical Research: Atmospheres},
  publisher = {American Geophysical Union (AGU)},
  year = {1999},
  volume = {104},
  number = {D13},
  pages = {15917--15927},
  doi = {https://doi.org/10.1029/1999jd900072}
}
</pre></td>
</tr>
<tr id="Ansmann_etal_JoGRA_2003a" class="entry">
	<td>Ansmann, A., B&ouml;Senberg, J., Chaikovsky, A., Comer&oacute;n, A., Eckhardt, S., Eixmann, R., Freudenthaler, V., Ginoux, P., Komguem, L., Linn&eacute;, H., M&aacute;Rquez, M.&Aacute;.L., Matthias, V., Mattis, I., Mitev, V., M&uuml;ller, D., Music, S., Nickovic, S., Pelon, J., Sauvage, L., Sobolewsky, P., Srivastava, M.K., Stohl, A., Torres, O., Vaughan, G., Wandinger, U. and Wiegner, M.</td>
	<td>Long-range transport of Saharan dust to northern Europe: The 11-16 October 2001 outbreak observed with EARLINET <p class="infolinks">[<a href="javascript:toggleInfo('Ansmann_etal_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ansmann_etal_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4783&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003JD003757">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4783A">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ansmann_etal_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The spread of mineral particles over southwestern, western, and central Europe resulting from a strong Saharan dust outbreak in October 2001 was observed at 10 stations of the European Aerosol Research Lidar Network (EARLINET). For the first time, an optically dense desert dust plume over Europe was characterized coherently with high vertical resolution on a continental scale. The main layer was located above the boundary layer (above 1-km height above sea level (asl)) up to 3-5-km height, and traces of dust particles reached heights of 7-8 km. The particle optical depth typically ranged from 0.1 to 0.5 above 1-km height asl at the wavelength of 532 nm, and maximum values close to 0.8 were found over northern Germany. The lidar observations are in qualitative agreement with values of optical depth derived from Total Ozone Mapping Spectrometer (TOMS) data. Ten-day backward trajectories clearly indicated the Sahara as the source region of the particles and revealed that the dust layer observed, e.g., over Belsk, Poland, crossed the EARLINET site Aberystwyth, UK, and southern Scandinavia 24-48 hours before. Lidar-derived particle depolarization ratios, backscatter- and extinction-related &Aring;ngstr&ouml;m exponents, and extinction-to-backscatter ratios mainly ranged from 15 to 25 -0.5 to 0.5, and 40-80 sr, respectively, within the lofted dust plumes. A few atmospheric model calculations are presented showing the dust concentration over Europe. The simulations were found to be consistent with the network observations.</td>
</tr>
<tr id="bib_Ansmann_etal_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ansmann_etal_JoGRA_2003a,
  author = {Ansmann, A. and B&ouml;Senberg, J. and Chaikovsky, A. and Comer&oacute;n, A. and Eckhardt, S. and Eixmann, R. and Freudenthaler, V. and Ginoux, P. and Komguem, L. and Linn&eacute;, H. and M&aacute;Rquez, M. &Aacute;. L. and Matthias, V. and Mattis, I. and Mitev, V. and M&uuml;ller, D. and Music, S. and Nickovic, S. and Pelon, J. and Sauvage, L. and Sobolewsky, P. and Srivastava, M. K. and Stohl, A. and Torres, O. and Vaughan, G. and Wandinger, U. and Wiegner, M.},
  title = {Long-range transport of Saharan dust to northern Europe: The 11-16 October 2001 outbreak observed with EARLINET},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4783},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4783A},
  doi = {https://doi.org/10.1029/2003JD003757}
}
</pre></td>
</tr>
<tr id="Balkanski_etal_JoGRA_1993a" class="entry">
	<td>Balkanski, Y.J., Jacob, D.J., Gardner, G.M., Graustein, W.C. and Turekian, K.K.</td>
	<td>Transport and residence times of tropospheric aerosols inferred from a global three-dimensional simulation of ^210Pb <p class="infolinks">[<a href="javascript:toggleInfo('Balkanski_etal_JoGRA_1993a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Balkanski_etal_JoGRA_1993a','bibtex')">BibTeX</a>]</p></td>
	<td>1993</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 98, pp. 20&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/93JD02456">DOI</a> <a href="http://adsabs.harvard.edu/abs/1993JGR....9820573B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Balkanski_etal_JoGRA_1993a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A global three-dimensional model is used to investigate the transport
<br>and tropospheric residence time of ^210Pb, an aerosol tracer
<br>produced in the atmosphere by radioactive decay of ^222Rn
<br>emitted from soils. The model uses meteorological input with
<br>4deg&times;5deg horizontal resolution and 4-hour temporal resolution
<br>from the Goddard Institute for Space Studies general circulation model
<br>(GCM). It computes aerosol scavenging by convective precipitation as
<br>part of the wet convective mass transport operator in order to capture
<br>the coupling between vertical transport and rainout. Scavenging in
<br>convective precipitation accounts for 74&#37; of the global ^210Pb
<br>sink in the model; scavenging in large-scale precipitation accounts for
<br>12 and scavenging in dry deposition accounts for 14%. The model
<br>captures 63&#37; of the variance of yearly mean ^210Pb
<br>concentrations measured at 85 sites around the world with negligible
<br>mean bias, lending support to the computation of aerosol scavenging.
<br>There are, however, a number of regional and seasonal discrepancies that
<br>reflect in part anomalies in GCM precipitation. Computed residence times
<br>with respect to deposition for ^210Pb aerosol in the
<br>tropospheric column are about 5 days at southern midlatitudes and 10-15
<br>days in the tropics; values at northern midlatitudes vary from about 5
<br>days in winter to 10 days in summer. The residence time of
<br>^210Pb produced in the lowest 0.5 km of atmosphere is on
<br>average four times shorter than that of ^210Pb produced in the
<br>upper atmosphere. Both model and observations indicate a weaker decrease
<br>of ^210Pb concentrations between the continental mixed layer
<br>and the free troposphere than is observed for total aerosol
<br>concentrations; an explanation is that ^222Rn is transported
<br>to high altitudes in wet convective updrafts, while aerosols and soluble
<br>precursors of aerosols are scavenged by precipitation in the updrafts.
<br>Thus ^210Pb is not simply a tracer of aerosols produced in the
<br>continental boundary layer, but also of aerosols derived from insoluble
<br>precursors emitted from the surface of continents. One may draw an
<br>analogy between ^210Pb and nitrate, whose precursor
<br>NO_x is sparingly soluble, and explain in this manner the
<br>strong correlation observed between nitrate and ^210Pb
<br>concentrations over the oceans.
<br></td>
</tr>
<tr id="bib_Balkanski_etal_JoGRA_1993a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Balkanski_etal_JoGRA_1993a,
  author = {Balkanski, Y. J. and Jacob, D. J. and Gardner, G. M. and Graustein, W. C. and Turekian, K. K.},
  title = {Transport and residence times of tropospheric aerosols inferred from a global three-dimensional simulation of ^210Pb},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1993},
  volume = {98},
  pages = {20},
  url = {http://adsabs.harvard.edu/abs/1993JGR....9820573B},
  doi = {https://doi.org/10.1029/93JD02456}
}
</pre></td>
</tr>
<tr id="Bauer_etal_JoGRA_2004a" class="entry">
	<td>Bauer, S.E., Balkanski, Y., Schulz, M., Hauglustaine, D.A. and Dentener, F.</td>
	<td>Global modeling of heterogeneous chemistry on mineral aerosol surfaces: Influence on tropospheric ozone chemistry and comparison to observations <p class="infolinks">[<a href="javascript:toggleInfo('Bauer_etal_JoGRA_2004a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Bauer_etal_JoGRA_2004a','bibtex')">BibTeX</a>]</p></td>
	<td>2004</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 109(D2), pp. D02304&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003JD003868">DOI</a> <a href="http://adsabs.harvard.edu/abs/2004JGRD..109.2304B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Bauer_etal_JoGRA_2004a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral aerosols can affect gas phase chemistry in the troposphere by
<br>providing reactive sites for heterogeneous reactions. We present here a
<br>global modeling study of the influence of mineral dust on the
<br>tropospheric photochemical cycle. This work is part of the Mineral Dust
<br>and Tropospheric Chemistry (MINATROC) project, which focussed on
<br>measurement campaigns, laboratory experiments, and integrative modeling.
<br>The laboratory experiments provide uptake coefficients for chemical
<br>species on mineral aerosol surfaces, which are used to compute the
<br>heterogeneous reaction rates in the model. The field measurements at
<br>Mount Cimone, northern Italy, provide trace gas and aerosol measurements
<br>during a Saharan dust episode and are used to evaluate the model. The
<br>simulations include the reactions between mineral dust aerosols and the
<br>gas-phase species O_3, HNO_3, NO_3, and
<br>N_2O_5. Under the conditions for the year 2000 the
<br>model simulates a decrease in global tropospheric ozone mass by about 5&#37; <br>due to the heterogeneous reactions on dust aerosols. The most important
<br>heterogeneous reaction is the uptake of HNO_3 on the dust
<br>surface, whereby the direct uptake of ozone on dust is not important in
<br>atmospheric chemistry. The comparison of the model results to
<br>observations indicates that the model simulates well the aerosol mass
<br>transported into the Mediterranean during the dust events and the
<br>arrival of all major dust events that were observed during a 7 month
<br>period. The decrease in ozone concentration during dust events is better
<br>simulated by the model when the heterogeneous reactions are included.
<br></td>
</tr>
<tr id="bib_Bauer_etal_JoGRA_2004a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Bauer_etal_JoGRA_2004a,
  author = {Bauer, S. E. and Balkanski, Y. and Schulz, M. and Hauglustaine, D. A. and Dentener, F.},
  title = {Global modeling of heterogeneous chemistry on mineral aerosol surfaces: Influence on tropospheric ozone chemistry and comparison to observations},
  journal = {Journal of Geophysical Research (Atmospheres)},
  publisher = {American Geophysical Union (AGU)},
  year = {2004},
  volume = {109},
  number = {D2},
  pages = {D02304},
  url = {http://adsabs.harvard.edu/abs/2004JGRD..109.2304B},
  doi = {https://doi.org/10.1029/2003JD003868}
}
</pre></td>
</tr>
<tr id="Caffrey_etal_JoGRA_2018a" class="entry">
	<td>Caffrey, P.F., Fromm, M.D. and Kablick, G.P.</td>
	<td>WRF-Chem Simulation of an East Asian Dust-Infused Baroclinic Storm (DIBS) <p class="infolinks">[<a href="javascript:toggleInfo('Caffrey_etal_JoGRA_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Caffrey_etal_JoGRA_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 123, pp. 6880-6895&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2017JD027848">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018JGRD..123.6880C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Caffrey_etal_JoGRA_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Observations of dust-infused baroclinic storm (DIBS) clouds (Fromm et al., 2016, <A href=``https://doi.org/10.1002/2016GL071801''>https://doi.org/10.1002/2016GL071801</A>) have revealed Saharan and Asian storm systems with mineral dust mixed with overrunning cirrus shield clouds at altitudes of 8-10 km. The unique characteristics observed in these clouds, including intense Cloud-Aerosol LIdar with Orthogonal Polarization lidar backscatter and large daytime 3.9- to 11-&mu;m brightness temperature differences (indicating relatively small ice crystals), have prompted this modeling study to determine the mineral dust pathway and dynamics, if any, through an observed DIBS. We use the Advanced Weather Research and Forecasting Model with the chemistry model (WRF-Chem) and constrained with the WRF data assimilation system (WRF-DA) to conduct a reanalysis of an East Asian DIBS from 6 to 11 April 2010. Desert dust emission via the Global Ozone Chemistry Aerosol Radiation and Transport dust emission scheme (Ginoux et al., 2001, <A href=``https://doi.org/10.1029/2000JD000053''>https://doi.org/10.1029/2000JD000053</A>) and transport from both the Taklimakan and Gobi deserts is simulated within WRF-Chem with the Model for Simulating Aerosol Interactions and Chemistry aerosol treatment (Zaveri et al., 2008, <A href=``https://doi.org/10.1029/2007JD008782''>https://doi.org/10.1029/2007JD008782</A>). In-line air mass trajectories were used to source and trace dust transport from the storm spin-up through dissipation 4 days later. Results show rapid dust transport from the Gobi desert to cirrus cloud tops via the warm conveyor belt mechanism, with the dust mixed throughout the cloud at altitudes from 5 to 10 km. Results are verified by good qualitative agreement with Cloud-Aerosol LIdar with Orthogonal Polarization observations at several different moments in the DIBS cycle, including an elevated layer of dust that remains after storm cloud dissipation. These results confirm the potential for routine and significant dust-cloud processing in DIBS cases, affecting both cloud properties and identifying a previously unidentified pathway for long-range transport of dust.</td>
</tr>
<tr id="bib_Caffrey_etal_JoGRA_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Caffrey_etal_JoGRA_2018a,
  author = {Caffrey, P. F. and Fromm, M. D. and Kablick, G. P.},
  title = {WRF-Chem Simulation of an East Asian Dust-Infused Baroclinic Storm (DIBS)},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2018},
  volume = {123},
  pages = {6880-6895},
  url = {http://adsabs.harvard.edu/abs/2018JGRD..123.6880C},
  doi = {https://doi.org/10.1029/2017JD027848}
}
</pre></td>
</tr>
<tr id="Cakmur_etal_JoGRA_2006a" class="entry">
	<td>Cakmur, R.V., Miller, R.L., Perlwitz, J., Geogdzhayev, I.V., Ginoux, P., Koch, D., Kohfeld, K.E., Tegen, I. and Zender, C.S.</td>
	<td>Constraining the magnitude of the global dust cycle by minimizing the difference between a model and observations <p class="infolinks">[<a href="javascript:toggleInfo('Cakmur_etal_JoGRA_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Cakmur_etal_JoGRA_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 111, pp. D06207&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD005791">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006JGRD..111.6207C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Cakmur_etal_JoGRA_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Current estimates of global dust emission vary by over a factor of two. Here, we use multiple data types and a worldwide array of stations combined with a dust model to constrain the magnitude of the global dust cycle for particles with radii between 0.1 and 8 &mu;m. An optimal value of global emission is calculated by minimizing the difference between the model dust distribution and observations. The optimal global emission is most sensitive to the prescription of the dust source region. Depending upon the assumed source, the agreement with observations is greatest for global, annual emission ranging from 1500 to 2600 Tg. However, global annual emission between 1000 and 3000 Tg remains in agreement with the observations, given small changes in the method of optimization. Both ranges include values that are substantially larger than calculated by current dust models. In contrast, the optimal fraction of clay particles (whose radii are less than 1 &mu;m) is lower than current model estimates. The optimal solution identified by a combination of data sets is different from that identified by any single data set and is more robust. Uncertainty is introduced into the optimal emission by model biases and the uncertain contribution of other aerosol species to the observations.</td>
</tr>
<tr id="bib_Cakmur_etal_JoGRA_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Cakmur_etal_JoGRA_2006a,
  author = {Cakmur, R. V. and Miller, R. L. and Perlwitz, J. and Geogdzhayev, I. V. and Ginoux, P. and Koch, D. and Kohfeld, K. E. and Tegen, I. and Zender, C. S.},
  title = {Constraining the magnitude of the global dust cycle by minimizing the difference between a model and observations},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2006},
  volume = {111},
  pages = {D06207},
  url = {http://adsabs.harvard.edu/abs/2006JGRD..111.6207C},
  doi = {https://doi.org/10.1029/2005JD005791}
}
</pre></td>
</tr>
<tr id="Chin_etal_JoGRA_2003a" class="entry">
	<td>Chin, M., Ginoux, P., Lucchesi, R., Huebert, B., Weber, R., Anderson, T., Masonis, S., Blomquist, B., Bandy, A. and Thornton, D.</td>
	<td>A global aerosol model forecast for the ACE-Asia field experiment <p class="infolinks">[<a href="javascript:toggleInfo('Chin_etal_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Chin_etal_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 8654&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003JD003642">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.8654C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Chin_etal_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present the results of aerosol forecast during the ACE-Asia field experiment in spring 2001, using the Georgia Tech/Goddard Global Ozone Chemistry Aerosol Radiation and Transport (GOCART) model and the meteorological forecast fields from the Goddard Earth Observing System Data Assimilation System (GEOS DAS). The model provides direct information on aerosol optical thickness and concentrations for effective flight planning, while feedbacks from measurements constantly evaluate the model for successful model improvements. We verify the model forecast skill by comparing model-predicted aerosol quantities and meteorological variables with those measured by the C-130 aircraft. The GEOS DAS meteorological forecast system shows excellent skills in predicting winds, relative humidity, and temperature, with skill scores usually in the range of 0.7-0.99. The model is also skillful in forecasting pollution aerosols, with most scores above 0.5. The model correctly predicted the dust outbreak events and their trans-Pacific transport, but it constantly missed the high dust concentrations observed in the boundary layer. We attribute this ``missing'' dust source to desertification regions in the Inner Mongolia Province in China, which have developed in recent years but were not included in the model during forecasting. After incorporating the desertification sources, the model is able to reproduce the observed boundary layer high dust concentrations over the Yellow Sea. We demonstrate that our global model can not only account for the large-scale intercontinental transport but also produce the small-scale spatial and temporal variations that are adequate for aircraft measurements planning.</td>
</tr>
<tr id="bib_Chin_etal_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Chin_etal_JoGRA_2003a,
  author = {Chin, M. and Ginoux, P. and Lucchesi, R. and Huebert, B. and Weber, R. and Anderson, T. and Masonis, S. and Blomquist, B. and Bandy, A. and Thornton, D.},
  title = {A global aerosol model forecast for the ACE-Asia field experiment},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {8654},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.8654C},
  doi = {https://doi.org/10.1029/2003JD003642}
}
</pre></td>
</tr>
<tr id="Chin_etal_JoGRA_2004a" class="entry">
	<td>Chin, M., Chu, A., Levy, R., Remer, L., Kaufman, Y., Holben, B., Eck, T., Ginoux, P. and Gao, Q.</td>
	<td>Aerosol distribution in the Northern Hemisphere during ACE-Asia: Results from global model, satellite observations, and Sun photometer measurements <p class="infolinks">[<a href="javascript:toggleInfo('Chin_etal_JoGRA_2004a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Chin_etal_JoGRA_2004a','bibtex')">BibTeX</a>]</p></td>
	<td>2004</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 109(#D18#), pp. D23S90&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004JD004829">DOI</a> <a href="http://adsabs.harvard.edu/abs/2004JGRD..10923S90C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Chin_etal_JoGRA_2004a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We analyze the aerosol distribution and composition in the Northern Hemisphere during the Asian Pacific Regional Aerosol Characterization Experiment (ACE-Asia) field experiment in spring 2001. We use the Goddard Chemistry Aerosol Radiation and Transport (GOCART) model in this study, in conjunction with satellite retrieval from the Moderate-Resolution Imaging Spectroradiometer (MODIS) on EOS-Terra satellite and Sun photometer measurements from the worldwide Aerosol Robotic Network (AERONET). Statistical analysis methods including histograms, mean bias, root-mean-square error, correlation coefficients, and skill scores are applied to quantify the differences between the MODIS 1deg &times; 1deg gridded data, the daytime average AERONET data, and the daily mean 2deg &times; 2.5deg resolution model results. Both MODIS and the model show relatively high aerosol optical thickness (&tau;) near the source regions of Asia, Europe, and northern Africa, and they agree on major features of the long-range transport of aerosols from their source regions to the neighboring oceans. The &tau; values from MODIS and from the model have similar probability distributions in the extratropical oceans and in Europe, but MODIS is approximately 2-3 times as high as the model in North/Central America and nearly twice as high in Asia and over the tropical/subtropical oceans. Comparisons with the AERONET measurements in the Northern Hemisphere demonstrate that in general the model and the AERONET data have comparable values and similar probability distributions of &tau;, whereas MODIS tends to report higher values of &tau; over land, particularly North/Central America. The MODIS high bias is primarily attributed to the difficulties in land algorithm dealing with surface reflectance over inhomogeneous and bright land surfaces, including mountaintops, arid areas, and areas of snow/ice melting and with land/water mixed pixels. The model estimates that on average, sulfate, carbon, dust, and sea salt comprise 30 25 32 and 13 respectively, of the 550-nm &tau; in April 2001 in the Northern Hemisphere, with tilde46&#37; of the total &tau; from anthropogenic activities and 66&#37; from fine mode aerosols.</td>
</tr>
<tr id="bib_Chin_etal_JoGRA_2004a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Chin_etal_JoGRA_2004a,
  author = {Chin, M. and Chu, A. and Levy, R. and Remer, L. and Kaufman, Y. and Holben, B. and Eck, T. and Ginoux, P. and Gao, Q.},
  title = {Aerosol distribution in the Northern Hemisphere during ACE-Asia: Results from global model, satellite observations, and Sun photometer measurements},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2004},
  volume = {109},
  number = {#D18#},
  pages = {D23S90},
  url = {http://adsabs.harvard.edu/abs/2004JGRD..10923S90C},
  doi = {https://doi.org/10.1029/2004JD004829}
}
</pre></td>
</tr>
<tr id="Claquin_etal_JoGRA_1999a" class="entry">
	<td>Claquin, T., Schulz, M. and Balkanski, Y.J.</td>
	<td>Modeling the mineralogy of atmospheric dust sources <p class="infolinks">[<a href="javascript:toggleInfo('Claquin_etal_JoGRA_1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 104(D18), pp. 22243-22256&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999jd900416">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Claquin_etal_JoGRA_1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Claquin_etal_JoGRA_1999a,
  author = {T. Claquin and M. Schulz and Y. J. Balkanski},
  title = {Modeling the mineralogy of atmospheric dust sources},
  journal = {Journal of Geophysical Research (Atmospheres)},
  publisher = {American Geophysical Union (AGU)},
  year = {1999},
  volume = {104},
  number = {D18},
  pages = {22243--22256},
  doi = {https://doi.org/10.1029/1999jd900416}
}
</pre></td>
</tr>
<tr id="Colarco_etal_JoGRA_2010a" class="entry">
	<td>Colarco, P., da Silva, A., Chin, M. and Diehl, T.</td>
	<td>Online simulations of global aerosol distributions in the NASA GEOS-4 model and comparisons to satellite and ground-based aerosol optical depth <p class="infolinks">[<a href="javascript:toggleInfo('Colarco_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Colarco_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D14207&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD012820">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11514207C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Colarco_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We have implemented a module for tropospheric aerosols (GOCART) online in the NASA Goddard Earth Observing System version 4 model and simulated global aerosol distributions for the period 2000-2006. The new online system offers several advantages over the previous offline version, providing a platform for aerosol data assimilation, aerosol-chemistry-climate interaction studies, and short-range chemical weather forecasting and climate prediction. We introduce as well a methodology for sampling model output consistently with satellite aerosol optical thickness (AOT) retrievals to facilitate model-satellite comparison. Our results are similar to the offline GOCART model and to the models participating in the AeroCom intercomparison. The simulated AOT has similar seasonal and regional variability and magnitude to Aerosol Robotic Network (AERONET), Moderate Resolution Imaging Spectroradiometer, and Multiangle Imaging Spectroradiometer observations. The model AOT and Angstrom parameter are consistently low relative to AERONET in biomass-burning-dominated regions, where emissions appear to be underestimated, consistent with the results of the offline GOCART model. In contrast, the model AOT is biased high in sulfate-dominated regions of North America and Europe. Our model-satellite comparison methodology shows that diurnal variability in aerosol loading is unimportant compared to sampling the model where the satellite has cloud-free observations, particularly in sulfate-dominated regions. Simulated sea salt burden and optical thickness are high by a factor of 2-3 relative to other models, and agreement between model and satellite over-ocean AOT is improved by reducing the model sea salt burden by a factor of 2. The best agreement in both AOT magnitude and variability occurs immediately downwind of the Saharan dust plume.</td>
</tr>
<tr id="bib_Colarco_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Colarco_etal_JoGRA_2010a,
  author = {Colarco, P. and da Silva, A. and Chin, M. and Diehl, T.},
  title = {Online simulations of global aerosol distributions in the NASA GEOS-4 model and comparisons to satellite and ground-based aerosol optical depth},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D14207},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11514207C},
  doi = {https://doi.org/10.1029/2009JD012820}
}
</pre></td>
</tr>
<tr id="Das_etal_JoGRA_2017a" class="entry">
	<td>Das, S., Harshvardhan, H., Bian, H., Chin, M., Curci, G., Protonotariou, A.P., Mielonen, T., Zhang, K., Wang, H. and Liu, X.</td>
	<td>Biomass burning aerosol transport and vertical distribution over the South African-Atlantic region <p class="infolinks">[<a href="javascript:toggleInfo('Das_etal_JoGRA_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Das_etal_JoGRA_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 122, pp. 6391-6415&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2016JD026421">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017JGRD..122.6391D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Das_etal_JoGRA_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Optically thick smoke aerosol plumes originating from biomass burning (BB) in the southwestern African Savanna during the austral spring are transported westward by the free tropospheric winds to primarily overlie vast stretches of stratocumulus cloud decks in the southeast Atlantic. We evaluated the simulations of long-range transport of BB aerosol by the Goddard Earth Observing System (GEOS-5) and four other global aerosol models over the complete South African-Atlantic region using Cloud-Aerosol Lidar with Orthogonal Polarization (CALIOP) observations to find any distinguishing or common model biases. Models, in general, captured the vertical distribution of aerosol over land but exhibited some common features after long-range transport of smoke plumes that were distinct from that of CALIOP. Most importantly, the model-simulated BB aerosol plumes quickly descend to lower levels just off the western coast of the continent, while CALIOP data suggest that smoke plumes continue their horizontal transport at elevated levels above the marine boundary layer. This is crucial because the sign of simulated aerosol semidirect effect can change depending on whether the bulk of the absorbing aerosols is present within or above the cloud levels in a model. The levels to which the aerosol plumes get subsided and the steepness of their descent vary amongst the models and amongst the different subregions of the domain. Investigations into possible causes of differences between GEOS-5 and CALIOP aerosol transport over the ocean revealed a minimal role of aerosol removal process representation in the model as opposed to model dynamics.</td>
</tr>
<tr id="bib_Das_etal_JoGRA_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Das_etal_JoGRA_2017a,
  author = {Das, S. and Harshvardhan, H. and Bian, H. and Chin, M. and Curci, G. and Protonotariou, A. P. and Mielonen, T. and Zhang, K. and Wang, H. and Liu, X.},
  title = {Biomass burning aerosol transport and vertical distribution over the South African-Atlantic region},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2017},
  volume = {122},
  pages = {6391-6415},
  url = {http://adsabs.harvard.edu/abs/2017JGRD..122.6391D},
  doi = {https://doi.org/10.1002/2016JD026421}
}
</pre></td>
</tr>
<tr id="Draxler_etal_JoGRA_2010a" class="entry">
	<td>Draxler, R.R., Ginoux, P. and Stein, A.F.</td>
	<td>An empirically derived emission algorithm for wind-blown dust <p class="infolinks">[<a href="javascript:toggleInfo('Draxler_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Draxler_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D16212&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD013167">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11516212D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Draxler_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A wind-blown dust emission algorithm was developed by matching the frequency of high-aerosol optical depth (AOD) events derived from the MODIS Deep Blue algorithm with the frequency of friction velocities derived from National Centers for Environmental Prediction's North American Mesoscale model. The threshold friction velocity is defined as the velocity that has the same frequency of as the 0.75 AOD. The AODs are converted to an emission flux that is used to compute the linear regression slope of the flux to the friction velocity. The slope represents the potential of a particular land surface to produce airborne dust and, in combination with the friction velocity, is used as a predictor for wind-blown dust emissions. Calculations for a test period of June and July 2007 showed the model prediction to capture the major measured plume events in timing and magnitude, although peak events tended to be overpredicted and many of the near-background level ambient concentrations were underpredicted. Most of the airborne dust loadings are attributed to locations with relatively low threshold friction velocities (lt45 cm s^-1), although these locations only composed of 9&#37; of the total number of source locations. There was some evidence that the duration of wind-blown dust plume events was comparable to the 3 day sampling frequency of the IMPROVE monitoring network. Higher temporal frequency AIRNow observations at Phoenix showed a surprisingly good fit with the magnitude of the model-predicted peak concentrations.</td>
</tr>
<tr id="bib_Draxler_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Draxler_etal_JoGRA_2010a,
  author = {Draxler, R. R. and Ginoux, P. and Stein, A. F.},
  title = {An empirically derived emission algorithm for wind-blown dust},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D16212},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11516212D},
  doi = {https://doi.org/10.1029/2009JD013167}
}
</pre></td>
</tr>
<tr id="Fan_etal_JoGRA_2012a" class="entry">
	<td>Fan, S.-M., Schwarz, J.P., Liu, J., Fahey, D.W., Ginoux, P., Horowitz, L.W., Levy II, H., Ming, Y. and Spackman, J.R.</td>
	<td>Inferring ice formation processes from global-scale black carbon profiles observed in the remote atmosphere and model simulations <p class="infolinks">[<a href="javascript:toggleInfo('Fan_etal_JoGRA_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Fan_etal_JoGRA_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 117(#D16#), pp. D23205&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2012JD018126">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012JGRD..11723205F">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Fan_etal_JoGRA_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Black carbon (BC) aerosol absorbs solar radiation and can act as cloud condensation nucleus and ice formation nucleus. The current generation of climate models have difficulty in accurately predicting global-scale BC concentrations. Previously, an ensemble of such models was compared to measurements, revealing model biases in the tropical troposphere and in the polar troposphere. Here global aerosol distributions are simulated using different parameterizations of wet removal, and model results are compared to BC profiles observed in the remote atmosphere to explore the possible sources of these biases. The model-data comparison suggests a slow removal of BC aerosol during transport to the Arctic in winter and spring, because ice crystal growth causes evaporation of liquid cloud via the Bergeron process and, hence, release of BC aerosol back to ambient air. By contrast, more efficient model wet removal is needed in the cold upper troposphere over the tropical Pacific. Parcel model simulations with detailed droplet and ice nucleation and growth processes suggest that ice formation in this region may be suppressed due to a lack of ice nuclei (mainly insoluble dust particles) in the remote atmosphere, allowing liquid and mixed-phase clouds to persist under freezing temperatures, and forming liquid precipitation capable of removing aerosol incorporated in cloud water. Falling ice crystals can scavenge droplets in lower clouds, which also results in efficient removal of cloud condensation nuclei. The combination of models with global-scale BC measurements in this study has provided new, latitude-dependent information on ice formation processes in the atmosphere, and highlights the importance of a consistent treatment of aerosol and moist physics in climate models.</td>
</tr>
<tr id="bib_Fan_etal_JoGRA_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Fan_etal_JoGRA_2012a,
  author = {Fan, S.-M. and Schwarz, J. P. and Liu, J. and Fahey, D. W. and Ginoux, P. and Horowitz, L. W. and Levy, II, H. and Ming, Y. and Spackman, J. R.},
  title = {Inferring ice formation processes from global-scale black carbon profiles observed in the remote atmosphere and model simulations},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2012},
  volume = {117},
  number = {#D16#},
  pages = {D23205},
  url = {http://adsabs.harvard.edu/abs/2012JGRD..11723205F},
  doi = {https://doi.org/10.1029/2012JD018126}
}
</pre></td>
</tr>
<tr id="Ganguly_etal_JoGRA_2009a" class="entry">
	<td>Ganguly, D., Ginoux, P., Ramaswamy, V., Dubovik, O., Welton, J., Reid, E.A. and Holben, B.N.</td>
	<td>Inferring the composition and concentration of aerosols by combining AERONET and MPLNET data: Comparison with other measurements and utilization to evaluate GCM output <p class="infolinks">[<a href="javascript:toggleInfo('Ganguly_etal_JoGRA_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ganguly_etal_JoGRA_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 114(#D13#), pp. D16203&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD011895">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009JGRD..11416203G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ganguly_etal_JoGRA_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: In this work we demonstrate a method to derive the concentration of aerosol components from the spectral measurements of AOD (aerosol optical depth) and single scattering albedo along with their size distribution and extinction profile available from AERONET (Aerosol Robotic Network) and MPLNET (Micro-pulse Lidar Network) stations. The technique involves finding the best combination of aerosol concentration by minimizing differences between measured and calculated values of aerosol parameters such as AOD, single scattering albedo, and size distribution. We applied this technique over selected sites in three different regions of the United States (West coast, Great Plains, and North-East). Our results are then compared with the measured concentration of aerosol components available from IMPROVE (Interagency Monitoring of Protected Visual Environments) and EPA (Environmental Protection Agency) network, as well as two different versions of the GFDL (Geophysical Fluid Dynamics Laboratory) General Circulation Model AM2 with online and offline aerosols. In general, concentrations retrieved by our technique compare well with the ground-based measurements, but there are some discrepancies possibly due to the inherent differences in temporal and spatial scales of data averaging or some of the assumptions made in our study. Over continental North America, the online version of AM2 appears to overestimate sulfate concentration approximately by a factor of two and underestimate organic carbon by nearly the same amount. Results of our sensitivity study show that the errors in the retrieval of black carbon and sulfate concentrations could be as high as 100&#37; when there is a large bias of tilde0.05 in the reference values of single scattering albedo under high AOD (ge0.5 at 0.44 &mu;m) conditions. Knowledge on the vertical distribution of aerosols is crucial for an accurate retrieval of surface concentration of aerosols. We also determine the composition and concentration of elevated aerosol layers using this technique.</td>
</tr>
<tr id="bib_Ganguly_etal_JoGRA_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ganguly_etal_JoGRA_2009a,
  author = {Ganguly, D. and Ginoux, P. and Ramaswamy, V. and Dubovik, O. and Welton, J. and Reid, E. A. and Holben, B. N.},
  title = {Inferring the composition and concentration of aerosols by combining AERONET and MPLNET data: Comparison with other measurements and utilization to evaluate GCM output},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2009},
  volume = {114},
  number = {#D13#},
  pages = {D16203},
  url = {http://adsabs.harvard.edu/abs/2009JGRD..11416203G},
  doi = {https://doi.org/10.1029/2009JD011895}
}
</pre></td>
</tr>
<tr id="Ge_etal_JoGRA_2016a" class="entry">
	<td>Ge, C., Wang, J., Carn, S., Yang, K., Ginoux, P. and Krotkov, N.</td>
	<td>Satellite-based global volcanic SO_2 emissions and sulfate direct radiative forcing during 2005-2012 <p class="infolinks">[<a href="javascript:toggleInfo('Ge_etal_JoGRA_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ge_etal_JoGRA_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 121, pp. 3446-3464&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015JD023134">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016JGRD..121.3446G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ge_etal_JoGRA_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: An 8 year volcanic SO_2 emission inventory for 2005-2012 is obtained based on satellite measurements of SO_2 from OMI (Ozone Monitoring Instrument) and ancillary information from the Global Volcanism Program. It includes contributions from global volcanic eruptions and from eight persistently degassing volcanoes in the tropics. It shows significant differences in the estimate of SO_2 amount and injection height for medium to large volcanic eruptions as compared to the counterparts in the existing volcanic SO_2 database. Emissions from Nyamuragira (DR Congo) in November 2006 and Gr\imsv&ouml;tn (Iceland) in May 2011 that were not included in the Intergovernmental Panel on Climate Change 5 (IPCC) inventory are included here. Using the updated emissions, the volcanic sulfate (SO_4^2-) distribution is simulated with the global transport model Goddard Earth Observing System (GEOS)-Chem. The simulated time series of sulfate aerosol optical depth (AOD) above 10 km captures every eruptive volcanic sulfate perturbation with a similar magnitude to that measured by Cloud-Aerosol Lidar and Infrared Pathfinder Satellite Observation (CALIPSO). The 8 year average contribution of eruptive SO_4^2- to total SO_4^2- loading above 10 km is &tilde;10&#37; over most areas of the Northern Hemisphere, with a maxima of 30&#37; in the tropics where the anthropogenic emissions are relatively smaller. The persistently degassing volcanic SO_4^2- in the tropics barely reaches above 10 km, but in the lower atmosphere it is regionally dominant (60 in terms of mass) over Hawaii and other oceanic areas northeast of Australia. Although the 7 year average (2005-2011) of eruptive volcanic sulfate forcing of -0.10 W m^-2 in this study is comparable to that in the 2013 IPCC report (-0.09 W m^-2), significant discrepancies exist for each year. Our simulations also imply that the radiative forcing per unit AOD for volcanic eruptions can vary from -40 to -80 W m^-2, much higher than the -25 W m^-2 implied in the IPCC calculations. In terms of sulfate forcing efficiency with respect to SO_2 emission, eruptive volcanic sulfate is 5 times larger than anthropogenic sulfate. The sulfate forcing efficiency from degassing volcanic sources is close to that of anthropogenic sources. This study highlights the importance of characterizing both volcanic emission amount and injection altitude as well as the key role of satellite observations in maintaining accurate volcanic emissions inventories.</td>
</tr>
<tr id="bib_Ge_etal_JoGRA_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ge_etal_JoGRA_2016a,
  author = {Ge, C. and Wang, J. and Carn, S. and Yang, K. and Ginoux, P. and Krotkov, N.},
  title = {Satellite-based global volcanic SO_2 emissions and sulfate direct radiative forcing during 2005-2012},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2016},
  volume = {121},
  pages = {3446-3464},
  url = {http://adsabs.harvard.edu/abs/2016JGRD..121.3446G},
  doi = {https://doi.org/10.1002/2015JD023134}
}
</pre></td>
</tr>
<tr id="Ginoux_etal_JoGRA_2006a" class="entry">
	<td>Ginoux, P., Horowitz, L.W., Ramaswamy, V., Geogdzhayev, I.V., Holben, B.N., Stenchikov, G. and Tie, X.</td>
	<td>Evaluation of aerosol distribution and optical depth in the Geophysical Fluid Dynamics Laboratory coupled model CM2.1 for present climate <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal_JoGRA_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal_JoGRA_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 111(#D10#), pp. D22210&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD006707">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006JGRD..11122210G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal_JoGRA_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This study evaluates the strengths and weaknesses of aerosol distributions and optical depths that are used to force the GFDL coupled climate model CM2.1. The concentrations of sulfate, organic carbon, black carbon, and dust are simulated using the MOZART model (Horowitz, 2006), while sea-salt concentrations are obtained from a previous study by Haywood et al. (1999). These aerosol distributions and precalculated relative-humidity-dependent specific extinction are utilized in the CM2.1 radiative scheme to calculate the aerosol optical depth. Our evaluation of the mean values (1996-2000) of simulated aerosols is based on comparisons with long-term mean climatological data from ground-based and remote sensing observations as well as previous modeling studies. Overall, the predicted concentrations of aerosol are within a factor 2 of the observed values and have a tendency to be overestimated. Comparison with satellite data shows an agreement within 10&#37; of global mean optical depth. This agreement masks regional differences of opposite signs in the optical depth. Essentially, the excessive optical depth from sulfate aerosols compensates for the underestimated contribution from organic and sea-salt aerosols. The largest discrepancies are over the northeastern United States (predicted optical depths are too high) and over biomass burning regions and southern oceans (predicted optical depths are too low). This analysis indicates that the aerosol properties are very sensitive to humidity, and major improvements could be achieved by properly taking into account their hygroscopic growth together with corresponding modifications of their optical properties.</td>
</tr>
<tr id="bib_Ginoux_etal_JoGRA_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal_JoGRA_2006a,
  author = {Ginoux, P. and Horowitz, L. W. and Ramaswamy, V. and Geogdzhayev, I. V. and Holben, B. N. and Stenchikov, G. and Tie, X.},
  title = {Evaluation of aerosol distribution and optical depth in the Geophysical Fluid Dynamics Laboratory coupled model CM2.1 for present climate},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2006},
  volume = {111},
  number = {#D10#},
  pages = {D22210},
  url = {http://adsabs.harvard.edu/abs/2006JGRD..11122210G},
  doi = {https://doi.org/10.1029/2005JD006707}
}
</pre></td>
</tr>
<tr id="Ginoux_etal_JoGRA_2010a" class="entry">
	<td>Ginoux, P., Garbuzov, D. and Hsu, N.C.</td>
	<td>Identification of anthropogenic and natural dust sources using Moderate Resolution Imaging Spectroradiometer (MODIS) Deep Blue level 2 data <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115, pp. D05204&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD012398">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..115.5204G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral dust interacts with radiation and impacts both the regional and global climate. The relative contribution of natural and anthropogenic dust sources, however, remains largely uncertain. Although human activities disturb soils and therefore enhance wind erosion, their contribution to global dust emission has never been directly evaluated because of a lack of data. The retrieval of aerosol properties over land, including deserts, using the Moderate Resolution Imaging Spectroradiometer Deep Blue algorithm makes the first direct characterization of the origin of individual sources possible. In order to separate freshly emitted dust from other aerosol types and aged dust particles, the spectral dependence of the single scattering albedo and the Angstrom wavelength exponent are used. Four years of data from the eastern part of West Africa, which includes one of the most active natural dust sources and the highest population density on the continent, are processed. Sources are identified on the basis of the persistence of significant aerosol optical depth from freshly emitted dust, and the origin is characterized as natural or anthropogenic on the basis of a land use data set. Our results indicate that although anthropogenic dust is observed less frequently and with lower optical depth than dust from natural sources in this particular region, it occupies a large area covering most of northern Nigeria and southern Chad, around Lake Chad. In addition, smaller anthropogenic sources are found as far south as 5deg of latitude north, well outside the domain of most dust source inventories.</td>
</tr>
<tr id="bib_Ginoux_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal_JoGRA_2010a,
  author = {Ginoux, P. and Garbuzov, D. and Hsu, N. C.},
  title = {Identification of anthropogenic and natural dust sources using Moderate Resolution Imaging Spectroradiometer (MODIS) Deep Blue level 2 data},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  pages = {D05204},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..115.5204G},
  doi = {https://doi.org/10.1029/2009JD012398}
}
</pre></td>
</tr>
<tr id="Ginoux_JoGRA_2003a" class="entry">
	<td>Ginoux, P.</td>
	<td>Effects of nonsphericity on mineral dust modeling <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4052&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002JD002516">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4052G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The dependency of nonsphericity on gravitational settling of mineral dust particles is parameterized for prolate ellipsoids and Reynolds number lower than 2. The settling speed is numerically solved from the momentum equation as a function of particle diameter and aspect ratio. The reduction of settling speed due to nonsphericity is included in the Global Ozone Chemistry Aerosol Radiation and Transport (GOCART) model to simulate dust size distribution for April 2001. Two numerical schemes for solving sedimentation are compared. For particles of diameter greater than 5 &mu;m, the simulated size distribution is sensitive to the numerical sedimentation scheme. Changing the particle shape from spherical to nonspherical with &lambda; = 2 makes little difference to the simulated surface concentration and size distribution except at the periphery of the dust sources. However, when very elongated particles (&lambda; = 5) are simulated, the differences between nonspherical and spherical particles are significant. With limited in situ measurements reporting most frequent &lambda; around 1.5, the overall effects on global modeling is rather negligible and the essential benefit is to relax the CFL condition of Eulerian settling schemes.</td>
</tr>
<tr id="bib_Ginoux_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_JoGRA_2003a,
  author = {Ginoux, P.},
  title = {Effects of nonsphericity on mineral dust modeling},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4052},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4052G},
  doi = {https://doi.org/10.1029/2002JD002516}
}
</pre></td>
</tr>
<tr id="GinouxTorres_JoGRA_2003a" class="entry">
	<td>Ginoux, P. and Torres, O.</td>
	<td>Empirical TOMS index for dust aerosol: Applications to model validation and source characterization <p class="infolinks">[<a href="javascript:toggleInfo('GinouxTorres_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('GinouxTorres_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4534&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003JD003470">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4534G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_GinouxTorres_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: An empirical relation is developed to express the Total Ozone Mapping Spectrometer (TOMS) aerosol index (AI) for the case of dust plumes, as an explicit function of four physical quantities: the single scattering albedo, optical thickness, altitude of the plume and surface pressure. This relation allows sensitivity analysis of the TOMS AI with physical properties, quantitative comparison with dust model results and physical analysis of dust sources, without the necessity of cumbersome radiative calculation. Two applications are presented: (1) the case study of a dust storm over the North Atlantic in March 1988, and (2) the characterization of 13 major dust sources. The first application shows that simulated dust distribution can be quantitatively compared to TOMS AI on a daily basis and over regions where dust is the dominant aerosol. The second application necessitates to further parameterize the relation by replacing the optical thickness and the altitude of the plume by meteorological variables. The advantage is that surface meteorological fields are easily available globally and for decades but the formulation only applies to dust sources. The daily, seasonal and interannual variability of the parameterized index over major dust sources reproduces correctly the variability of the observed TOMS AI. The correlation between these two indices is used to determine the surface characteristics and physical properties of dust aerosol over the sources.</td>
</tr>
<tr id="bib_GinouxTorres_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{GinouxTorres_JoGRA_2003a,
  author = {Ginoux, P. and Torres, O.},
  title = {Empirical TOMS index for dust aerosol: Applications to model validation and source characterization},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4534},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4534G},
  doi = {https://doi.org/10.1029/2003JD003470}
}
</pre></td>
</tr>
<tr id="Guelle_etal_JoGRA_1998a" class="entry">
	<td>Guelle, W., Balkanski, Y.J., Schulz, M., Dulac, F. and Monfray, P.</td>
	<td>Wet deposition in a global size-dependent aerosol transport model: 1. Comparison of a 1 year ^210Pb simulation with ground measurements <p class="infolinks">[<a href="javascript:toggleInfo('Guelle_etal_JoGRA_1998a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Guelle_etal_JoGRA_1998a','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 103, pp. 11&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/97JD03680">DOI</a> <a href="http://adsabs.harvard.edu/abs/1998JGR...10311429G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Guelle_etal_JoGRA_1998a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present and discuss results from a 1 year (1991) global simulation of
<br>the transport and deposition of ^210Pb with a new
<br>size-resolved aerosol transport model. The model accounts for aerosol
<br>size distribution and its evolution during transport. Our wet deposition
<br>scheme is size-dependent and distinguishes between scavenging by deep
<br>and shallow convective rains. It treats separately below- and in-cloud
<br>scavenging by synoptic rains. Although the model is formulated to treat
<br>all aerosol sizes, the validation was done for the ^210Pb
<br>submicronic aerosol for which the main sink is wet deposition. We assess
<br>the model transport and deposition of submicron aerosols by a comparison
<br>of model results with available surface measurements. Annual mean
<br>surface concentrations are compared at 117 stations throughout the
<br>globe; seasonal variations are examined for 35 of these sites. The mean
<br>bias between simulated and measured yearly averaged surface
<br>concentrations is -2.7 and the correlation coefficient is 0.80. The
<br>observed seasonal cycle and the annual mean concentrations are
<br>particularly well reproduced, although the model's poor vertical
<br>resolution does not capture the strong winter peak at some continental
<br>stations, nor the transport to Indian Ocean stations. Using the observed
<br>precipitation at or near the sites studied, we were able to explain a
<br>large part of the bias in model annual deposition. Deposition at coastal
<br>sites deserves also a special treatment since influenced by the
<br>land-ocean partition inherent to the model. When we represent correctly
<br>these coastal stations, we reduce the mean bias between observed and
<br>predicted annual deposition fluxes from 7.7&#37; to 1.2&#37; at 147 stations,
<br>and the correlation coefficient improves from 0.70 to 0.77.
<br></td>
</tr>
<tr id="bib_Guelle_etal_JoGRA_1998a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guelle_etal_JoGRA_1998a,
  author = {Guelle, W. and Balkanski, Y. J. and Schulz, M. and Dulac, F. and Monfray, P.},
  title = {Wet deposition in a global size-dependent aerosol transport model: 1. Comparison of a 1 year ^210Pb simulation with ground measurements},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1998},
  volume = {103},
  pages = {11},
  url = {http://adsabs.harvard.edu/abs/1998JGR...10311429G},
  doi = {https://doi.org/10.1029/97JD03680}
}
</pre></td>
</tr>
<tr id="Guelle_etal_JoGRA_1998b" class="entry">
	<td>Guelle, W., Balkanski, Y.J., Dibb, J.E., Schulz, M. and Dulac, F.</td>
	<td>Wet deposition in a global size-dependent aerosol transport model: 2. Influence of the scavenging scheme on ^210Pb vertical profiles, surface concentrations, and deposition <p class="infolinks">[<a href="javascript:toggleInfo('Guelle_etal_JoGRA_1998b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Guelle_etal_JoGRA_1998b','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 103, pp. 28&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/98JD01826">DOI</a> <a href="http://adsabs.harvard.edu/abs/1998JGR...10328875G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Guelle_etal_JoGRA_1998b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The main atmospheric sink for submicron aerosols is wet removal. Lead
<br>210, the radioactive decay product of ^222Rn, attaches
<br>immediately after being formed to submicron particles. Here we compare
<br>the effects of three different wet-scavenging schemes used in global
<br>aerosol simulations on the ^210Pb aerosol distribution using
<br>an off-line, size-resolved, global atmospheric transport model. We
<br>highlight the merits and shortcomings of each scavenging scheme at
<br>reproducing available measurements, which include concentrations in
<br>surface air and deposition, as well as vertical profiles observed over
<br>North America and western and central North Pacific. We show that
<br>model-measurement comparison of total deposition does not allow to
<br>distinguish between scavenging schemes because compensation effects can
<br>hide the differences in their respective scavenging efficiencies.
<br>Differences in scavenging parameterization affect the aerosol vertical
<br>distribution to a much greater extent than the surface concentration.
<br>Zonally averaged concentrations at different altitudes derived from the
<br>model vary by more than a factor of 3 according to the scavenging
<br>formulation, and only one scheme enables us to reproduce reliably the
<br>individual profiles observed. This study shows that ground measurements
<br>alone are insufficient to validate a global aerosol transport model.
<br></td>
</tr>
<tr id="bib_Guelle_etal_JoGRA_1998b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guelle_etal_JoGRA_1998b,
  author = {Guelle, W. and Balkanski, Y. J. and Dibb, J. E. and Schulz, M. and Dulac, F.},
  title = {Wet deposition in a global size-dependent aerosol transport model: 2. Influence of the scavenging scheme on ^210Pb vertical profiles, surface concentrations, and deposition},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1998},
  volume = {103},
  pages = {28},
  url = {http://adsabs.harvard.edu/abs/1998JGR...10328875G},
  doi = {https://doi.org/10.1029/98JD01826}
}
</pre></td>
</tr>
<tr id="Guelle_etal_JoGRA_2000a" class="entry">
	<td>Guelle, W., Balkanski, Y.J., Schulz, M., Marticorena, B., Bergametti, G., Moulin, C., Arimoto, R. and Perry, K.D.</td>
	<td>Modeling the atmospheric distribution of mineral aerosol: Comparison with ground measurements and satellite observations for yearly and synoptic timescales over the North Atlantic <p class="infolinks">[<a href="javascript:toggleInfo('Guelle_etal_JoGRA_2000a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Guelle_etal_JoGRA_2000a','bibtex')">BibTeX</a>]</p></td>
	<td>2000</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 105, pp. 1997-2012&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999JD901084">DOI</a> <a href="http://adsabs.harvard.edu/abs/2000JGR...105.1997G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Guelle_etal_JoGRA_2000a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present here a 3-year simulation (1990 to 1992) of the atmospheric
<br>cycle of Saharan dust over the Atlantic with an off-line
<br>three-dimensional transport model. The results of the simulation have
<br>been compared with selected relevant measurements. Careful attention has
<br>been paid to the spatial and temporal consistency between the
<br>observations and the model results. Satellite observations of optical
<br>thickness and the model show a closely similar latitudinal shift and
<br>change of the aerosol plume extent from month to month over 3 years.
<br>This is explained by the dominant role of the large-scale transport,
<br>well described by the European Centre for Medium-Range Weather Forecasts
<br>winds, a sufficiently consistent description of aerosol physics along
<br>with a detailed prognostic source function. A feature not captured
<br>perfectly by the model is the winter maximum in observed optical depth,
<br>which is south of the satellite observation window. This underestimate
<br>in the very southern tropical region in winter suggests that additional
<br>aerosol sources become important, such as Sahelian dust and carbonaceous
<br>aerosols from biomass burning, not included in our simulation. However,
<br>spring and autumn simulated optical thickness is 50&#37; less than that
<br>observed, while it is only 30&#37; less in summer and winter. This is found
<br>for both the subtropical and the tropical Atlantic Ocean, which points
<br>to a general underestimate by the model, not just because of aerosol
<br>sources missing in the Sahel region. Another seasonal feature is
<br>discussed for Sal Island where measurements suggest that low-level dust
<br>transport in winter is replaced by a pronounced high-level Saharan dust
<br>layer in summer. The model reproduces this pattern except that there is
<br>also significant low level transport in summer, associated mainly with
<br>peculiar simulated dust transport events from the western Sahara. On a
<br>synoptic scale the frequency of dust outbreaks over the North Atlantic
<br>and of major dust deposition events in Spain and a dust vertical profile
<br>measured by a lidar over the Azores region are reproduced by the model.
<br></td>
</tr>
<tr id="bib_Guelle_etal_JoGRA_2000a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guelle_etal_JoGRA_2000a,
  author = {Guelle, W. and Balkanski, Y. J. and Schulz, M. and Marticorena, B. and Bergametti, G. and Moulin, C. and Arimoto, R. and Perry, K. D.},
  title = {Modeling the atmospheric distribution of mineral aerosol: Comparison with ground measurements and satellite observations for yearly and synoptic timescales over the North Atlantic},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2000},
  volume = {105},
  pages = {1997-2012},
  url = {http://adsabs.harvard.edu/abs/2000JGR...105.1997G},
  doi = {https://doi.org/10.1029/1999JD901084}
}
</pre></td>
</tr>
<tr id="Guelle_etal_JoGRA_2001a" class="entry">
	<td>Guelle, W., Schulz, M., Balkanski, Y. and Dentener, F.</td>
	<td>Influence of the source formulation on modeling the atmospheric global distribution of sea salt aerosol <p class="infolinks">[<a href="javascript:toggleInfo('Guelle_etal_JoGRA_2001a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Guelle_etal_JoGRA_2001a','bibtex')">BibTeX</a>]</p></td>
	<td>2001</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 106, pp. 27&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2001JD900249">DOI</a> <a href="http://adsabs.harvard.edu/abs/2001JGR...10627509G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Guelle_etal_JoGRA_2001a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Three different sea salt generation functions are investigated for use
<br>in global three-dimensional atmospheric models. Complementary
<br>observational data are used to validate an annual simulation of the
<br>whole size range (film, jet, and spume droplet derived particles).
<br>Aerosol concentrations are corrected for humidity growth and sampler
<br>inlet characteristics. Data from the North American deposition network
<br>are corrected for mineral dust to derive sea salt wet fluxes. We find
<br>that sea salt transport to inner continental areas requires substantial
<br>mass in the jet droplet range, which is best reproduced with the source
<br>of Monahan et al. [1986]. The results from this source formulation also
<br>shows the best agreement with aerosol concentration seasonality and sea
<br>salt size distributions below 4 &mu;m dry radius. Measured wind speed
<br>dependence of coarse particle occurrence suggests that above 4 &mu; the
<br>source from Smith and Harrison [1998] is most appropriate. Such sea salt
<br>simulations are relevant for assessing heterogeneous chemistry and
<br>radiative effects. Sea salt aerosol provides on an annual average, in
<br>marine regions, an aggregate surface area equal to 1-10&#37; of the area of
<br>the underlying Earth's surface. Together with mineral dust, sulfate, and
<br>carbonaceous aerosol the total aerosol surface area globally amounts to
<br>13&#37; of that of the Earth's surface. On the basis of atmospheric column
<br>burdens, sea salt represents 21&#37; of the total global aerosol surface
<br>area. Equal partitioning of the aerosol surface area among the four
<br>components suggests that one has to consider all of them if the global
<br>aerosol impact is to be fully determined.
<br></td>
</tr>
<tr id="bib_Guelle_etal_JoGRA_2001a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guelle_etal_JoGRA_2001a,
  author = {Guelle, W. and Schulz, M. and Balkanski, Y. and Dentener, F.},
  title = {Influence of the source formulation on modeling the atmospheric global distribution of sea salt aerosol},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2001},
  volume = {106},
  pages = {27},
  url = {http://adsabs.harvard.edu/abs/2001JGR...10627509G},
  doi = {https://doi.org/10.1029/2001JD900249}
}
</pre></td>
</tr>
<tr id="Hansen_etal_JoGRA_2005a" class="entry">
	<td>Hansen, J., Sato, M., Ruedy, R., Nazarenko, L., Lacis, A., Schmidt, G.A., Russell, G., Aleinov, I., Bauer, M., Bauer, S., Bell, N., Cairns, B., Canuto, V., Chandler, M., Cheng, Y., Del Genio, A., Faluvegi, G., Fleming, E., Friend, A., Hall, T., Jackman, C., Kelley, M., Kiang, N., Koch, D., Lean, J., Lerner, J., Lo, K., Menon, S., Miller, R., Minnis, P., Novakov, T., Oinas, V., Perlwitz, J., Perlwitz, J., Rind, D., Romanou, A., Shindell, D., Stone, P., Sun, S., Tausnev, N., Thresher, D., Wielicki, B., Wong, T., Yao, M. and Zhang, S.</td>
	<td>Efficacy of climate forcings <p class="infolinks">[<a href="javascript:toggleInfo('Hansen_etal_JoGRA_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Hansen_etal_JoGRA_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 110(#D9#), pp. D18104&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD005776">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JGRD..11018104H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Hansen_etal_JoGRA_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We use a global climate model to compare the effectiveness of many
<br>climate forcing agents for producing climate change. We find a
<br>substantial range in the ``efficacy'' of different forcings, where the
<br>efficacy is the global temperature response per unit forcing relative to
<br>the response to CO_2 forcing. Anthropogenic CH_4 has
<br>efficacy tilde110 which increases to tilde145&#37; when its indirect
<br>effects on stratospheric H_2O and tropospheric O_3
<br>are included, yielding an effective climate forcing of tilde0.8
<br>W/m^2 for the period 1750-2000 and making CH_4 the
<br>largest anthropogenic climate forcing other than CO_2. Black
<br>carbon (BC) aerosols from biomass burning have a calculated efficacy
<br>tilde58 while fossil fuel BC has an efficacy tilde78%. Accounting
<br>for forcing efficacies and for indirect effects via snow albedo and
<br>cloud changes, we find that fossil fuel soot, defined as BC + OC
<br>(organic carbon), has a net positive forcing while biomass burning BC +
<br>OC has a negative forcing. We show that replacement of the traditional
<br>instantaneous and adjusted forcings, Fi and Fa, with an easily computed
<br>alternative, Fs, yields a better predictor of climate change, i.e., its
<br>efficacies are closer to unity. Fs is inferred from flux and temperature
<br>changes in a fixed-ocean model run. There is remarkable congruence in
<br>the spatial distribution of climate change, normalized to the same
<br>forcing Fs, for most climate forcing agents, suggesting that the global
<br>forcing has more relevance to regional climate change than may have been
<br>anticipated. Increasing greenhouse gases intensify the Hadley
<br>circulation in our model, increasing rainfall in the Intertropical
<br>Convergence Zone (ITCZ), Eastern United States, and East Asia, while
<br>intensifying dry conditions in the subtropics including the Southwest
<br>United States, the Mediterranean region, the Middle East, and an
<br>expanding Sahel. These features survive in model simulations that use
<br>all estimated forcings for the period 1880-2000. Responses to localized
<br>forcings, such as land use change and heavy regional concentrations of
<br>BC aerosols, include more specific regional characteristics. We suggest
<br>that anthropogenic tropospheric O_3 and the BC snow albedo
<br>effect contribute substantially to rapid warming and sea ice loss in the
<br>Arctic. As a complement to a priori forcings, such as Fi, Fa, and Fs, we
<br>tabulate the a posteriori effective forcing, Fe, which is the product of
<br>the forcing and its efficacy. Fe requires calculation of the climate
<br>response and introduces greater model dependence, but once it is
<br>calculated for a given amount of a forcing agent it provides a good
<br>prediction of the response to other forcing amounts.</td>
</tr>
<tr id="bib_Hansen_etal_JoGRA_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hansen_etal_JoGRA_2005a,
  author = {Hansen, J. and Sato, M. and Ruedy, R. and Nazarenko, L. and Lacis, A. and Schmidt, G. A. and Russell, G. and Aleinov, I. and Bauer, M. and Bauer, S. and Bell, N. and Cairns, B. and Canuto, V. and Chandler, M. and Cheng, Y. and Del Genio, A. and Faluvegi, G. and Fleming, E. and Friend, A. and Hall, T. and Jackman, C. and Kelley, M. and Kiang, N. and Koch, D. and Lean, J. and Lerner, J. and Lo, K. and Menon, S. and Miller, R. and Minnis, P. and Novakov, T. and Oinas, V. and Perlwitz, J. and Perlwitz, J. and Rind, D. and Romanou, A. and Shindell, D. and Stone, P. and Sun, S. and Tausnev, N. and Thresher, D. and Wielicki, B. and Wong, T. and Yao, M. and Zhang, S.},
  title = {Efficacy of climate forcings},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2005},
  volume = {110},
  number = {#D9#},
  pages = {D18104},
  url = {http://adsabs.harvard.edu/abs/2005JGRD..11018104H},
  doi = {https://doi.org/10.1029/2005JD005776}
}
</pre></td>
</tr>
<tr id="Harrison_etal_JoGRA_1990a" class="entry">
	<td>Harrison, E.F., Minnis, P., Barkstrom, B.R., Ramanathan, V., Cess, R.D. and Gibson, G.G.</td>
	<td>Seasonal variation of cloud radiative forcing derived from the Earth Radiation Budget Experiment <p class="infolinks">[<a href="javascript:toggleInfo('Harrison_etal_JoGRA_1990a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Harrison_etal_JoGRA_1990a','bibtex')">BibTeX</a>]</p></td>
	<td>1990</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 95, pp. 18&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/JD095iD11p18687">DOI</a> <a href="http://adsabs.harvard.edu/abs/1990JGR....9518687H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Harrison_etal_JoGRA_1990a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The NASA Earth Radiation Budget Experiment (ERBE), flying aboard
<br>multiple satellites, is providing new insights into the climate system.
<br>Monthly averaged clear-sky and cloudy sky flux data derived from the
<br>ERBE are used to assess the impact of clouds on the Earth's radiation
<br>balance. This impact is examined in terms of three quantities: longwave,
<br>shortwave, and net cloud forcing. Overall, clouds appear to cool the
<br>Earth-atmosphere system. The global mean cooling varied from 14 to 21 W
<br>m^-2 between April 1985 and January 1986. Hemispherically, the
<br>longwave and shortwave cloud forcing nearly cancel each other in the
<br>winter hemisphere, while in the summer the negative shortwave cloud
<br>forcing is significantly lower than the longwave cloud forcing,
<br>producing a strong cooling. Thus clouds significantly reduce the
<br>seasonal changes in the net radiative heating of the planet. This
<br>reduction is particularly strong over the mid- and high-latitude oceans,
<br>where they reduce the summer and spring solar heating by as much as
<br>100-150 W m^-2. In the low latitudes, the longwave and
<br>shortwave cloud forcing reach peak values over the convectively
<br>disturbed regions and tend to offset each other to a large extent. This
<br>feature, when combined with the large cooling effect over mid- and
<br>high-latitude oceans, leads to the conclusion that clouds significantly
<br>reduce the equator-to-pole radiative heating gradient of the planet
<br>during spring and summer. In the tropical convective regions the large
<br>magnitudes of the shortwave and longwave forcing and the near
<br>cancellation of the two suggest that clouds have a significant influence
<br>on the vertical distribution of heating between the atmosphere and the
<br>surface. Thus the ERBE data reveal that globally, hemispherically, and
<br>zonally, clouds have a significant effect on the radiative heating
<br>gradients. Comparisons of the ERBE results with general circulation
<br>models (GCMs) show that global net cloud forcing can be determined
<br>reasonably well from some current versions of the GCMs. Modeled regional
<br>and zonal values of radiative cloud forcing, however, indicate a need
<br>for considerable improvement.
<br></td>
</tr>
<tr id="bib_Harrison_etal_JoGRA_1990a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Harrison_etal_JoGRA_1990a,
  author = {Harrison, E. F. and Minnis, P. and Barkstrom, B. R. and Ramanathan, V. and Cess, R. D. and Gibson, G. G.},
  title = {Seasonal variation of cloud radiative forcing derived from the Earth Radiation Budget Experiment},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1990},
  volume = {95},
  pages = {18},
  url = {http://adsabs.harvard.edu/abs/1990JGR....9518687H},
  doi = {https://doi.org/10.1029/JD095iD11p18687}
}
</pre></td>
</tr>
<tr id="Horowitz_JoGRA_2006a" class="entry">
	<td>Horowitz, L.W.</td>
	<td>Past, present, and future concentrations of tropospheric ozone and aerosols: Methodology, ozone evaluation, and sensitivity to aerosol wet removal <p class="infolinks">[<a href="javascript:toggleInfo('Horowitz_JoGRA_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Horowitz_JoGRA_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 111(#D10#), pp. D22211&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD006937">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006JGRD..11122211H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Horowitz_JoGRA_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Tropospheric ozone and aerosols are radiatively important trace species, whose concentrations have increased dramatically since preindustrial times and are projected to continue to change in the future. The evolution of ozone and aerosol concentrations from 1860 to 2100 is simulated on the basis of estimated historical emissions and four different future emission scenarios (Intergovernmental Panel on Climate Change Special Report on Emissions Scenarios A2, A1B, B1, and A1FI). The simulations suggest that the tropospheric burden of ozone has increased by 50&#37; and sulfate and carbonaceous aerosol burdens have increased by factors of 3 and 6, respectively, since preindustrial times. Projected ozone changes over the next century range from -6&#37; to +43 depending on the emissions scenario. Sulfate concentrations are projected to increase for the next several decades but then to decrease by 2100 to 4-45&#37; below their 2000 values. Simulated ozone concentrations agree well with present-day observations and recent trends. Preindustrial surface concentrations of ozone are shown to be sensitive to the assumed anthropogenic and biomass burning emissions, but in all cases they overestimate the few available measurements from that era. Simulated tropospheric burdens of aerosols are sensitive by up to a factor of 2 to assumptions about the rate of aerosol wet deposition in the model. The concentrations of ozone and aerosols produced by this study are provided as climate-forcing agents in the Geophysical Fluid Dynamics Laboratory coupled climate model to estimate their effects on climate. The aerosol distributions from this study and the resulting optical depths are evaluated in a companion paper by P. Ginoux et al. (2006).</td>
</tr>
<tr id="bib_Horowitz_JoGRA_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Horowitz_JoGRA_2006a,
  author = {Horowitz, L. W.},
  title = {Past, present, and future concentrations of tropospheric ozone and aerosols: Methodology, ozone evaluation, and sensitivity to aerosol wet removal},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2006},
  volume = {111},
  number = {#D10#},
  pages = {D22211},
  url = {http://adsabs.harvard.edu/abs/2006JGRD..11122211H},
  doi = {https://doi.org/10.1029/2005JD006937}
}
</pre></td>
</tr>
<tr id="Huang_etal_JoGRA_2010a" class="entry">
	<td>Huang, L., Gong, S.L., Jia, C.Q. and Lavou&eacute;, D.</td>
	<td>Importance of deposition processes in simulating the seasonality of the Arctic black carbon aerosol <p class="infolinks">[<a href="javascript:toggleInfo('Huang_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Huang_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D17207&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD013478">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11517207H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Huang_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Anthropogenic aerosol components in the Arctic troposphere, such as black carbon (BC), show a strong seasonal variation characterized by a peak in later winter and early spring. The seasonality, however, is not properly simulated by most existing global aerosol models. Using the Canadian global air quality model with an online aerosol algorithm-Global Environmental Multiscale model with Air Quality processes (GEM-AQ), this work investigates the mechanisms of the seasonal variation of the Arctic BC. Through enhancements to parameterizations of wet and dry depositions in the Canadian Aerosol Module (CAM), the GEM-AQ model is able to simulate the observed seasonality of BC over the Arctic. The observed seasonality of Arctic BC is mainly attributed to the seasonal changes in aerosol wet scavenging. Seasonal injection of aerosols (e.g., BC from the European and the former USSR sectors and to a less extent from the North Atlantic sector) also contributes to the seasonality of Arctic aerosols in the lower troposphere. Although dry deposition has little effect on the seasonal pattern of BC in the Arctic lower troposphere, it significantly changes BC surface concentration in the Arctic. The enhanced model suggests an annual budget of BC deposition to the Arctic of 0.11 Tg, a 10&#37; increase over the original estimation. The enhanced GEM-AQ model also suggests that the below-cloud scavenging dominates the contribution of BC removal over the Arctic with an estimation of 48&#37; for 2001, whereas the contributions of in-cloud scavenging and dry deposition contribute about 27&#37; and 25 respectively. The estimated global BC burden is 0.28 Tg, which implies a global average BC lifetime of 9.2 days, whereas the AeroCom project suggests a range of 4.9-11.4 days.</td>
</tr>
<tr id="bib_Huang_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Huang_etal_JoGRA_2010a,
  author = {Huang, L. and Gong, S. L. and Jia, C. Q. and Lavou&eacute;, D.},
  title = {Importance of deposition processes in simulating the seasonality of the Arctic black carbon aerosol},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D17207},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11517207H},
  doi = {https://doi.org/10.1029/2009JD013478}
}
</pre></td>
</tr>
<tr id="Jacob_etal_JoGRA_1997a" class="entry">
	<td>Jacob, D.J., Prather, M.J., Rasch, P.J., Shia, R.-L., Balkanski, Y.J., Beagley, S.R., Bergmann, D.J., Blackshear, W.T., Brown, M., Chiba, M., Chipperfield, M.P., de Grandpr&eacute;, J., Dignon, J.E., Feichter, J., Genthon, C., Grose, W.L., Kasibhatla, P.S., K&ouml;hler, I., Kritz, M.A., Law, K., Penner, J.E., Ramonet, M., Reeves, C.E., Rotman, D.A., Stockwell, D.Z., Van Velthoven, P.F.J., Verver, G., Wild, O., Yang, H. and Zimmermann, P.</td>
	<td>Evaluation and intercomparison of global atmospheric transport models using ^222Rn and other short-lived tracers <p class="infolinks">[<a href="javascript:toggleInfo('Jacob_etal_JoGRA_1997a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Jacob_etal_JoGRA_1997a','bibtex')">BibTeX</a>]</p></td>
	<td>1997</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 102, pp. 5953-5970&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/96JD02955">DOI</a> <a href="http://adsabs.harvard.edu/abs/1997JGR...102.5953J">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Jacob_etal_JoGRA_1997a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Simulations of ^222Rn and other short-lived tracers are used
<br>to evaluate and intercompare the representations of convective and
<br>synoptic processes in 20 global atmospheric transport models. Results
<br>show that most established three-dimensional models simulate vertical
<br>mixing in the troposphere to within the constraints offered by the
<br>observed mean ^222Rn concentrations and that subgrid
<br>parameterization of convection is essential for this purpose. However,
<br>none of the models captures the observed variability of ^222Rn
<br>concentrations in the upper troposphere, and none reproduces the high
<br>^222Rn concentrations measured at 200 hPa over Hawaii. The
<br>established three-dimensional models reproduce the frequency and
<br>magnitude of high-^222Rn episodes observed at Crozet Island in
<br>the Indian Ocean, demonstrating that they can resolve the synoptic-scale
<br>transport of continental plumes with no significant numerical diffusion.
<br>Large differences between models are found in the rates of meridional
<br>transport in the upper troposphere (interhemispheric exchange, exchange
<br>between tropics and high latitudes). The four two-dimensional models
<br>which participated in the intercomparison tend to underestimate the rate
<br>of vertical transport from the lower to the upper troposphere but show
<br>concentrations of ^222Rn in the lower troposphere that are
<br>comparable to the zonal mean values in the three-dimensional models.
<br></td>
</tr>
<tr id="bib_Jacob_etal_JoGRA_1997a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Jacob_etal_JoGRA_1997a,
  author = {Jacob, D. J. and Prather, M. J. and Rasch, P. J. and Shia, R.-L. and Balkanski, Y. J. and Beagley, S. R. and Bergmann, D. J. and Blackshear, W. T. and Brown, M. and Chiba, M. and Chipperfield, M. P. and de Grandpr&eacute;, J. and Dignon, J. E. and Feichter, J. and Genthon, C. and Grose, W. L. and Kasibhatla, P. S. and K&ouml;hler, I. and Kritz, M. A. and Law, K. and Penner, J. E. and Ramonet, M. and Reeves, C. E. and Rotman, D. A. and Stockwell, D. Z. and Van Velthoven, P. F. J. and Verver, G. and Wild, O. and Yang, H. and Zimmermann, P.},
  title = {Evaluation and intercomparison of global atmospheric transport models using ^222Rn and other short-lived tracers},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1997},
  volume = {102},
  pages = {5953-5970},
  url = {http://adsabs.harvard.edu/abs/1997JGR...102.5953J},
  doi = {https://doi.org/10.1029/96JD02955}
}
</pre></td>
</tr>
<tr id="Kaufman_etal_JoGRA_2005a" class="entry">
	<td>Kaufman, Y.J., Koren, I., Remer, L.A., Tanr&eacute;, D., Ginoux, P. and Fan, S.</td>
	<td>Dust transport and deposition observed from the Terra-Moderate Resolution Imaging Spectroradiometer (MODIS) spacecraft over the Atlantic Ocean <p class="infolinks">[<a href="javascript:toggleInfo('Kaufman_etal_JoGRA_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kaufman_etal_JoGRA_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 110(#D9#), pp. D10S12&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2003JD004436">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JGRD..11010S12K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kaufman_etal_JoGRA_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Meteorological observations, in situ data, and satellite images of dust episodes were used already in the 1970s to estimate that 100 Tg of dust are transported from Africa over the Atlantic Ocean every year between June and August and are deposited in the Atlantic Ocean and the Americas. Desert dust is a main source of nutrients to oceanic biota and the Amazon forest, but it deteriorates air quality, as shown for Florida. Dust affects the Earth radiation budget, thus participating in climate change and feedback mechanisms. There is an urgent need for new tools for quantitative evaluation of the dust distribution, transport, and deposition. The Terra spacecraft, launched at the dawn of the last millennium, provides the first systematic well-calibrated multispectral measurements from the Moderate Resolution Imaging Spectroradiometer (MODIS) instrument for daily global analysis of aerosol. MODIS data are used here to distinguish dust from smoke and maritime aerosols and to evaluate the African dust column concentration, transport, and deposition. We found that 240 plusmn 80 Tg of dust are transported annually from Africa to the Atlantic Ocean, 140 plusmn 40 Tg are deposited in the Atlantic Ocean, 50 Tg fertilize the Amazon Basin (four times as previous estimates, thus explaining a paradox regarding the source of nutrition to the Amazon forest), 50 Tg reach the Caribbean, and 20 Tg return to Africa and Europe. The results are compared favorably with dust transport models for maximum particle diameter between 6 and 12 &mu;m. This study is a first example of quantitative use of MODIS aerosol for a geophysical research.</td>
</tr>
<tr id="bib_Kaufman_etal_JoGRA_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kaufman_etal_JoGRA_2005a,
  author = {Kaufman, Y. J. and Koren, I. and Remer, L. A. and Tanr&eacute;, D. and Ginoux, P. and Fan, S.},
  title = {Dust transport and deposition observed from the Terra-Moderate Resolution Imaging Spectroradiometer (MODIS) spacecraft over the Atlantic Ocean},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2005},
  volume = {110},
  number = {#D9#},
  pages = {D10S12},
  url = {http://adsabs.harvard.edu/abs/2005JGRD..11010S12K},
  doi = {https://doi.org/10.1029/2003JD004436}
}
</pre></td>
</tr>
<tr id="Kim_etal_JoGRA_2013a" class="entry">
	<td>Kim, D., Chin, M., Bian, H., Tan, Q., Brown, M.E., Zheng, T., You, R., Diehl, T., Ginoux, P. and Kucsera, T.</td>
	<td>The effect of the dynamic surface bareness on dust source function, emission, and distribution <p class="infolinks">[<a href="javascript:toggleInfo('Kim_etal_JoGRA_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kim_etal_JoGRA_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 118, pp. 871-886&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2012JD017907">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013JGRD..118..871K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kim_etal_JoGRA_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: In this study we report the development of a time dependency of global dust source and its impact on dust simulation in the Goddard Chemistry Aerosol Radiation and Transport (GOCART) model. We determine the surface bareness using the 8 km normalized difference vegetation index (NDVI) observed from the advanced very high resolution radiometer satellite. The results are used to analyze the temporal variations of surface bareness in 22 global dust source regions. One half of these regions can be considered permanent dust source regions where NDVI is always less than 0.15, while the other half shows substantial seasonality of NDVI. This NDVI-based surface bareness map is then used, along with the soil and topographic characteristics, to construct a dynamic dust source function for simulating dust emissions with the GOCART model. We divide the 22 dust source regions into three groups of (I) permanent desert, (II) seasonally changing bareness that regulates dust emissions, and (III) seasonally changing bareness that has little effect on dust emission. Compared with the GOCART results with the previously employed static dust source function, the simulation with the new dynamic source function shows significant improvements in category II regions. Even though the global improvement of the aerosol optical depth (AOD) is rather small when compared with satellite and ground-based remote sensing observations, we found a clear and significant effect of the new dust source on seasonal variation of dust emission and dust optical depth near the source regions. Globally, we have found that the permanent bare land contributes to 88&#37; of the total dust emission, whereas the grassland and cultivated crops land contribute to about 12%. Our results suggest the potential of using NDVI over a vegetated area to link the dust emission with land cover and land use change for air quality and climate change studies.</td>
</tr>
<tr id="bib_Kim_etal_JoGRA_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kim_etal_JoGRA_2013a,
  author = {Kim, D. and Chin, M. and Bian, H. and Tan, Q. and Brown, M. E. and Zheng, T. and You, R. and Diehl, T. and Ginoux, P. and Kucsera, T.},
  title = {The effect of the dynamic surface bareness on dust source function, emission, and distribution},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2013},
  volume = {118},
  pages = {871-886},
  url = {http://adsabs.harvard.edu/abs/2013JGRD..118..871K},
  doi = {https://doi.org/10.1029/2012JD017907}
}
</pre></td>
</tr>
<tr id="Kinne_etal_JoGRA_2003a" class="entry">
	<td>Kinne, S., Lohmann, U., Feichter, J., Schulz, M., Timmreck, C., Ghan, S., Easter, R., Chin, M., Ginoux, P., Takemura, T., Tegen, I., Koch, D., Herzog, M., Penner, J., Pitari, G., Holben, B., Eck, T., Smirnov, A., Dubovik, O., Slutsker, I., Tanre, D., Torres, O., Mishchenko, M., Geogdzhayev, I., Chu, D.A. and Kaufman, Y.</td>
	<td>Monthly averages of aerosol properties: A global comparison among models, satellite data, and AERONET ground data <p class="infolinks">[<a href="javascript:toggleInfo('Kinne_etal_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kinne_etal_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4634&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2001JD001253">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4634K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kinne_etal_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: New aerosol modules of global (circulation and chemical transport) models are evaluated. These new modules distinguish among at least five aerosol components: sulfate, organic carbon, black carbon, sea salt, and dust. Monthly and regionally averaged predictions for aerosol mass and aerosol optical depth are compared. Differences among models are significant for all aerosol types. The largest differences were found near expected source regions of biomass burning (carbon) and dust. Assumptions for the permitted water uptake also contribute to optical depth differences (of sulfate, organic carbon, and sea salt) at higher latitudes. The decline of mass or optical depth away from recognized sources reveals strong differences in aerosol transport or removal among models. These differences are also a function of altitude, as transport biases of dust do not always extend to other aerosol types. Ratios of optical depth and mass demonstrate large differences in the mass extinction efficiency, even for hydrophobic aerosol. This suggests that efforts of good mass simulations could be wasted or that conversions are misused to cover for poor mass simulations. In an attempt to provide an absolute measure for model skill, simulated total optical depths (when adding contributions from all five aerosol types) are compared to measurements from ground and space. Comparisons to the Aerosol Robotic Network (AERONET) suggest a source strength underestimate in many models, most frequently for (subtropical) tropical biomass or dust. Comparisons to the combined best of Moderate-Resolution Imaging Spectroradiometer (MODIS) and Total Ozone Mapping Spectrometer (TOMS) indicate that away from sources, model simulations are usually smaller. Particularly large are discrepancies over tropical oceans and oceans of the Southern Hemisphere, raising issues on the treatment of sea salt in models. Totals for mass or optical depth in many models are defined by the absence or dominance of only one aerosol component. With appropriate corrections to that component (e.g., to removal, to source strength, or to seasonality) a much better model performance can be expected. Still, many important modeling issues remain inconclusive as the combined result of poor coordination (different emissions and meteorology), insufficient model output (vertical distributions, water uptake by aerosol type), and unresolved measurement issues (retrieval assumptions and temporal or spatial sampling biases).</td>
</tr>
<tr id="bib_Kinne_etal_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kinne_etal_JoGRA_2003a,
  author = {Kinne, S. and Lohmann, U. and Feichter, J. and Schulz, M. and Timmreck, C. and Ghan, S. and Easter, R. and Chin, M. and Ginoux, P. and Takemura, T. and Tegen, I. and Koch, D. and Herzog, M. and Penner, J. and Pitari, G. and Holben, B. and Eck, T. and Smirnov, A. and Dubovik, O. and Slutsker, I. and Tanre, D. and Torres, O. and Mishchenko, M. and Geogdzhayev, I. and Chu, D. A. and Kaufman, Y.},
  title = {Monthly averages of aerosol properties: A global comparison among models, satellite data, and AERONET ground data},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4634},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4634K},
  doi = {https://doi.org/10.1029/2001JD001253}
}
</pre></td>
</tr>
<tr id="Koffi_etal_JoGRA_2012a" class="entry">
	<td>Koffi, B., Schulz, M., Br&eacute;On, F.-M., Griesfeller, J., Winker, D., Balkanski, Y., Bauer, S., Berntsen, T., Chin, M., Collins, W.D., Dentener, F., Diehl, T., Easter, R., Ghan, S., Ginoux, P., Gong, S., Horowitz, L.W., Iversen, T., Kirkev&acirc;G, A., Koch, D., Krol, M., Myhre, G., Stier, P. and Takemura, T.</td>
	<td>Application of the CALIOP layer product to evaluate the vertical distribution of aerosols estimated by global models: AeroCom phase I results <p class="infolinks">[<a href="javascript:toggleInfo('Koffi_etal_JoGRA_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Koffi_etal_JoGRA_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 117(#D16#), pp. D10201&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2011JD016858">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012JGRD..11710201K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Koffi_etal_JoGRA_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The CALIOP (Cloud-Aerosol Lidar with Orthogonal Polarization) layer product is used for a multimodel evaluation of the vertical distribution of aerosols. Annual and seasonal aerosol extinction profiles are analyzed over 13 sub-continental regions representative of industrial, dust, and biomass burning pollution, from CALIOP 2007-2009 observations and from AeroCom (Aerosol Comparisons between Observations and Models) 2000 simulations. An extinction mean height diagnostic (Z_α) is defined to quantitatively assess the models' performance. It is calculated over the 0-6 km and 0-10 km altitude ranges by weighting the altitude of each 100 m altitude layer by its aerosol extinction coefficient. The mean extinction profiles derived from CALIOP layer products provide consistent regional and seasonal specificities and a low inter-annual variability. While the outputs from most models are significantly correlated with the observed Z_α climatologies, some do better than others, and 2 of the 12 models perform particularly well in all seasons. Over industrial and maritime regions, most models show higher Z_α than observed by CALIOP, whereas over the African and Chinese dust source regions, Z_α is underestimated during Northern Hemisphere Spring and Summer. The positive model bias in Z_α is mainly due to an overestimate of the extinction above 6 km. Potential CALIOP and model limitations, and methodological factors that might contribute to the differences are discussed.</td>
</tr>
<tr id="bib_Koffi_etal_JoGRA_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Koffi_etal_JoGRA_2012a,
  author = {Koffi, B. and Schulz, M. and Br&eacute;On, F.-M. and Griesfeller, J. and Winker, D. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Chin, M. and Collins, W. D. and Dentener, F. and Diehl, T. and Easter, R. and Ghan, S. and Ginoux, P. and Gong, S. and Horowitz, L. W. and Iversen, T. and Kirkev&acirc;G, A. and Koch, D. and Krol, M. and Myhre, G. and Stier, P. and Takemura, T.},
  title = {Application of the CALIOP layer product to evaluate the vertical distribution of aerosols estimated by global models: AeroCom phase I results},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2012},
  volume = {117},
  number = {#D16#},
  pages = {D10201},
  url = {http://adsabs.harvard.edu/abs/2012JGRD..11710201K},
  doi = {https://doi.org/10.1029/2011JD016858}
}
</pre></td>
</tr>
<tr id="Koffi_etal_JoGRA_2016a" class="entry">
	<td>Koffi, B., Schulz, M., Br&eacute;on, F.-M., Dentener, F., Steensen, B.M., Griesfeller, J., Winker, D., Balkanski, Y., Bauer, S.E., Bellouin, N., Berntsen, T., Bian, H., Chin, M., Diehl, T., Easter, R., Ghan, S., Hauglustaine, D.A., Iversen, T., Kirkev&acirc;g, A., Liu, X., Lohmann, U., Myhre, G., Rasch, P., Seland, &Aring;., Skeie, R.B., Steenrod, S.D., Stier, P., Tackett, J., Takemura, T., Tsigaridis, K., Vuolo, M.R., Yoon, J. and Zhang, K.</td>
	<td>Evaluation of the aerosol vertical distribution in global aerosol models through comparison against CALIOP measurements: AeroCom phase II results <p class="infolinks">[<a href="javascript:toggleInfo('Koffi_etal_JoGRA_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Koffi_etal_JoGRA_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 121, pp. 7254-7283&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015JD024639">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016JGRD..121.7254K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Koffi_etal_JoGRA_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The ability of 11 models in simulating the aerosol vertical distribution from regional to global scales, as part of the second phase of the AeroCom model intercomparison initiative (AeroCom II), is assessed and compared to results of the first phase. The evaluation is performed using a global monthly gridded data set of aerosol extinction profiles built for this purpose from the CALIOP (Cloud-Aerosol Lidar with Orthogonal Polarization) Layer Product 3.01. Results over 12 subcontinental regions show that five models improved, whereas three degraded in reproducing the interregional variability in Z_α0-6 km, the mean extinction height diagnostic, as computed from the CALIOP aerosol profiles over the 0-6 km altitude range for each studied region and season. While the models' performance remains highly variable, the simulation of the timing of the Z_α0-6 km peak season has also improved for all but two models from AeroCom Phase I to Phase II. The biases in Z_α0-6 km are smaller in all regions except Central Atlantic, East Asia, and North and South Africa. Most of the models now underestimate Z_α0-6 km over land, notably in the dust and biomass burning regions in Asia and Africa. At global scale, the AeroCom II models better reproduce the Z_α0-6 km latitudinal variability over ocean than over land. Hypotheses for the performance and evolution of the individual models and for the intermodel diversity are discussed. We also provide an analysis of the CALIOP limitations and uncertainties contributing to the differences between the simulations and observations.</td>
</tr>
<tr id="bib_Koffi_etal_JoGRA_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Koffi_etal_JoGRA_2016a,
  author = {Koffi, B. and Schulz, M. and Br&eacute;on, F.-M. and Dentener, F. and Steensen, B. M. and Griesfeller, J. and Winker, D. and Balkanski, Y. and Bauer, S. E. and Bellouin, N. and Berntsen, T. and Bian, H. and Chin, M. and Diehl, T. and Easter, R. and Ghan, S. and Hauglustaine, D. A. and Iversen, T. and Kirkev&acirc;g, A. and Liu, X. and Lohmann, U. and Myhre, G. and Rasch, P. and Seland, &Aring;. and Skeie, R. B. and Steenrod, S. D. and Stier, P. and Tackett, J. and Takemura, T. and Tsigaridis, K. and Vuolo, M. R. and Yoon, J. and Zhang, K.},
  title = {Evaluation of the aerosol vertical distribution in global aerosol models through comparison against CALIOP measurements: AeroCom phase II results},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2016},
  volume = {121},
  pages = {7254-7283},
  url = {http://adsabs.harvard.edu/abs/2016JGRD..121.7254K},
  doi = {https://doi.org/10.1002/2015JD024639}
}
</pre></td>
</tr>
<tr id="Laurent_etal_JoGRA_2008a" class="entry">
	<td>Laurent, B., Marticorena, B., Bergametti, G., L&eacute;On, J.F. and Mahowald, N.M.</td>
	<td>Modeling mineral dust emissions from the Sahara desert using new surface properties and soil database <p class="infolinks">[<a href="javascript:toggleInfo('Laurent_etal_JoGRA_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Laurent_etal_JoGRA_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 113(#D12#), pp. D14218&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2007JD009484">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008JGRD..11314218L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Laurent_etal_JoGRA_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The present study investigates the mineral dust emissions and the
<br>occurrence of dust emission events over the Sahara desert from 1996 to
<br>2001. Mineral dust emissions are simulated over a region extending from
<br>16degN to 38degN and from 19degW to 40degE with a ?deg &times;
<br>?deg spatial resolution. The input parameters required by the dust
<br>emission model are surface features data (aerodynamic roughness length,
<br>dry soil size distribution and texture for erodible soils), and
<br>meteorological surface data (mainly surface wind velocity and soil
<br>moisture). A map of the aerodynamic roughness lengths is established
<br>based on a composition of protrusion coefficients derived from the
<br>POLDER-1 surface products. Soil dry size distribution and texture are
<br>derived from measurements performed on soil samples from desert areas,
<br>and from a soil map derived from a geomorphologic analysis of desert
<br>landscapes. Surface re-analyzed meteorological databases (ERA-40) of the
<br>European Centre for Medium range Weather Forecasts (ECMWF) are used. The
<br>influence of soil moisture on simulated dust emissions is quantified.
<br>The main Saharan dust sources identified during the 6-year simulated
<br>period are in agreement with the previous studies based on in situ or
<br>satellite observations. The relevance of the simulated large dust
<br>sources and point sources (``hot spots'') is tested using aerosol indexes
<br>derived from satellite observations (TOMS Absorbing Aerosol Index and
<br>Infrared Dust Difference Index Meteosat). The Saharan dust emissions
<br>simulated from 1996 to 2001 range from 585 to 759 Tg a^-1. The
<br>simulations show marked seasonal cycles with a maximum in summer for the
<br>western Sahara and in spring for the eastern Sahara. The interannual
<br>variability of dust emissions is pronounced in the eastern part of the
<br>Sahara while the emissions from the western Sahara are more regular over
<br>the studied period. The soil moisture does not noticeably affect the
<br>Saharan dust emissions, their seasonal cycle or their interannual
<br>variability, but it can partly control and limit the dust emissions in
<br>some parts of the northern desert margin, where the precipitation rates
<br>are higher. Our simulations also tend to confirm that the Sahara is the
<br>major terrestrial source of mineral dust.
<br></td>
</tr>
<tr id="bib_Laurent_etal_JoGRA_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Laurent_etal_JoGRA_2008a,
  author = {Laurent, B. and Marticorena, B. and Bergametti, G. and L&eacute;On, J. F. and Mahowald, N. M.},
  title = {Modeling mineral dust emissions from the Sahara desert using new surface properties and soil database},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2008},
  volume = {113},
  number = {#D12#},
  pages = {D14218},
  url = {http://adsabs.harvard.edu/abs/2008JGRD..11314218L},
  doi = {https://doi.org/10.1029/2007JD009484}
}
</pre></td>
</tr>
<tr id="Li_etal_JoGRA_2008a" class="entry">
	<td>Li, F., Ginoux, P. and Ramaswamy, V.</td>
	<td>Distribution, transport, and deposition of mineral dust in the Southern Ocean and Antarctica: Contribution of major sources <p class="infolinks">[<a href="javascript:toggleInfo('Li_etal_JoGRA_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Li_etal_JoGRA_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 113(#D12#), pp. D10207&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2007JD009190">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008JGRD..11310207L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Li_etal_JoGRA_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A model-based investigation of the transport, distribution and deposition of mineral dust in the Southern Hemisphere (SH) is performed by using the GFDL Atmospheric Model (AM2). The study represents an attempt to quantify the contribution of the major sources by tagging dust based on its origin. We evaluate the contribution of each source to the emission, distribution, mass burden and deposition of dust in the Southern Ocean and Antarctica, and show that each source produces distinctive meridional transport, vertical distribution, and deposition patterns. The dust in SH originates primarily from Australia (120 Tg a^-1), Patagonia (38 Tg a^-1) and the inter-hemispheric transport from Northern Hemisphere (31 Tg a^-1). A small fraction of it (7 Tg a^-1) is transported and deposited in the Southern Ocean and Antarctica, where dust from South America, Australia, and Northern Hemisphere are essentially located in the boundary layer, mid-troposphere, and upper-troposphere, respectively. These three sources contribute to nearly all the dust burden in the Southern Ocean and Antarctica. South America and Australia are the main sources of the dust deposition, but they differ zonally, with each one dominating half of a hemisphere along 120degE-60degW: the half comprising the Atlantic and Indian oceans in the case of the South American dust and the Pacific half in the case of the Australian dust. Our study also indicates a potentially important role of Northern Hemisphere dust, as it appears to be a significant part of the dust burden but contributing little to the dust deposition in Antarctica.</td>
</tr>
<tr id="bib_Li_etal_JoGRA_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Li_etal_JoGRA_2008a,
  author = {Li, F. and Ginoux, P. and Ramaswamy, V.},
  title = {Distribution, transport, and deposition of mineral dust in the Southern Ocean and Antarctica: Contribution of major sources},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2008},
  volume = {113},
  number = {#D12#},
  pages = {D10207},
  url = {http://adsabs.harvard.edu/abs/2008JGRD..11310207L},
  doi = {https://doi.org/10.1029/2007JD009190}
}
</pre></td>
</tr>
<tr id="Li_etal_JoGRA_2010a" class="entry">
	<td>Li, F., Ginoux, P. and Ramaswamy, V.</td>
	<td>Transport of Patagonian dust to Antarctica <p class="infolinks">[<a href="javascript:toggleInfo('Li_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Li_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D18217&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD012356">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11518217L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Li_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The transport of Patagonian dust to Antarctica is investigated by using the Geophysical Fluid Dynamics Laboratory Atmospheric Model with online aerosol, in combination with trajectory analysis and satellite observations. The southern coastal region of northern Patagonia and the San Julian's Great depression are identified as major sources in Patagonia. Trajectory analysis indicates that only 1320&#37; of air masses from Patagonia reach Antarctica within 10 days, with ? and ? going to West and East Antarctica, respectively. Almost twice as many trajectories from the San Julian's Great Depression reach Antarctica compared to the more northern Patagonian source. It takes tilde7 days for Patagonian dust to be transported to East Antarctica, and 4-5 days to West Antarctica. The transport to East Antarctica is driven by the low-pressure systems moving eastward in the subpolar low-pressure zone, whereas a dust event going directly southward to West Antarctica typically happens when a high-pressure system blocks the depressions moving through the Drake Passage. Demonstrating these features, respectively, by following the journey of two typical dust plumes from Patagonia to East and West Antarctica, this study clarifies how climatic factors may affect the amount of dust reaching the Antarctic surface.</td>
</tr>
<tr id="bib_Li_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Li_etal_JoGRA_2010a,
  author = {Li, F. and Ginoux, P. and Ramaswamy, V.},
  title = {Transport of Patagonian dust to Antarctica},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D18217},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11518217L},
  doi = {https://doi.org/10.1029/2009JD012356}
}
</pre></td>
</tr>
<tr id="Li_etal_JoGRA_2010b" class="entry">
	<td>Li, F., Ramaswamy, V., Ginoux, P., Broccoli, A.J., Delworth, T. and Zeng, F.</td>
	<td>Toward understanding the dust deposition in Antarctica during the Last Glacial Maximum: Sensitivity studies on plausible causes <p class="infolinks">[<a href="javascript:toggleInfo('Li_etal_JoGRA_2010b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Li_etal_JoGRA_2010b','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D24120&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2010JD014791">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11524120L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Li_etal_JoGRA_2010b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Understanding the plausible causes for the observed high dust concentrations in Antarctic ice cores during the Last Glacial Maximum (LGM) is crucial for interpreting the Antarctic dust records in the past climates and could provide insights into dust variability in future climates. Using the Geophysical Fluid Dynamics Laboratory (GFDL) General Circulation Models, we conduct an investigation into the various factors modulating dust emission, transport, and deposition, with a view toward an improved quantification of the LGM dust enhancements in the Antarctic ice cores. The model simulations show that the expansion of source areas and changes in the Antarctic ice accumulation rates together can account for most of the observed increase of dust concentrations in the Vostok, Dome C, and Taylor Dome cores, but there is an overestimate of the LGM/present ratio in the case of the Byrd core. The source expansion due to the lowering of sea level yields a factor of 2-3 higher contribution than that due to the reduction of continental vegetation. The changes in other climate parameters (e.g., SH precipitation change) are estimated to be relatively less important within the context of this sensitivity study, while the model-simulated LGM surface winds yield a 2030&#37; reduction rather than an increase in dust deposition in Antarctica. This research yields insights toward a fundamental understanding of the causes for the significant enhancement of the dust deposition in the Antarctic ice cores during the LGM.</td>
</tr>
<tr id="bib_Li_etal_JoGRA_2010b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Li_etal_JoGRA_2010b,
  author = {Li, F. and Ramaswamy, V. and Ginoux, P. and Broccoli, A. J. and Delworth, T. and Zeng, F.},
  title = {Toward understanding the dust deposition in Antarctica during the Last Glacial Maximum: Sensitivity studies on plausible causes},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D24120},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11524120L},
  doi = {https://doi.org/10.1029/2010JD014791}
}
</pre></td>
</tr>
<tr id="LiaoSeinfeld_JoGRA_1998a" class="entry">
	<td>Liao, H. and Seinfeld, J.H.</td>
	<td>Radiative forcing by mineral dust aerosols: Sensitivity to key variables <p class="infolinks">[<a href="javascript:toggleInfo('LiaoSeinfeld_JoGRA_1998a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('LiaoSeinfeld_JoGRA_1998a','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 103, pp. 31&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1998JD200036">DOI</a> <a href="http://adsabs.harvard.edu/abs/1998JGR...10331637L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_LiaoSeinfeld_JoGRA_1998a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We examine diurnally averaged radiative forcing by mineral dust aerosols
<br>in shortwave and longwave spectral regions using a one-dimensional
<br>column radiation model. At the top of the atmosphere (TOA), net
<br>(shortwave plus longwave) dust radiative forcing can be positive
<br>(heating) or negative (cooling) depending on values of key variables. We
<br>derive an analytical expression for the critical single-scattering
<br>albedo at which forcing changes sign for an atmosphere containing both
<br>cloud and aerosol layers. At the surface, net dust forcing can be
<br>positive or negative under clear-sky conditions, whereas it is always
<br>cooling in the presence of a low-level stratus cloud. Longwave radiative
<br>forcing is essentially zero when clouds are present. We also study the
<br>sensitivity of dust diurnally averaged forcing to the imaginary part of
<br>refractive index (k), height of the dust layer, dust particle size, and
<br>dust optical depth. These variables play different roles as follows: (1)
<br>under both clear- and cloudy sky conditions, net TOA forcing is more
<br>sensitive to k than net surface forcing; (2) clear-sky longwave forcing
<br>and cloudy-sky TOA shortwave forcing are very sensitive to the altitude
<br>of the dust layer; although clear-sky shortwave forcing is not sensitive
<br>to it; (3) clear-sky shortwave forcing is much more sensitive to
<br>particle size than cloudy-sky shortwave forcing; longwave forcing is not
<br>sensitive to particle size; and (4) all forcings are sensitive to
<br>optical depth except cloudy-sky longwave forcing.
<br></td>
</tr>
<tr id="bib_LiaoSeinfeld_JoGRA_1998a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{LiaoSeinfeld_JoGRA_1998a,
  author = {Liao, H. and Seinfeld, J. H.},
  title = {Radiative forcing by mineral dust aerosols: Sensitivity to key variables},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1998},
  volume = {103},
  pages = {31},
  url = {http://adsabs.harvard.edu/abs/1998JGR...10331637L},
  doi = {https://doi.org/10.1029/1998JD200036}
}
</pre></td>
</tr>
<tr id="Liu_etal_JoGRA_2008a" class="entry">
	<td>Liu, D., Wang, Z., Liu, Z., Winker, D. and Trepte, C.</td>
	<td>A height resolved global view of dust aerosols from the first year CALIPSO lidar measurements <p class="infolinks">[<a href="javascript:toggleInfo('Liu_etal_JoGRA_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Liu_etal_JoGRA_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 113(#D12#), pp. D16214&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2007JD009776">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008JGRD..11316214L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Liu_etal_JoGRA_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Based on the first year of CALIPSO lidar measurements under cloud-free conditions, a height-resolved global distribution of dust aerosols is presented for the first time. Results indicate that spring is the most active dust season, during which tilde20&#37; and tilde12&#37; of areas between 0 and 60degN are influenced by dust at least 10&#37; and 50&#37; of the time, respectively. In summer within 3-6 km, tilde8.3&#37; of area between 0 and 60degN is impacted by dust at least 50&#37; of the time. Strong seasonal cycles of dust layer vertical extent are observed in major source regions, which are similar to the seasonal variation of the thermally driven boundary layer depth. The arid and semiarid areas in North Africa and the Arabian Peninsula are the most persistent and prolific dust sources. African dust is transported across the Atlantic all yearlong with strong seasonal variation in the transport pathways mainly in the free troposphere in summer and at the low altitudes in winter. However, the trans-Atlantic dust is transported at the low altitudes is important for all seasons, especially transported further cross the ocean. The crossing Atlantic dusty zones are shifted southward from summer to winter, which is accompanied by a similar southward shift of dust-generating areas over North Africa. The Taklimakan and Gobi deserts are two major dust sources in East Asia with long-range transport mainly occurring in spring. The large horizontal and vertical coverage of dust aerosols indicate their importance in the climate system through both direct and indirect aerosol effects.</td>
</tr>
<tr id="bib_Liu_etal_JoGRA_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Liu_etal_JoGRA_2008a,
  author = {Liu, D. and Wang, Z. and Liu, Z. and Winker, D. and Trepte, C.},
  title = {A height resolved global view of dust aerosols from the first year CALIPSO lidar measurements},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2008},
  volume = {113},
  number = {#D12#},
  pages = {D16214},
  url = {http://adsabs.harvard.edu/abs/2008JGRD..11316214L},
  doi = {https://doi.org/10.1029/2007JD009776}
}
</pre></td>
</tr>
<tr id="Magi_etal_JoGRA_2009a" class="entry">
	<td>Magi, B.I., Ginoux, P., Ming, Y. and Ramaswamy, V.</td>
	<td>Evaluation of tropical and extratropical Southern Hemisphere African aerosol properties simulated by a climate model <p class="infolinks">[<a href="javascript:toggleInfo('Magi_etal_JoGRA_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Magi_etal_JoGRA_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 114(#D13#), pp. D14204&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2008JD011128">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009JGRD..11414204M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Magi_etal_JoGRA_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We compare aerosol optical depth (AOD) and single scattering albedo (SSA) simulated by updated configurations of a version of the atmospheric model (AM2) component of the NOAA Geophysical Fluid Dynamics Laboratory general circulation model over Southern Hemisphere Africa with AOD and SSA derived from research aircraft measurements and NASA Aerosol Robotic Network (AERONET) stations and with regional AOD from the NASA Moderate Resolution Imaging Spectroradiometer satellite. The results of the comparisons suggest that AM2 AOD is biased low by 30-40&#37; in the tropics and 0-20&#37; in the extratropics, while AM2 SSA is biased high by 4-8%. The AM2 SSA bias is higher during the biomass burning season, and the monthly variations in AM2 SSA are poorly correlated with AERONET. On the basis of a comparison of aerosol mass in the models with measurements from southern Africa, and a detailed analysis of aerosol treatment in AM2, we suggest that the low bias in AOD and high bias in SSA are related to an underestimate of carbonaceous aerosol emissions in the biomass burning inventories used by AM2. Increases in organic matter and black carbon emissions by factors of 1.6 and 3.8 over southern Africa improve the biases in AOD and especially SSA. We estimate that the AM2 biases in AOD and SSA imply that the magnitude of annual top of the atmosphere radiative forcing in clear-sky conditions over southern Africa is overestimated (too negative) by tilde8&#37; while surface radiative forcing is underestimated (not negative enough) by tilde20%.</td>
</tr>
<tr id="bib_Magi_etal_JoGRA_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Magi_etal_JoGRA_2009a,
  author = {Magi, B. I. and Ginoux, P. and Ming, Y. and Ramaswamy, V.},
  title = {Evaluation of tropical and extratropical Southern Hemisphere African aerosol properties simulated by a climate model},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2009},
  volume = {114},
  number = {#D13#},
  pages = {D14204},
  url = {http://adsabs.harvard.edu/abs/2009JGRD..11414204M},
  doi = {https://doi.org/10.1029/2008JD011128}
}
</pre></td>
</tr>
<tr id="Mahowald_etal_JoGRA_1999a" class="entry">
	<td>Mahowald, N., Kohfeld, K., Hansson, M., Balkanski, Y., Harrison, S.P., Prentice, I.C., Schulz, M. and Rodhe, H.</td>
	<td>Dust sources and deposition during the last glacial maximum and current climate: A comparison of model results with paleodata from ice cores and marine sediments <p class="infolinks">[<a href="javascript:toggleInfo('Mahowald_etal_JoGRA_1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Mahowald_etal_JoGRA_1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 104, pp. 15&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/1999JD900084">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999JGR...10415895M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Mahowald_etal_JoGRA_1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral dust aerosols in the atmosphere have the potential to affect the
<br>global climate by influencing the radiative balance of the atmosphere
<br>and the supply of micronutrients to the ocean. Ice and marine sediment
<br>cores indicate that dust deposition from the atmosphere was at some
<br>locations 2-20 times greater during glacial periods, raising the
<br>possibility that mineral aerosols might have contributed to climate
<br>change on glacial-interglacial time scales. To address this question, we
<br>have used linked terrestrial biosphere, dust source, and atmospheric
<br>transport models to simulate the dust cycle in the atmosphere for
<br>current and last glacial maximum (LGM) climates. We obtain a 2.5-fold
<br>higher dust loading in the entire atmosphere and a twenty-fold higher
<br>loading in high latitudes, in LGM relative to present. Comparisons to a
<br>compilation of atmospheric dust deposition flux estimates for LGM and
<br>present in marine sediment and ice cores show that the simulated flux
<br>ratios are broadly in agreement with observations; differences suggest
<br>where further improvements in the simple dust model could be made. The
<br>simulated increase in high-latitude dustiness depends on the expansion
<br>of unvegetated areas, especially in the high latitudes and in central
<br>Asia, caused by a combination of increased aridity and low atmospheric
<br>[CO_2]. The existence of these dust source areas at the LGM is
<br>supported by pollen data and loess distribution in the northern
<br>continents. These results point to a role for vegetation feedbacks,
<br>including climate effects and physiological effects of low
<br>[CO_2], in modulating the atmospheric distribution of dust.
<br></td>
</tr>
<tr id="bib_Mahowald_etal_JoGRA_1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Mahowald_etal_JoGRA_1999a,
  author = {Mahowald, N. and Kohfeld, K. and Hansson, M. and Balkanski, Y. and Harrison, S. P. and Prentice, I. C. and Schulz, M. and Rodhe, H.},
  title = {Dust sources and deposition during the last glacial maximum and current climate: A comparison of model results with paleodata from ice cores and marine sediments},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1999},
  volume = {104},
  pages = {15},
  url = {http://adsabs.harvard.edu/abs/1999JGR...10415895M},
  doi = {https://doi.org/10.1029/1999JD900084}
}
</pre></td>
</tr>
<tr id="Martin_etal_JoGRA_2002a" class="entry">
	<td>Martin, R.V., Jacob, D.J., Logan, J.A., Bey, I., Yantosca, R.M., Staudt, A.C., Li, Q., Fiore, A.M., Duncan, B.N., Liu, H., Ginoux, P. and Thouret, V.</td>
	<td>Interpretation of TOMS observations of tropical tropospheric ozone with a global model and in situ observations <p class="infolinks">[<a href="javascript:toggleInfo('Martin_etal_JoGRA_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Martin_etal_JoGRA_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 107, pp. 4351&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2001JD001480">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002JGRD..107.4351M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Martin_etal_JoGRA_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We interpret the distribution of tropical tropospheric ozone columns (TTOCs) from the Total Ozone Mapping Spectrometer (TOMS) by using a global three-dimensional model of tropospheric chemistry (GEOS-CHEM) and additional information from in situ observations. The GEOS-CHEM TTOCs capture 44&#37; of the variance of monthly mean TOMS TTOCs from the convective cloud differential method (CCD) with no global bias. Major discrepancies are found over northern Africa and south Asia where the TOMS TTOCs do not capture the seasonal enhancements from biomass burning found in the model and in aircraft observations. A characteristic feature of these northern tropical enhancements, in contrast to southern tropical enhancements, is that they are driven by the lower troposphere where the sensitivity of TOMS is poor due to Rayleigh scattering. We develop an efficiency correction to the TOMS retrieval algorithm that accounts for the variability of ozone in the lower troposphere. This efficiency correction increases TTOCs over biomass burning regions by 3-5 Dobson units (DU) and decreases them by 2-5 DU over oceanic regions, improving the agreement between CCD TTOCs and in situ observations. Applying the correction to CCD TTOCs reduces by tilde5 DU the magnitude of the ``tropical Atlantic paradox'' [, 2000], i.e. the presence of a TTOC enhancement over the southern tropical Atlantic during the northern African biomass burning season in December-February. We reproduce the remainder of the paradox in the model and explain it by the combination of upper tropospheric ozone production from lightning NO_x, persistent subsidence over the southern tropical Atlantic as part of the Walker circulation, and cross-equatorial transport of upper tropospheric ozone from northern midlatitudes in the African ``westerly duct.'' These processes in the model can also account for the observed 13-17 DU persistent wave-1 pattern in TTOCs with a maximum over the tropical Atlantic and a minimum over the tropical Pacific during all seasons. The photochemical effects of mineral dust have only a minor role on the modeled distribution of TTOCs, including over northern Africa, due to multiple competing effects. The photochemical effects of mineral dust globally decrease annual mean OH concentrations by 9%. A global lightning NO_x source of 6 Tg N yr^-1 in the model produces a simulation that is most consistent with TOMS and in situ observations.</td>
</tr>
<tr id="bib_Martin_etal_JoGRA_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Martin_etal_JoGRA_2002a,
  author = {Martin, R. V. and Jacob, D. J. and Logan, J. A. and Bey, I. and Yantosca, R. M. and Staudt, A. C. and Li, Q. and Fiore, A. M. and Duncan, B. N. and Liu, H. and Ginoux, P. and Thouret, V.},
  title = {Interpretation of TOMS observations of tropical tropospheric ozone with a global model and in situ observations},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2002},
  volume = {107},
  pages = {4351},
  url = {http://adsabs.harvard.edu/abs/2002JGRD..107.4351M},
  doi = {https://doi.org/10.1029/2001JD001480}
}
</pre></td>
</tr>
<tr id="Martin_etal_JoGRA_2003a" class="entry">
	<td>Martin, R.V., Jacob, D.J., Yantosca, R.M., Chin, M. and Ginoux, P.</td>
	<td>Global and regional decreases in tropospheric oxidants from photochemical effects of aerosols <p class="infolinks">[<a href="javascript:toggleInfo('Martin_etal_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Martin_etal_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4097&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002JD002622">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4097M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Martin_etal_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We evaluate the sensitivity of tropospheric OH, O_3, and O_3 precursors to photochemical effects of aerosols not usually included in global models: (1) aerosol scattering and absorption of ultraviolet radiation and (2) reactive uptake of HO_2, NO_2, and NO_3. Our approach is to couple a global 3-D model of tropospheric chemistry (GEOS-CHEM) with aerosol fields from a global 3-D aerosol model (GOCART). Reactive uptake by aerosols is computed using reaction probabilities from a recent review (&gamma;_HO2 = 0.2, &gamma;_NO2 = 10^-4, &gamma;_NO3 = 10^-3). Aerosols decrease the O_3 rarr O(^1D) photolysis frequency by 5-20&#37; at the surface throughout the Northern Hemisphere (largely due to mineral dust) and by a factor of 2 in biomass burning regions (largely due to black carbon). Aerosol uptake of HO_2 accounts for 10-40&#37; of total HO_x radical (&equiv; OH + peroxy) loss in the boundary layer over polluted continental regions (largely due to sulfate and organic carbon) and for more than 70&#37; over tropical biomass burning regions (largely due to organic carbon). Uptake of NO_2 and NO_3 accounts for 10-20&#37; of total HNO_3 production over biomass burning regions and less elsewhere. Annual mean OH concentrations decrease by 9&#37; globally and by 5-35&#37; in the boundary layer over the Northern Hemisphere. Simulated CO increases by 5-15 ppbv in the remote Northern Hemisphere, improving agreement with observations. Simulated boundary layer O_3 decreases by 15-45 ppbv over India during the biomass burning season in March and by 5-9 ppbv over northern Europe in August, again improving comparison with observations. We find that particulate matter controls would increase surface O_3 over Europe and other industrial regions.</td>
</tr>
<tr id="bib_Martin_etal_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Martin_etal_JoGRA_2003a,
  author = {Martin, R. V. and Jacob, D. J. and Yantosca, R. M. and Chin, M. and Ginoux, P.},
  title = {Global and regional decreases in tropospheric oxidants from photochemical effects of aerosols},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4097},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4097M},
  doi = {https://doi.org/10.1029/2002JD002622}
}
</pre></td>
</tr>
<tr id="Miller_etal_JoGRA_2006a" class="entry">
	<td>Miller, R.L., Cakmur, R.V., Perlwitz, J., Geogdzhayev, I.V., Ginoux, P., Koch, D., Kohfeld, K.E., Prigent, C., Ruedy, R., Schmidt, G.A. and Tegen, I.</td>
	<td>Mineral dust aerosols in the NASA Goddard Institute for Space Sciences ModelE atmospheric general circulation model <p class="infolinks">[<a href="javascript:toggleInfo('Miller_etal_JoGRA_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Miller_etal_JoGRA_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 111, pp. D06208&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD005796">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006JGRD..111.6208M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Miller_etal_JoGRA_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We describe an updated model of the dust aerosol cycle embedded within the NASA Goddard Institute for Space Studies `ModelE' atmospheric general circulation model (AGCM). The model dust distribution is compared to observations ranging from aerosol optical thickness and surface concentration to deposition and size distribution. The agreement with observations is improved compared to previous distributions computed by either an older version of the GISS AGCM or an offline tracer transport model. The largest improvement is in dust transport over the Atlantic due to increased emission over the Sahara. This increase comes from subgrid wind fluctuations associated with dry convective eddies driven by intense summertime heating. Representation of `preferred sources' of soil dust particles is also fundamental to the improvement. The observations suggest that deposition is too efficient in the model, partly due to AGCM rainfall errors.</td>
</tr>
<tr id="bib_Miller_etal_JoGRA_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Miller_etal_JoGRA_2006a,
  author = {Miller, R. L. and Cakmur, R. V. and Perlwitz, J. and Geogdzhayev, I. V. and Ginoux, P. and Koch, D. and Kohfeld, K. E. and Prigent, C. and Ruedy, R. and Schmidt, G. A. and Tegen, I.},
  title = {Mineral dust aerosols in the NASA Goddard Institute for Space Sciences ModelE atmospheric general circulation model},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2006},
  volume = {111},
  pages = {D06208},
  url = {http://adsabs.harvard.edu/abs/2006JGRD..111.6208M},
  doi = {https://doi.org/10.1029/2005JD005796}
}
</pre></td>
</tr>
<tr id="Miller_etal_JoGRA_2011a" class="entry">
	<td>Miller, D.J., Sun, K., Zondlo, M.A., Kanter, D., Dubovik, O., Welton, E.J., Winker, D.M. and Ginoux, P.</td>
	<td>Assessing boreal forest fire smoke aerosol impacts on U.S. air quality: A case study using multiple data sets <p class="infolinks">[<a href="javascript:toggleInfo('Miller_etal_JoGRA_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Miller_etal_JoGRA_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 116(#D15#), pp. D22209&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2011JD016170">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011JGRD..11622209M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Miller_etal_JoGRA_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We synthesize multiple ground-based and satellite measurements to track the physical and chemical evolution of biomass burning smoke plumes transported from western Canada to the northeastern U.S. This multiple data set case study is an advantageous methodology compared with using individual or small groups of data sets, each with their own limitations. The case study analyzed is a Canadian boreal forest fire event on July 4, 2006 with carbonaceous aerosol smoke emission magnitudes comparable to those during the summer fire seasons of the previous decade. We track long-range transport of these aerosol plumes with data from space-borne remote sensing satellite instruments (MODIS, OMI, MISR, CALIOP lidar, AIRS) and ground-based in situ and remote aerosol observations (AERONET CIMEL sky/Sun photometer, MPLNET lidar, IMPROVE, EPA AirNow). Convective lofting elevated smoke emissions above the boundary layer into the free troposphere, where high speed winds aloft led to rapid, long-range transport. Aerosol layer subsidence occurred during transport due to a region of surface high pressure. Smoke aerosols reaching the boundary layer led to surface fine particulate matter (PM_2.5) enhancements accompanied by changes in aerosol composition as the plume mixed with anthropogenic aerosols over the northeastern U.S. The extensive coverage of this smoke plume over the northeastern U.S. affected regional air quality, with increases of 10-20 &mu;g m^-3 PM_2.5 attributable to biomass burning smoke aerosols and EPA 24-hour PM_2.5 standard exceedances along the U.S. East Coast. Although each data set individually provides a limited view of the transport of smoke emissions, we demonstrate that a multi-data set approach results in a more comprehensive view of potential impacts due to long-range transport of smoke from a less extreme fire event. Our case study demonstrates that fires emit smoke aerosols that under certain meteorological conditions can degrade regional air quality 3000 km from the source region, with additional implications for aerosol radiative forcing and regional haze over the northeastern U.S.</td>
</tr>
<tr id="bib_Miller_etal_JoGRA_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Miller_etal_JoGRA_2011a,
  author = {Miller, D. J. and Sun, K. and Zondlo, M. A. and Kanter, D. and Dubovik, O. and Welton, E. J. and Winker, D. M. and Ginoux, P.},
  title = {Assessing boreal forest fire smoke aerosol impacts on U.S. air quality: A case study using multiple data sets},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2011},
  volume = {116},
  number = {#D15#},
  pages = {D22209},
  url = {http://adsabs.harvard.edu/abs/2011JGRD..11622209M},
  doi = {https://doi.org/10.1029/2011JD016170}
}
</pre></td>
</tr>
<tr id="Ming_etal_JoGRA_2005a" class="entry">
	<td>Ming, Y., Ramaswamy, V., Ginoux, P.A. and Horowitz, L.H.</td>
	<td>Direct radiative forcing of anthropogenic organic aerosol <p class="infolinks">[<a href="javascript:toggleInfo('Ming_etal_JoGRA_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ming_etal_JoGRA_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 110(#D9#), pp. D20208&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004JD005573">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JGRD..11020208M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ming_etal_JoGRA_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This study simulates the direct radiative forcing of organic aerosol using the GFDL AM2 GCM. The aerosol climatology is provided by the MOZART chemical transport model (CTM). The approach to calculating aerosol optical properties explicitly considers relative humidity-dependent hygroscopic growth by employing a functional group-based thermodynamic model, and makes use of the size distribution derived from AERONET measurements. The preindustrial (PI) and present-day (PD) global burdens of organic carbon are 0.17 and 1.36 Tg OC, respectively. The annual global mean total-sky and clear-sky top-of-the atmosphere (TOA) forcings (PI to PD) are estimated as -0.34 and -0.71 W m^-2, respectively. Geographically the radiative cooling largely lies over the source regions, namely part of South America, Central Africa, Europe and South and East Asia. The annual global mean total-sky and clear-sky surface forcings are -0.63 and -0.98 W m^-2, respectively. A series of sensitivity analyses shows that the treatments of hygroscopic growth and optical properties of organic aerosol are intertwined in the determination of the global organic aerosol forcing. For example, complete deprivation of water uptake by hydrophilic organic particles reduces the standard (total-sky) and clear-sky TOA forcing estimates by 18&#37; and 20 respectively, while the uptake by a highly soluble organic compound (malonic acid) enhances them by 18&#37; and 32 respectively. Treating particles as non-absorbing enhances aerosol reflection and increases the total-sky and clear-sky TOA forcing by 47&#37; and 18 respectively, while neglecting the scattering brought about by the water associated with particles reduces them by 24&#37; and 7 respectively.</td>
</tr>
<tr id="bib_Ming_etal_JoGRA_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ming_etal_JoGRA_2005a,
  author = {Ming, Y. and Ramaswamy, V. and Ginoux, P. A. and Horowitz, L. H.},
  title = {Direct radiative forcing of anthropogenic organic aerosol},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2005},
  volume = {110},
  number = {#D9#},
  pages = {D20208},
  url = {http://adsabs.harvard.edu/abs/2005JGRD..11020208M},
  doi = {https://doi.org/10.1029/2004JD005573}
}
</pre></td>
</tr>
<tr id="Ming_etal_JoGRA_2005b" class="entry">
	<td>Ming, Y., Ramaswamy, V., Ginoux, P.A., Horowitz, L.W. and Russell, L.M.</td>
	<td>Geophysical Fluid Dynamics Laboratory general circulation model investigation of the indirect radiative effects of anthropogenic sulfate aerosol <p class="infolinks">[<a href="javascript:toggleInfo('Ming_etal_JoGRA_2005b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ming_etal_JoGRA_2005b','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 110(#D9#), pp. D22206&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005JD006161">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JGRD..11022206M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ming_etal_JoGRA_2005b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Geophysical Fluid Dynamics Laboratory (GFDL) atmosphere general circulation model, with its new cloud scheme, is employed to study the indirect radiative effect of anthropogenic sulfate aerosol during the industrial period. The preindustrial and present-day monthly mean aerosol climatologies are generated from running the Model for Ozone And Related chemical Tracers (MOZART) chemistry-transport model. The respective global annual mean sulfate burdens are 0.22 and 0.81 Tg S. Cloud droplet number concentrations are related to sulfate mass concentrations using an empirical relationship (Boucher and Lohmann, 1995). A distinction is made between ``forcing'' and flux change at the top of the atmosphere in this study. The simulations, performed with prescribed sea surface temperature, show that the first indirect ``forcing'' (``Twomey'' effect) amounts to an annual mean of -1.5 W m^-2, concentrated largely over the oceans in the Northern Hemisphere (NH). The annual mean flux change owing to the response of the model to the first indirect effect is -1.4 W m^-2, similar to the annual mean forcing. However, the model's response causes a rearrangement of cloud distribution as well as changes in longwave flux (smaller than solar flux changes). There is thus a differing geographical nature of the radiation field than for the forcing even though the global means are similar. The second indirect effect, which is necessarily an estimate made in terms of the model's response, amounts to -0.9 W m^-2, but the statistical significance of the simulated geographical distribution of this effect is relatively low owing to the model's natural variability. Both the first and second effects are approximately linearly additive, giving rise to a combined annual mean flux change of -2.3 W m^-2, with the NH responsible for 77&#37; of the total flux change. Statistically significant model responses are obtained for the zonal mean total indirect effect in the entire NH and in the Southern Hemisphere low latitudes and midlatitudes (north of 45degS). The area of significance extends more than for the first and second effects considered separately. A comparison with a number of previous studies based on the same sulfate-droplet relationship shows that, after distinguishing between forcing and flux change, the global mean change in watts per square meter for the total effect computed in this study is comparable to existing studies in spite of the differences in cloud schemes.</td>
</tr>
<tr id="bib_Ming_etal_JoGRA_2005b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ming_etal_JoGRA_2005b,
  author = {Ming, Y. and Ramaswamy, V. and Ginoux, P. A. and Horowitz, L. W. and Russell, L. M.},
  title = {Geophysical Fluid Dynamics Laboratory general circulation model investigation of the indirect radiative effects of anthropogenic sulfate aerosol},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2005},
  volume = {110},
  number = {#D9#},
  pages = {D22206},
  url = {http://adsabs.harvard.edu/abs/2005JGRD..11022206M},
  doi = {https://doi.org/10.1029/2005JD006161}
}
</pre></td>
</tr>
<tr id="Naik_etal_JoGRA_2013a" class="entry">
	<td>Naik, V., Horowitz, L.W., Fiore, A.M., Ginoux, P., Mao, J., Aghedo, A.M. and Levy, H.</td>
	<td>Impact of preindustrial to present-day changes in short-lived pollutant emissions on atmospheric composition and climate forcing <p class="infolinks">[<a href="javascript:toggleInfo('Naik_etal_JoGRA_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Naik_etal_JoGRA_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 118, pp. 8086-8110&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/jgrd.50608">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013JGRD..118.8086N">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Naik_etal_JoGRA_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We describe and evaluate atmospheric chemistry in the newly developed Geophysical Fluid Dynamics Laboratory chemistry-climate model (GFDL AM3) and apply it to investigate the net impact of preindustrial (PI) to present (PD) changes in short-lived pollutant emissions (ozone precursors, sulfur dioxide, and carbonaceous aerosols) and methane concentration on atmospheric composition and climate forcing. The inclusion of online troposphere-stratosphere interactions, gas-aerosol chemistry, and aerosol-cloud interactions (including direct and indirect aerosol radiative effects) in AM3 enables a more complete representation of interactions among short-lived species, and thus their net climate impact, than was considered in previous climate assessments. The base AM3 simulation, driven with observed sea surface temperature (SST) and sea ice cover (SIC) over the period 1981-2007, generally reproduces the observed mean magnitude, spatial distribution, and seasonal cycle of tropospheric ozone and carbon monoxide. The global mean aerosol optical depth in our base simulation is within 5&#37; of satellite measurements over the 1982-2006 time period. We conduct a pair of simulations in which only the short-lived pollutant emissions and methane concentrations are changed from PI (1860) to PD (2000) levels (i.e., SST, SIC, greenhouse gases, and ozone-depleting substances are held at PD levels). From the PI to PD, we find that changes in short-lived pollutant emissions and methane have caused the tropospheric ozone burden to increase by 39&#37; and the global burdens of sulfate, black carbon, and organic carbon to increase by factors of 3, 2.4, and 1.4, respectively. Tropospheric hydroxyl concentration decreases by 7 showing that increases in OH sinks (methane, carbon monoxide, nonmethane volatile organic compounds, and sulfur dioxide) dominate over sources (ozone and nitrogen oxides) in the model. Combined changes in tropospheric ozone and aerosols cause a net negative top-of-the-atmosphere radiative forcing perturbation (-1.05 W m^-2) indicating that the negative forcing (direct plus indirect) from aerosol changes dominates over the positive forcing due to ozone increases, thus masking nearly half of the PI to PD positive forcing from long-lived greenhouse gases globally, consistent with other current generation chemistry-climate models.</td>
</tr>
<tr id="bib_Naik_etal_JoGRA_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Naik_etal_JoGRA_2013a,
  author = {Naik, V. and Horowitz, L. W. and Fiore, A. M. and Ginoux, P. and Mao, J. and Aghedo, A. M. and Levy, H.},
  title = {Impact of preindustrial to present-day changes in short-lived pollutant emissions on atmospheric composition and climate forcing},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2013},
  volume = {118},
  pages = {8086-8110},
  url = {http://adsabs.harvard.edu/abs/2013JGRD..118.8086N},
  doi = {https://doi.org/10.1002/jgrd.50608}
}
</pre></td>
</tr>
<tr id="Ocko_etal_JoGRA_2012a" class="entry">
	<td>Ocko, I.B., Ramaswamy, V., Ginoux, P., Ming, Y. and Horowitz, L.W.</td>
	<td>Sensitivity of scattering and absorbing aerosol direct radiative forcing to physical climate factors <p class="infolinks">[<a href="javascript:toggleInfo('Ocko_etal_JoGRA_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ocko_etal_JoGRA_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 117(#D16#), pp. D20203&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2012JD018019">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012JGRD..11720203O">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ocko_etal_JoGRA_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The direct radiative forcing of the climate system includes effects due to scattering and absorbing aerosols. This study explores how important physical climate characteristics contribute to the magnitudes of the direct radiative forcings (DRF) from anthropogenic sulfate, black carbon, and organic carbon. For this purpose, we employ the GFDL CM2.1 global climate model, which has reasonable aerosol concentrations and reconstruction of twentieth-century climate change. Sulfate and carbonaceous aerosols constitute the most important anthropogenic aerosol perturbations to the climate system and provide striking contrasts between primarily scattering (sulfate and organic carbon) and primarily absorbing (black carbon) species. The quantitative roles of cloud coverage, surface albedo, and relative humidity in governing the sign and magnitude of all-sky top-of-atmosphere (TOA) forcings are examined. Clouds reduce the global mean sulfate TOA DRF by almost 50 reduce the global mean organic carbon TOA DRF by more than 30 and increase the global mean black carbon TOA DRF by almost 80%. Sulfate forcing is increased by over 50&#37; as a result of hygroscopic growth, while high-albedo surfaces are found to have only a minor (less than 10 impact on all global mean forcings. Although the radiative forcing magnitudes are subject to uncertainties in the state of mixing of the aerosol species, it is clear that fundamental physical climate characteristics play a large role in governing aerosol direct radiative forcing magnitudes.</td>
</tr>
<tr id="bib_Ocko_etal_JoGRA_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ocko_etal_JoGRA_2012a,
  author = {Ocko, I. B. and Ramaswamy, V. and Ginoux, P. and Ming, Y. and Horowitz, L. W.},
  title = {Sensitivity of scattering and absorbing aerosol direct radiative forcing to physical climate factors},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2012},
  volume = {117},
  number = {#D16#},
  pages = {D20203},
  url = {http://adsabs.harvard.edu/abs/2012JGRD..11720203O},
  doi = {https://doi.org/10.1029/2012JD018019}
}
</pre></td>
</tr>
<tr id="Rotstayn_etal_JoGRA_2007a" class="entry">
	<td>Rotstayn, L.D., Cai, W., Dix, M.R., Farquhar, G.D., Feng, Y., Ginoux, P., Herzog, M., Ito, A., Penner, J.E., Roderick, M.L. and Wang, M.</td>
	<td>Have Australian rainfall and cloudiness increased due to the remote effects of Asian anthropogenic aerosols? <p class="infolinks">[<a href="javascript:toggleInfo('Rotstayn_etal_JoGRA_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Rotstayn_etal_JoGRA_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 112, pp. D09202&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2006JD007712">DOI</a> <a href="http://adsabs.harvard.edu/abs/2007JGRD..112.9202R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Rotstayn_etal_JoGRA_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: There is ample evidence that anthropogenic aerosols have important effects on climate in the Northern Hemisphere but little such evidence in the Southern Hemisphere. Observations of Australian rainfall and cloudiness since 1950 show increases over much of the continent. We show that including anthropogenic aerosol changes in 20th century simulations of a global climate model gives increasing rainfall and cloudiness over Australia during 1951-1996, whereas omitting this forcing gives decreasing rainfall and cloudiness. The pattern of increasing rainfall when aerosols are included is strongest over northwestern Australia, in agreement with the observed trends. The strong impact of aerosols is primarily due to the massive Asian aerosol haze, as confirmed by a sensitivity test in which only Asian anthropogenic aerosols are included. The Asian haze alters the meridional temperature and pressure gradients over the tropical Indian Ocean, thereby increasing the tendency of monsoonal winds to flow toward Australia. Anthropogenic aerosols also make the simulated pattern of surface-temperature change in the tropical Pacific more like La Ni&ntilde;a, since they induce a cooling of the surface waters in the extratropical North Pacific, which are then transported to the tropical eastern Pacific via the deep ocean. Transient climate model simulations forced only by increased greenhouse gases have generally not reproduced the observed rainfall increase over northwestern and central Australia. Our results suggest that a possible reason for this failure was the omission of forcing by Asian aerosols. Further research is essential to more accurately quantify the role of Asian aerosols in forcing Australian climate change.</td>
</tr>
<tr id="bib_Rotstayn_etal_JoGRA_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Rotstayn_etal_JoGRA_2007a,
  author = {Rotstayn, L. D. and Cai, W. and Dix, M. R. and Farquhar, G. D. and Feng, Y. and Ginoux, P. and Herzog, M. and Ito, A. and Penner, J. E. and Roderick, M. L. and Wang, M.},
  title = {Have Australian rainfall and cloudiness increased due to the remote effects of Asian anthropogenic aerosols?},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2007},
  volume = {112},
  pages = {D09202},
  url = {http://adsabs.harvard.edu/abs/2007JGRD..112.9202R},
  doi = {https://doi.org/10.1029/2006JD007712}
}
</pre></td>
</tr>
<tr id="Schulz_etal_JoGRA_1998a" class="entry">
	<td>Schulz, M., Balkanski, Y.J., Guelle, W. and Dulac, F.</td>
	<td>Role of aerosol size distribution and source location in a three-dimensional simulation of a Saharan dust episode tested against satellite-derived optical thickness <p class="infolinks">[<a href="javascript:toggleInfo('Schulz_etal_JoGRA_1998a','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 103(D9), pp. 10579-10592&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/97jd02779">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Schulz_etal_JoGRA_1998a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schulz_etal_JoGRA_1998a,
  author = {Michael Schulz and Yves J. Balkanski and Walter Guelle and Francois Dulac},
  title = {Role of aerosol size distribution and source location in a three-dimensional simulation of a Saharan dust episode tested against satellite-derived optical thickness},
  journal = {Journal of Geophysical Research (Atmospheres)},
  publisher = {American Geophysical Union (AGU)},
  year = {1998},
  volume = {103},
  number = {D9},
  pages = {10579--10592},
  doi = {https://doi.org/10.1029/97jd02779}
}
</pre></td>
</tr>
<tr id="Schulz_etal_JoGRA_1998b" class="entry">
	<td>Schulz, M., Balkanski, Y.J., Guelle, W. and Dulac, F.</td>
	<td>Role of aerosol size distribution and source location in a three-dimensional simulation of a Saharan dust episode tested against satellite-derived optical thickness <p class="infolinks">[<a href="javascript:toggleInfo('Schulz_etal_JoGRA_1998b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Schulz_etal_JoGRA_1998b','bibtex')">BibTeX</a>]</p></td>
	<td>1998</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 103, pp. 10&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/97JD02779">DOI</a> <a href="http://adsabs.harvard.edu/abs/1998JGR...10310579S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Schulz_etal_JoGRA_1998b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: An off-line global three-dimensional tracer model based on analyzed wind
<br>fields was augmented to simulate the atmospheric transport of mineral
<br>dust. The model describes the evolution of the aerosol size distribution
<br>and hence allows to compute aerosol number and mass concentrations. In
<br>this study we describe the parameterization of the sedimentation process
<br>and include a preliminary source formulation but exclude wet deposition.
<br>Validation of the model is done during a 16-day period in June-July 1988
<br>with very scarce precipitation. It is based on a comparison of every
<br>model grid box with daily satellite-derived optical thickness
<br>observations of Saharan dust plumes over the North Atlantic and the
<br>Mediterranean. The model reproduces accurately the daily position of the
<br>dust plumes over the ocean, with the exception of Atlantic regions
<br>remote from the African coast. By systematic analysis of transport and
<br>aerosol components we show that the largest uncertainty in reproducing
<br>the position of the dust clouds is the correct localization of the
<br>source regions. The model simulation is also very sensitive to the
<br>inclusion of convection and to an accurate treatment of the
<br>sedimentation process. Only the combination of source activation, rapid
<br>transport of dust to higher altitudes by convective updraft and
<br>long-range transport allows the simulation of the dust plumes position.
<br>This study shows that a mineral dust transport model is only constrained
<br>if both the source strength and the aerosol size distribution are known.
<br>The satellite observation of optical thickness over the Mediterranean
<br>and assumptions about the size distribution indicate that the dust
<br>emission flux was of the order of 17&times;10^6 t for the
<br>16-day period under investigation. The simulations suggest that a major
<br>aerosol mode initially around 2.5 &mu;m with a standard deviation of 2.0
<br>plays the dominant role in long-range transport of mineral dust.
<br></td>
</tr>
<tr id="bib_Schulz_etal_JoGRA_1998b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schulz_etal_JoGRA_1998b,
  author = {Schulz, M. and Balkanski, Y. J. and Guelle, W. and Dulac, F.},
  title = {Role of aerosol size distribution and source location in a three-dimensional simulation of a Saharan dust episode tested against satellite-derived optical thickness},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {1998},
  volume = {103},
  pages = {10},
  url = {http://adsabs.harvard.edu/abs/1998JGR...10310579S},
  doi = {https://doi.org/10.1029/97JD02779}
}
</pre></td>
</tr>
<tr id="Seifert_etal_JoGRA_2010a" class="entry">
	<td>Seifert, P., Ansmann, A., Mattis, I., Wandinger, U., Tesche, M., Engelmann, R., M&uuml;ller, D., P&eacute;Rez, C. and Haustein, K.</td>
	<td>Saharan dust and heterogeneous ice formation: Eleven years of cloud observations at a central European EARLINET site <p class="infolinks">[<a href="javascript:toggleInfo('Seifert_etal_JoGRA_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Seifert_etal_JoGRA_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 115(#D14#), pp. D20201&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2009JD013222">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010JGRD..11520201S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Seifert_etal_JoGRA_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: More than 2300 observed cloud layers were analyzed to investigate the
<br>impact of aged Saharan dust on heterogeneous ice formation. The
<br>observations were performed with a polarization/Raman lidar at the
<br>European Aerosol Research Lidar Network site of Leipzig, Germany
<br>(51.3degN, 12.4degE) from February 1997 to June 2008. The
<br>statistical analysis is based on lidar-derived information on cloud
<br>phase (liquid water, mixed phase, ice cloud) and cloud top height, cloud
<br>top temperature, and vertical profiles of dust mass concentration
<br>calculated with the Dust Regional Atmospheric Modeling system. Compared
<br>to dust-free air masses, a significantly higher amount of ice-containing
<br>clouds (2530&#37; more) was observed for cloud top temperatures from
<br>-10degC to -20degC in air masses that contained mineral dust. The
<br>midlatitude lidar study is compared with our SAMUM lidar study of
<br>tropical stratiform clouds at Cape Verde in the winter of 2008. The
<br>comparison reveals that heterogeneous ice formation is much stronger
<br>over central Europe and starts at higher temperatures than over the
<br>tropical station. Possible reasons for the large difference are
<br>discussed.
<br></td>
</tr>
<tr id="bib_Seifert_etal_JoGRA_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Seifert_etal_JoGRA_2010a,
  author = {Seifert, P. and Ansmann, A. and Mattis, I. and Wandinger, U. and Tesche, M. and Engelmann, R. and M&uuml;ller, D. and P&eacute;Rez, C. and Haustein, K.},
  title = {Saharan dust and heterogeneous ice formation: Eleven years of cloud observations at a central European EARLINET site},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2010},
  volume = {115},
  number = {#D14#},
  pages = {D20201},
  url = {http://adsabs.harvard.edu/abs/2010JGRD..11520201S},
  doi = {https://doi.org/10.1029/2009JD013222}
}
</pre></td>
</tr>
<tr id="Strong_etal_JoGRA_2018a" class="entry">
	<td>Strong, J.D.O., Vecchi, G.A. and Ginoux, P.</td>
	<td>The Climatological Effect of Saharan Dust on Global Tropical Cyclones in a Fully Coupled GCM <p class="infolinks">[<a href="javascript:toggleInfo('Strong_etal_JoGRA_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Strong_etal_JoGRA_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 123, pp. 5538-5559&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2017JD027808">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018JGRD..123.5538S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Strong_etal_JoGRA_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Climate in the tropical North Atlantic and West Africa is known to be sensitive to both the atmospheric burden and optical properties of aerosolized mineral dust. We investigate the global climatic response to an idealized perturbation in atmospheric burden of Saharan-born mineral dust, comparable to the observed changes between the 1960s and 1980s, using simulations with the high-resolution, fully coupled Geophysical Fluid Dynamics Laboratory Climate Model 2.5, Forecast-oriented Low Ocean Resolution version, across a range of realistic optical properties, with a specific focus on tropical cyclones. The direct radiative responses at the top of the atmosphere and at the surface along with regional hydrologic and thermodynamic responses are in agreement with previous studies, depending largely on the amount of aerosol absorption versus scattering. In all simulations, dust causes a decrease in tropical cyclone activity across the North Atlantic Ocean, as determined by a tropical cyclone tracking scheme, with the largest response occurring in the most absorbing and scattering optical regimes. These changes are partially corroborated by common local genesis potential indices. However, no clear-cut explanation can be developed upon inspection of their constituent variables. There are also nonnegligible anomalies in the North Pacific and Indian Oceans in these simulations. A relationship between accumulated cyclone energy and top of the atmosphere radiative flux anomalies is used to explain the North Atlantic anomalies, while analogy to known climate variations can help us understand the far-field response to the dust forcing.</td>
</tr>
<tr id="bib_Strong_etal_JoGRA_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Strong_etal_JoGRA_2018a,
  author = {Strong, J. D. O. and Vecchi, G. A. and Ginoux, P.},
  title = {The Climatological Effect of Saharan Dust on Global Tropical Cyclones in a Fully Coupled GCM},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2018},
  volume = {123},
  pages = {5538-5559},
  url = {http://adsabs.harvard.edu/abs/2018JGRD..123.5538S},
  doi = {https://doi.org/10.1029/2017JD027808}
}
</pre></td>
</tr>
<tr id="SuToon_JoGRA_2009a" class="entry">
	<td>Su, L. and Toon, O.B.</td>
	<td>Numerical simulations of Asian dust storms using a coupled climate-aerosol microphysical model <p class="infolinks">[<a href="javascript:toggleInfo('SuToon_JoGRA_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('SuToon_JoGRA_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 114(#D13#), pp. D14202&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2008JD010956">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009JGRD..11414202S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_SuToon_JoGRA_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We have developed a three-dimensional coupled microphysical/climate model based on the National Center for Atmospheric Research Community Atmospheres Model and the University of Colorado/NASA Community Aerosol and Radiation Model for Atmospheres. We have used the model to investigate the sources, removal processes, transport, and optical properties of Asian dust aerosol and its impact on downwind regions. The model simulations are conducted primarily during the time frame of the Aerosol Characterization Experiment-Asia field experiment (March-May 2001) since considerable in situ data are available at that time. Our dust source function follows Ginoux et al. (2001). We modified the dust source function by using the friction velocity instead of the 10-m wind based on wind erosion theory, by adding a size-dependent threshold friction velocity following Marticorena and Bergametti (1995) and by adding a soil moisture correction. A Weibull distribution is implemented to estimate the subgrid-scale wind speed variability. We use eight size bins for mineral dust ranging from 0.1 to 10 &mu;m radius. Generally, the model reproduced the aerosol optical depth retrieved by the ground-based Aerosol Robotic Network (AERONET) Sun photometers at six study sites ranging in location from near the Asian dust sources to the Eastern Pacific region. By constraining the dust complex refractive index from AERONET retrievals near the dust source, we also find the single-scattering albedo to be consistent with AERONET retrievals. However, large regional variations are observed due to local pollution. The timing of dust events is comparable to the National Institute for Environmental Studies (NIES) lidar data in Beijing and Nagasaki. However, the simulated dust aerosols are at higher altitudes than those observed by the NIES lidar.</td>
</tr>
<tr id="bib_SuToon_JoGRA_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{SuToon_JoGRA_2009a,
  author = {Su, L. and Toon, O. B.},
  title = {Numerical simulations of Asian dust storms using a coupled climate-aerosol microphysical model},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2009},
  volume = {114},
  number = {#D13#},
  pages = {D14202},
  url = {http://adsabs.harvard.edu/abs/2009JGRD..11414202S},
  doi = {https://doi.org/10.1029/2008JD010956}
}
</pre></td>
</tr>
<tr id="Tie_etal_JoGRA_2005a" class="entry">
	<td>Tie, X., Madronich, S., Walters, S., Edwards, D.P., Ginoux, P., Mahowald, N., Zhang, R., Lou, C. and Brasseur, G.</td>
	<td>Assessment of the global impact of aerosols on tropospheric oxidants <p class="infolinks">[<a href="javascript:toggleInfo('Tie_etal_JoGRA_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Tie_etal_JoGRA_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 110, pp. D03204&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004JD005359">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JGRD..110.3204T">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Tie_etal_JoGRA_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present here a fully coupled global aerosol and chemistry model for the troposphere. The model is used to assess the interactions between aerosols and chemical oxidants in the troposphere, including (1) the conversion from gas-phase oxidants into the condensed phase during the formation of aerosols, (2) the heterogeneous reactions occurring on the surface of aerosols, and (3) the effect of aerosols on ultraviolet radiation and photolysis rates. The present study uses the global three-dimensional chemical/transport model, Model for Ozone and Related Chemical Tracers, version 2 (MOZART-2), in which aerosols are coupled with the model. The model accounts for the presence of sulfate, soot, primary organic carbon, ammonium nitrate, secondary organic carbon, sea salt, and mineral dust particles. The simulated global distributions of the aerosols are analyzed and evaluated using satellite measurements (Moderate-Resolution Imaging Spectroradiometer (MODIS)) and surface measurements. The results suggest that in northern continental regions the tropospheric aerosol loading is highest in Europe, North America, and east Asia. Sulfate, organic carbon, black carbon, and ammonium nitrate are major contributions for the high aerosol loading in these regions. Aerosol loading is also high in the Amazon and in Africa. In these areas the aerosols consist primarily of organic carbon and black carbon. Over the southern high-latitude ocean (around 60degS), high concentrations of sea-salt aerosol are predicted. The concentration of mineral dust is highest over the Sahara and, as a result of transport, spread out into adjacent regions. The model and MODIS show similar geographical distributions of aerosol particles. However, the model overestimates the sulfate and carbonaceous aerosol in the eastern United States, Europe, and east Asia. In the region where aerosol loading is high, aerosols have important impacts on tropospheric ozone and other oxidants. The model suggests that heterogeneous reactions of HO_2 and CH_2O on sulfate have an important impact on HO_x (OH + HO_2) concentrations, while the heterogeneous reaction of O_3 on soot has a minor effect on O_3 concentrations in the lower troposphere. The heterogeneous reactions on dust have very important impacts on HO_x and O_3 in the region of dust mobilization, where the reduction of HO_x and O_3 concentrations can reach a maximum of 30&#37; and 20 respectively, over the Sahara desert. Dust, organic carbon, black carbon, and sulfate aerosols have important impacts on photolysis rates. For example, the photodissociation frequencies of ozone and nitrogen dioxide are reduced by 20&#37; at the surface in the Sahara, in the Amazon, and in eastern Asia, leading to 5-20&#37; reduction in the concentration of HO_x and to a few percent change in the O_3 abundance in these regions.</td>
</tr>
<tr id="bib_Tie_etal_JoGRA_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Tie_etal_JoGRA_2005a,
  author = {Tie, X. and Madronich, S. and Walters, S. and Edwards, D. P. and Ginoux, P. and Mahowald, N. and Zhang, R. and Lou, C. and Brasseur, G.},
  title = {Assessment of the global impact of aerosols on tropospheric oxidants},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2005},
  volume = {110},
  pages = {D03204},
  url = {http://adsabs.harvard.edu/abs/2005JGRD..110.3204T},
  doi = {https://doi.org/10.1029/2004JD005359}
}
</pre></td>
</tr>
<tr id="Weaver_etal_JoGRA_2003a" class="entry">
	<td>Weaver, C.J., Joiner, J. and Ginoux, P.</td>
	<td>Mineral aerosol contamination of TIROS Operational Vertical Sounder (TOVS) temperature and moisture retrievals <p class="infolinks">[<a href="javascript:toggleInfo('Weaver_etal_JoGRA_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Weaver_etal_JoGRA_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research (Atmospheres)<br/>Vol. 108, pp. 4246&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002JD002571">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JGRD..108.4246W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Weaver_etal_JoGRA_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Since mineral aerosols absorb significant amounts of infrared radiation, they may contribute to errors in the retrievals of atmospheric and surface parameters from the TIROS Operational Vertical Sounder (TOVS) High-Resolution Infrared Radiation Sounder (HIRS) if the atmosphere is assumed clear. TOVS is an operational sounder on NOAA polar satellites. To see if observed brightness temperatures are reduced by mineral aerosol, we analyzed results from the Data Assimilation Office (DAO) Finite Volume Data Assimilation System (fvDAS). Every 6 hours the assimilated temperature and moisture profiles are used as a first guess in the DAO interactive cloud-clearing TOVS retrieval system. The observed minus the forecast (O-F) brightness temperature, which is a measure of the accuracy of the first guess and radiative transfer parameters, becomes more negative with increasing dust concentrations. Dust concentrations are from the Goddard Ozone Chemistry Aerosol Radiation Transport (GOCART) model. Since there was no account of dust during this fvDAS run, the dependence of O-F on the estimated atmospheric dust concentrations from GOCART indicates that the dust is affecting the TOVS brightness temperatures. HIRS channels that are sensitive to the surface temperature, lower tropospheric temperature, and moisture are subject to a 0.5 K or more reduction in the brightness temperature during heavy dust loading conditions. The radiative transfer module used in the TOVS retrieval system was modified to account for dust assuming a composition of illite, and the fvDAS run was repeated. Accounting for dust absorption in the retrieval system yields warmer surface temperatures (0.4 K) and warmer lower tropospheric temperatures in regions of moderate dust loading over the tropical Atlantic.</td>
</tr>
<tr id="bib_Weaver_etal_JoGRA_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Weaver_etal_JoGRA_2003a,
  author = {Weaver, C. J. and Joiner, J. and Ginoux, P.},
  title = {Mineral aerosol contamination of TIROS Operational Vertical Sounder (TOVS) temperature and moisture retrievals},
  journal = {Journal of Geophysical Research (Atmospheres)},
  year = {2003},
  volume = {108},
  pages = {4246},
  url = {http://adsabs.harvard.edu/abs/2003JGRD..108.4246W},
  doi = {https://doi.org/10.1029/2002JD002571}
}
</pre></td>
</tr>
<tr id="Grini_JoGR_2005a" class="entry">
	<td>Grini, A.</td>
	<td>Model simulations of dust sources and transport in the global atmosphere: Effects of soil erodibility and wind speed variability <p class="infolinks">[<a href="javascript:toggleInfo('Grini_JoGR_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Geophysical Research<br/>Vol. 110(D2)&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004jd005037">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Grini_JoGR_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Grini_JoGR_2005a,
  author = {Alf Grini},
  title = {Model simulations of dust sources and transport in the global atmosphere: Effects of soil erodibility and wind speed variability},
  journal = {Journal of Geophysical Research},
  publisher = {American Geophysical Union (AGU)},
  year = {2005},
  volume = {110},
  number = {D2},
  doi = {https://doi.org/10.1029/2004jd005037}
}
</pre></td>
</tr>
<tr id="Myhre_JoGR_2003a" class="entry">
	<td>Myhre, G.</td>
	<td>Modeling the radiative impact of mineral dust during the Saharan Dust Experiment (SHADE) campaign <p class="infolinks">[<a href="javascript:toggleInfo('Myhre_JoGR_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Geophysical Research<br/>Vol. 108(D18)&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002jd002566">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Myhre_JoGR_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Myhre_JoGR_2003a,
  author = {Gunnar Myhre},
  title = {Modeling the radiative impact of mineral dust during the Saharan Dust Experiment (SHADE) campaign},
  journal = {Journal of Geophysical Research},
  publisher = {American Geophysical Union (AGU)},
  year = {2003},
  volume = {108},
  number = {D18},
  doi = {https://doi.org/10.1029/2002jd002566}
}
</pre></td>
</tr>
<tr id="TegenFung_JoGR_1994a" class="entry">
	<td>Tegen, I. and Fung, I.</td>
	<td>Modeling of mineral dust in the atmosphere: Sources, transport, and optical thickness <p class="infolinks">[<a href="javascript:toggleInfo('TegenFung_JoGR_1994a','bibtex')">BibTeX</a>]</p></td>
	<td>1994</td>
	<td>Journal of Geophysical Research<br/>Vol. 99(D11), pp. 22897&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/94jd01928">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_TegenFung_JoGR_1994a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{TegenFung_JoGR_1994a,
  author = {Ina Tegen and Inez Fung},
  title = {Modeling of mineral dust in the atmosphere: Sources, transport, and optical thickness},
  journal = {Journal of Geophysical Research},
  publisher = {American Geophysical Union (AGU)},
  year = {1994},
  volume = {99},
  number = {D11},
  pages = {22897},
  doi = {https://doi.org/10.1029/94jd01928}
}
</pre></td>
</tr>
<tr id="Delworth_etal_JoC_2006a" class="entry">
	<td>Delworth, T.L., Broccoli, A.J., Rosati, A., Stouffer, R.J., Balaji, V., Beesley, J.A., Cooke, W.F., Dixon, K.W., Dunne, J., Dunne, K.A., Durachta, J.W., Findell, K.L., Ginoux, P., Gnanadesikan, A., Gordon, C.T., Griffies, S.M., Gudgel, R., Harrison, M.J., Held, I.M., Hemler, R.S., Horowitz, L.W., Klein, S.A., Knutson, T.R., Kushner, P.J., Langenhorst, A.R., Lee, H.-C., Lin, S.-J., Lu, J., Malyshev, S.L., Milly, P.C.D., Ramaswamy, V., Russell, J., Schwarzkopf, M.D., Shevliakova, E., Sirutis, J.J., Spelman, M.J., Stern, W.F., Winton, M., Wittenberg, A.T., Wyman, B., Zeng, F. and Zhang, R.</td>
	<td>GFDL's CM2 Global Coupled Climate Models. Part I: Formulation and Simulation Characteristics <p class="infolinks">[<a href="javascript:toggleInfo('Delworth_etal_JoC_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Journal of Climate<br/>Vol. 19, pp. 643&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI3629.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006JCli...19..643D">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Delworth_etal_JoC_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Delworth_etal_JoC_2006a,
  author = {Delworth, T. L. and Broccoli, A. J. and Rosati, A. and Stouffer, R. J. and Balaji, V. and Beesley, J. A. and Cooke, W. F. and Dixon, K. W. and Dunne, J. and Dunne, K. A. and Durachta, J. W. and Findell, K. L. and Ginoux, P. and Gnanadesikan, A. and Gordon, C. T. and Griffies, S. M. and Gudgel, R. and Harrison, M. J. and Held, I. M. and Hemler, R. S. and Horowitz, L. W. and Klein, S. A. and Knutson, T. R. and Kushner, P. J. and Langenhorst, A. R. and Lee, H.-C. and Lin, S.-J. and Lu, J. and Malyshev, S. L. and Milly, P. C. D. and Ramaswamy, V. and Russell, J. and Schwarzkopf, M. D. and Shevliakova, E. and Sirutis, J. J. and Spelman, M. J. and Stern, W. F. and Winton, M. and Wittenberg, A. T. and Wyman, B. and Zeng, F. and Zhang, R.},
  title = {GFDL's CM2 Global Coupled Climate Models. Part I: Formulation and Simulation Characteristics},
  journal = {Journal of Climate},
  year = {2006},
  volume = {19},
  pages = {643},
  url = {http://adsabs.harvard.edu/abs/2006JCli...19..643D},
  doi = {https://doi.org/10.1175/JCLI3629.1}
}
</pre></td>
</tr>
<tr id="Donner_etal_JoC_2011a" class="entry">
	<td>Donner, L.J., Wyman, B.L., Hemler, R.S., Horowitz, L.W., Ming, Y., Zhao, M., Golaz, J.-C., Ginoux, P., Lin, S.-J., Schwarzkopf, M.D., Austin, J., Alaka, G., Cooke, W.F., Delworth, T.L., Freidenreich, S.M., Gordon, C.T., Griffies, S.M., Held, I.M., Hurlin, W.J., Klein, S.A., Knutson, T.R., Langenhorst, A.R., Lee, H.-C., Lin, Y., Magi, B.I., Malyshev, S.L., Milly, P.C.D., Naik, V., Nath, M.J., Pincus, R., Ploshay, J.J., Ramaswamy, V., Seman, C.J., Shevliakova, E., Sirutis, J.J., Stern, W.F., Stouffer, R.J., Wilson, R.J., Winton, M., Wittenberg, A.T. and Zeng, F.</td>
	<td>The Dynamical Core, Physical Parameterizations, and Basic Simulation Characteristics of the Atmospheric Component AM3 of the GFDL Global Coupled Model CM3 <p class="infolinks">[<a href="javascript:toggleInfo('Donner_etal_JoC_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Journal of Climate<br/>Vol. 24, pp. 3484-3519&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/2011JCLI3955.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011JCli...24.3484D">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Donner_etal_JoC_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Donner_etal_JoC_2011a,
  author = {Donner, L. J. and Wyman, B. L. and Hemler, R. S. and Horowitz, L. W. and Ming, Y. and Zhao, M. and Golaz, J.-C. and Ginoux, P. and Lin, S.-J. and Schwarzkopf, M. D. and Austin, J. and Alaka, G. and Cooke, W. F. and Delworth, T. L. and Freidenreich, S. M. and Gordon, C. T. and Griffies, S. M. and Held, I. M. and Hurlin, W. J. and Klein, S. A. and Knutson, T. R. and Langenhorst, A. R. and Lee, H.-C. and Lin, Y. and Magi, B. I. and Malyshev, S. L. and Milly, P. C. D. and Naik, V. and Nath, M. J. and Pincus, R. and Ploshay, J. J. and Ramaswamy, V. and Seman, C. J. and Shevliakova, E. and Sirutis, J. J. and Stern, W. F. and Stouffer, R. J. and Wilson, R. J. and Winton, M. and Wittenberg, A. T. and Zeng, F.},
  title = {The Dynamical Core, Physical Parameterizations, and Basic Simulation Characteristics of the Atmospheric Component AM3 of the GFDL Global Coupled Model CM3},
  journal = {Journal of Climate},
  year = {2011},
  volume = {24},
  pages = {3484-3519},
  url = {http://adsabs.harvard.edu/abs/2011JCli...24.3484D},
  doi = {https://doi.org/10.1175/2011JCLI3955.1}
}
</pre></td>
</tr>
<tr id="Dunne_etal_JoC_2012a" class="entry">
	<td>Dunne, J.P., John, J.G., Adcroft, A.J., Griffies, S.M., Hallberg, R.W., Shevliakova, E., Stouffer, R.J., Cooke, W., Dunne, K.A., Harrison, M.J., Krasting, J.P., Malyshev, S.L., Milly, P.C.D., Phillipps, P.J., Sentman, L.T., Samuels, B.L., Spelman, M.J., Winton, M., Wittenberg, A.T. and Zadeh, N.</td>
	<td>GFDL's ESM2 Global Coupled Climate-Carbon Earth System Models. Part I: Physical Formulation and Baseline Simulation Characteristics <p class="infolinks">[<a href="javascript:toggleInfo('Dunne_etal_JoC_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Journal of Climate<br/>Vol. 25, pp. 6646-6665&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-11-00560.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012JCli...25.6646D">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Dunne_etal_JoC_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dunne_etal_JoC_2012a,
  author = {Dunne, J. P. and John, J. G. and Adcroft, A. J. and Griffies, S. M. and Hallberg, R. W. and Shevliakova, E. and Stouffer, R. J. and Cooke, W. and Dunne, K. A. and Harrison, M. J. and Krasting, J. P. and Malyshev, S. L. and Milly, P. C. D. and Phillipps, P. J. and Sentman, L. T. and Samuels, B. L. and Spelman, M. J. and Winton, M. and Wittenberg, A. T. and Zadeh, N.},
  title = {GFDL's ESM2 Global Coupled Climate-Carbon Earth System Models. Part I: Physical Formulation and Baseline Simulation Characteristics},
  journal = {Journal of Climate},
  year = {2012},
  volume = {25},
  pages = {6646-6665},
  url = {http://adsabs.harvard.edu/abs/2012JCli...25.6646D},
  doi = {https://doi.org/10.1175/JCLI-D-11-00560.1}
}
</pre></td>
</tr>
<tr id="Dunne_etal_JoC_2013a" class="entry">
	<td>Dunne, J.P., John, J.G., Shevliakova, E., Stouffer, R.J., Krasting, J.P., Malyshev, S.L., Milly, P.C.D., Sentman, L.T., Adcroft, A.J., Cooke, W., Dunne, K.A., Griffies, S.M., Hallberg, R.W., Harrison, M.J., Levy, H., Wittenberg, A.T., Phillips, P.J. and Zadeh, N.</td>
	<td>GFDL's ESM2 Global Coupled Climate-Carbon Earth System Models. Part II: Carbon System Formulation and Baseline Simulation Characteristics* <p class="infolinks">[<a href="javascript:toggleInfo('Dunne_etal_JoC_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Journal of Climate<br/>Vol. 26, pp. 2247-2267&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-12-00150.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013JCli...26.2247D">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Dunne_etal_JoC_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dunne_etal_JoC_2013a,
  author = {Dunne, J. P. and John, J. G. and Shevliakova, E. and Stouffer, R. J. and Krasting, J. P. and Malyshev, S. L. and Milly, P. C. D. and Sentman, L. T. and Adcroft, A. J. and Cooke, W. and Dunne, K. A. and Griffies, S. M. and Hallberg, R. W. and Harrison, M. J. and Levy, H. and Wittenberg, A. T. and Phillips, P. J. and Zadeh, N.},
  title = {GFDL's ESM2 Global Coupled Climate-Carbon Earth System Models. Part II: Carbon System Formulation and Baseline Simulation Characteristics*},
  journal = {Journal of Climate},
  year = {2013},
  volume = {26},
  pages = {2247-2267},
  url = {http://adsabs.harvard.edu/abs/2013JCli...26.2247D},
  doi = {https://doi.org/10.1175/JCLI-D-12-00150.1}
}
</pre></td>
</tr>
<tr id="Guo_etal_JoC_2014a" class="entry">
	<td>Guo, H., Golaz, J.-C., Donner, L.J., Ginoux, P. and Hemler, R.S.</td>
	<td>Multivariate Probability Density Functions with Dynamics in the GFDL Atmospheric General Circulation Model: Global Tests <p class="infolinks">[<a href="javascript:toggleInfo('Guo_etal_JoC_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Journal of Climate<br/>Vol. 27, pp. 2087-2108&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-13-00347.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014JCli...27.2087G">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Guo_etal_JoC_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Guo_etal_JoC_2014a,
  author = {Guo, H. and Golaz, J.-C. and Donner, L. J. and Ginoux, P. and Hemler, R. S.},
  title = {Multivariate Probability Density Functions with Dynamics in the GFDL Atmospheric General Circulation Model: Global Tests},
  journal = {Journal of Climate},
  year = {2014},
  volume = {27},
  pages = {2087-2108},
  url = {http://adsabs.harvard.edu/abs/2014JCli...27.2087G},
  doi = {https://doi.org/10.1175/JCLI-D-13-00347.1}
}
</pre></td>
</tr>
<tr id="Shao_etal_JoC_2013a" class="entry">
	<td>Shao, P., Zeng, X., Sakaguchi, K., Monson, R.K. and Zeng, X.</td>
	<td>Terrestrial Carbon Cycle: Climate Relations in Eight CMIP5 Earth System Models <p class="infolinks">[<a href="javascript:toggleInfo('Shao_etal_JoC_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Journal of Climate<br/>Vol. 26, pp. 8744-8764&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-12-00831.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013JCli...26.8744S">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Shao_etal_JoC_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Shao_etal_JoC_2013a,
  author = {Shao, P. and Zeng, X. and Sakaguchi, K. and Monson, R. K. and Zeng, X.},
  title = {Terrestrial Carbon Cycle: Climate Relations in Eight CMIP5 Earth System Models},
  journal = {Journal of Climate},
  year = {2013},
  volume = {26},
  pages = {8744-8764},
  url = {http://adsabs.harvard.edu/abs/2013JCli...26.8744S},
  doi = {https://doi.org/10.1175/JCLI-D-12-00831.1}
}
</pre></td>
</tr>
<tr id="Strong_etal_JoC_2015a" class="entry">
	<td>Strong, J.D.O., Vecchi, G.A. and Ginoux, P.</td>
	<td>The Response of the Tropical Atlantic and West African Climate to Saharan Dust in a Fully Coupled GCM <p class="infolinks">[<a href="javascript:toggleInfo('Strong_etal_JoC_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Journal of Climate<br/>Vol. 28, pp. 7071-7092&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-14-00797.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015JCli...28.7071S">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Strong_etal_JoC_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Strong_etal_JoC_2015a,
  author = {Strong, J. D. O. and Vecchi, G. A. and Ginoux, P.},
  title = {The Response of the Tropical Atlantic and West African Climate to Saharan Dust in a Fully Coupled GCM},
  journal = {Journal of Climate},
  year = {2015},
  volume = {28},
  pages = {7071-7092},
  url = {http://adsabs.harvard.edu/abs/2015JCli...28.7071S},
  doi = {https://doi.org/10.1175/JCLI-D-14-00797.1}
}
</pre></td>
</tr>
<tr id="Zhao_etal_JoC_2016a" class="entry">
	<td>Zhao, M., Golaz, J.-C., Held, I.M., Ramaswamy, V., Lin, S.-J., Ming, Y., Ginoux, P., Wyman, B., Donner, L.J., Paynter, D. and Guo, H.</td>
	<td>Uncertainty in Model Climate Sensitivity Traced to Representations of Cumulus Precipitation Microphysics <p class="infolinks">[<a href="javascript:toggleInfo('Zhao_etal_JoC_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Journal of Climate<br/>Vol. 29, pp. 543-560&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JCLI-D-15-0191.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016JCli...29..543Z">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Zhao_etal_JoC_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhao_etal_JoC_2016a,
  author = {Zhao, M. and Golaz, J.-C. and Held, I. M. and Ramaswamy, V. and Lin, S.-J. and Ming, Y. and Ginoux, P. and Wyman, B. and Donner, L. J. and Paynter, D. and Guo, H.},
  title = {Uncertainty in Model Climate Sensitivity Traced to Representations of Cumulus Precipitation Microphysics},
  journal = {Journal of Climate},
  year = {2016},
  volume = {29},
  pages = {543-560},
  url = {http://adsabs.harvard.edu/abs/2016JCli...29..543Z},
  doi = {https://doi.org/10.1175/JCLI-D-15-0191.1}
}
</pre></td>
</tr>
<tr id="Chin_etal_JoAS_2002a" class="entry">
	<td>Chin, M., Ginoux, P., Kinne, S., Torres, O., Holben, B.N., Duncan, B.N., Martin, R.V., Logan, J.A., Higurashi, A. and Nakajima, T.</td>
	<td>Tropospheric Aerosol Optical Thickness from the GOCART Model and Comparisons with Satellite and Sun Photometer Measurements. <p class="infolinks">[<a href="javascript:toggleInfo('Chin_etal_JoAS_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Chin_etal_JoAS_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 59, pp. 461-483&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0461:TAOTFT%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002JAtS...59..461C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Chin_etal_JoAS_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Georgia Institute of Technology-Goddard Global Ozone Chemistry Aerosol Radiation and Transport (GOCART) model is used to simulate the aerosol optical thickness  for major types of tropospheric aerosols including sulfate, dust, organic carbon (OC), black carbon (BC), and sea salt. The GOCART model uses a dust emission algorithm that quantifies the dust source as a function of the degree of topographic depression, and a biomass burning emission source that includes seasonal and interannual variability based on satellite observations. Results presented here show that on global average, dust aerosol has the highest at 500 nm (0.051), followed by sulfate (0.040), sea salt (0.027), OC (0.017), and BC (0.007). There are large geographical and seasonal variations of , controlled mainly by emission, transport, and hygroscopic properties of aerosols. The model calculated total s at 500 nm have been compared with the satellite retrieval products from the Total Ozone Mapping Spectrometer (TOMS) over both land and ocean and from the Advanced Very High Resolution Radiometer (AVHRR) over the ocean. The model reproduces most of the prominent features in the satellite data, with an overall agreement within a factor of 2 over the aerosol source areas and outflow regions. While there are clear differences among the satellite products, a major discrepancy between the model and the satellite data is that the model shows a stronger variation of  from source to remote regions. Quantitative comparison of model and satellite data is still difficult, due to the large uncertainties involved in deriving the  values by both the model and satellite retrieval, and by the inconsistency in physical and optical parameters used between the model and the satellite retrieval. The comparison of monthly averaged model results with the sun photometer network [Aerosol Robotics Network (AERONET)] measurements shows that the model reproduces the seasonal variations at most of the sites, especially the places where biomass burning or dust aerosol dominates.</td>
</tr>
<tr id="bib_Chin_etal_JoAS_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Chin_etal_JoAS_2002a,
  author = {Chin, M. and Ginoux, P. and Kinne, S. and Torres, O. and Holben, B. N. and Duncan, B. N. and Martin, R. V. and Logan, J. A. and Higurashi, A. and Nakajima, T.},
  title = {Tropospheric Aerosol Optical Thickness from the GOCART Model and Comparisons with Satellite and Sun Photometer Measurements.},
  journal = {Journal of Atmospheric Sciences},
  year = {2002},
  volume = {59},
  pages = {461-483},
  url = {http://adsabs.harvard.edu/abs/2002JAtS...59..461C},
  doi = {https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0461:TAOTFT%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Ming_etal_JoAS_2007a" class="entry">
	<td>Ming, Y., Ramaswamy, V., Donner, L.J., Phillips, V.T.J., Klein, S.A., Ginoux, P.A. and Horowitz, L.W.</td>
	<td>Modeling the Interactions between Aerosols and Liquid Water Clouds with a Self-Consistent Cloud Scheme in a General Circulation Model <p class="infolinks">[<a href="javascript:toggleInfo('Ming_etal_JoAS_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 64, pp. 1189&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JAS3874.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2007JAtS...64.1189M">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Ming_etal_JoAS_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ming_etal_JoAS_2007a,
  author = {Ming, Y. and Ramaswamy, V. and Donner, L. J. and Phillips, V. T. J. and Klein, S. A. and Ginoux, P. A. and Horowitz, L. W.},
  title = {Modeling the Interactions between Aerosols and Liquid Water Clouds with a Self-Consistent Cloud Scheme in a General Circulation Model},
  journal = {Journal of Atmospheric Sciences},
  year = {2007},
  volume = {64},
  pages = {1189},
  url = {http://adsabs.harvard.edu/abs/2007JAtS...64.1189M},
  doi = {https://doi.org/10.1175/JAS3874.1}
}
</pre></td>
</tr>
<tr id="Penner_etal_JoAS_2002a" class="entry">
	<td>Penner, J.E., Zhang, S.Y., Chin, M., Chuang, C.C., Feichter, J., Feng, Y., Geogdzhayev, I.V., Ginoux, P., Herzog, M., Higurashi, A., Koch, D., Land, C., Lohmann, U., Mishchenko, M., Nakajima, T., Pitari, G., Soden, B., Tegen, I. and LawrencenbspStowe</td>
	<td>A Comparison of Model- and Satellite-Derived Aerosol Optical Depth and Reflectivity. <p class="infolinks">[<a href="javascript:toggleInfo('Penner_etal_JoAS_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Penner_etal_JoAS_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 59, pp. 441-460&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0441:ACOMAS%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002JAtS...59..441P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Penner_etal_JoAS_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The determination of an accurate quantitative understanding of the role of tropospheric aerosols in the earth's radiation budget is extremely important because forcing by anthropogenic aerosols presently represents one of the most uncertain aspects of climate models. Here the authors present a systematic comparison of three different analyses of satellite-retrieved aerosol optical depth based on the Advanced Very High Resolution Radiometer (AVHRR)-measured radiances with optical depths derived from six different models. Also compared are the model-derived clear-sky reflected shortwave radiation with satellite-measured reflectivities derived from the Earth Radiation Budget Experiment (ERBE) satellite.The three different satellite-derived optical depths differ by between 0.10 and 0.07 optical depth units in comparison to the average of the three analyses depending on latitude and month, but the general features of the retrievals are similar. The models differ by between 0.09 and +0.16 optical depth units from the average of the models. Differences between the average of the models and the average of the satellite analyses range over 0.11 to +0.05 optical depth units. These differences are significant since the annual average clear-sky radiative forcing associated with the difference between the average of the models and the average of the satellite analyses ranges between 3.9 and 0.7 W m^2 depending on latitude and is 1.7 W m^2 on a global average annual basis. Variations in the source strengths of dimethylsulfide-derived aerosols and sea salt aerosols can explain differences between the models, and between the models and satellite retrievals of up to 0.2 optical depth units.The comparison of model-generated reflected shortwave radiation and ERBE-measured shortwave radiation is similar in character as a function of latitude to the analysis of modeled and satellite-retrieved optical depths, but the differences between the modeled clear-sky reflected flux and the ERBE clear-sky reflected flux is generally larger than that inferred from the difference between the models and the AVHRR optical depths, especially at high latitudes. The difference between the mean of the models and the ERBE-analyzed clear-sky flux is 1.6 W m^2.The overall comparison indicates that the model-generated aerosol optical depth is systematically lower than that inferred from measurements between the latitudes of 10deg and 30degS. It is not likely that the shortfall is due to small values of the sea salt optical depth because increases in this component would create modeled optical depths that are larger than those from satellites in the region north of 30degN and near 50degS. Instead, the source strengths for DMS and biomass aerosols in the models may be too low. Firm conclusions, however, will require better retrieval procedures for the satellites, including better cloud screening procedures, further improvement of the model's treatment of aerosol transport and removal, and a better determination of aerosol source strengths.</td>
</tr>
<tr id="bib_Penner_etal_JoAS_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Penner_etal_JoAS_2002a,
  author = {Penner, J. E. and Zhang, S. Y. and Chin, M. and Chuang, C. C. and Feichter, J. and Feng, Y. and Geogdzhayev, I. V. and Ginoux, P. and Herzog, M. and Higurashi, A. and Koch, D. and Land, C. and Lohmann, U. and Mishchenko, M. and Nakajima, T. and Pitari, G. and Soden, B. and Tegen, I. and LawrencenbspStowe},
  title = {A Comparison of Model- and Satellite-Derived Aerosol Optical Depth and Reflectivity.},
  journal = {Journal of Atmospheric Sciences},
  year = {2002},
  volume = {59},
  pages = {441-460},
  url = {http://adsabs.harvard.edu/abs/2002JAtS...59..441P},
  doi = {https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0441:ACOMAS%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Torres_etal_JoAS_2002a" class="entry">
	<td>Torres, O., Bhartia, P.K., Herman, J.R., Sinyuk, A., Ginoux, P. and Holben, B.</td>
	<td>A Long-Term Record of Aerosol Optical Depth from TOMS Observations and Comparison to AERONET Measurements. <p class="infolinks">[<a href="javascript:toggleInfo('Torres_etal_JoAS_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Torres_etal_JoAS_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 59, pp. 398-413&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0398:ALTROA%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002JAtS...59..398T">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Torres_etal_JoAS_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Observations of backscattered near-ultraviolet radiation from the Total Ozone Mapping Spectrometer (TOMS) on board the Nimbus-7 (1979-92) and the Earth Probe (mid-1996 to present) satellites have been used to derive a long-term record of aerosol optical depth over oceans and continents. The retrieval technique applied to the TOMS data makes use of two unique advantages of near-UV remote sensing not available in the visible or near-IR: 1) low reflectivity of all land surface types (including the normally bright deserts in the visible), which makes possible aerosol retrieval over the continents; and 2) large sensitivity to aerosol types that absorb in the UV, allowing the clear separation of carbonaceous and mineral aerosols from purely scattering particles such as sulfate and sea salt aerosols. The near-UV method of aerosol characterization is validated by comparison with Aerosol Robotic Network (AERONET) ground-based observations. TOMS retrievals of aerosol optical depth over land areas (1996-2000) are shown to agree reasonably well with AERONET sun photometer observations for a variety of environments characterized by different aerosol types, such as carbonaceous aerosols from biomass burning, desert dust aerosols, and sulfate aerosols. In most cases the TOMS-derived optical depths of UV-absorbing aerosols are within 30&#37; of the AERONET observations, while nonabsorbing optical depths agree to within 20%. The results presented here constitute the first long-term nearly global climatology of aerosol optical depth over both land and water surfaces, extending the observations of aerosol optical depth to regions and times (1979 to present) not accessible to ground-based observations.</td>
</tr>
<tr id="bib_Torres_etal_JoAS_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Torres_etal_JoAS_2002a,
  author = {Torres, O. and Bhartia, P. K. and Herman, J. R. and Sinyuk, A. and Ginoux, P. and Holben, B.},
  title = {A Long-Term Record of Aerosol Optical Depth from TOMS Observations and Comparison to AERONET Measurements.},
  journal = {Journal of Atmospheric Sciences},
  year = {2002},
  volume = {59},
  pages = {398-413},
  url = {http://adsabs.harvard.edu/abs/2002JAtS...59..398T},
  doi = {https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0398:ALTROA%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Weaver_etal_JoAS_2002a" class="entry">
	<td>Weaver, C.J., Ginoux, P., Hsu, N.C., Chou, M.-D. and Joiner, J.</td>
	<td>Radiative Forcing of Saharan Dust: GOCART Model Simulations Compared with ERBE Data. <p class="infolinks">[<a href="javascript:toggleInfo('Weaver_etal_JoAS_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Weaver_etal_JoAS_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 59, pp. 736-747&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0736:RFOSDG%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002JAtS...59..736W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Weaver_etal_JoAS_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This study uses information on Saharan aerosol from a dust transport model to calculate radiative forcing values. The transport model is driven by assimilated meteorological fields from the Goddard Earth Observing System Data Assimilation System. The model produces global three-dimensional dust spatial information for four different mineral aerosol sizes. These dust fields are input to an offline radiative transfer calculation to obtain the direct radiative forcing due to the dust fields. These estimates of the shortwave reduction of radiation at the top of the atmosphere (TOA) compare reasonably well with the TOA reductions derived from Earth Radiation Budget Experiment (ERBE) and Total Ozone Mapping Spectrometer (TOMS) satellite data. The longwave radiation also agrees with the observations; however, potential errors in the assimilated temperatures complicate the comparison. Depending on the assumptions used in the calculation and the dust loading, the summertime forcing ranges from 0 to 18 W m^2 over ocean and from 0 to +20 W m^2 over land.Increments are terms in the assimilation general circulation model (GCM) equations that force the model toward observations. They are differences between the observed analyses and the GCM forecasts. Off west Africa the analysis temperature increments produced by the assimilation system show patterns that are consistent with the dust spatial distribution. It is not believed that radiative heating of dust is influencing the increments. Instead, it is suspected that dust is affecting the Television Infrared Observational Satellite (TIROS) Operational Vertical Sounder (TOVS) satellite temperature retrievals that provide the basis of the assimilated temperatures used by the model.</td>
</tr>
<tr id="bib_Weaver_etal_JoAS_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Weaver_etal_JoAS_2002a,
  author = {Weaver, C. J. and Ginoux, P. and Hsu, N. C. and Chou, M.-D. and Joiner, J.},
  title = {Radiative Forcing of Saharan Dust: GOCART Model Simulations Compared with ERBE Data.},
  journal = {Journal of Atmospheric Sciences},
  year = {2002},
  volume = {59},
  pages = {736-747},
  url = {http://adsabs.harvard.edu/abs/2002JAtS...59..736W},
  doi = {https://doi.org/10.1175/1520-0469(2002)059%5C&lt;0736:RFOSDG%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Weaver_etal_JoAS_2007a" class="entry">
	<td>Weaver, C., da Silva, A., Chin, M., Ginoux, P., Dubovik, O., Flittner, D., Zia, A., Remer, L., Holben, B. and Gregg, W.</td>
	<td>Direct Insertion of MODIS Radiances in a Global Aerosol Transport Model <p class="infolinks">[<a href="javascript:toggleInfo('Weaver_etal_JoAS_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 64, pp. 808&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JAS3838.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2007JAtS...64..808W">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Weaver_etal_JoAS_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Weaver_etal_JoAS_2007a,
  author = {Weaver, C. and da Silva, A. and Chin, M. and Ginoux, P. and Dubovik, O. and Flittner, D. and Zia, A. and Remer, L. and Holben, B. and Gregg, W.},
  title = {Direct Insertion of MODIS Radiances in a Global Aerosol Transport Model},
  journal = {Journal of Atmospheric Sciences},
  year = {2007},
  volume = {64},
  pages = {808},
  url = {http://adsabs.harvard.edu/abs/2007JAtS...64..808W},
  doi = {https://doi.org/10.1175/JAS3838.1}
}
</pre></td>
</tr>
<tr id="WetheraldManabe_JoAS_1988a" class="entry">
	<td>Wetherald, R.T. and Manabe, S.</td>
	<td>Cloud Feedback Processes in a General Circulation Model. <p class="infolinks">[<a href="javascript:toggleInfo('WetheraldManabe_JoAS_1988a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('WetheraldManabe_JoAS_1988a','bibtex')">BibTeX</a>]</p></td>
	<td>1988</td>
	<td>Journal of Atmospheric Sciences<br/>Vol. 45, pp. 1397-1416&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0469(1988)045%5C&lt;1397:CFPIAG%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/1988JAtS...45.1397W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_WetheraldManabe_JoAS_1988a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The influence of the cloud feedback process upon the sensitivity of
<br>climate is investigated by comparing the behavior of two versions of a
<br>climate model with predicted and prescribed cloud cover. The model used
<br>for this study is a general circulation model of the atmosphere coupled
<br>with a mixed layer model of the oceans. The sensitivity of each version
<br>of the model is inferred from the equilibrium response of the model to a
<br>doubling of the atmospheric concentration of carbon dioxide.It is found
<br>that the cloud feedback process in the present model enhances the
<br>sensitivity of the model climate. In response to the increase of
<br>atmospheric carbon dioxide, cloudiness increases around the tropopause
<br>and is reduced in the upper troposphere, thereby raising the height of
<br>the cloud layer in the upper troposphere. This rise of the high cloud
<br>layer implies a reduction of the temperature of the cloud top and,
<br>accordingly, of the upward terrestrial radiation from the top of the
<br>model atmosphere. Thus, the heat loss from the atmosphere-earth system
<br>of the model is reduced. As the high cloud layer rises, the vertical
<br>distribution of cloudiness changes, thereby affecting the absorption of
<br>solar radiation by the model atmosphere. At most latitudes the effect of
<br>reduced cloud amount in the upper troposphere overshadows that of
<br>increased cloudiness around the tropopause, thereby lowering the global
<br>mean planetary albedo and enhancing the CO_2 induced
<br>warming.On the other hand, the increase of low cloudiness in high
<br>latitudes raises the planetary albedo and thus decreases the
<br>CO_2 induced warming of climate. However, the contribution of
<br>this negative feedback process is much smaller than the effect of the
<br>positive feedback process involving the change of high cloud.The model
<br>used here does not take into consideration the possible change in the
<br>optical properties of clouds due to the change of their liquid water
<br>content. In view of the extreme idealization in the formulation of the
<br>cloud feedback process in the model, this study should be regarded as a
<br>study of the mechanisms involved in this process rather than the
<br>quantitative assessment of its influence on the sensitivity of climate.
<br></td>
</tr>
<tr id="bib_WetheraldManabe_JoAS_1988a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{WetheraldManabe_JoAS_1988a,
  author = {Wetherald, R. T. and Manabe, S.},
  title = {Cloud Feedback Processes in a General Circulation Model.},
  journal = {Journal of Atmospheric Sciences},
  year = {1988},
  volume = {45},
  pages = {1397-1416},
  url = {http://adsabs.harvard.edu/abs/1988JAtS...45.1397W},
  doi = {https://doi.org/10.1175/1520-0469(1988)045%5C&lt;1397:CFPIAG%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Loeb_etal_JoAaOT_2005a" class="entry">
	<td>Loeb, N.G., Kato, S., Loukachine, K. and Manalo-Smith, N.</td>
	<td>Angular Distribution Models for Top-of-Atmosphere Radiative Flux Estimation from the Clouds and the Earth's Radiant Energy System Instrument on the Terra Satellite. Part I: Methodology <p class="infolinks">[<a href="javascript:toggleInfo('Loeb_etal_JoAaOT_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Journal of Atmospheric and Oceanic Technology<br/>Vol. 22, pp. 338&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/JTECH1712.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005JAtOT..22..338L">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Loeb_etal_JoAaOT_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Loeb_etal_JoAaOT_2005a,
  author = {Loeb, N. G. and Kato, S. and Loukachine, K. and Manalo-Smith, N.},
  title = {Angular Distribution Models for Top-of-Atmosphere Radiative Flux Estimation from the Clouds and the Earth's Radiant Energy System Instrument on the Terra Satellite. Part I: Methodology},
  journal = {Journal of Atmospheric and Oceanic Technology},
  year = {2005},
  volume = {22},
  pages = {338},
  url = {http://adsabs.harvard.edu/abs/2005JAtOT..22..338L},
  doi = {https://doi.org/10.1175/JTECH1712.1}
}
</pre></td>
</tr>
<tr id="Loeb_etal_JoAM_2003a" class="entry">
	<td>Loeb, N.G., Manalo-Smith, N., Kato, S., Miller, W.F., Gupta, S.K., Minnis, P. and Wielicki, B.A.</td>
	<td>Angular Distribution Models for Top-of-Atmosphere Radiative Flux Estimation from the Clouds and the Earth's Radiant Energy System Instrument on the Tropical Rainfall Measuring Mission Satellite. Part I: Methodology. <p class="infolinks">[<a href="javascript:toggleInfo('Loeb_etal_JoAM_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Loeb_etal_JoAM_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Journal of Applied Meteorology<br/>Vol. 42, pp. 240-265&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/1520-0450(2003)042%5C&lt;0240:ADMFTO%5C&gt;2.0.CO;2">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003JApMe..42..240L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Loeb_etal_JoAM_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Clouds and the Earth's Radiant Energy System (CERES) investigates the
<br>critical role that clouds and aerosols play in modulating the radiative
<br>energy flow within the Earth-atmosphere system. CERES builds upon the
<br>foundation laid by previous missions, such as the Earth Radiation Budget
<br>Experiment, to provide highly accurate top-of-atmosphere (TOA) radiative
<br>fluxes together with coincident cloud and aerosol properties inferred
<br>from high-resolution imager measurements. This paper describes the
<br>method used to construct empirical angular distribution models (ADMs)
<br>for estimating shortwave, longwave, and window TOA radiative fluxes from
<br>CERES radiance measurements on board the Tropical Rainfall Measuring
<br>Mission satellite. To construct the ADMs, multiangle CERES measurements
<br>are combined with coincident high-resolution Visible Infrared Scanner
<br>measurements and meteorological parameters from the European Centre for
<br>Medium-Range Weather Forecasts data assimilation product. The ADMs are
<br>stratified by scene types defined by parameters that have a strong
<br>influence on the angular dependence of Earth's radiation field at the
<br>TOA. Examples of how the new CERES ADMs depend upon the imager-based
<br>parameters are provided together with comparisons with existing models.
<br></td>
</tr>
<tr id="bib_Loeb_etal_JoAM_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Loeb_etal_JoAM_2003a,
  author = {Loeb, N. G. and Manalo-Smith, N. and Kato, S. and Miller, W. F. and Gupta, S. K. and Minnis, P. and Wielicki, B. A.},
  title = {Angular Distribution Models for Top-of-Atmosphere Radiative Flux Estimation from the Clouds and the Earth's Radiant Energy System Instrument on the Tropical Rainfall Measuring Mission Satellite. Part I: Methodology.},
  journal = {Journal of Applied Meteorology},
  year = {2003},
  volume = {42},
  pages = {240-265},
  url = {http://adsabs.harvard.edu/abs/2003JApMe..42..240L},
  doi = {https://doi.org/10.1175/1520-0450(2003)042%5C&lt;0240:ADMFTO%5C&gt;2.0.CO;2}
}
</pre></td>
</tr>
<tr id="Zhao_etal_JoAiMES_2018a" class="entry">
	<td>Zhao, M., Golaz, J.-C., Held, I.M., Guo, H., Balaji, V., Benson, R., Chen, J.-H., Chen, X., Donner, L.J., Dunne, J.P., Dunne, K., Durachta, J., Fan, S.-M., Freidenreich, S.M., Garner, S.T., Ginoux, P., Harris, L.M., Horowitz, L.W., Krasting, J.P., Langenhorst, A.R., Liang, Z., Lin, P., Lin, S.-J., Malyshev, S.L., Mason, E., Milly, P.C.D., Ming, Y., Naik, V., Paulot, F., Paynter, D., Phillipps, P., Radhakrishnan, A., Ramaswamy, V., Robinson, T., Schwarzkopf, D., Seman, C.J., Shevliakova, E., Shen, Z., Shin, H., Silvers, L.G., Wilson, J.R., Winton, M., Wittenberg, A.T., Wyman, B. and Xiang, B.</td>
	<td>The GFDL Global Atmosphere and Land Model AM4.0/LM4.0: 2. Model Description, Sensitivity Studies, and Tuning Strategies <p class="infolinks">[<a href="javascript:toggleInfo('Zhao_etal_JoAiMES_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhao_etal_JoAiMES_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Journal of Advances in Modeling Earth Systems<br/>Vol. 10, pp. 735-769&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2017MS001209">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018JAMES..10..735Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhao_etal_JoAiMES_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: In Part 2 of this two-part paper, documentation is provided of key aspects of a version of the AM4.0/LM4.0 atmosphere/land model that will serve as a base for a new set of climate and Earth system models (CM4 and ESM4) under development at NOAA's Geophysical Fluid Dynamics Laboratory (GFDL). The quality of the simulation in AMIP (Atmospheric Model Intercomparison Project) mode has been provided in Part 1. Part 2 provides documentation of key components and some sensitivities to choices of model formulation and values of parameters, highlighting the convection parameterization and orographic gravity wave drag. The approach taken to tune the model's clouds to observations is a particular focal point. Care is taken to describe the extent to which aerosol effective forcing and Cess sensitivity have been tuned through the model development process, both of which are relevant to the ability of the model to simulate the evolution of temperatures over the last century when coupled to an ocean model.</td>
</tr>
<tr id="bib_Zhao_etal_JoAiMES_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhao_etal_JoAiMES_2018a,
  author = {Zhao, M. and Golaz, J.-C. and Held, I. M. and Guo, H. and Balaji, V. and Benson, R. and Chen, J.-H. and Chen, X. and Donner, L. J. and Dunne, J. P. and Dunne, K. and Durachta, J. and Fan, S.-M. and Freidenreich, S. M. and Garner, S. T. and Ginoux, P. and Harris, L. M. and Horowitz, L. W. and Krasting, J. P. and Langenhorst, A. R. and Liang, Z. and Lin, P. and Lin, S.-J. and Malyshev, S. L. and Mason, E. and Milly, P. C. D. and Ming, Y. and Naik, V. and Paulot, F. and Paynter, D. and Phillipps, P. and Radhakrishnan, A. and Ramaswamy, V. and Robinson, T. and Schwarzkopf, D. and Seman, C. J. and Shevliakova, E. and Shen, Z. and Shin, H. and Silvers, L. G. and Wilson, J. R. and Winton, M. and Wittenberg, A. T. and Wyman, B. and Xiang, B.},
  title = {The GFDL Global Atmosphere and Land Model AM4.0/LM4.0: 2. Model Description, Sensitivity Studies, and Tuning Strategies},
  journal = {Journal of Advances in Modeling Earth Systems},
  year = {2018},
  volume = {10},
  pages = {735-769},
  url = {http://adsabs.harvard.edu/abs/2018JAMES..10..735Z},
  doi = {https://doi.org/10.1002/2017MS001209}
}
</pre></td>
</tr>
<tr id="Zhao_etal_JoAiMES_2018b" class="entry">
	<td>Zhao, M., Golaz, J.-C., Held, I.M., Guo, H., Balaji, V., Benson, R., Chen, J.-H., Chen, X., Donner, L.J., Dunne, J.P., Dunne, K., Durachta, J., Fan, S.-M., Freidenreich, S.M., Garner, S.T., Ginoux, P., Harris, L.M., Horowitz, L.W., Krasting, J.P., Langenhorst, A.R., Liang, Z., Lin, P., Lin, S.-J., Malyshev, S.L., Mason, E., Milly, P.C.D., Ming, Y., Naik, V., Paulot, F., Paynter, D., Phillipps, P., Radhakrishnan, A., Ramaswamy, V., Robinson, T., Schwarzkopf, D., Seman, C.J., Shevliakova, E., Shen, Z., Shin, H., Silvers, L.G., Wilson, J.R., Winton, M., Wittenberg, A.T., Wyman, B. and Xiang, B.</td>
	<td>The GFDL Global Atmosphere and Land Model AM4.0/LM4.0: 1. Simulation Characteristics With Prescribed SSTs <p class="infolinks">[<a href="javascript:toggleInfo('Zhao_etal_JoAiMES_2018b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhao_etal_JoAiMES_2018b','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Journal of Advances in Modeling Earth Systems<br/>Vol. 10, pp. 691-734&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2017MS001208">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018JAMES..10..691Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhao_etal_JoAiMES_2018b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: In this two-part paper, a description is provided of a version of the AM4.0/LM4.0 atmosphere/land model that will serve as a base for a new set of climate and Earth system models (CM4 and ESM4) under development at NOAA's Geophysical Fluid Dynamics Laboratory (GFDL). This version, with roughly 100 km horizontal resolution and 33 levels in the vertical, contains an aerosol model that generates aerosol fields from emissions and a ``light'' chemistry mechanism designed to support the aerosol model but with prescribed ozone. In Part 1, the quality of the simulation in AMIP (Atmospheric Model Intercomparison Project) modemdashwith prescribed sea surface temperatures (SSTs) and sea-ice distributionmdashis described and compared with previous GFDL models and with the CMIP5 archive of AMIP simulations. The model's Cess sensitivity (response in the top-of-atmosphere radiative flux to uniform warming of SSTs) and effective radiative forcing are also presented. In Part 2, the model formulation is described more fully and key sensitivities to aspects of the model formulation are discussed, along with the approach to model tuning.</td>
</tr>
<tr id="bib_Zhao_etal_JoAiMES_2018b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhao_etal_JoAiMES_2018b,
  author = {Zhao, M. and Golaz, J.-C. and Held, I. M. and Guo, H. and Balaji, V. and Benson, R. and Chen, J.-H. and Chen, X. and Donner, L. J. and Dunne, J. P. and Dunne, K. and Durachta, J. and Fan, S.-M. and Freidenreich, S. M. and Garner, S. T. and Ginoux, P. and Harris, L. M. and Horowitz, L. W. and Krasting, J. P. and Langenhorst, A. R. and Liang, Z. and Lin, P. and Lin, S.-J. and Malyshev, S. L. and Mason, E. and Milly, P. C. D. and Ming, Y. and Naik, V. and Paulot, F. and Paynter, D. and Phillipps, P. and Radhakrishnan, A. and Ramaswamy, V. and Robinson, T. and Schwarzkopf, D. and Seman, C. J. and Shevliakova, E. and Shen, Z. and Shin, H. and Silvers, L. G. and Wilson, J. R. and Winton, M. and Wittenberg, A. T. and Wyman, B. and Xiang, B.},
  title = {The GFDL Global Atmosphere and Land Model AM4.0/LM4.0: 1. Simulation Characteristics With Prescribed SSTs},
  journal = {Journal of Advances in Modeling Earth Systems},
  year = {2018},
  volume = {10},
  pages = {691-734},
  url = {http://adsabs.harvard.edu/abs/2018JAMES..10..691Z},
  doi = {https://doi.org/10.1002/2017MS001208}
}
</pre></td>
</tr>
<tr id="Schulz_etal_ICSEaES_2009a" class="entry">
	<td>Schulz, M., Cozic, A. and Szopa, S.</td>
	<td>LMDzT-INCA dust forecast model developments and associated validation efforts <p class="infolinks">[<a href="javascript:toggleInfo('Schulz_etal_ICSEaES_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>IOP Conference Series: Earth and Environmental Science<br/>Vol. 7, pp. 012014&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1088/1755-1307/7/1/012014">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Schulz_etal_ICSEaES_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schulz_etal_ICSEaES_2009a,
  author = {M Schulz and A Cozic and S Szopa},
  title = {LMDzT-INCA dust forecast model developments and associated validation efforts},
  journal = {IOP Conference Series: Earth and Environmental Science},
  publisher = {IOP Publishing},
  year = {2009},
  volume = {7},
  pages = {012014},
  doi = {https://doi.org/10.1088/1755-1307/7/1/012014}
}
</pre></td>
</tr>
<tr id="LetellierGinoux_IJoBaC_2009a" class="entry">
	<td>Letellier, C. and Ginoux, J.-M.</td>
	<td>Development of the Nonlinear Dynamical Systems Theory from Radio Engineering to Electronics <p class="infolinks">[<a href="javascript:toggleInfo('LetellierGinoux_IJoBaC_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>International Journal of Bifurcation and Chaos<br/>Vol. 19, pp. 2131&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1142/S0218127409023986">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009IJBC...19.2131L">URL</a>&nbsp;</td>
</tr>
<tr id="bib_LetellierGinoux_IJoBaC_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{LetellierGinoux_IJoBaC_2009a,
  author = {Letellier, C. and Ginoux, J.-M.},
  title = {Development of the Nonlinear Dynamical Systems Theory from Radio Engineering to Electronics},
  journal = {International Journal of Bifurcation and Chaos},
  year = {2009},
  volume = {19},
  pages = {2131},
  url = {http://adsabs.harvard.edu/abs/2009IJBC...19.2131L},
  doi = {https://doi.org/10.1142/S0218127409023986}
}
</pre></td>
</tr>
<tr id="Balkanski_etal_GBC_1999a" class="entry">
	<td>Balkanski, Y., Monfray, P., Battle, M. and Heimann, M.</td>
	<td>Ocean primary production derived from satellite data: An evaluation with atmospheric oxygen measurements <p class="infolinks">[<a href="javascript:toggleInfo('Balkanski_etal_GBC_1999a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Balkanski_etal_GBC_1999a','bibtex')">BibTeX</a>]</p></td>
	<td>1999</td>
	<td>Global Biogeochemical Cycles<br/>Vol. 13, pp. 257-271&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/98GB02312">DOI</a> <a href="http://adsabs.harvard.edu/abs/1999GBioC..13..257B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Balkanski_etal_GBC_1999a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Recently, very precise measurements have detected the seasonal
<br>variability in the atmospheric O_2/N_2 ratio at
<br>several sites in the northern and southern hemispheres. In this paper,
<br>we derive marine primary productivity (PP) from satellite ocean color
<br>data. To infer air-sea oxygen fluxes, a simple one-dimensional
<br>diagnostic model of ocean biology has been developed that depends on
<br>only two parameters: a time delay between organic production and
<br>oxidation (set to 2 weeks) and an export scale length (50 m). This model
<br>gives a global net community production of 4.3 mol C m^-2
<br>yr^-1 in the euphotic zone and 3.2 mol C m^-2
<br>yr^-1 in the mixed layer. This last value corresponds to a
<br>global f ratio (net community production (NCP)/PP) at the base of the
<br>mixed layer of 0.37. The air-sea fluxes derived from this model are then
<br>used at the base of a three-dimensional atmospheric model to compare the
<br>atmospheric seasonal cycle of O_2/N_2 at five sites:
<br>Cape Grim (40.6degS, 144.6E), Baring Head (41.3degS, 174.8degE),
<br>Mauna Loa (19.5degN,154.8degW), La Jolla (32.9degN, 117.3degW),
<br>and Barrow (71.3degN, 156.6degW). The agreement between model and
<br>observations is very encouraging. We infer from the agreement that the
<br>seasonal variations in O_2/N_2 are largely
<br>controlled by the photosynthesis rate but also by the remineralization
<br>linked to the deepening and shoaling of the mixed layer. Lateral
<br>ventilation to high latitudes may also be an important factor
<br>controlling the amplitude of the seasonal cycle.
<br></td>
</tr>
<tr id="bib_Balkanski_etal_GBC_1999a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Balkanski_etal_GBC_1999a,
  author = {Balkanski, Y. and Monfray, P. and Battle, M. and Heimann, M.},
  title = {Ocean primary production derived from satellite data: An evaluation with atmospheric oxygen measurements},
  journal = {Global Biogeochemical Cycles},
  year = {1999},
  volume = {13},
  pages = {257-271},
  url = {http://adsabs.harvard.edu/abs/1999GBioC..13..257B},
  doi = {https://doi.org/10.1029/98GB02312}
}
</pre></td>
</tr>
<tr id="Collins_etal_GMD_2011a" class="entry">
	<td>Collins, W.J., Bellouin, N., Doutriaux-Boucher, M., Gedney, N., Halloran, P., Hinton, T., Hughes, J., Jones, C.D., Joshi, M., Liddicoat, S., Martin, G., O'Connor, F., Rae, J., Senior, C., Sitch, S., Totterdell, I., Wiltshire, A. and Woodward, S.</td>
	<td>Development and evaluation of an Earth-System model - HadGEM2 <p class="infolinks">[<a href="javascript:toggleInfo('Collins_etal_GMD_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Collins_etal_GMD_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Geoscientific Model Development<br/>Vol. 4, pp. 1051-1075&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-4-1051-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011GMD.....4.1051C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Collins_etal_GMD_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We describe here the development and evaluation of an Earth system model
<br>suitable for centennial-scale climate prediction. The principal new
<br>components added to the physical climate model are the terrestrial and
<br>ocean ecosystems and gas-phase tropospheric chemistry, along with their
<br>coupled interactions. <BR /><BR /> The individual Earth system
<br>components are described briefly and the relevant interactions between
<br>the components are explained. Because the multiple interactions could
<br>lead to unstable feedbacks, we go through a careful process of model
<br>spin up to ensure that all components are stable and the interactions
<br>balanced. This spun-up configuration is evaluated against observed data
<br>for the Earth system components and is generally found to perform very
<br>satisfactorily. The reason for the evaluation phase is that the model is
<br>to be used for the core climate simulations carried out by the Met
<br>Office Hadley Centre for the Coupled Model Intercomparison Project
<br>(CMIP5), so it is essential that addition of the extra complexity does
<br>not detract substantially from its climate performance. Localised
<br>changes in some specific meteorological variables can be identified, but
<br>the impacts on the overall simulation of present day climate are slight.
<br><BR /><BR /> This model is proving valuable both for climate
<br>predictions, and for investigating the strengths of biogeochemical
<br>feedbacks.
<br></td>
</tr>
<tr id="bib_Collins_etal_GMD_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Collins_etal_GMD_2011a,
  author = {Collins, W. J. and Bellouin, N. and Doutriaux-Boucher, M. and Gedney, N. and Halloran, P. and Hinton, T. and Hughes, J. and Jones, C. D. and Joshi, M. and Liddicoat, S. and Martin, G. and O'Connor, F. and Rae, J. and Senior, C. and Sitch, S. and Totterdell, I. and Wiltshire, A. and Woodward, S.},
  title = {Development and evaluation of an Earth-System model - HadGEM2},
  journal = {Geoscientific Model Development},
  year = {2011},
  volume = {4},
  pages = {1051-1075},
  url = {http://adsabs.harvard.edu/abs/2011GMD.....4.1051C},
  doi = {https://doi.org/10.5194/gmd-4-1051-2011}
}
</pre></td>
</tr>
<tr id="Collins_etal_GMD_2017a" class="entry">
	<td>Collins, W.J., Lamarque, J.-F., Schulz, M., Boucher, O., Eyring, V., Hegglin, M.I., Maycock, A., Myhre, G., Prather, M., Shindell, D. and Smith, S.J.</td>
	<td>AerChemMIP: quantifying the effects of chemistry and aerosols in CMIP6 <p class="infolinks">[<a href="javascript:toggleInfo('Collins_etal_GMD_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Geoscientific Model Development<br/>Vol. 10(2), pp. 585-607&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-10-585-2017">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Collins_etal_GMD_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Collins_etal_GMD_2017a,
  author = {William J. Collins and Jean-Fran&ccedil;ois Lamarque and Michael Schulz and Olivier Boucher and Veronika Eyring and Michaela I. Hegglin and Amanda Maycock and Gunnar Myhre and Michael Prather and Drew Shindell and Steven J. Smith},
  title = {AerChemMIP: quantifying the effects of chemistry and aerosols in CMIP6},
  journal = {Geoscientific Model Development},
  publisher = {Copernicus GmbH},
  year = {2017},
  volume = {10},
  number = {2},
  pages = {585--607},
  doi = {https://doi.org/10.5194/gmd-10-585-2017}
}
</pre></td>
</tr>
<tr id="Eyring_etal_GMD_2016a" class="entry">
	<td>Eyring, V., Righi, M., Lauer, A., Evaldsson, M., Wenzel, S., Jones, C., Anav, A., Andrews, O., Cionni, I., Davin, E.L., Deser, C., Ehbrecht, C., Friedlingstein, P., Gleckler, P., Gottschaldt, K.-D., Hagemann, S., Juckes, M., Kindermann, S., Krasting, J., Kunert, D., Levine, R., Loew, A., M&auml;kel&auml;, J., Martin, G., Mason, E., Phillips, A.S., Read, S., Rio, C., Roehrig, R., Senftleben, D., Sterl, A., van Ulft, L.H., Walton, J., Wang, S. and Williams, K.D.</td>
	<td>ESMValTool (v1.0) - a community diagnostic and performance metrics tool for routine evaluation of Earth system models in CMIP <p class="infolinks">[<a href="javascript:toggleInfo('Eyring_etal_GMD_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Eyring_etal_GMD_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Geoscientific Model Development<br/>Vol. 9, pp. 1747-1802&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-9-1747-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016GMD.....9.1747E">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Eyring_etal_GMD_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A community diagnostics and performance metrics tool for the evaluation
<br>of Earth system models (ESMs) has been developed that allows for routine
<br>comparison of single or multiple models, either against predecessor
<br>versions or against observations. The priority of the effort so far has
<br>been to target specific scientific themes focusing on selected essential
<br>climate variables (ECVs), a range of known systematic biases common to
<br>ESMs, such as coupled tropical climate variability, monsoons, Southern
<br>Ocean processes, continental dry biases, and soil hydrology-climate
<br>interactions, as well as atmospheric CO_2 budgets,
<br>tropospheric and stratospheric ozone, and tropospheric aerosols. The
<br>tool is being developed in such a way that additional analyses can
<br>easily be added. A set of standard namelists for each scientific topic
<br>reproduces specific sets of diagnostics or performance metrics that have
<br>demonstrated their importance in ESM evaluation in the peer-reviewed
<br>literature. The Earth System Model Evaluation Tool (ESMValTool) is a
<br>community effort open to both users and developers encouraging open
<br>exchange of diagnostic source code and evaluation results from the
<br>Coupled Model Intercomparison Project (CMIP) ensemble. This will
<br>facilitate and improve ESM evaluation beyond the state-of-the-art and
<br>aims at supporting such activities within CMIP and at individual
<br>modelling centres. Ultimately, we envisage running the ESMValTool
<br>alongside the Earth System Grid Federation (ESGF) as part of a more
<br>routine evaluation of CMIP model simulations while utilizing
<br>observations available in standard formats (obs4MIPs) or provided by the
<br>user.
<br></td>
</tr>
<tr id="bib_Eyring_etal_GMD_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Eyring_etal_GMD_2016a,
  author = {Eyring, V. and Righi, M. and Lauer, A. and Evaldsson, M. and Wenzel, S. and Jones, C. and Anav, A. and Andrews, O. and Cionni, I. and Davin, E. L. and Deser, C. and Ehbrecht, C. and Friedlingstein, P. and Gleckler, P. and Gottschaldt, K.-D. and Hagemann, S. and Juckes, M. and Kindermann, S. and Krasting, J. and Kunert, D. and Levine, R. and Loew, A. and M&auml;kel&auml;, J. and Martin, G. and Mason, E. and Phillips, A. S. and Read, S. and Rio, C. and Roehrig, R. and Senftleben, D. and Sterl, A. and van Ulft, L. H. and Walton, J. and Wang, S. and Williams, K. D.},
  title = {ESMValTool (v1.0) - a community diagnostic and performance metrics tool for routine evaluation of Earth system models in CMIP},
  journal = {Geoscientific Model Development},
  year = {2016},
  volume = {9},
  pages = {1747-1802},
  url = {http://adsabs.harvard.edu/abs/2016GMD.....9.1747E},
  doi = {https://doi.org/10.5194/gmd-9-1747-2016}
}
</pre></td>
</tr>
<tr id="Eyring_etal_GMD_2016b" class="entry">
	<td>Eyring, V., Bony, S., Meehl, G.A., Senior, C.A., Stevens, B., Stouffer, R.J. and Taylor, K.E.</td>
	<td>Overview of the Coupled Model Intercomparison Project Phase 6 (CMIP6) experimental design and organization <p class="infolinks">[<a href="javascript:toggleInfo('Eyring_etal_GMD_2016b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Eyring_etal_GMD_2016b','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Geoscientific Model Development<br/>Vol. 9, pp. 1937-1958&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-9-1937-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016GMD.....9.1937E">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Eyring_etal_GMD_2016b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: By coordinating the design and distribution of global climate model
<br>simulations of the past, current, and future climate, the Coupled Model
<br>Intercomparison Project (CMIP) has become one of the foundational
<br>elements of climate science. However, the need to address an
<br>ever-expanding range of scientific questions arising from more and more
<br>research communities has made it necessary to revise the organization of
<br>CMIP. After a long and wide community consultation, a new and more
<br>federated structure has been put in place. It consists of three major
<br>elements: (1) a handful of common experiments, the DECK (Diagnostic,
<br>Evaluation and Characterization of Klima) and CMIP historical
<br>simulations (1850-near present) that will maintain continuity and help
<br>document basic characteristics of models across different phases of
<br>CMIP; (2) common standards, coordination, infrastructure, and
<br>documentation that will facilitate the distribution of model outputs and
<br>the characterization of the model ensemble; and (3) an ensemble of
<br>CMIP-Endorsed Model Intercomparison Projects (MIPs) that will be
<br>specific to a particular phase of CMIP (now CMIP6) and that will build
<br>on the DECK and CMIP historical simulations to address a large range of
<br>specific questions and fill the scientific gaps of the previous CMIP
<br>phases. The DECK and CMIP historical simulations, together with the use
<br>of CMIP data standards, will be the entry cards for models participating
<br>in CMIP. Participation in CMIP6-Endorsed MIPs by individual modelling
<br>groups will be at their own discretion and will depend on their
<br>scientific interests and priorities. With the Grand Science Challenges
<br>of the World Climate Research Programme (WCRP) as its scientific
<br>backdrop, CMIP6 will address three broad questions: <BR /><BR /> - How
<br>does the Earth system respond to forcing?<BR /><BR /> - What are the
<br>origins and consequences of systematic model biases? <BR /><BR /> - How
<br>can we assess future climate changes given internal climate variability,
<br>predictability, and uncertainties in scenarios?<BR /><BR /> This CMIP6
<br>overview paper presents the background and rationale for the new
<br>structure of CMIP, provides a detailed description of the DECK and CMIP6
<br>historical simulations, and includes a brief introduction to the 21
<br>CMIP6-Endorsed MIPs.
<br></td>
</tr>
<tr id="bib_Eyring_etal_GMD_2016b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Eyring_etal_GMD_2016b,
  author = {Eyring, V. and Bony, S. and Meehl, G. A. and Senior, C. A. and Stevens, B. and Stouffer, R. J. and Taylor, K. E.},
  title = {Overview of the Coupled Model Intercomparison Project Phase 6 (CMIP6) experimental design and organization},
  journal = {Geoscientific Model Development},
  year = {2016},
  volume = {9},
  pages = {1937-1958},
  url = {http://adsabs.harvard.edu/abs/2016GMD.....9.1937E},
  doi = {https://doi.org/10.5194/gmd-9-1937-2016}
}
</pre></td>
</tr>
<tr id="Jones_etal_GMD_2011a" class="entry">
	<td>Jones, C.D., Hughes, J.K., Bellouin, N., Hardiman, S.C., Jones, G.S., Knight, J., Liddicoat, S., O'Connor, F.M., Andres, R.J., Bell, C., Boo, K.-O., Bozzo, A., Butchart, N., Cadule, P., Corbin, K.D., Doutriaux-Boucher, M., Friedlingstein, P., Gornall, J., Gray, L., Halloran, P.R., Hurtt, G., Ingram, W.J., Lamarque, J.-F., Law, R.M., Meinshausen, M., Osprey, S., Palin, E.J., Parsons Chini, L., Raddatz, T., Sanderson, M.G., Sellar, A.A., Schurer, A., Valdes, P., Wood, N., Woodward, S., Yoshioka, M. and Zerroukat, M.</td>
	<td>The HadGEM2-ES implementation of CMIP5 centennial simulations <p class="infolinks">[<a href="javascript:toggleInfo('Jones_etal_GMD_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Jones_etal_GMD_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Geoscientific Model Development<br/>Vol. 4, pp. 543-570&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-4-543-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011GMD.....4..543J">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Jones_etal_GMD_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The scientific understanding of the Earth's climate system, including
<br>the central question of how the climate system is likely to respond to
<br>human-induced perturbations, is comprehensively captured in GCMs and
<br>Earth System Models (ESM). Diagnosing the simulated climate response,
<br>and comparing responses across different models, is crucially dependent
<br>on transparent assumptions of how the GCM/ESM has been driven -
<br>especially because the implementation can involve subjective decisions
<br>and may differ between modelling groups performing the same experiment.
<br>This paper outlines the climate forcings and setup of the Met Office
<br>Hadley Centre ESM, HadGEM2-ES for the CMIP5 set of centennial
<br>experiments. We document the prescribed greenhouse gas concentrations,
<br>aerosol precursors, stratospheric and tropospheric ozone assumptions, as
<br>well as implementation of land-use change and natural forcings for the
<br>HadGEM2-ES historical and future experiments following the
<br>Representative Concentration Pathways. In addition, we provide details
<br>of how HadGEM2-ES ensemble members were initialised from the control run
<br>and how the palaeoclimate and AMIP experiments, as well as the
<br>``emission-driven'' RCP experiments were performed.
<br></td>
</tr>
<tr id="bib_Jones_etal_GMD_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Jones_etal_GMD_2011a,
  author = {Jones, C. D. and Hughes, J. K. and Bellouin, N. and Hardiman, S. C. and Jones, G. S. and Knight, J. and Liddicoat, S. and O'Connor, F. M. and Andres, R. J. and Bell, C. and Boo, K.-O. and Bozzo, A. and Butchart, N. and Cadule, P. and Corbin, K. D. and Doutriaux-Boucher, M. and Friedlingstein, P. and Gornall, J. and Gray, L. and Halloran, P. R. and Hurtt, G. and Ingram, W. J. and Lamarque, J.-F. and Law, R. M. and Meinshausen, M. and Osprey, S. and Palin, E. J. and Parsons Chini, L. and Raddatz, T. and Sanderson, M. G. and Sellar, A. A. and Schurer, A. and Valdes, P. and Wood, N. and Woodward, S. and Yoshioka, M. and Zerroukat, M.},
  title = {The HadGEM2-ES implementation of CMIP5 centennial simulations},
  journal = {Geoscientific Model Development},
  year = {2011},
  volume = {4},
  pages = {543-570},
  url = {http://adsabs.harvard.edu/abs/2011GMD.....4..543J},
  doi = {https://doi.org/10.5194/gmd-4-543-2011}
}
</pre></td>
</tr>
<tr id="Jones_etal_GMD_2016a" class="entry">
	<td>Jones, C.D., Arora, V., Friedlingstein, P., Bopp, L., Brovkin, V., Dunne, J., Graven, H., Hoffman, F., Ilyina, T., John, J.G., Jung, M., Kawamiya, M., Koven, C., Pongratz, J., Raddatz, T., Randerson, J.T. and Zaehle, S.</td>
	<td>C4MIP The Coupled Climate&ndash;Carbon Cycle Model Intercomparison Project: experimental protocol for CMIP6 <p class="infolinks">[<a href="javascript:toggleInfo('Jones_etal_GMD_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Geoscientific Model Development<br/>Vol. 9(8), pp. 2853-2880&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-9-2853-2016">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Jones_etal_GMD_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Jones_etal_GMD_2016a,
  author = {Chris D. Jones and Vivek Arora and Pierre Friedlingstein and Laurent Bopp and Victor Brovkin and John Dunne and Heather Graven and Forrest Hoffman and Tatiana Ilyina and Jasmin G. John and Martin Jung and Michio Kawamiya and Charlie Koven and Julia Pongratz and Thomas Raddatz and James T. Randerson and Sönke Zaehle},
  title = {C4MIP The Coupled Climate&ndash;Carbon Cycle Model Intercomparison Project: experimental protocol for CMIP6},
  journal = {Geoscientific Model Development},
  publisher = {Copernicus GmbH},
  year = {2016},
  volume = {9},
  number = {8},
  pages = {2853--2880},
  doi = {https://doi.org/10.5194/gmd-9-2853-2016}
}
</pre></td>
</tr>
<tr id="ONeill_etal_GMD_2016a" class="entry">
	<td>ONeill, B.C., Tebaldi, C., van Vuuren, D.P., Eyring, V., Friedlingstein, P., Hurtt, G., Knutti, R., Kriegler, E., Lamarque, J.-F., Lowe, J., Meehl, G.A., Moss, R., Riahi, K. and Sanderson, B.M.</td>
	<td>The Scenario Model Intercomparison Project (ScenarioMIP) for CMIP6 <p class="infolinks">[<a href="javascript:toggleInfo('ONeill_etal_GMD_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Geoscientific Model Development<br/>Vol. 9(9), pp. 3461-3482&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-9-3461-2016">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_ONeill_etal_GMD_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{ONeill_etal_GMD_2016a,
  author = {Brian C. ONeill and Claudia Tebaldi and Detlef P. van Vuuren and Veronika Eyring and Pierre Friedlingstein and George Hurtt and Reto Knutti and Elmar Kriegler and Jean-Francois Lamarque and Jason Lowe and Gerald A. Meehl and Richard Moss and Keywan Riahi and Benjamin M. Sanderson},
  title = {The Scenario Model Intercomparison Project (ScenarioMIP) for CMIP6},
  journal = {Geoscientific Model Development},
  publisher = {Copernicus GmbH},
  year = {2016},
  volume = {9},
  number = {9},
  pages = {3461--3482},
  doi = {https://doi.org/10.5194/gmd-9-3461-2016}
}
</pre></td>
</tr>
<tr id="Seferian_etal_GMD_2016a" class="entry">
	<td>S&eacute;f&eacute;rian, R., Delire, C., Decharme, B., Voldoire, A., y Melia, D.S., Chevallier, M., Saint-Martin, D., Aumont, O., Calvet, J.-C., Carrer, D., Douville, H., Franchist&eacute;guy, L., Joetzjer, E. and S&eacute;n&eacute;si, S.</td>
	<td>Development and evaluation of CNRM Earth system model &ndash; CNRM-ESM1 <p class="infolinks">[<a href="javascript:toggleInfo('Seferian_etal_GMD_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Geoscientific Model Development<br/>Vol. 9(4), pp. 1423-1453&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-9-1423-2016">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Seferian_etal_GMD_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Seferian_etal_GMD_2016a,
  author = {Roland S&eacute;f&eacute;rian and Christine Delire and Bertrand Decharme and Aurore Voldoire and David Salas&nbsp;y&nbsp;Melia and Matthieu Chevallier and David Saint-Martin and Olivier Aumont and Jean-Christophe Calvet and Dominique Carrer and Herv&eacute; Douville and Laurent Franchist&eacute;guy and Emilie Joetzjer and S&eacute;phane S&eacute;n&eacute;si},
  title = {Development and evaluation of CNRM Earth system model &ndash; CNRM-ESM1},
  journal = {Geoscientific Model Development},
  publisher = {Copernicus GmbH},
  year = {2016},
  volume = {9},
  number = {4},
  pages = {1423--1453},
  doi = {https://doi.org/10.5194/gmd-9-1423-2016}
}
</pre></td>
</tr>
<tr id="Team_etal_GMD_2011a" class="entry">
	<td>Team, H.D., Martin, G.M., Bellouin, N., Collins, W.J., Culverwell, I.D., Halloran, P.R., Hardiman, S.C., Hinton, T.J., Jones, C.D., McDonald, R.E., McLaren, A.J., O'Connor, F.M., Roberts, M.J., Rodriguez, J.M., Woodward, S., Best, M.J., Brooks, M.E., Brown, A.R., Butchart, N., Dearden, C., Derbyshire, S.H., Dharssi, I., Doutriaux-Boucher, M., Edwards, J.M., Falloon, P.D., Gedney, N., Gray, L.J., Hewitt, H.T., Hobson, M., Huddleston, M.R., Hughes, J., Ineson, S., Ingram, W.J., James, P.M., Johns, T.C., Johnson, C.E., Jones, A., Jones, C.P., Joshi, M.M., Keen, A.B., Liddicoat, S., Lock, A.P., Maidens, A.V., Manners, J.C., Milton, S.F., Rae, J.G.L., Ridley, J.K., Sellar, A., Senior, C.A., Totterdell, I.J., Verhoef, A., Vidale, P.L. and Wiltshire, A.</td>
	<td>The HadGEM2 family of Met Office Unified Model climate configurations <p class="infolinks">[<a href="javascript:toggleInfo('Team_etal_GMD_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Team_etal_GMD_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Geoscientific Model Development<br/>Vol. 4, pp. 723-757&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/gmd-4-723-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011GMD.....4..723H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Team_etal_GMD_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We describe the HadGEM2 family of climate configurations of the Met
<br>Office Unified Model, MetUM. The concept of a model ``family'' comprises a
<br>range of specific model configurations incorporating different levels of
<br>complexity but with a common physical framework. The HadGEM2 family of
<br>configurations includes atmosphere and ocean components, with and
<br>without a vertical extension to include a well-resolved stratosphere,
<br>and an Earth-System (ES) component which includes dynamic vegetation,
<br>ocean biology and atmospheric chemistry. The HadGEM2 physical model
<br>includes improvements designed to address specific systematic errors
<br>encountered in the previous climate configuration, HadGEM1, namely
<br>Northern Hemisphere continental temperature biases and tropical sea
<br>surface temperature biases and poor variability. Targeting these biases
<br>was crucial in order that the ES configuration could represent important
<br>biogeochemical climate feedbacks. Detailed descriptions and evaluations
<br>of particular HadGEM2 family members are included in a number of other
<br>publications, and the discussion here is limited to a summary of the
<br>overall performance using a set of model metrics which compare the way
<br>in which the various configurations simulate present-day climate and its
<br>variability.
<br></td>
</tr>
<tr id="bib_Team_etal_GMD_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Team_etal_GMD_2011a,
  author = {Hadgem2 Development Team and Martin, G. M. and Bellouin, N. and Collins, W. J. and Culverwell, I. D. and Halloran, P. R. and Hardiman, S. C. and Hinton, T. J. and Jones, C. D. and McDonald, R. E. and McLaren, A. J. and O'Connor, F. M. and Roberts, M. J. and Rodriguez, J. M. and Woodward, S. and Best, M. J. and Brooks, M. E. and Brown, A. R. and Butchart, N. and Dearden, C. and Derbyshire, S. H. and Dharssi, I. and Doutriaux-Boucher, M. and Edwards, J. M. and Falloon, P. D. and Gedney, N. and Gray, L. J. and Hewitt, H. T. and Hobson, M. and Huddleston, M. R. and Hughes, J. and Ineson, S. and Ingram, W. J. and James, P. M. and Johns, T. C. and Johnson, C. E. and Jones, A. and Jones, C. P. and Joshi, M. M. and Keen, A. B. and Liddicoat, S. and Lock, A. P. and Maidens, A. V. and Manners, J. C. and Milton, S. F. and Rae, J. G. L. and Ridley, J. K. and Sellar, A. and Senior, C. A. and Totterdell, I. J. and Verhoef, A. and Vidale, P. L. and Wiltshire, A.},
  title = {The HadGEM2 family of Met Office Unified Model climate configurations},
  journal = {Geoscientific Model Development},
  year = {2011},
  volume = {4},
  pages = {723-757},
  url = {http://adsabs.harvard.edu/abs/2011GMD.....4..723H},
  doi = {https://doi.org/10.5194/gmd-4-723-2011}
}
</pre></td>
</tr>
<tr id="Mahowald_GRL_2003a" class="entry">
	<td>Mahowald, N.M.</td>
	<td>Mineral aerosol and cloud interactions <p class="infolinks">[<a href="javascript:toggleInfo('Mahowald_GRL_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Geophysical Research Letters<br/>Vol. 30(9)&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2002gl016762">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Mahowald_GRL_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Mahowald_GRL_2003a,
  author = {Natalie M. Mahowald},
  title = {Mineral aerosol and cloud interactions},
  journal = {Geophysical Research Letters},
  publisher = {American Geophysical Union (AGU)},
  year = {2003},
  volume = {30},
  number = {9},
  doi = {https://doi.org/10.1029/2002gl016762}
}
</pre></td>
</tr>
<tr id="Mouillot_etal_GRL_2006a" class="entry">
	<td>Mouillot, F., Narasimha, A., Balkanski, Y., Lamarque, J.-F. and Field, C.B.</td>
	<td>Global carbon emissions from biomass burning in the 20th century <p class="infolinks">[<a href="javascript:toggleInfo('Mouillot_etal_GRL_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Mouillot_etal_GRL_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Geophysical Research Letters<br/>Vol. 33, pp. L01801&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2005GL024707">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006GeoRL..33.1801M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Mouillot_etal_GRL_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We used a new, 100-year, 1 &times; 1deg global fire map and a carbon
<br>cycle model (CASA) to provide a yearly gridded estimate of the temporal
<br>trend in carbon emissions due to wildfires through the 20th century.
<br>2700-3325 Tg C y^-1 burn at the end of the 20th century,
<br>compared to 1500-2700 Tg C y^-1 at the beginning, with
<br>increasing uncertainty moving backward in time. There have been major
<br>changes in the regional distribution of emissions from fires, as a
<br>consequence of i) increased burning in tropical savannas and ii) a
<br>switch of emissions from temperate and boreal forests towards the
<br>tropics. The frequently-used assumption that pre-industrial emissions
<br>were 10&#37; of present biomass burning is clearly inadequate, in terms of
<br>both the total amount and the spatial distribution of combustion.
<br></td>
</tr>
<tr id="bib_Mouillot_etal_GRL_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Mouillot_etal_GRL_2006a,
  author = {Mouillot, F. and Narasimha, A. and Balkanski, Y. and Lamarque, J.-F. and Field, C. B.},
  title = {Global carbon emissions from biomass burning in the 20th century},
  journal = {Geophysical Research Letters},
  year = {2006},
  volume = {33},
  pages = {L01801},
  url = {http://adsabs.harvard.edu/abs/2006GeoRL..33.1801M},
  doi = {https://doi.org/10.1029/2005GL024707}
}
</pre></td>
</tr>
<tr id="Reddy_etal_GRL_2005a" class="entry">
	<td>Reddy, M.S., Boucher, O., Balkanski, Y. and Schulz, M.</td>
	<td>Aerosol optical depths and direct radiative perturbations by species and source type <p class="infolinks">[<a href="javascript:toggleInfo('Reddy_etal_GRL_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Reddy_etal_GRL_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Geophysical Research Letters<br/>Vol. 32, pp. L12803&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004GL021743">DOI</a> <a href="http://adsabs.harvard.edu/abs/2005GeoRL..3212803R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Reddy_etal_GRL_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We have used the Laboratoire de M&eacute;t&eacute;orologie Dynamique
<br>General Circulation Model (LMDZT GCM) to estimate the relative
<br>contributions of different aerosol source types (i.e., fossil fuels,
<br>biomass burning, and ``natural'') and aerosol species to the aerosol
<br>optical depth (AOD) and direct aerosol radiative perturbation (DARP) at
<br>the top-of-atmosphere. The largest estimated contribution to the global
<br>annual average AOD (0.12 at 550 nm) is from natural (58, followed by
<br>fossil fuel (26, and biomass burning (16 sources. The global annual
<br>mean all-sky DARP in the shortwave (SW) spectrum by sulfate, black
<br>carbon (BC), organic matter (OM), dust, and sea salt are -0.62, +0.55,
<br>-0.33, -0.28, and -0.30 Wm^-2, respectively. The all-sky DARP
<br>in the longwave spectrum (LW) is not negligible and is a bit less than
<br>half of the SW DARP. The net (i.e., SW+LW) DARP distribution is
<br>predominantly negative with patches of positive values over the dust
<br>source regions, and off the west coasts of Southern Africa and South and
<br>North America. For dust aerosols the SW effect is partially offset by LW
<br>greenhouse effect.
<br></td>
</tr>
<tr id="bib_Reddy_etal_GRL_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Reddy_etal_GRL_2005a,
  author = {Reddy, M. S. and Boucher, O. and Balkanski, Y. and Schulz, M.},
  title = {Aerosol optical depths and direct radiative perturbations by species and source type},
  journal = {Geophysical Research Letters},
  year = {2005},
  volume = {32},
  pages = {L12803},
  url = {http://adsabs.harvard.edu/abs/2005GeoRL..3212803R},
  doi = {https://doi.org/10.1029/2004GL021743}
}
</pre></td>
</tr>
<tr id="Wang_etal_GRL_2015a" class="entry">
	<td>Wang, R., Balkanski, Y., Bopp, L., Aumont, O., Boucher, O., Ciais, P., Gehlen, M., Pe&ntilde;uelas, J., Eth&eacute;, C., Hauglustaine, D., Li, B., Liu, J., Zhou, F. and Tao, S.</td>
	<td>Influence of anthropogenic aerosol deposition on the relationship between oceanic productivity and warming <p class="infolinks">[<a href="javascript:toggleInfo('Wang_etal_GRL_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Wang_etal_GRL_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Geophysical Research Letters<br/>Vol. 42, pp. 10&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1002/2015GL066753">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015GeoRL..4210745W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Wang_etal_GRL_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Satellite data and models suggest that oceanic productivity is reduced
<br>in response to less nutrient supply under warming. In contrast,
<br>anthropogenic aerosols provide nutrients and exert a fertilizing effect,
<br>but its contribution to evolution of oceanic productivity is unknown. We
<br>simulate the response of oceanic biogeochemistry to anthropogenic
<br>aerosols deposition under varying climate from 1850 to 2010. We find a
<br>positive response of observed chlorophyll to deposition of anthropogenic
<br>aerosols. Our results suggest that anthropogenic aerosols reduce the
<br>sensitivity of oceanic productivity to warming from -15.2 plusmn 1.8
<br>to -13.3 plusmn 1.6 Pg C yr^-1 degC^-1 in global
<br>stratified oceans during 1948-2007. The reducing percentage over the
<br>North Atlantic, North Pacific, and Indian Oceans reaches 40, 24, and
<br>25 respectively. We hypothesize that inevitable reduction of aerosol
<br>emissions in response to higher air quality standards in the future
<br>might accelerate the decline of oceanic productivity per unit warming.
<br></td>
</tr>
<tr id="bib_Wang_etal_GRL_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Wang_etal_GRL_2015a,
  author = {Wang, R. and Balkanski, Y. and Bopp, L. and Aumont, O. and Boucher, O. and Ciais, P. and Gehlen, M. and Pe&ntilde;uelas, J. and Eth&eacute;, C. and Hauglustaine, D. and Li, B. and Liu, J. and Zhou, F. and Tao, S.},
  title = {Influence of anthropogenic aerosol deposition on the relationship between oceanic productivity and warming},
  journal = {Geophysical Research Letters},
  year = {2015},
  volume = {42},
  pages = {10},
  url = {http://adsabs.harvard.edu/abs/2015GeoRL..4210745W},
  doi = {https://doi.org/10.1002/2015GL066753}
}
</pre></td>
</tr>
<tr id="Wong_etal_GRL_2008a" class="entry">
	<td>Wong, S., Dessler, A.E., Mahowald, N.M., Colarco, P.R. and da Silva, A.</td>
	<td>Long-term variability in Saharan dust transport and its link to North Atlantic sea surface temperature <p class="infolinks">[<a href="javascript:toggleInfo('Wong_etal_GRL_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Geophysical Research Letters<br/>Vol. 35(7), pp. n/a-n/a&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2007gl032297">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Wong_etal_GRL_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Wong_etal_GRL_2008a,
  author = {Sun Wong and Andrew E. Dessler and Natalie M. Mahowald and Peter R. Colarco and Arlindo da Silva},
  title = {Long-term variability in Saharan dust transport and its link to North Atlantic sea surface temperature},
  journal = {Geophysical Research Letters},
  publisher = {American Geophysical Union (AGU)},
  year = {2008},
  volume = {35},
  number = {7},
  pages = {n/a--n/a},
  doi = {https://doi.org/10.1029/2007gl032297}
}
</pre></td>
</tr>
<tr id="Zender_etal_ETAGU_2004a" class="entry">
	<td>Zender, C.S., Miller, R.L.L. and Tegen, I.</td>
	<td>Quantifying mineral dust mass budgets:Terminology, constraints, and current estimates <p class="infolinks">[<a href="javascript:toggleInfo('Zender_etal_ETAGU_2004a','bibtex')">BibTeX</a>]</p></td>
	<td>2004</td>
	<td>Eos, Transactions American Geophysical Union<br/>Vol. 85(48), pp. 509-512&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1029/2004eo480002">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Zender_etal_ETAGU_2004a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zender_etal_ETAGU_2004a,
  author = {C. S. Zender and R. L.R. L. Miller and I. Tegen},
  title = {Quantifying mineral dust mass budgets:Terminology, constraints, and current estimates},
  journal = {Eos, Transactions American Geophysical Union},
  publisher = {Wiley-Blackwell},
  year = {2004},
  volume = {85},
  number = {48},
  pages = {509--512},
  doi = {https://doi.org/10.1029/2004eo480002}
}
</pre></td>
</tr>
<tr id="Schulz_etal_ESaT_2012a" class="entry">
	<td>Schulz, M., Prospero, J.M., Baker, A.R., Dentener, F., Ickes, L., Liss, P.S., Mahowald, N.M., Nickovic, S., Garc\ia-Pando, C.P., Rodr\iguez, S., Sarin, M., Tegen, I. and Duce, R.A.</td>
	<td>Atmospheric Transport and Deposition of Mineral Dust to the Ocean: Implications for Research Needs <p class="infolinks">[<a href="javascript:toggleInfo('Schulz_etal_ESaT_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Environmental Science and Technology<br/>Vol. 46, pp. 10390-10404&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1021/es300073u">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Schulz_etal_ESaT_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schulz_etal_ESaT_2012a,
  author = {Schulz, M. and Prospero, J. M. and Baker, A. R. and Dentener, F. and Ickes, L. and Liss, P. S. and Mahowald, N. M. and Nickovic, S. and Garc\ia-Pando, C. P. and Rodr\iguez, S. and Sarin, M. and Tegen, I. and Duce, R. A.},
  title = {Atmospheric Transport and Deposition of Mineral Dust to the Ocean: Implications for Research Needs},
  journal = {Environmental Science and Technology},
  year = {2012},
  volume = {46},
  pages = {10390-10404},
  doi = {https://doi.org/10.1021/es300073u}
}
</pre></td>
</tr>
<tr id="Hoose_etal_ERL_2008a" class="entry">
	<td>Hoose, C., Lohmann, U., Erdin, R. and Tegen, I.</td>
	<td>The global influence of dust mineralogical composition on heterogeneous ice nucleation in mixed-phase clouds <p class="infolinks">[<a href="javascript:toggleInfo('Hoose_etal_ERL_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Hoose_etal_ERL_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Environmental Research Letters<br/>Vol. 3(2), pp. 025003&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1088/1748-9326/3/2/025003">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008ERL.....3b5003H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Hoose_etal_ERL_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral dust is the dominant natural ice nucleating aerosol. Its ice
<br>nucleation efficiency depends on the mineralogical composition. We show
<br>the first sensitivity studies with a global climate model and a
<br>three-dimensional dust mineralogy. Results show that, depending on the
<br>dust mineralogical composition, coating with soluble material from
<br>anthropogenic sources can lead to quasi-deactivation of natural dust ice
<br>nuclei. This effect counteracts the increased cloud glaciation by
<br>anthropogenic black carbon particles. The resulting aerosol indirect
<br>effect through the glaciation of mixed-phase clouds by black carbon
<br>particles is small (+0.1 W m^-2 in the shortwave
<br>top-of-the-atmosphere radiation in the northern hemisphere).
<br></td>
</tr>
<tr id="bib_Hoose_etal_ERL_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hoose_etal_ERL_2008a,
  author = {Hoose, C. and Lohmann, U. and Erdin, R. and Tegen, I.},
  title = {The global influence of dust mineralogical composition on heterogeneous ice nucleation in mixed-phase clouds},
  journal = {Environmental Research Letters},
  year = {2008},
  volume = {3},
  number = {2},
  pages = {025003},
  url = {http://adsabs.harvard.edu/abs/2008ERL.....3b5003H},
  doi = {https://doi.org/10.1088/1748-9326/3/2/025003}
}
</pre></td>
</tr>
<tr id="Remer_ERL_2006a" class="entry">
	<td>Remer, L.A.</td>
	<td>PERSPECTIVE: Dust, fertilization and sources <p class="infolinks">[<a href="javascript:toggleInfo('Remer_ERL_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Remer_ERL_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Environmental Research Letters<br/>Vol. 1(1), pp. 011001&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1088/1748-9326/1/1/011001">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006ERL.....1a1001R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Remer_ERL_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosols, tiny suspended particles in the atmosphere, play an important role in modifying the Earth's energy balance and are essential for the formation of cloud droplets. Suspended dust particles lifted from the world's arid regions by strong winds contain essential minerals that can be transported great distances and deposited into the ocean or on other continents where productivity is limited by lack of usable minerals [<A href=``ref1''>1</A>]. Dust can transport pathogens as well as minerals great distance, contributing to the spread of human and agricultural diseases, and a portion of dust can be attributed to human activity suggesting that dust radiative effects should be included in estimates of anthropogenic climate forcing. The greenish and brownish tints in figure 1 show the wide extent of monthly mean mineral dust transport, as viewed by the MODerate resolution Imaging Spectroradiometer (MODIS) satellite sensor.  The monthly mean global aerosol system for February 2006 from the MODIS aboard the Terra satellite  Figure 1. The monthly mean global aerosol system for February 2006 from the MODIS aboard the Terra satellite. The brighter the color, the greater the aerosol loading. Red and reddish tints indicate aerosol dominated by small particles created primarily from combustion processes. Green and brownish tints indicate larger particles created from wind-driven processes, usually transported desert dust. Note the bright green band at the southern edge of the Saharan desert, the reddish band it must cross if transported to the southwest and the long brownish transport path as it crosses the Atlantic to South America. Image courtesy of the NASA Earth Observatory (<A href=``http://earthobservatory.nasa.gov''>http://earthobservatory.nasa.gov</A>).  Even though qualitatively we recognize the extent and importance of dust transport and the role that it plays in fertilizing nutrient-limited regions, there is much that is still unknown. We are just now beginning to quantify the amount of dust that exits one continental region and the fraction that arrives at another continent [<A href=``ref2''>2</A>].  At the deposition end of the chain, it is still unclear how the limited minerals in the dust such as iron are released for uptake by organisms either on land or in the ocean. Not all dust deposited into oceans results in a phytoplankton bloom. The process requires a chemical pathway that mobilizes a fraction of the iron into soluble form. Meskhidze et al [<A href=``ref3''>3</A>] show that phytoplankton blooms following dust transport from the Gobi desert in Asia into the Pacific ocean result in a phytoplankton bloom only if the dust is accompanied by high initial SO_2-to-dust ratios, suggesting that sulfuric acid coatings on the dust particle mobilize the embedded iron in the dust for phytoplankton uptake.  Quantifying transport, deposition and nutrient availability are the latter ends of a puzzle that must begin by identifying and quantifying dust emission at the sources. The emission process is complex at the microscale requiring the right conditions for saltation and bombardment, which makes identification and inclusion of sources in global transport models very difficult. The result is that estimates of annual global dust emissions range from 1000 to 3000 Tg per year [<A href=``ref4''>4</A>]. Even as global estimates of dust emissions are uncertain, localizing the sources brings even greater uncertainty. It has been recognized for several years that dust sources are not uniformly distributed over the arid regions of the Earth, but are regulated to topographic lows associated with dried lake deposits [<A href=``ref5''>5</A>]. Using aerosol information from satellites, a comprehensive map of the world's source regions shows sources localized to specific areas of the Earth's arid regions [<A href=``ref6''>6</A>]. Still these maps suggest broad emission sources covering several degrees of latitude and longitude.  In the paper by Koren and co-authors [<A href=``ref7''>7</A>] appearing in this issue, one particular dust source, the Bod&eacute;l&eacute; depression in Chad, is analyzed in detail. They find that the specific topography of the depression combined with the prevailing wind direction in the winter provides perfect conditions for aerosol saltation, uplift and transport. The winter Bod&eacute;l&eacute; dust is carried over the populated regions of west Africa where it can be affected by smoke and urban pollution before it continues transport over the Atlantic and towards Amazonia. Although Koren et al do not speculate on the chemical possibilities in their paper, the interaction between the dust and the pollutants provides opportunity for acids to coat the dust particles and to mobilize the iron compounds, creating a highly efficient fertilizing agent for ocean phytoplankton and the biota of the Amazon forest. Koren et al do quantify the dust emission of the Bod&eacute;l&eacute; depression, estimating that this small area produces approximately 50&#37; of the Saharan dust deposited in the Amazon.  The findings of Koren and his co-authors suggest that dust emission sources may be highly localized spots in the Earth's deserts that can be mapped precisely by satellites of moderate to fine resolution. Like fire hot spots that localize smoke emission, desert dust hot spots can be identified with great detail. This can provide aerosol transport models with better source emission information and improve estimates that will help in making estimates concerning biogeochemical processes and also estimates of climate forcing and response.  References  <A>[1]</A> Swap R et al 1992 Saharan dust in the Amazon basin Tellus B 44 133-49 (<A href=``http://dx.doi.org/10.1034/j.1600-0889.1992.t01-1-00005.x''>doi:10.1034/j.1600-0889.1992.t01-1-00005.x</A>)  <A>[2]</A> Kaufman Y J, Koren I, Remer L A, Tanr&eacute; D, Ginoux P and Fan S 2005 Dust transport and deposition observed from the Terra-MODIS space observations J. Geophys. Res. 110 D10S12 (<A href=``http://dx.doi.org/10.1029/2003JD004436''>doi:10.1029/2003JD004436</A>)  <A>[3]</A> Meskhidze N, Chameides W L and Nenes A 2005 Dust and pollution: a recipe for enhanced ocean fertizilation? J. Geophys. Res. 110 (D3) D03301 (<A href=``http://dx.doi.org/10.1029/2004JD005082''>doi:10.1029/2004JD005082</A>)  <A>[4]</A> Cakur R V et al 2006 Constraining the magnitude of the global dust cycle by minimizing the difference between a model and observations J. Geophys. Res. 111 D06207 (<A href=``http://dx.doi.org/10.1029/2005JD005791''>doi:10.1029/2005JD005791</A>)  <A>[5]</A> Ginoux P et al 2001 Sources and distribution of dust aerosol simulated with the GOCART model J. Geophys. Res. 106 20255-74 (<A href=``http://dx.doi.org/10.1029/2000JD000053''>doi:10.1029/2000JD000053</A>)  <A>[6]</A> Prospero J M, Ginoux P, Torres O, Nicholson S E and Gill T E 2002 Environmental characterization of global sources of atmospheric soil dust identified with the NIMBUS 7 total Ozone Mapping Spectrometer (TOMS) absorbing aerosol product Rev. Geophys. 40 (1) 1002 (<A href=``http://dx.doi.org/10.1029/2000RG000095''>doi:10.1029/2000RG000095</A>)  <A>[7]</A> Koren I, Kaufman Y J, Washington R, Todd M C, Rudich Y, Martins J V and Rosenfeld D 2006 The Bod&eacute;l&eacute; depression: a single spot in the Sahara that provides most of the mineral dust to the Amazon forest Environ. Res Lett. 1 014005 (<A href=``http://dx.doi.org/10.1088/1748-9326/1/1/014005''>doi:10.1088/1748-9326/1/1/014005</A>)  Photo of Lorraine A Remer  Lorraine A Remer received a BS degree in atmospheric science from the University of California, Davis, in 1980, an MS degree in oceanography from the Scripps Institution of Oceanography, University of California, San Diego, in 1983, and a PhD degree, also in atmospheric science from the University of California, Davis, in 1991. She became involved with the MODIS retrievals of atmospheric aerosols in 1991, first as a Research Scientist with Science Systems and Applications, Inc., and subsequently with the National Aeronautics and Space Administration, which she joined in 1998. She is an Associate Member of the MODIS Science Team and a Member of the Global Aerosol Climatology Project Science Team.</td>
</tr>
<tr id="bib_Remer_ERL_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Remer_ERL_2006a,
  author = {Remer, L. A.},
  title = {PERSPECTIVE: Dust, fertilization and sources},
  journal = {Environmental Research Letters},
  year = {2006},
  volume = {1},
  number = {1},
  pages = {011001},
  url = {http://adsabs.harvard.edu/abs/2006ERL.....1a1001R},
  doi = {https://doi.org/10.1088/1748-9326/1/1/011001}
}
</pre></td>
</tr>
<tr id="Ginoux_etal__2018a" class="entry">
	<td>Ginoux, P., Kapnick, S., Malyshev, S., Chan, V., Guo, H., Milly, C., Naik, V., Pascale, S., Pu, B., Shevliakova, E. and Zhao, M.</td>
	<td>Analysis of aerosol deposition on snowpack over global high mountain ranges <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal__2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal__2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td><br/>Vol. 20EGU General Assembly Conference Abstracts, pp. 10062&nbsp;</td>
	<td>inproceedings</td>
	<td><a href="http://adsabs.harvard.edu/abs/2018EGUGA..2010062G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal__2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Snow and ice over high mountain ranges are often not pure, but contains absorbing aerosols such as black carbon or dust. These impurities can alter the surface albedo and influence cryosphere melt dynamics and feed back on broader circulation. These effects will depend on the intensity of snowfall accumulation and aerosol deposition, as well as their spatial and temporal distributions.  Here, we present an analysis of a 36-year simulation (1980-2015) with the new Geophysical Fluid Dynamics Laboratory (GFDL) atmospheric and land model (AM4-LM4) using the latest CMIP6 inventory of emission of aerosols, GHGs and other forcing agents, with a 50 km resolution, and nudging of wind components by NCEP re-analysis. After briefly presenting the evaluation of AM4 performances by comparing precipitation, snow and aerosol properties with observations, we will discuss the key features of the variability and trends of snow and aerosol deposition over major mountain ranges in North America (Alaska and Rockies), South America (Andes), Europe (Alps), and Central (Caucasus) and East (Hindu Kush, Karakoram, Tian Shan, Hengduan, and Himalayas) Asia. While most mountain ranges have nearby sources of dust or pollutants, they are rarely collocated. This will translate into distinct spatial distributions and temporal variations. One important factor is the vertical distribution of aerosol deposition, which generally does not coincide with maximum snow depth. Regional sources have their maximum deposition rates on the flank of the mountain with large contribution from dry deposition. Remote sources will contribute dominantly by wet deposition at higher elevation. We can then classify mountain ranges where one or both aerosol depositions are in phase or out of phase with the snow accumulation season. Our results indicate considerable variability of aerosol deposition between mountain ranges, and the importance of taking into account their spatial and seasonal variability. We are also able to classify high mountain snowpack with significant trends of aerosol deposition since the 1980s. The sign of these trends varies not only between mountain ranges, but also by aerosol classification within a single range, highlighting the importance of regional aerosol-snowpack assessments.</td>
</tr>
<tr id="bib_Ginoux_etal__2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@inproceedings{Ginoux_etal__2018a,
  author = {Ginoux, P. and Kapnick, S. and Malyshev, S. and Chan, V. and Guo, H. and Milly, C. and Naik, V. and Pascale, S. and Pu, B. and Shevliakova, E. and Zhao, M.},
  title = {Analysis of aerosol deposition on snowpack over global high mountain ranges},
  booktitle = {EGU General Assembly Conference Abstracts},
  year = {2018},
  volume = {20},
  pages = {10062},
  url = {http://adsabs.harvard.edu/abs/2018EGUGA..2010062G}
}
</pre></td>
</tr>
<tr id="Haustein_etal__2009a" class="entry">
	<td>Haustein, K., P&eacute;rez, C., Jorba, O., Baldasano, J.M., Janjic, Z., Black, T. and Nickovic, S.</td>
	<td>NMMB/BSC-DUST: an online mineral dust atmospheric model from meso to global scales <p class="infolinks">[<a href="javascript:toggleInfo('Haustein_etal__2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Haustein_etal__2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td><br/>Vol. 11EGU General Assembly Conference Abstracts, pp. 11057&nbsp;</td>
	<td>inproceedings</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009EGUGA..1111057H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Haustein_etal__2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: While mineral dust distribution and effects are important at global scales, they strongly depend on dust emissions that are controlled on small spatial and temporal scales. Most global dust models use prescribed wind fields provided by meteorological centers (e.g., NCEP and ECMWF) and their spatial resolution is currently never better than about 1deg&times;1deg. Regional dust models offer substantially higher resolution (10-20 km) and are typically coupled with weather forecast models that simulate processes that GCMs either cannot resolve or can resolve only poorly. These include internal circulation features such as the low-level nocturnal jet which is a crucial feature for dust emission in several dust lsquohot spot' sources in North Africa. Based on our modeling experience with the BSC-DREAM regional forecast model (http://www.bsc.es/projects/earthscience/DREAM/) we are currently implementing an improved mineral dust model [P&eacute;rez et al., 2008] coupled online with the new global/regional NMMB atmospheric model under development in NOAA/NCEP/EMC [Janjic, 2005]. The NMMB is an evolution of the operational WRF-NMME extending from meso to global scales. The NMMB will become the next-generation NCEP model for operational weather forecast in 2010. The corresponding unified non-hydrostatic dynamical core ranges from meso to global scale allowing regional and global simulations. It has got an add-on non-hydrostatic module and it is based on the Arakawa B-grid and hybrid pressure-sigma vertical coordinates. NMMB is fully embedded into the Earth System Modeling Framework (ESMF), treating dynamics and physics separately and coupling them easily within the ESMF structure. Our main goal is to provide global dust forecasts up to 7 days at mesoscale resolutions.  New features of the model include a physically-based dust emission scheme after White [1979], Iversen and White [1982] and Marticorena and Bergametti [1995] that takes the effects of saltation and sandblasting into account. Viscous sublayer approach [Janjic, 1994] for dust injection in the lower atmosphere is maintained as applied in DREAM [Nickovic et al., 2001]. Soil moisture effects are considered following Fecan et al. [1999]. A new source function for the land surface is calculated using the USGS 1km landuse database, the NESDIS 5-years monthly climatology for the vegetation fraction, and preferential source areas according the topographic approach after Ginoux et al. [2001]. Furthermore, 4 top soil texture classes (coarse sand, fine/medium sand, silt, clay) are introduced, based on the new STASGO-FAO 1km soil database and modified following Tegen et al. [2002]. The dry deposition scheme accounts for the effects of sedimentation and turbulent mixout following the approach of Giorgi [1986]. Finally, in-cloud and below-cloud wet scavenging for grid-scale and convective precipitation is applied following Slinn [1983; 1984] and Loosmore and Cederwall [2004]. Dust radiative feedback on meteorology is not yet considered.  In order to explore the assets and drawbacks of the new model, we perform global simulations of the dust cycle at 0.3degx0.45deg to demonstrate the ability of the model to capture the large scale and seasonal patterns. These fundamental evaluations serve as starting point for further testing as well as future developments of the NMMb-DUST. In a second step, we study the behavior of the model during the SAMUM-I phase [Haustein et al., 2009] and the BODEX campaign [Todd et al., 2008], focusing on how the model reproduces moist convection and low level jet in North Africa at mesoscale resolutions.    References:  Fecan, F., B. Marticorena and G. Bergametti. (1999). Parameterization of the increase of the aeolian erosion threshold wind friction velocity due to soil moisture for arid and semi arid areas. Annales Geophysicae, 17, 149-157.  Ginoux, P. et al. (2001). Sources and distribution of dust aerosols simulated with the GOCART model. J. Geophys. Res., 106, D17, 20255-20273.  Giorgi, F. (1986). A particle dry-deposition parameterization scheme for use in tracer transport models. J. Geophys. Res., 91, 9794-9804.  Haustein, K. et al. (2009). Regional dust model performance during SAMUM-I 2006. Geophys. Res. Letters, in press.  Iversen, J.D. and B. R. White (1982). Saltation threshold on Earth, Mars and Venus. Sedimentology, 29, 111-119.  Janjic, Z. I. (1994). The Step-Mountain Eta Coordinate Model: Further Developments of the Convection, Viscous Sublayer, and Turbulence Closure Schemes. Monthly Weather Review, 122, 927-945.  Janjic, Z. I. (2005). A unified model approach from meso to global scales. Geophysical Research Abstracts, 7, 05582, 2005, EGU05-A-05582.  Loosmore, G. A. and Cederwall, R. T. (2004). Precipitation scavenging of atmospheric aerosols for emergency response applications: testing an updated model with new real-time data. Atmospheric Environment, 38, 993-1003. Marticorena, B. and G. Bergametti (1995). Modeling the atmospheric dust cycle: 1. Design of a soil-derived dust emission scheme. J. Geophys. Res., 100, D8, 16415-16430.  Nickovic, S., G. Kallos, A. Papadopoulos, and O. Kakaliagou (2001). A model for prediction of desert dust cycle in the atmosphere. Journal of Geophysical Research 106, D16, 18113-18129. P&eacute;rez, C. et al. (2008). An online mineral dust model within the global/regional NMMB: Current progress and plans. AGU Fall Meeting, 14-19 December 2008, San Francisco, USA.  Slinn, W. G. N. (1983). A potpourri of deposition and resuspension questions. In: Pruppacher, Semonin and Slinn (Editors), Precip. Scavenging., Dry Deposition, and Resuspension. Elsevier, New York (1983), 1361-1416.  Slinn, W.G.N. (1984). Precipitation scavenging. In: Randerson, D. (Editor), Atmospheric Science and Power Production. OSTI, Oak Ridge, 466-532. Tegen, I. et al. (2002). Impact of vegetation and preferential source areas on global dust aerosol: Results from a model study. J. Geophys. Res., 107, D21, doi:10.1029/2001JD000963.  Todd, M. (2008). Quantifying uncertainty in estimates of mineral dust flux: An intercomparison of model performance over the Bodele Depression, northern Chad. J. Geophys. Res., 113, D24107, doi:10.1029/2008JD010476.  White, B. (1979). Soil transport by winds on Mars. J. Geophys. Res., 84, 4643-4651.</td>
</tr>
<tr id="bib_Haustein_etal__2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@inproceedings{Haustein_etal__2009a,
  author = {Haustein, K. and P&eacute;rez, C. and Jorba, O. and Baldasano, J. M. and Janjic, Z. and Black, T. and Nickovic, S.},
  title = {NMMB/BSC-DUST: an online mineral dust atmospheric model from meso to global scales},
  booktitle = {EGU General Assembly Conference Abstracts},
  year = {2009},
  volume = {11},
  pages = {11057},
  url = {http://adsabs.harvard.edu/abs/2009EGUGA..1111057H}
}
</pre></td>
</tr>
<tr id="Mallet_etal__2018a" class="entry">
	<td>Mallet, M.D., Bourrianne, T., Burnet, F., Cazaunau, M., Doussin, J.-F., Feron, A., Landsheere, X., Perrin, T., Richard, P., Waquet, F., Flamant, C., Gaetani, M., Cuesta, J., D'Anna, B. and Formenti, P.</td>
	<td>In situ size and optical properties of dust and biomass burning aerosol over Namibia during the 2017 AEROCLO-sA project <p class="infolinks">[<a href="javascript:toggleInfo('Mallet_etal__2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Mallet_etal__2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td><br/>Vol. 20EGU General Assembly Conference Abstracts, pp. 14002&nbsp;</td>
	<td>inproceedings</td>
	<td><a href="http://adsabs.harvard.edu/abs/2018EGUGA..2014002M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Mallet_etal__2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The south-east Atlantic Ocean off the west coast of Namibia in southern Africa is a very unique environment with complex atmospheric processes that have wide-spread repercussions (Myhre et al., 2013). Low sea-surface temperatures off the coast are partially responsible for a semi-permanent stratocumulus cloud deck, an extremely effective cloud regime in reflecting short-wave radiation. Frequent upwelling of dust, lofting biomass burning plumes from extensive fires across southern Africa, marine aerosols and both urban and shipping pollution contribute to the aerosol burden in this region (van der Werf et al., 2010; Ginoux et al., 2012; Formenti et al., 1999; Rap et al., 2013).  The AEROCLO-sA (AErosols, RadiatOn and CLOuds in southern Africa) project was undertaken in August and September of 2017 with extensive aerosol in situ and remote sensing measurements from the PEGASUS mobile station at Henties Bay, Namibia, and on board the SAFIRE Falcon-20 across the Namibian land and coast. During this period, high concentrations of biomass burning aerosol transported from central Africa were observed within the troposphere and dust and sea salt was observed in the lower troposphere. These were observed in cloud-free regimes as well as below and above the cloud deck. This presentation will show the first results of aerosol size distributions and optical properties at the ground station and from the aircraft measurements during AEROCLO-sA.  In preparation for the future launch of the EUMETSAT Polar System - Second Generation launch of new satellites and remote sensing instrumentation, these in situ aerosol size and optical measurements will be used to validate retrieval products from recently developed algorithms that will utilize the remote sensing instrumentation. Finally, these measurements will be implemented within regional climate models to assist in the constraint of radiative forcing uncertainties.  References Formenti, P., Piketh, S., and Annegarn, H.: Detection of non-sea salt sulphate aerosol at a remote coastal site in South Africa: A PIXE study, Nuclear Instruments and Methods in Physics Research Section B: Beam Interactions with Materials and Atoms, 150, 332-338, 1999. Ginoux, P., Prospero, J. M., Gill, T. E., Hsu, N. C., and Zhao, M.: Global-scale attribution of anthropogenic and natural dust sources and their emission rates based on MODIS Deep Blue aerosol products, Reviews of Geophysics, 50, 2012. Myhre, G., Samset, B., Schulz, M., Balkanski, Y., Bauer, S., Berntsen, T., Bian, H., Bellouin, N., Chin, M., and Diehl, T.: Radiative forcing of the direct aerosol effect from AeroCom Phase II simulations, Atmospheric Chemistry and Physics, 13, 1853, 2013. Rap, A., Scott, C. E., Spracklen, D. V., Bellouin, N., Forster, P. M., Carslaw, K. S., Schmidt, A., and Mann, G.: Natural aerosol direct and indirect radiative effects, Geophysical Research Letters, 40, 3297-3301, 2013. van der Werf, G. R., Randerson, J. T., Giglio, L., Collatz, G., Mu, M., Kasibhatla, P. S., Morton, D. C., DeFries, R., Jin, Y. v., and van Leeuwen, T. T.: Global fire emissions and the contribution of deforestation, savanna, forest, agricultural, and peat fires (1997-2009), Atmospheric Chemistry and Physics, 10, 11707-11735, 2010.</td>
</tr>
<tr id="bib_Mallet_etal__2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@inproceedings{Mallet_etal__2018a,
  author = {Mallet, M. D. and Bourrianne, T. and Burnet, F. and Cazaunau, M. and Doussin, J.-F. and Feron, A. and Landsheere, X. and Perrin, T. and Richard, P. and Waquet, F. and Flamant, C. and Gaetani, M. and Cuesta, J. and D'Anna, B. and Formenti, P.},
  title = {In situ size and optical properties of dust and biomass burning aerosol over Namibia during the 2017 AEROCLO-sA project},
  booktitle = {EGU General Assembly Conference Abstracts},
  year = {2018},
  volume = {20},
  pages = {14002},
  url = {http://adsabs.harvard.edu/abs/2018EGUGA..2014002M}
}
</pre></td>
</tr>
<tr id="Murray_etal__2013a" class="entry">
	<td>Murray, J.E., Brindley, H.E., Bryant, R.G., Russell, J.E. and Jenkins, K.F.</td>
	<td>Enhancing weak transient signals in SEVIRI false colour imagery: application to dust source detection in southern Africa <p class="infolinks">[<a href="javascript:toggleInfo('Murray_etal__2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Murray_etal__2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td><br/>Vol. 15EGU General Assembly Conference Abstracts, pp. EGU2013-5363&nbsp;</td>
	<td>inproceedings</td>
	<td><a href="http://adsabs.harvard.edu/abs/2013EGUGA..15.5363M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Murray_etal__2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Understanding the processes governing the availability and entrainment of mineral dust  into the atmosphere requires dust sources to be identified and the evolution of dust events to be monitored. To achieve this aim a wide range of approaches have been developed utilising observations from a variety of different satellite sensors. Global maps of source regions and their relative strengths have been derived from instruments in low Earth orbit (e.g. Total Ozone Monitoring Spectrometer (TOMS) (Prospero et al., 2002), MODerate resolution Imaging Spectrometer (MODIS) (Ginoux et al., 2012)). Instruments such as MODIS can also be used to improve precise source location (Baddock et al., 2009) but the information available is restricted to the satellite overpass times which may not be coincident with active dust emission from the source. Hence, at a regional scale, some of the more successful approaches used to characterise the activity of different sources use high temporal resolution data available from instruments in geostationary orbit. For example, the widely used red-green-blue (RGB) dust scheme developed by Lensky and Rosenfeld (2008) (hereafter LR2008) makes use of observations from selected thermal channels of the Spinning Enhanced Visible and InfraRed Imager (SEVIRI) in a false colour rendering scheme in which dust appears pink. This scheme has provided the basis for numerous studies of north African dust sources and factors governing their activation (e.g. Schepanski et al., 2007, 2009, 2012).  However, the LR2008 imagery can fail to identify dust events due to the effects of atmospheric moisture, variations in dust layer height and optical properties, and surface conditions (Brindley et al., 2012).  Here we introduce a new method designed to circumvent some of these issues and enhance the signature of dust events using observations from SEVIRI. The approach involves the derivation of a composite clear-sky signal for selected channels on an individual time-step and pixel basis. These composite signals are subtracted from each observation in the relevant channels to enhance weak transient signals associated with low levels of dust emission.  Different channel combinations are then rendered in false colour imagery to better identify dust source locations and activity. We have applied this new clear-sky difference (CSD) algorithm over three key source regions in southern Africa: the Makgadikgadi Basin, Etosha Pan, and the Namibian and western South African coast. Case studies indicate that advantages associated with the CSD approach include an improved ability to detect dust and distinguish multiple sources, the observation of source activation earlier in the diurnal cycle, and an improved ability to pinpoint dust source locations. These advantages are confirmed by a survey of four-years of data, comparing the results obtained using the CSD technique with those derived from LR2008 dust imagery. On average the new algorithm more than doubles the number of dust events identified, with the greatest improvement for the Makgadigkadi Basin and coastal regions.  We anticipate exploiting this new activation record derived using the CSD approach to better understand the surface and meteorological conditions controlling dust uplift and subsequent atmospheric transport.</td>
</tr>
<tr id="bib_Murray_etal__2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@inproceedings{Murray_etal__2013a,
  author = {Murray, J. E. and Brindley, H. E. and Bryant, R. G. and Russell, J. E. and Jenkins, K. F.},
  title = {Enhancing weak transient signals in SEVIRI false colour imagery: application to dust source detection in southern Africa},
  booktitle = {EGU General Assembly Conference Abstracts},
  year = {2013},
  volume = {15},
  pages = {EGU2013-5363},
  url = {http://adsabs.harvard.edu/abs/2013EGUGA..15.5363M}
}
</pre></td>
</tr>
<tr id="Eyring_etal_ESD_2016a" class="entry">
	<td>Eyring, V., Gleckler, P.J., Heinze, C., Stouffer, R.J., Taylor, K.E., Balaji, V., Guilyardi, E., Joussaume, S., Kindermann, S., Lawrence, B.N., Meehl, G.A., Righi, M. and Williams, D.N.</td>
	<td>Towards improved and more routine Earth system model evaluation in CMIP <p class="infolinks">[<a href="javascript:toggleInfo('Eyring_etal_ESD_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Earth System Dynamics<br/>Vol. 7(4), pp. 813-830&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/esd-7-813-2016">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Eyring_etal_ESD_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Eyring_etal_ESD_2016a,
  author = {Veronika Eyring and Peter J. Gleckler and Christoph Heinze and Ronald J. Stouffer and Karl E. Taylor and V. Balaji and Eric Guilyardi and Sylvie Joussaume and Stephan Kindermann and Bryan N. Lawrence and Gerald A. Meehl and Mattia Righi and Dean N. Williams},
  title = {Towards improved and more routine Earth system model evaluation in CMIP},
  journal = {Earth System Dynamics},
  publisher = {Copernicus GmbH},
  year = {2016},
  volume = {7},
  number = {4},
  pages = {813--830},
  doi = {https://doi.org/10.5194/esd-7-813-2016}
}
</pre></td>
</tr>
<tr id="Gregg_etal_DSRPITSiO_2003a" class="entry">
	<td>Gregg, W.W., Ginoux, P., Schopf, P.S. and Casey, N.W.</td>
	<td>Phytoplankton and iron: validation of a global three-dimensional ocean biogeochemical model <p class="infolinks">[<a href="javascript:toggleInfo('Gregg_etal_DSRPITSiO_2003a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Gregg_etal_DSRPITSiO_2003a','bibtex')">BibTeX</a>]</p></td>
	<td>2003</td>
	<td>Deep Sea Research Part II: Topical Studies in Oceanography<br/>Vol. 50, pp. 3143-3169&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.dsr2.2003.07.013">DOI</a> <a href="http://adsabs.harvard.edu/abs/2003DSRII..50.3143G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Gregg_etal_DSRPITSiO_2003a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The JGOFS program and NASA ocean-color satellites have provided a wealth of data that can be used to test and validate models of ocean biogeochemistry. A coupled three-dimensional general circulation, biogeochemical, and radiative model of the global oceans was validated using these in situ data sources and satellite data sets. Biogeochemical processes in the model were determined from the influences of circulation and turbulence dynamics, irradiance availability, and the interactions among four phytoplankton functional groups (diatoms, chlorophytes, cyanobacteria, and coccolithophores) and four nutrients (nitrate, ammonium, silica, and dissolved iron). Annual mean log-transformed dissolved iron concentrations in the model were statistically positively correlated on basin scale with observations ( Plt0.05) over the eight (out of 12) major oceanographic basins where data were available. The model tended to overestimate in situ observations, except in the Antarctic where a large underestimate occurred. Inadequate scavenging and excessive remineralization and/or regeneration were possible reasons for the overestimation. Basin scale model chlorophyll seasonal distributions were positively correlated with SeaWiFS chlorophyll in each of the 12 oceanographic basins ( Plt0.05). The global mean difference was 3.9&#37; (model higher than SeaWiFS). The four phytoplankton groups were initialized as homogeneous and equal distributions throughout the model domain. After 26 years of simulation, they arrived at reasonable distributions throughout the global oceans: diatoms predominated high latitudes, coastal, and equatorial upwelling areas, cyanobacteria predominated the mid-ocean gyres, and chlorophytes and coccolithophores represented transitional assemblages. Seasonal patterns exhibited a range of relative responses: from a seasonal succession in the North Atlantic with coccolithophores replacing diatoms as the dominant group in mid-summer, to successional patterns with cyanobacteria replacing diatoms in mid-summer in the central North Pacific. Diatoms were associated with regions where nutrient availability was high. Cyanobacteria predominated in quiescent regions with low nutrients. While the overall patterns of phytoplankton functional group distributions exhibited broad qualitative agreement with in situ data, quantitative comparisons were mixed. Three of the four phytoplankton groups exhibited statistically significant correspondence across basins. Diatoms did not. Some basins exhibited excellent correspondence, while most showed moderate agreement, with two functional groups in agreement with data and the other two in disagreement. The results are encouraging for a first attempt at simulating functional groups in a global coupled three-dimensional model but many issues remain.</td>
</tr>
<tr id="bib_Gregg_etal_DSRPITSiO_2003a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Gregg_etal_DSRPITSiO_2003a,
  author = {Gregg, W. W. and Ginoux, P. and Schopf, P. S. and Casey, N. W.},
  title = {Phytoplankton and iron: validation of a global three-dimensional ocean biogeochemical model},
  journal = {Deep Sea Research Part II: Topical Studies in Oceanography},
  year = {2003},
  volume = {50},
  pages = {3143-3169},
  url = {http://adsabs.harvard.edu/abs/2003DSRII..50.3143G},
  doi = {https://doi.org/10.1016/j.dsr2.2003.07.013}
}
</pre></td>
</tr>
<tr id="Carslaw_etal_CCCR_2017a" class="entry">
	<td>Carslaw, K.S., Gordon, H., Hamilton, D.S., Johnson, J.S., Regayre, L.A., Yoshioka, M. and Pringle, K.J.</td>
	<td>Aerosols in the Pre-industrial Atmosphere <p class="infolinks">[<a href="javascript:toggleInfo('Carslaw_etal_CCCR_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Current Climate Change Reports<br/>Vol. 3(1), pp. 1-15&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s40641-017-0061-2">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Carslaw_etal_CCCR_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Carslaw_etal_CCCR_2017a,
  author = {Kenneth S. Carslaw and Hamish Gordon and Douglas S. Hamilton and Jill S. Johnson and Leighton A. Regayre and M. Yoshioka and Kirsty J. Pringle},
  title = {Aerosols in the Pre-industrial Atmosphere},
  journal = {Current Climate Change Reports},
  publisher = {Springer Nature},
  year = {2017},
  volume = {3},
  number = {1},
  pages = {1--15},
  doi = {https://doi.org/10.1007/s40641-017-0061-2}
}
</pre></td>
</tr>
<tr id="Lambert_etal_CotP_2012a" class="entry">
	<td>Lambert, F., Bigler, M., Steffensen, J.P., Hutterli, M. and Fischer, H.</td>
	<td>Centennial mineral dust variability in high-resolution ice core data from Dome C, Antarctica <p class="infolinks">[<a href="javascript:toggleInfo('Lambert_etal_CotP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Lambert_etal_CotP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Climate of the Past<br/>Vol. 8, pp. 609-623&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/cp-8-609-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012CliPa...8..609L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Lambert_etal_CotP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Ice core data from Antarctica provide detailed insights into the
<br>characteristics of past climate, atmospheric circulation, as well as
<br>changes in the aerosol load of the atmosphere. We present
<br>high-resolution records of soluble calcium (Ca^2+),
<br>non-sea-salt soluble calcium (nssCa^2+), and particulate
<br>mineral dust aerosol from the East Antarctic Plateau at a depth
<br>resolution of 1 cm, spanning the past 800 000 years. Despite the fact
<br>that all three parameters are largely dust-derived, the ratio of
<br>nssCa^2+ to particulate dust is dependent on the particulate
<br>dust concentration itself. We used principal component analysis to
<br>extract the joint climatic signal and produce a common high-resolution
<br>record of dust flux. This new record is used to identify Antarctic
<br>warming events during the past eight glacial periods. The phasing of
<br>dust flux and CO_2 changes during glacial-interglacial
<br>transitions reveals that iron fertilization of the Southern Ocean during
<br>the past nine glacial terminations was not the dominant factor in the
<br>deglacial rise of CO_2 concentrations. Rapid changes in dust
<br>flux during glacial terminations and Antarctic warming events point to a
<br>rapid response of the southern westerly wind belt in the region of
<br>southern South American dust sources on changing climate conditions. The
<br>clear lead of these dust changes on temperature rise suggests that an
<br>atmospheric reorganization occurred in the Southern Hemisphere before
<br>the Southern Ocean warmed significantly.
<br></td>
</tr>
<tr id="bib_Lambert_etal_CotP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Lambert_etal_CotP_2012a,
  author = {Lambert, F. and Bigler, M. and Steffensen, J. P. and Hutterli, M. and Fischer, H.},
  title = {Centennial mineral dust variability in high-resolution ice core data from Dome C, Antarctica},
  journal = {Climate of the Past},
  year = {2012},
  volume = {8},
  pages = {609-623},
  url = {http://adsabs.harvard.edu/abs/2012CliPa...8..609L},
  doi = {https://doi.org/10.5194/cp-8-609-2012}
}
</pre></td>
</tr>
<tr id="Claquin_etal_CD_2002a" class="entry">
	<td>Claquin, T., Roelandt, C., Kohfeld, K.E., Harrison, S.P., Tegen, I., Prentice, I.C., Balkanski, Y., Bergametti, G., Hansson, M., Mahowald, N., Rodhe, H. and Schulz, M.</td>
	<td>Radiative forcing of climate by ice-age atmospheric dust <p class="infolinks">[<a href="javascript:toggleInfo('Claquin_etal_CD_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Claquin_etal_CD_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>Climate Dynamics<br/>Vol. 20, pp. 193-202&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-002-0269-1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2002ClDy...20..193C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Claquin_etal_CD_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: During glacial periods, dust deposition rates and inferred atmospheric
<br>concentrations were globally much higher than present. According to
<br>recent model results, the large enhancement of atmospheric dust content
<br>at the last glacial maximum (LGM) can be explained only if increases in
<br>the potential dust source areas are taken into account. Such increases
<br>are to be expected, due to effects of low precipitation and low
<br>atmospheric (CO_2) on plant growth. Here the modelled
<br>three-dimensional dust fields from Mahowald et al. and modelled
<br>seasonally varying surface-albedo fields derived in a parallel manner,
<br>are used to quantify the mean radiative forcing due to modern
<br>(non-anthropogenic) and LGM dust. The effect of mineralogical provenance
<br>on the radiative properties of the dust is taken into account, as is the
<br>range of optical properties associated with uncertainties about the
<br>mixing state of the dust particles. The high-latitude (poleward of
<br>45deg) mean change in forcing (LGM minus modern) is estimated to be
<br>small (-0.9 to +0.2 W m^-2), especially when compared to
<br>nearly -20 W m^-2 due to reflection from the extended ice
<br>sheets. Although the net effect of dust over ice sheets is a positive
<br>forcing (warming), much of the simulated high-latitude dust was not over
<br>the ice sheets, but over unglaciated regions close to the expanded dust
<br>source region in central Asia. In the tropics the change in forcing is
<br>estimated to be overall negative, and of similarly large magnitude (-2.2
<br>to -3.2 W m^-2) to the radiative cooling effect of low
<br>atmospheric (CO_2). Thus, the largest long-term climatic
<br>effect of the LGM dust is likely to have been a cooling of the tropics.
<br>Low tropical sea-surface temperatures, low atmospheric (CO_2)
<br>and high atmospheric dust loading may be mutually reinforcing due to
<br>multiple positive feedbacks, including the negative radiative forcing
<br>effect of dust.
<br></td>
</tr>
<tr id="bib_Claquin_etal_CD_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Claquin_etal_CD_2002a,
  author = {Claquin, T. and Roelandt, C. and Kohfeld, K. E. and Harrison, S. P. and Tegen, I. and Prentice, I. C. and Balkanski, Y. and Bergametti, G. and Hansson, M. and Mahowald, N. and Rodhe, H. and Schulz, M.},
  title = {Radiative forcing of climate by ice-age atmospheric dust},
  journal = {Climate Dynamics},
  year = {2002},
  volume = {20},
  pages = {193-202},
  url = {http://adsabs.harvard.edu/abs/2002ClDy...20..193C},
  doi = {https://doi.org/10.1007/s00382-002-0269-1}
}
</pre></td>
</tr>
<tr id="Dufresne_etal_CD_2013a" class="entry">
	<td>Dufresne, J.-L., Foujols, M.-A., Denvil, S., Caubel, A., Marti, O., Aumont, O., Balkanski, Y., Bekki, S., Bellenger, H., Benshila, R., Bony, S., Bopp, L., Braconnot, P., Brockmann, P., Cadule, P., Cheruy, F., Codron, F., Cozic, A., Cugnet, D., de Noblet, N., Duvel, J.-P., Eth&eacute;, C., Fairhead, L., Fichefet, T., Flavoni, S., Friedlingstein, P., Grandpeix, J.-Y., Guez, L., Guilyardi, E., Hauglustaine, D., Hourdin, F., Idelkadi, A., Ghattas, J., Joussaume, S., Kageyama, M., Krinner, G., Labetoulle, S., Lahellec, A., Lefebvre, M.-P., Lefevre, F., Levy, C., Li, Z.X., Lloyd, J., Lott, F., Madec, G., Mancip, M., Marchand, M., Masson, S., Meurdesoif, Y., Mignot, J., Musat, I., Parouty, S., Polcher, J., Rio, C., Schulz, M., Swingedouw, D., Szopa, S., Talandier, C., Terray, P., Viovy, N. and Vuichard, N.</td>
	<td>Climate change projections using the IPSL-CM5 Earth System Model: from CMIP3 to CMIP5 <p class="infolinks">[<a href="javascript:toggleInfo('Dufresne_etal_CD_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dufresne_etal_CD_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Climate Dynamics<br/>Vol. 40(9-10), pp. 2123-2165&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-012-1636-1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013ClDy...40.2123D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dufresne_etal_CD_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present the global general circulation model IPSL-CM5 developed to
<br>study the long-term response of the climate system to natural and
<br>anthropogenic forcings as part of the 5th Phase of the Coupled Model
<br>Intercomparison Project (CMIP5). This model includes an interactive
<br>carbon cycle, a representation of tropospheric and stratospheric
<br>chemistry, and a comprehensive representation of aerosols. As it
<br>represents the principal dynamical, physical, and bio-geochemical
<br>processes relevant to the climate system, it may be referred to as an
<br>Earth System Model. However, the IPSL-CM5 model may be used in a
<br>multitude of configurations associated with different boundary
<br>conditions and with a range of complexities in terms of processes and
<br>interactions. This paper presents an overview of the different model
<br>components and explains how they were coupled and used to simulate
<br>historical climate changes over the past 150 years and different
<br>scenarios of future climate change. A single version of the IPSL-CM5
<br>model (IPSL-CM5A-LR) was used to provide climate projections associated
<br>with different socio-economic scenarios, including the different
<br>Representative Concentration Pathways considered by CMIP5 and several
<br>scenarios from the Special Report on Emission Scenarios considered by
<br>CMIP3. Results suggest that the magnitude of global warming projections
<br>primarily depends on the socio-economic scenario considered, that there
<br>is potential for an aggressive mitigation policy to limit global warming
<br>to about two degrees, and that the behavior of some components of the
<br>climate system such as the Arctic sea ice and the Atlantic Meridional
<br>Overturning Circulation may change drastically by the end of the
<br>twenty-first century in the case of a no climate policy scenario.
<br>Although the magnitude of regional temperature and precipitation changes
<br>depends fairly linearly on the magnitude of the projected global warming
<br>(and thus on the scenario considered), the geographical pattern of these
<br>changes is strikingly similar for the different scenarios. The
<br>representation of atmospheric physical processes in the model is shown
<br>to strongly influence the simulated climate variability and both the
<br>magnitude and pattern of the projected climate changes.
<br></td>
</tr>
<tr id="bib_Dufresne_etal_CD_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dufresne_etal_CD_2013a,
  author = {Dufresne, J.-L. and Foujols, M.-A. and Denvil, S. and Caubel, A. and Marti, O. and Aumont, O. and Balkanski, Y. and Bekki, S. and Bellenger, H. and Benshila, R. and Bony, S. and Bopp, L. and Braconnot, P. and Brockmann, P. and Cadule, P. and Cheruy, F. and Codron, F. and Cozic, A. and Cugnet, D. and de Noblet, N. and Duvel, J.-P. and Eth&eacute;, C. and Fairhead, L. and Fichefet, T. and Flavoni, S. and Friedlingstein, P. and Grandpeix, J.-Y. and Guez, L. and Guilyardi, E. and Hauglustaine, D. and Hourdin, F. and Idelkadi, A. and Ghattas, J. and Joussaume, S. and Kageyama, M. and Krinner, G. and Labetoulle, S. and Lahellec, A. and Lefebvre, M.-P. and Lefevre, F. and Levy, C. and Li, Z. X. and Lloyd, J. and Lott, F. and Madec, G. and Mancip, M. and Marchand, M. and Masson, S. and Meurdesoif, Y. and Mignot, J. and Musat, I. and Parouty, S. and Polcher, J. and Rio, C. and Schulz, M. and Swingedouw, D. and Szopa, S. and Talandier, C. and Terray, P. and Viovy, N. and Vuichard, N.},
  title = {Climate change projections using the IPSL-CM5 Earth System Model: from CMIP3 to CMIP5},
  journal = {Climate Dynamics},
  publisher = {Springer Nature},
  year = {2013},
  volume = {40},
  number = {9-10},
  pages = {2123-2165},
  url = {http://adsabs.harvard.edu/abs/2013ClDy...40.2123D},
  doi = {https://doi.org/10.1007/s00382-012-1636-1}
}
</pre></td>
</tr>
<tr id="Hourdin_etal_CD_2012a" class="entry">
	<td>Hourdin, F., Foujols, M.-A., Codron, F., Guemas, V., Dufresne, J.-L., Bony, S., Denvil, S., Guez, L., Lott, F., Ghattas, J., Braconnot, P., Marti, O., Meurdesoif, Y. and Bopp, L.</td>
	<td>Impact of the LMDZ atmospheric grid configuration on the climate and sensitivity of the IPSL-CM5A coupled model <p class="infolinks">[<a href="javascript:toggleInfo('Hourdin_etal_CD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Climate Dynamics<br/>Vol. 40(9-10), pp. 2167-2192&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-012-1411-3">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Hourdin_etal_CD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hourdin_etal_CD_2012a,
  author = {Fr&eacute;d&eacute;ric Hourdin and Marie-Alice Foujols and Francis Codron and Virginie Guemas and Jean-Louis Dufresne and Sandrine Bony and S&eacute;bastien Denvil and Lionel Guez and Fran&ccedil;ois Lott and Josefine Ghattas and Pascale Braconnot and Olivier Marti and Yann Meurdesoif and Laurent Bopp},
  title = {Impact of the LMDZ atmospheric grid configuration on the climate and sensitivity of the IPSL-CM5A coupled model},
  journal = {Climate Dynamics},
  publisher = {Springer Nature},
  year = {2012},
  volume = {40},
  number = {9-10},
  pages = {2167--2192},
  doi = {https://doi.org/10.1007/s00382-012-1411-3}
}
</pre></td>
</tr>
<tr id="Hourdin_etal_CD_2012b" class="entry">
	<td>Hourdin, F., Grandpeix, J.-Y., Rio, C., Bony, S., Jam, A., Cheruy, F., Rochetin, N., Fairhead, L., Idelkadi, A., Musat, I., Dufresne, J.-L., Lahellec, A., Lefebvre, M.-P. and Roehrig, R.</td>
	<td>LMDZ5B: the atmospheric component of the IPSL climate model with revisited parameterizations for clouds and convection <p class="infolinks">[<a href="javascript:toggleInfo('Hourdin_etal_CD_2012b','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Climate Dynamics<br/>Vol. 40(9-10), pp. 2193-2222&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-012-1343-y">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Hourdin_etal_CD_2012b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hourdin_etal_CD_2012b,
  author = {Fr&eacute;d&eacute;ric Hourdin and Jean-Yves Grandpeix and Catherine Rio and Sandrine Bony and Arnaud Jam and Fr&eacute;d&eacute;rique Cheruy and Nicolas Rochetin and Laurent Fairhead and Abderrahmane Idelkadi and Ionela Musat and Jean-Louis Dufresne and Alain Lahellec and Marie-Pierre Lefebvre and Romain Roehrig},
  title = {LMDZ5B: the atmospheric component of the IPSL climate model with revisited parameterizations for clouds and convection},
  journal = {Climate Dynamics},
  publisher = {Springer Nature},
  year = {2012},
  volume = {40},
  number = {9-10},
  pages = {2193--2222},
  doi = {https://doi.org/10.1007/s00382-012-1343-y}
}
</pre></td>
</tr>
<tr id="Krinner_etal_CD_2006a" class="entry">
	<td>Krinner, G., Boucher, O. and Balkanski, Y.</td>
	<td>Ice-free glacial northern Asia due to dust deposition on snow <p class="infolinks">[<a href="javascript:toggleInfo('Krinner_etal_CD_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Krinner_etal_CD_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Climate Dynamics<br/>Vol. 27, pp. 613-625&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-006-0159-z">DOI</a> <a href="http://adsabs.harvard.edu/abs/2006ClDy...27..613K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Krinner_etal_CD_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: During the Last Glacial Maximum (LGM, 21 kyr BP), no large ice sheets
<br>were present in northern Asia, while northern Europe and North America
<br>(except Alaska) were heavily glaciated. We use a general circulation
<br>model with high regional resolution and a new parameterization of snow
<br>albedo to show that the ice-free conditions in northern Asia during the
<br>LGM are favoured by strong glacial dust deposition on the seasonal snow
<br>cover. Our climate model simulations indicate that mineral dust
<br>deposition on the snow surface leads to low snow albedo during the melt
<br>season. This, in turn, caused enhanced snow melt and therefore favoured
<br>snow-free peak summer conditions over almost the entire Asian continent
<br>during the LGM, whereas perennial snow cover is simulated over a large
<br>part of eastern Siberia when glacial dust deposition is not taken into
<br>account.
<br></td>
</tr>
<tr id="bib_Krinner_etal_CD_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Krinner_etal_CD_2006a,
  author = {Krinner, G. and Boucher, O. and Balkanski, Y.},
  title = {Ice-free glacial northern Asia due to dust deposition on snow},
  journal = {Climate Dynamics},
  year = {2006},
  volume = {27},
  pages = {613-625},
  url = {http://adsabs.harvard.edu/abs/2006ClDy...27..613K},
  doi = {https://doi.org/10.1007/s00382-006-0159-z}
}
</pre></td>
</tr>
<tr id="Marti_etal_CD_2009a" class="entry">
	<td>Marti, O., Braconnot, P., Dufresne, J.-L., Bellier, J., Benshila, R., Bony, S., Brockmann, P., Cadule, P., Caubel, A., Codron, F., de Noblet, N., Denvil, S., Fairhead, L., Fichefet, T., Foujols, M.-A., Friedlingstein, P., Goosse, H., Grandpeix, J.-Y., Guilyardi, E., Hourdin, F., Idelkadi, A., Kageyama, M., Krinner, G., L&eacute;vy, C., Madec, G., Mignot, J., Musat, I., Swingedouw, D. and Talandier, C.</td>
	<td>Key features of the IPSL ocean atmosphere model and its sensitivity to atmospheric resolution <p class="infolinks">[<a href="javascript:toggleInfo('Marti_etal_CD_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Climate Dynamics<br/>Vol. 34(1), pp. 1-26&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-009-0640-6">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Marti_etal_CD_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Marti_etal_CD_2009a,
  author = {Olivier Marti and P. Braconnot and J.-L. Dufresne and J. Bellier and R. Benshila and S. Bony and P. Brockmann and P. Cadule and A. Caubel and F. Codron and N. de Noblet and S. Denvil and L. Fairhead and T. Fichefet and M.-A. Foujols and P. Friedlingstein and H. Goosse and J.-Y. Grandpeix and E. Guilyardi and F. Hourdin and A. Idelkadi and M. Kageyama and G. Krinner and C. L&eacute;vy and G. Madec and J. Mignot and I. Musat and D. Swingedouw and C. Talandier},
  title = {Key features of the IPSL ocean atmosphere model and its sensitivity to atmospheric resolution},
  journal = {Climate Dynamics},
  publisher = {Springer Nature},
  year = {2009},
  volume = {34},
  number = {1},
  pages = {1--26},
  doi = {https://doi.org/10.1007/s00382-009-0640-6}
}
</pre></td>
</tr>
<tr id="Szopa_etal_CD_2013a" class="entry">
	<td>Szopa, S., Balkanski, Y., Schulz, M., Bekki, S., Cugnet, D., Fortems-Cheiney, A., Turquety, S., Cozic, A., D&eacute;andreis, C., Hauglustaine, D., Idelkadi, A., Lathi&egrave;re, J., Lefevre, F., Marchand, M., Vuolo, R., Yan, N. and Dufresne, J.-L.</td>
	<td>Aerosol and ozone changes as forcing for climate evolution between 1850 and 2100 <p class="infolinks">[<a href="javascript:toggleInfo('Szopa_etal_CD_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Szopa_etal_CD_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Climate Dynamics<br/>Vol. 40, pp. 2223-2250&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-012-1408-y">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013ClDy...40.2223S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Szopa_etal_CD_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Global aerosol and ozone distributions and their associated radiative
<br>forcings were simulated between 1850 and 2100 following a recent
<br>historical emission dataset and under the representative concentration
<br>pathways (RCP) for the future. These simulations were used in an Earth
<br>System Model to account for the changes in both radiatively and
<br>chemically active compounds, when simulating the climate evolution. The
<br>past negative stratospheric ozone trends result in a negative climate
<br>forcing culminating at -0.15 W m^-2 in the 1990s. In the
<br>meantime, the tropospheric ozone burden increase generates a positive
<br>climate forcing peaking at 0.41 W m^-2. The future evolution
<br>of ozone strongly depends on the RCP scenario considered. In RCP4.5 and
<br>RCP6.0, the evolution of both stratospheric and tropospheric ozone
<br>generate relatively weak radiative forcing changes until 2060-2070
<br>followed by a relative 30 &#37; decrease in radiative forcing by 2100. In
<br>contrast, RCP8.5 and RCP2.6 model projections exhibit strongly different
<br>ozone radiative forcing trajectories. In the RCP2.6 scenario, both
<br>effects (stratospheric ozone, a negative forcing, and tropospheric
<br>ozone, a positive forcing) decline towards 1950s values while they both
<br>get stronger in the RCP8.5 scenario. Over the twentieth century, the
<br>evolution of the total aerosol burden is characterized by a strong
<br>increase after World War II until the middle of the 1980s followed by a
<br>stabilization during the last decade due to the strong decrease in
<br>sulfates in OECD countries since the 1970s. The cooling effects reach
<br>their maximal values in 1980, with -0.34 and -0.28 W m^-2
<br>respectively for direct and indirect total radiative forcings. According
<br>to the RCP scenarios, the aerosol content, after peaking around 2010, is
<br>projected to decline strongly and monotonically during the twenty-first
<br>century for the RCP8.5, 4.5 and 2.6 scenarios. While for RCP6.0 the
<br>decline occurs later, after peaking around 2050. As a consequence the
<br>relative importance of the total cooling effect of aerosols becomes
<br>weaker throughout the twenty-first century compared with the positive
<br>forcing of greenhouse gases. Nevertheless, both surface ozone and
<br>aerosol content show very different regional features depending on the
<br>future scenario considered. Hence, in 2050, surface ozone changes vary
<br>between -12 and +12 ppbv over Asia depending on the RCP projection,
<br>whereas the regional direct aerosol radiative forcing can locally exceed
<br>-3 W m^-2.
<br></td>
</tr>
<tr id="bib_Szopa_etal_CD_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Szopa_etal_CD_2013a,
  author = {Szopa, S. and Balkanski, Y. and Schulz, M. and Bekki, S. and Cugnet, D. and Fortems-Cheiney, A. and Turquety, S. and Cozic, A. and D&eacute;andreis, C. and Hauglustaine, D. and Idelkadi, A. and Lathi&egrave;re, J. and Lefevre, F. and Marchand, M. and Vuolo, R. and Yan, N. and Dufresne, J.-L.},
  title = {Aerosol and ozone changes as forcing for climate evolution between 1850 and 2100},
  journal = {Climate Dynamics},
  year = {2013},
  volume = {40},
  pages = {2223-2250},
  url = {http://adsabs.harvard.edu/abs/2013ClDy...40.2223S},
  doi = {https://doi.org/10.1007/s00382-012-1408-y}
}
</pre></td>
</tr>
<tr id="Voldoire_etal_CD_2012a" class="entry">
	<td>Voldoire, A., Sanchez-Gomez, E., y M&eacute;lia, D.S., Decharme, B., Cassou, C., S&eacute;n&eacute;si, S., Valcke, S., Beau, I., Alias, A., Chevallier, M., D&eacute;qu&eacute;, M., Deshayes, J., Douville, H., Fernandez, E., Madec, G., Maisonnave, E., Moine, M.-P., Planton, S., Saint-Martin, D., Szopa, S., Tyteca, S., Alkama, R., Belamari, S., Braun, A., Coquart, L. and Chauvin, F.</td>
	<td>The CNRM-CM5.1 global climate model: description and basic evaluation <p class="infolinks">[<a href="javascript:toggleInfo('Voldoire_etal_CD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Climate Dynamics<br/>Vol. 40(9-10), pp. 2091-2121&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00382-011-1259-y">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Voldoire_etal_CD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Voldoire_etal_CD_2012a,
  author = {A. Voldoire and E. Sanchez-Gomez and D. Salas y M&eacute;lia and B. Decharme and C. Cassou and S. S&eacute;n&eacute;si and S. Valcke and I. Beau and A. Alias and M. Chevallier and M. D&eacute;qu&eacute; and J. Deshayes and H. Douville and E. Fernandez and G. Madec and E. Maisonnave and M.-P. Moine and S. Planton and D. Saint-Martin and S. Szopa and S. Tyteca and R. Alkama and S. Belamari and A. Braun and L. Coquart and F. Chauvin},
  title = {The CNRM-CM5.1 global climate model: description and basic evaluation},
  journal = {Climate Dynamics},
  publisher = {Springer Nature},
  year = {2012},
  volume = {40},
  number = {9-10},
  pages = {2091--2121},
  doi = {https://doi.org/10.1007/s00382-011-1259-y}
}
</pre></td>
</tr>
<tr id="Hurrell_etal_BotAMS_2013a" class="entry">
	<td>Hurrell, J.W., Holland, M.M., Gent, P.R., Ghan, S., Kay, J.E., Kushner, P.J., Lamarque, J.-F., Large, W.G., Lawrence, D., Lindsay, K., Lipscomb, W.H., Long, M.C., Mahowald, N., Marsh, D.R., Neale, R.B., Rasch, P., Vavrus, S., Vertenstein, M., Bader, D., Collins, W.D., Hack, J.J., Kiehl, J. and Marshall, S.</td>
	<td>The Community Earth System Model: A Framework for Collaborative Research <p class="infolinks">[<a href="javascript:toggleInfo('Hurrell_etal_BotAMS_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Bulletin of the American Meteorological Society<br/>Vol. 94, pp. 1339-1360&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1175/BAMS-D-12-00121.1">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013BAMS...94.1339H">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Hurrell_etal_BotAMS_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hurrell_etal_BotAMS_2013a,
  author = {Hurrell, J. W. and Holland, M. M. and Gent, P. R. and Ghan, S. and Kay, J. E. and Kushner, P. J. and Lamarque, J.-F. and Large, W. G. and Lawrence, D. and Lindsay, K. and Lipscomb, W. H. and Long, M. C. and Mahowald, N. and Marsh, D. R. and Neale, R. B. and Rasch, P. and Vavrus, S. and Vertenstein, M. and Bader, D. and Collins, W. D. and Hack, J. J. and Kiehl, J. and Marshall, S.},
  title = {The Community Earth System Model: A Framework for Collaborative Research},
  journal = {Bulletin of the American Meteorological Society},
  year = {2013},
  volume = {94},
  pages = {1339-1360},
  url = {http://adsabs.harvard.edu/abs/2013BAMS...94.1339H},
  doi = {https://doi.org/10.1175/BAMS-D-12-00121.1}
}
</pre></td>
</tr>
<tr id="ChuHa_AE_2016a" class="entry">
	<td>Chu, J.-E. and Ha, K.-J.</td>
	<td>Quantifying organic aerosol single scattering albedo over the tropical biomass burning regions <p class="infolinks">[<a href="javascript:toggleInfo('ChuHa_AE_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('ChuHa_AE_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Environment<br/>Vol. 147, pp. 67-78&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2016.09.069">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016AtmEn.147...67C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_ChuHa_AE_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Despite growing evidence of light-absorbing organic aerosols (OAs), their contribution to the Earth's radiative budget is still poorly understood. In this study we derived a new empirical relationship that binds OA single scattering albedo (SSA), which is the ratio of light scattering to extinction, with sulfate + nitrate aerosol optical depth (AOD) and applied this method to estimate OA SSA over the tropical biomass burning regions. This method includes division of the attribution of black carbon (BC) and OA absorption aerosol optical depths from the Aerosol Robotic Network (AERONET) observation and determination of the fine-mode ratio of sea-salt and dust AODs from several atmospheric chemistry models. Our best estimate of OA SSA over the tropical biomass burning regions is 0.91 at 550 nm. Uncertainties associated with observations and models permit a value range of 0.82-0.93. Furthermore, by using the estimated OA SSA and comprehensive observations including AERONET, Moderate Resolution Imaging Spectroradiometer (MODIS) and Multi-angle Imaging Spectroradiometer (MISR), we examined the first global estimate of sulfate + nitrate AOD through a semi-observational approach. The global mean sulfate + nitrate AOD of 0.017 is in the lower range of the values obtained from 21 models participated in AeroCom phase II. The results imply that most aerosol models as well as climate models, which commonly use OA SSA of 0.96-1.0, have so far ignored light absorption by OAs and have overestimated light scattering by sulfate + nitrate aerosols. This indicates that the actual aerosol direct radiative forcing should be less negative than currently believed.</td>
</tr>
<tr id="bib_ChuHa_AE_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{ChuHa_AE_2016a,
  author = {Chu, J.-E. and Ha, K.-J.},
  title = {Quantifying organic aerosol single scattering albedo over the tropical biomass burning regions},
  journal = {Atmospheric Environment},
  year = {2016},
  volume = {147},
  pages = {67-78},
  url = {http://adsabs.harvard.edu/abs/2016AtmEn.147...67C},
  doi = {https://doi.org/10.1016/j.atmosenv.2016.09.069}
}
</pre></td>
</tr>
<tr id="Isaksen_etal_AE_2009a" class="entry">
	<td>Isaksen, I.S.A., Granier, C., Myhre, G., Berntsen, T.K., Dals&oslash;ren, S.B., Gauss, M., Klimont, Z., Benestad, R., Bousquet, P., Collins, W., Cox, T., Eyring, V., Fowler, D., Fuzzi, S., J&ouml;ckel, P., Laj, P., Lohmann, U., Maione, M., Monks, P., Prevot, A.S.H., Raes, F., Richter, A., Rognerud, B., Schulz, M., Shindell, D., Stevenson, D.S., Storelvmo, T., Wang, W.-C., van Weele, M., Wild, M. and Wuebbles, D.</td>
	<td>Atmospheric composition change: Climate-Chemistry interactions <p class="infolinks">[<a href="javascript:toggleInfo('Isaksen_etal_AE_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Isaksen_etal_AE_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Environment<br/>Vol. 43, pp. 5138-5192&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2009.08.003">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009AtmEn..43.5138I">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Isaksen_etal_AE_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Chemically active climate compounds are either primary compounds like methane (CH _4), removed by oxidation in the atmosphere, or secondary compounds like ozone (O _3), sulfate and organic aerosols, both formed and removed in the atmosphere. Man-induced climate-chemistry interaction is a two-way process: Emissions of pollutants change the atmospheric composition contributing to climate change through the aforementioned climate components, and climate change, through changes in temperature, dynamics, the hydrological cycle, atmospheric stability, and biosphere-atmosphere interactions, affects the atmospheric composition and oxidation processes in the troposphere. Here we present progress in our understanding of processes of importance for climate-chemistry interactions, and their contributions to changes in atmospheric composition and climate forcing. A key factor is the oxidation potential involving compounds like O _3 and the hydroxyl radical (OH). Reported studies represent both current and future changes. Reported results include new estimates of radiative forcing based on extensive model studies of chemically active climate compounds like O _3, and of particles inducing both direct and indirect effects. Through EU projects like ACCENT, QUANTIFY, and the AeroCom project, extensive studies on regional and sector-wise differences in the impact on atmospheric distribution are performed. Studies have shown that land-based emissions have a different effect on climate than ship and aircraft emissions, and different measures are needed to reduce the climate impact. Several areas where climate change can affect the tropospheric oxidation process and the chemical composition are identified. This can take place through enhanced stratospheric-tropospheric exchange of ozone, more frequent periods with stable conditions favoring pollution build up over industrial areas, enhanced temperature induced biogenic emissions, methane releases from permafrost thawing, and enhanced concentration through reduced biospheric uptake. During the last 5-10 years, new observational data have been made available and used for model validation and the study of atmospheric processes. Although there are significant uncertainties in the modeling of composition changes, access to new observational data has improved modeling capability. Emission scenarios for the coming decades have a large uncertainty range, in particular with respect to regional trends, leading to a significant uncertainty range in estimated regional composition changes and climate impact.</td>
</tr>
<tr id="bib_Isaksen_etal_AE_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Isaksen_etal_AE_2009a,
  author = {Isaksen, I. S. A. and Granier, C. and Myhre, G. and Berntsen, T. K. and Dals&oslash;ren, S. B. and Gauss, M. and Klimont, Z. and Benestad, R. and Bousquet, P. and Collins, W. and Cox, T. and Eyring, V. and Fowler, D. and Fuzzi, S. and J&ouml;ckel, P. and Laj, P. and Lohmann, U. and Maione, M. and Monks, P. and Prevot, A. S. H. and Raes, F. and Richter, A. and Rognerud, B. and Schulz, M. and Shindell, D. and Stevenson, D. S. and Storelvmo, T. and Wang, W.-C. and van Weele, M. and Wild, M. and Wuebbles, D.},
  title = {Atmospheric composition change: Climate-Chemistry interactions},
  journal = {Atmospheric Environment},
  year = {2009},
  volume = {43},
  pages = {5138-5192},
  url = {http://adsabs.harvard.edu/abs/2009AtmEn..43.5138I},
  doi = {https://doi.org/10.1016/j.atmosenv.2009.08.003}
}
</pre></td>
</tr>
<tr id="Jacob_AE_2000a" class="entry">
	<td>Jacob, D.J.</td>
	<td>Heterogeneous chemistry and tropospheric ozone <p class="infolinks">[<a href="javascript:toggleInfo('Jacob_AE_2000a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Jacob_AE_2000a','bibtex')">BibTeX</a>]</p></td>
	<td>2000</td>
	<td>Atmospheric Environment<br/>Vol. 34, pp. 2131-2159&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/S1352-2310(99)00462-8">DOI</a> <a href="https://pdfs.semanticscholar.org/b874/0a4cc80c757f32339c94f48af92c88abd05d.pdf">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Jacob_AE_2000a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Ozone is produced in the troposphere by gas-phase oxidation of
<br>hydrocarbons and CO catalyzed by hydrogen oxide radicals (HO
<br>_x&equiv;OH+H+peroxy radicals) and nitrogen oxide radicals (NO
<br>_x&equiv;NO+NO _2). Heterogeneous chemistry
<br>involving reactions in aerosol particles and cloud droplets may affect O
<br>_3 concentrations in a number of ways including production and
<br>loss of HO _x and NO _x, direct loss of O
<br>_3, and production of halogen radicals. Current knowledge and
<br>hypotheses regarding these processes are reviewed. It is recommended
<br>that standard O _3 models include in their chemical mechanisms
<br>the following reaction probability parameterizations for reactive uptake
<br>of gases by aqueous aerosols and clouds: &gamma;_HO <SUB>2</SUB>=0.2
<br>(range 0.1-1) for HO _2rarr0.5 H _2O _2,
<br>&gamma;_NO <SUB>2</SUB>=10 ^-4 (10 ^-6-10
<br>^-3) for NO _2rarr 0.5 HONO+0.5 HNO _3,
<br>&gamma;_NO <SUB>3</SUB>=10 ^-3 (2&times;10
<br>^-4-10 ^-2) for NO _3rarrHNO
<br>_3, and &gamma;_N <SUB>2O</SUB> _5=0.1 (0.01-1)
<br>for N _2O _5rarr2 HNO _3. Current
<br>knowledge does not appear to warrant a more detailed approach.
<br>Hypotheses regarding fast O _3 loss on soot or in clouds, fast
<br>reduction of HNO _3 to NO _x in aerosols, or
<br>heterogeneous loss of CH _2O are not supported by evidence.
<br>Halogen radical chemistry could possibly be significant in the marine
<br>boundary layer but more evidence is needed. Recommendations for future
<br>research are presented. They include among others (1) improved
<br>characterization of the phase and composition of atmospheric aerosols,
<br>in particular the organic component; (2) aircraft and ship studies of
<br>marine boundary layer chemistry; (3) measurements of HONO vertical
<br>profiles in urban boundary layers, and of the resulting HO _x
<br>source at sunrise; (4) laboratory studies of the mechanisms for
<br>reactions of peroxy radicals, NO _2, and HNO _3 on
<br>surfaces representative of atmospheric aerosol; and (4) laboratory
<br>studies of O _3 reactivity on organic aerosols and mineral
<br>dust.
<br>
<br></td>
</tr>
<tr id="bib_Jacob_AE_2000a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Jacob_AE_2000a,
  author = {Jacob, D. J.},
  title = {Heterogeneous chemistry and tropospheric ozone},
  journal = {Atmospheric Environment},
  year = {2000},
  volume = {34},
  pages = {2131-2159},
  url = {https://pdfs.semanticscholar.org/b874/0a4cc80c757f32339c94f48af92c88abd05d.pdf},
  doi = {https://doi.org/10.1016/S1352-2310(99)00462-8}
}
</pre></td>
</tr>
<tr id="Kim_etal_AE_2017a" class="entry">
	<td>Kim, D., Chin, M., Kemp, E.M., Tao, Z., Peters-Lidard, C.D. and Ginoux, P.</td>
	<td>Development of high-resolution dynamic dust source function - A case study with a strong dust storm in a regional model <p class="infolinks">[<a href="javascript:toggleInfo('Kim_etal_AE_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kim_etal_AE_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Environment<br/>Vol. 159, pp. 11-25&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2017.03.045">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017AtmEn.159...11K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kim_etal_AE_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A high-resolution dynamic dust source has been developed in the NASA Unified-Weather Research and Forecasting (NU-WRF) model to improve the existing coarse static dust source. In the new dust source map, topographic depression is in 1-km resolution and surface bareness is derived using the Normalized Difference Vegetation Index (NDVI) data from Moderate Resolution Imaging Spectroradiometer (MODIS). The new dust source better resolves the complex topographic distribution over the Western United States where its magnitude is higher than the existing, coarser resolution static source. A case study is conducted with an extreme dust storm that occurred in Phoenix, Arizona in 02-03 UTC July 6, 2011. The NU-WRF model with the new high-resolution dynamic dust source is able to successfully capture the dust storm, which was not achieved with the old source identification. However the case study also reveals several challenges in reproducing the time evolution of the short-lived, extreme dust storm events.</td>
</tr>
<tr id="bib_Kim_etal_AE_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kim_etal_AE_2017a,
  author = {Kim, D. and Chin, M. and Kemp, E. M. and Tao, Z. and Peters-Lidard, C. D. and Ginoux, P.},
  title = {Development of high-resolution dynamic dust source function - A case study with a strong dust storm in a regional model},
  journal = {Atmospheric Environment},
  year = {2017},
  volume = {159},
  pages = {11-25},
  url = {http://adsabs.harvard.edu/abs/2017AtmEn.159...11K},
  doi = {https://doi.org/10.1016/j.atmosenv.2017.03.045}
}
</pre></td>
</tr>
<tr id="Krueger_etal_AE_2004a" class="entry">
	<td>Krueger, B., Grassian, V., Cowin, J. and Laskin, A.</td>
	<td>Heterogeneous chemistry of individual mineral dust particles from different dust source regions: the importance of particle mineralogy <p class="infolinks">[<a href="javascript:toggleInfo('Krueger_etal_AE_2004a','bibtex')">BibTeX</a>]</p></td>
	<td>2004</td>
	<td>Atmospheric Environment<br/>Vol. 38(36), pp. 6253-6261&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2004.07.010">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Krueger_etal_AE_2004a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Krueger_etal_AE_2004a,
  author = {B.J. Krueger and V.H. Grassian and J.P. Cowin and A. Laskin},
  title = {Heterogeneous chemistry of individual mineral dust particles from different dust source regions: the importance of particle mineralogy},
  journal = {Atmospheric Environment},
  publisher = {Elsevier BV},
  year = {2004},
  volume = {38},
  number = {36},
  pages = {6253--6261},
  doi = {https://doi.org/10.1016/j.atmosenv.2004.07.010}
}
</pre></td>
</tr>
<tr id="Liu_etal_AE_2009a" class="entry">
	<td>Liu, J., Mauzerall, D.L., Horowitz, L.W., Ginoux, P. and Fiore, A.M.</td>
	<td>Evaluating inter-continental transport of fine aerosols: (1) Methodology, global aerosol distribution and optical depth <p class="infolinks">[<a href="javascript:toggleInfo('Liu_etal_AE_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Liu_etal_AE_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Environment<br/>Vol. 43, pp. 4327-4338&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2009.03.054">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009AtmEn..43.4327L">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Liu_etal_AE_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Our objectives are to evaluate inter-continental source-receptor relationships for fine aerosols and to identify the regions whose emissions have dominant influence on receptor continents. We simulate sulfate, black carbon (BC), organic carbon (OC), and mineral dust aerosols using a global coupled chemistry-aerosol model (MOZART-2) driven with NCEP/NCAR reanalysis meteorology for 1997-2003 and emissions approximately representing year 2000. The concentrations of simulated aerosol species in general agree within a factor of 2 with observations, except that the model tends to overestimate sulfate over Europe in summer, underestimate BC and OC over the western and southeastern (SE) U.S. and Europe, and underestimate dust over the SE U.S. By tagging emissions from ten continental regions, we quantify the contribution of each region's emissions on surface aerosol concentrations (relevant for air quality) and aerosol optical depth (AOD, relevant for visibility and climate) globally. We find that domestic emissions contribute substantially to surface aerosol concentrations (57-95 over all regions, but are responsible for a smaller fraction of AOD (26-76. We define ``background'' aerosols as those aerosols over a region that result from inter-continental transport, DMS oxidation, and emissions from ships or volcanoes. Transport from other continental source regions accounts for a substantial portion of background aerosol concentrations: 36-97&#37; for surface concentrations and 38-89&#37; for AOD. We identify the Region of Primary Influence (RPI) as the source region with the largest contribution to the receptor's background aerosol concentrations (or AOD). We find that for dust Africa is the RPI for both aerosol concentrations and AOD over all other receptor regions. For non-dust aerosols (particularly for sulfate and BC), the RPIs for aerosol concentrations and AOD are identical for most receptor regions. These findings indicate that the reduction of the emission of non-dust aerosols and their precursors from an RPI will simultaneously improve both air quality and visibility over a receptor region.</td>
</tr>
<tr id="bib_Liu_etal_AE_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Liu_etal_AE_2009a,
  author = {Liu, J. and Mauzerall, D. L. and Horowitz, L. W. and Ginoux, P. and Fiore, A. M.},
  title = {Evaluating inter-continental transport of fine aerosols: (1) Methodology, global aerosol distribution and optical depth},
  journal = {Atmospheric Environment},
  year = {2009},
  volume = {43},
  pages = {4327-4338},
  url = {http://adsabs.harvard.edu/abs/2009AtmEn..43.4327L},
  doi = {https://doi.org/10.1016/j.atmosenv.2009.03.054}
}
</pre></td>
</tr>
<tr id="Lodge_AE_1988a" class="entry">
	<td>Lodge, J.P.</td>
	<td>Book Review: Carburants et moteurs, volumes 1 and 2 . J.C. Guibet and Brigitte Martin, Editions Technip, 27 Rue Ginoux, 75737 Paris Cedex 15, France, 1987, Vol. 1, xxxi + 512 pp., Vol. 2. xxxi + 389 pp. Price: Vol. 1 ff 680, Vol. 2 ff 520 <p class="infolinks">[<a href="javascript:toggleInfo('Lodge_AE_1988a','bibtex')">BibTeX</a>]</p></td>
	<td>1988</td>
	<td>Atmospheric Environment<br/>Vol. 22, pp. 1772-1773&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/0004-6981(88)90416-7">DOI</a> <a href="http://adsabs.harvard.edu/abs/1988AtmEn..22T1772L">URL</a>&nbsp;</td>
</tr>
<tr id="bib_Lodge_AE_1988a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Lodge_AE_1988a,
  author = {Lodge, J. P.},
  title = {Book Review: Carburants et moteurs, volumes 1 and 2 . J.C. Guibet and Brigitte Martin, Editions Technip, 27 Rue Ginoux, 75737 Paris Cedex 15, France, 1987, Vol. 1, xxxi + 512 pp., Vol. 2. xxxi + 389 pp. Price: Vol. 1 ff 680, Vol. 2 ff 520},
  journal = {Atmospheric Environment},
  year = {1988},
  volume = {22},
  pages = {1772-1773},
  url = {http://adsabs.harvard.edu/abs/1988AtmEn..22T1772L},
  doi = {https://doi.org/10.1016/0004-6981(88)90416-7}
}
</pre></td>
</tr>
<tr id="Monks_etal_AE_2009a" class="entry">
	<td>Monks, P.S., Granier, C., Fuzzi, S., Stohl, A., Williams, M.L., Akimoto, H., Amann, M., Baklanov, A., Baltensperger, U., Bey, I., Blake, N., Blake, R.S., Carslaw, K., Cooper, O.R., Dentener, F., Fowler, D., Fragkou, E., Frost, G.J., Generoso, S., Ginoux, P., Grewe, V., Guenther, A., Hansson, H.C., Henne, S., Hjorth, J., Hofzumahaus, A., Huntrieser, H., Isaksen, I.S.A., Jenkin, M.E., Kaiser, J., Kanakidou, M., Klimont, Z., Kulmala, M., Laj, P., Lawrence, M.G., Lee, J.D., Liousse, C., Maione, M., McFiggans, G., Metzger, A., Mieville, A., Moussiopoulos, N., Orlando, J.J., O'Dowd, C.D., Palmer, P.I., Parrish, D.D., Petzold, A., Platt, U., P&ouml;schl, U., Pr&eacute;v&ocirc;t, A.S.H., Reeves, C.E., Reimann, S., Rudich, Y., Sellegri, K., Steinbrecher, R., Simpson, D., ten Brink, H., Theloke, J., van der Werf, G.R., Vautard, R., Vestreng, V., Vlachokostas, C. and von Glasow, R.</td>
	<td>Atmospheric composition change - global and regional air quality <p class="infolinks">[<a href="javascript:toggleInfo('Monks_etal_AE_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Monks_etal_AE_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Environment<br/>Vol. 43, pp. 5268-5350&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.atmosenv.2009.08.021">DOI</a> <a href="http://adsabs.harvard.edu/abs/2009AtmEn..43.5268M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Monks_etal_AE_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Air quality transcends all scales with in the atmosphere from the local to the global with handovers and feedbacks at each scale interaction. Air quality has manifold effects on health, ecosystems, heritage and climate. In this review the state of scientific understanding in relation to global and regional air quality is outlined. The review discusses air quality, in terms of emissions, processing and transport of trace gases and aerosols. New insights into the characterization of both natural and anthropogenic emissions are reviewed looking at both natural (e.g. dust and lightning) as well as plant emissions. Trends in anthropogenic emissions both by region and globally are discussed as well as biomass burning emissions. In terms of chemical processing the major air quality elements of ozone, non-methane hydrocarbons, nitrogen oxides and aerosols are covered. A number of topics are presented as a way of integrating the process view into the atmospheric context; these include the atmospheric oxidation efficiency, halogen and HO_x chemistry, nighttime chemistry, tropical chemistry, heat waves, megacities, biomass burning and the regional hot spot of the Mediterranean. New findings with respect to the transport of pollutants across the scales are discussed, in particular the move to quantify the impact of long-range transport on regional air quality. Gaps and research questions that remain intractable are identified. The review concludes with a focus of research and policy questions for the coming decade. In particular, the policy challenges for concerted air quality and climate change policy (co-benefit) are discussed.</td>
</tr>
<tr id="bib_Monks_etal_AE_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Monks_etal_AE_2009a,
  author = {Monks, P. S. and Granier, C. and Fuzzi, S. and Stohl, A. and Williams, M. L. and Akimoto, H. and Amann, M. and Baklanov, A. and Baltensperger, U. and Bey, I. and Blake, N. and Blake, R. S. and Carslaw, K. and Cooper, O. R. and Dentener, F. and Fowler, D. and Fragkou, E. and Frost, G. J. and Generoso, S. and Ginoux, P. and Grewe, V. and Guenther, A. and Hansson, H. C. and Henne, S. and Hjorth, J. and Hofzumahaus, A. and Huntrieser, H. and Isaksen, I. S. A. and Jenkin, M. E. and Kaiser, J. and Kanakidou, M. and Klimont, Z. and Kulmala, M. and Laj, P. and Lawrence, M. G. and Lee, J. D. and Liousse, C. and Maione, M. and McFiggans, G. and Metzger, A. and Mieville, A. and Moussiopoulos, N. and Orlando, J. J. and O'Dowd, C. D. and Palmer, P. I. and Parrish, D. D. and Petzold, A. and Platt, U. and P&ouml;schl, U. and Pr&eacute;v&ocirc;t, A. S. H. and Reeves, C. E. and Reimann, S. and Rudich, Y. and Sellegri, K. and Steinbrecher, R. and Simpson, D. and ten Brink, H. and Theloke, J. and van der Werf, G. R. and Vautard, R. and Vestreng, V. and Vlachokostas, C. and von Glasow, R.},
  title = {Atmospheric composition change - global and regional air quality},
  journal = {Atmospheric Environment},
  year = {2009},
  volume = {43},
  pages = {5268-5350},
  url = {http://adsabs.harvard.edu/abs/2009AtmEn..43.5268M},
  doi = {https://doi.org/10.1016/j.atmosenv.2009.08.021}
}
</pre></td>
</tr>
<tr id="Glassmeier_etal_ACaP_2017a" class="entry">
	<td>Glassmeier, F., Possner, A., Vogel, B., Vogel, H. and Lohmann, U.</td>
	<td>A comparison of two chemistry and aerosol schemes on the regional scale and the resulting impact on radiative properties and liquid- and ice-phase aerosol&ndash;cloud interactions <p class="infolinks">[<a href="javascript:toggleInfo('Glassmeier_etal_ACaP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry and Physics<br/>Vol. 17(14), pp. 8651-8680&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-8651-2017">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Glassmeier_etal_ACaP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Glassmeier_etal_ACaP_2017a,
  author = {Franziska Glassmeier and Anna Possner and Bernhard Vogel and Heike Vogel and Ulrike Lohmann},
  title = {A comparison of two chemistry and aerosol schemes on the regional scale and the resulting impact on radiative properties and liquid- and ice-phase aerosol&ndash;cloud interactions},
  journal = {Atmospheric Chemistry and Physics},
  publisher = {Copernicus GmbH},
  year = {2017},
  volume = {17},
  number = {14},
  pages = {8651--8680},
  doi = {https://doi.org/10.5194/acp-17-8651-2017}
}
</pre></td>
</tr>
<tr id="Smith_etal_ACaP_2017a" class="entry">
	<td>Smith, M.B., Mahowald, N.M., Albani, S., Perry, A., Losno, R., Qu, Z., Marticorena, B., Ridley, D.A. and Heald, C.L.</td>
	<td>Sensitivity of the interannual variability of mineral aerosol simulations to meteorological forcing dataset <p class="infolinks">[<a href="javascript:toggleInfo('Smith_etal_ACaP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry and Physics<br/>Vol. 17(5), pp. 3253-3278&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-3253-2017">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Smith_etal_ACaP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Smith_etal_ACaP_2017a,
  author = {Molly B. Smith and Natalie M. Mahowald and Samuel Albani and Aaron Perry and Remi Losno and Zihan Qu and Beatrice Marticorena and David A. Ridley and Colette L. Heald},
  title = {Sensitivity of the interannual variability of mineral aerosol simulations to meteorological forcing dataset},
  journal = {Atmospheric Chemistry and Physics},
  publisher = {Copernicus GmbH},
  year = {2017},
  volume = {17},
  number = {5},
  pages = {3253--3278},
  doi = {https://doi.org/10.5194/acp-17-3253-2017}
}
</pre></td>
</tr>
<tr id="Astitha_etal_ACPD_2012a" class="entry">
	<td>Astitha, M., Lelieveld, J., Abdel Kader, M., Pozzer, A. and de Meij, A.</td>
	<td>New parameterization of dust emissions in the global atmospheric chemistry-climate model EMAC <p class="infolinks">[<a href="javascript:toggleInfo('Astitha_etal_ACPD_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Astitha_etal_ACPD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 12, pp. 13237-13298&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-12-13237-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACPD...1213237A">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Astitha_etal_ACPD_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Airborne desert dust influences radiative transfer, atmospheric chemistry and dynamics, as well as nutrient transport and deposition. It directly and indirectly affects climate on regional and global scales. We present two versions of a parameterization scheme to compute desert dust emissions, incorporated into the atmospheric chemistry general circulation model EMAC (ECHAM5/MESSy2.41 Atmospheric Chemistry). One uses a globally uniform soil particle size distribution, whereas the other explicitly accounts for different soil textures worldwide. We have tested these schemes and investigated the sensitivity to input parameters, using remote sensing data from the Aerosol Robotic Network (AERONET) and dust concentrations and deposition measurements from the AeroCom dust benchmark database (and others). The two schemes are shown to produce similar atmospheric dust loads in the N-African region, while they deviate in the Asian, Middle Eastern and S-American regions. The dust outflow from Africa over the Atlantic Ocean is accurately simulated by both schemes, in magnitude, location and seasonality. The modelled dust concentrations and deposition fluxes compare well with observations at (island) stations in the Atlantic Ocean and Asia, and are underestimated in the Pacific Ocean where annual means are relatively low (lt1 &mu;g m^-3). The two schemes perform similarly well, even though the total annual source differs by &tilde;50 indicating the importance of transport and deposition processes (being the same for the two schemes). Our results emphasize the need to represent arid regions individually and explicitly in global models according to their unique land characteristics and meteorological conditions.</td>
</tr>
<tr id="bib_Astitha_etal_ACPD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Astitha_etal_ACPD_2012a,
  author = {Astitha, M. and Lelieveld, J. and Abdel Kader, M. and Pozzer, A. and de Meij, A.},
  title = {New parameterization of dust emissions in the global atmospheric chemistry-climate model EMAC},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2012},
  volume = {12},
  pages = {13237-13298},
  url = {http://adsabs.harvard.edu/abs/2012ACPD...1213237A},
  doi = {https://doi.org/10.5194/acpd-12-13237-2012}
}
</pre></td>
</tr>
<tr id="Diehl_etal_ACPD_2012a" class="entry">
	<td>Diehl, T., Heil, A., Chin, M., Pan, X., Streets, D., Schultz, M. and Kinne, S.</td>
	<td>Anthropogenic, biomass burning, and volcanic emissions of black carbon, organic carbon, and SO_2 from 1980 to 2010 for hindcast model experiments <p class="infolinks">[<a href="javascript:toggleInfo('Diehl_etal_ACPD_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Diehl_etal_ACPD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 12(9), pp. 24895-24954&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-12-24895-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACPD...1224895D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Diehl_etal_ACPD_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Two historical emission inventories of black carbon (BC), primary organic carbon (OC), and SO_2 emissions from land-based anthropogenic sources, ocean-going vessels, air traffic, biomass burning, and volcanoes are presented and discussed for the period 1980-2010. These gridded inventories are provided to the internationally coordinated AeroCom Phase II multi-model hindcast experiments. The horizontal resolution is 0.5deg&times;0.5deg and 1.0deg&times;1.0deg, while the temporal resolution varies from daily for volcanoes to monthly for biomass burning and aircraft emissions, and annual averages for land-based and ship emissions. One inventory is based on inter-annually varying activity rates of land-based anthropogenic emissions and shows strong variability within a decade, while the other one is derived from interpolation between decadal endpoints and thus exhibits linear trends within a decade. Both datasets capture the major trends of decreasing anthropogenic emissions over the USA and Western Europe since 1980, a sharp decrease around 1990 over Eastern Europe and the former USSR, and a steep increase after 2000 over East and South Asia. The inventory differences for the combined anthropogenic and biomass burning emissions in the year 2005 are 34&#37; for BC, 46&#37; for OC, and 13&#37; for SO_2. They vary strongly depending on species, year and region, from about 10&#37; to 40&#37; in most cases, but in some cases the inventories differ by 100&#37; or more. Differences in emissions from wild-land fires are caused only by different choices of the emission factors for years after 1996 which vary by a factor of about 1 to 2 for OC depending on region, and by a combination of emission factors and the amount of dry mass burned for years up to 1996. Volcanic SO_2 emissions, which are only provided in one inventory, include emissions from explosive, effusive, and quiescent degassing events for 1167 volcanoes.</td>
</tr>
<tr id="bib_Diehl_etal_ACPD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Diehl_etal_ACPD_2012a,
  author = {Diehl, T. and Heil, A. and Chin, M. and Pan, X. and Streets, D. and Schultz, M. and Kinne, S.},
  title = {Anthropogenic, biomass burning, and volcanic emissions of black carbon, organic carbon, and SO_2 from 1980 to 2010 for hindcast model experiments},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  publisher = {Copernicus GmbH},
  year = {2012},
  volume = {12},
  number = {9},
  pages = {24895-24954},
  url = {http://adsabs.harvard.edu/abs/2012ACPD...1224895D},
  doi = {https://doi.org/10.5194/acpd-12-24895-2012}
}
</pre></td>
</tr>
<tr id="Dubovik_etal_ACPD_2007a" class="entry">
	<td>Dubovik, O., Lapyonok, T., Kaufman, Y.J., Chin, M., Ginoux, P. and Sinyuk, A.</td>
	<td>Retrieving global sources of aerosols from MODIS observations by inverting GOCART model <p class="infolinks">[<a href="javascript:toggleInfo('Dubovik_etal_ACPD_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dubovik_etal_ACPD_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 7, pp. 3629-3718&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2007ACPD....7.3629D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dubovik_etal_ACPD_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Knowledge of the global distribution of tropospheric aerosols is important for studying the effects of aerosols on global climate. Chemical transport models rely on archived meteorological fields, accounting for aerosol sources, transport and removal processes can simulate the global distribution of atmospheric aerosols. However, the accuracy of global aerosol modeling is limited. Uncertainty in location and strength of aerosol emission sources is a major factor in limiting modeling accuracy. This paper describes an effort to develop an algorithm for retrieving global sources of aerosol from satellite observations by inverting the GOCART aerosol transport model. <BR /><BR /> To optimize inversion algorithm performance, the inversion was formulated as a generalized multi-term least-squares-type fitting. This concept uses the principles of statistical optimization and unites diverse retrieval techniques into a single flexible inversion procedure. It is particularly useful for choosing and refining a priori constraints in the retrieval algorithm. For example, it is demonstrated that a priori limitations on the partial derivatives of retrieved characteristics, which are widely used in atmospheric remote sensing, can also be useful in inverse modeling for constraining time and space variability of the retrieved global aerosol emissions. The similarities and differences with the standard ``Kalman filter'' inverse modeling approach and the ``Phillips-Tikhonov-Twomey'' constrained inversion widely used in remote sensing are discussed. In order to retain the originally high space and time resolution of the global model in the inversion of a long record of observations, the algorithm was expressed using adjoint operators in a form convenient for practical development of the inversion from codes implementing forward model simulations. <BR /><BR /> The inversion algorithm was implemented using the GOCART aerosol transport model. The numerical tests we conducted showed successful retrievals of global aerosol emissions with a 2deg&times;2.5deg resolution by inverting the GOCART output. For achieving satisfactory retrieval from satellite sensors such as MODIS, the emissions were assumed constant within the 24 h diurnal cycle and aerosol differences in chemical composition were neglected. Such additional assumptions were needed to constrain the inversion due to limitations of satellite temporal coverage and sensitivity to aerosol parameters. As a result, the algorithm was defined for the retrieval of emission sources of fine and coarse mode aerosols from the MODIS fine and coarse mode aerosol optical thickness data respectively. Numerical tests showed that such assumptions are justifiable, taking into account the accuracy of the model and observations and that it provides valuable retrievals of the location and the strength of the aerosol emissions. The algorithm was applied to MODIS observations during two weeks in August 2000. The global placement of fine mode aerosol sources retrieved from inverting MODIS observations was coherent with available independent knowledge. This was particularly encouraging since the inverse method did not use any a priori information about the sources and it was initialized under a ``zero aerosol emission'' assumption. The retrieval reproduced the instantaneous global MODIS observations with a standard deviation in fitting of aerosol optical thickness of &tilde;0.04. The optical thickness during high aerosol loading events was reproduced with a standard deviation of &tilde;48%. Applications of the algorithm for the retrieval of coarse mode aerosol emissions were less successful, mainly due to the currently existing lack of MODIS data over high reflectance desert dust sources. <BR /><BR /> Possibilities for enhancing the global satellite data inversion by using diverse a priori constraints on the retrieval are demonstrated. The potential and limitations of applying our approach for the retrieval of global aerosol sources from aerosol remote sensing are discussed.</td>
</tr>
<tr id="bib_Dubovik_etal_ACPD_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dubovik_etal_ACPD_2007a,
  author = {Dubovik, O. and Lapyonok, T. and Kaufman, Y. J. and Chin, M. and Ginoux, P. and Sinyuk, A.},
  title = {Retrieving global sources of aerosols from MODIS observations by inverting GOCART model},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2007},
  volume = {7},
  pages = {3629-3718},
  url = {http://adsabs.harvard.edu/abs/2007ACPD....7.3629D}
}
</pre></td>
</tr>
<tr id="Goto_etal_ACPD_2012a" class="entry">
	<td>Goto, D., Oshima, N., Nakajima, T., Takemura, T. and Ohara, T.</td>
	<td>Impact of the aging process of black carbon aerosols on their spatial distribution, hygroscopicity, and radiative forcing in a global climate model <p class="infolinks">[<a href="javascript:toggleInfo('Goto_etal_ACPD_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Goto_etal_ACPD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 12, pp. 29801-29849&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-12-29801-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACPD...1229801G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Goto_etal_ACPD_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Black carbon (BC) absorbs shortwave radiation more strongly than any other type of aerosol, and an accurate simulation of the aging processes of BC-containing particle is required to properly predict aerosol radiative forcing (ARF) and climate change. However, BC aging processes have been simplified in general circulation models (GCMs) due to limited computational resources. In particular, differences in the representation of the mixing states of BC-containing particles between GCMs constitute one of main reasons for the uncertainty in ARF estimates. To understand an impact of the BC aging processes and the mixing state of BC on the spatial distribution of BC and ARF caused by BC (BC-ARF), we implemented three different methods of incorporating BC aging processes into a global aerosol transport model, SPRINTARS: (1) the ``AGV'' method, using variable conversion rates of BC aging based on a new type of parameterization depending on both BC amount and sulfuric acid; (2) the ``AGF'' method, using a constant conversion rate used worldwide in GCMs; and (3) the ``ORIG'' method, which is used in the original SPRINTARS. First, we found that these different methods produced different BC burden within 10&#37; over industrial areas and 50&#37; over remote oceans. Second, a ratio of water-insoluble BC to total BC (WIBC ratio) was very different among the three methods. Near the BC source region, for example, the WIBC ratios were estimated to be 80-90&#37; (AGV and AGF) and 50-60&#37; (ORIG). Third, although the BC aging process in GCMs had small impacts on the BC burden, they had a large impact on BC-ARF through a change in both the WIBC ratio and non-BC compounds coating on BC cores. As a result, possible differences in the treatment of the BC aging process between aerosol modeling studies can produce a difference of approximately 0.3 Wm^-2 in the magnitude of BC-ARF, which is comparable to the uncertainty suggested by results from a global aerosol modeling intercomparison project, AeroCom. The surface aerosol forcing efficiencies normalized by aerosol optical thickness and by BC burden varied greatly with region in the AGV method, which allowed for the existence of internally mixed BC and sulfate, whereas these were not varied with region in the AGF method. These results suggest that the efficiencies of BC-ARF obtained by previous studies using the AGF method are significantly underestimated.</td>
</tr>
<tr id="bib_Goto_etal_ACPD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Goto_etal_ACPD_2012a,
  author = {Goto, D. and Oshima, N. and Nakajima, T. and Takemura, T. and Ohara, T.},
  title = {Impact of the aging process of black carbon aerosols on their spatial distribution, hygroscopicity, and radiative forcing in a global climate model},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2012},
  volume = {12},
  pages = {29801-29849},
  url = {http://adsabs.harvard.edu/abs/2012ACPD...1229801G},
  doi = {https://doi.org/10.5194/acpd-12-29801-2012}
}
</pre></td>
</tr>
<tr id="Myhre_etal_ACPD_2012a" class="entry">
	<td>Myhre, G., Samset, B.H., Schulz, M., Balkanski, Y., Bauer, S., Berntsen, T.K., Bian, H., Bellouin, N., Chin, M., Diehl, T., Easter, R.C., Feichter, J., Ghan, S.J., Hauglustaine, D., Iversen, T., Kinne, S., Kirkev&aring;g, A., Lamarque, J.-F., Lin, G., Liu, X., Luo, G., Ma, X., Penner, J.E., Rasch, P.J., Seland, &Oslash;., Skeie, R.B., Stier, P., Takemura, T., Tsigaridis, K., Wang, Z., Xu, L., Yu, H., Yu, F., Yoon, J.-H., Zhang, K., Zhang, H. and Zhou, C.</td>
	<td>Radiative forcing of the direct aerosol effect from AeroCom Phase II simulations <p class="infolinks">[<a href="javascript:toggleInfo('Myhre_etal_ACPD_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Myhre_etal_ACPD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 12, pp. 22355-22413&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-12-22355-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACPD...1222355M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Myhre_etal_ACPD_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We report on the AeroCom Phase II direct aerosol effect (DAE) experiment
<br>where 15 detailed global aerosol models have been used to simulate the
<br>changes in the aerosol distribution over the industrial era. All 15
<br>models have estimated the radiative forcing (RF) of the anthropogenic
<br>DAE, and have taken into account anthropogenic sulphate, black carbon
<br>(BC) and organic aerosols (OA) from fossil fuel, biofuel, and biomass
<br>burning emissions. In addition several models have simulated the DAE of
<br>anthropogenic nitrate and anthropogenic influenced secondary organic
<br>aerosols (SOA). The model simulated all-sky RF of the DAE from total
<br>anthropogenic aerosols has a range from -0.58 to -0.02 W m^-2,
<br>with a mean of -0.30 W m^-2 for the 15 models. Several models
<br>did not include nitrate or SOA and modifying the estimate by accounting
<br>for this with information from the other AeroCom models reduces the
<br>range and slightly strengthens the mean. Modifying the model estimates
<br>for missing aerosol components and for the time period 1750 to 2010
<br>results in a mean RF for the DAE of -0.39 W m^-2. Compared to
<br>AeroCom Phase I (Schulz et al., 2006) we find very similar spreads in
<br>both total DAE and aerosol component RF. However, the RF of the total
<br>DAE is stronger negative and RF from BC from fossil fuel and biofuel
<br>emissions are stronger positive in the present study than in the
<br>previous AeroCom study. We find a tendency for models having a strong
<br>(positive) BC RF to also have strong (negative) sulphate or OA RF. This
<br>relationship leads to smaller uncertainty in the total RF of the DAE
<br>compared to the RF of the sum of the individual aerosol components. The
<br>spread in results for the individual aerosol components is substantial,
<br>and can be divided into diversities in burden, mass extinction
<br>coefficient (MEC), and normalized RF with respect to AOD. We find that
<br>these three factors give similar contributions to the spread in results.
<br></td>
</tr>
<tr id="bib_Myhre_etal_ACPD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Myhre_etal_ACPD_2012a,
  author = {Myhre, G. and Samset, B. H. and Schulz, M. and Balkanski, Y. and Bauer, S. and Berntsen, T. K. and Bian, H. and Bellouin, N. and Chin, M. and Diehl, T. and Easter, R. C. and Feichter, J. and Ghan, S. J. and Hauglustaine, D. and Iversen, T. and Kinne, S. and Kirkev&aring;g, A. and Lamarque, J.-F. and Lin, G. and Liu, X. and Luo, G. and Ma, X. and Penner, J. E. and Rasch, P. J. and Seland, &Oslash;. and Skeie, R. B. and Stier, P. and Takemura, T. and Tsigaridis, K. and Wang, Z. and Xu, L. and Yu, H. and Yu, F. and Yoon, J.-H. and Zhang, K. and Zhang, H. and Zhou, C.},
  title = {Radiative forcing of the direct aerosol effect from AeroCom Phase II simulations},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2012},
  volume = {12},
  pages = {22355-22413},
  url = {http://adsabs.harvard.edu/abs/2012ACPD...1222355M},
  doi = {https://doi.org/10.5194/acpd-12-22355-2012}
}
</pre></td>
</tr>
<tr id="Paulot_etal_ACPD_2015a" class="entry">
	<td>Paulot, F., Ginoux, P., Cooke, W.F., Donner, L.J., Fan, S., Lin, M., Mao, J., Naik, V. and Horowitz, L.W.</td>
	<td>Sensitivity of nitrate aerosols to ammonia emissions and to nitrate chemistry: implications for present and future nitrate optical depth <p class="infolinks">[<a href="javascript:toggleInfo('Paulot_etal_ACPD_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Paulot_etal_ACPD_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 15, pp. 25739-25788&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-15-25739-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACPD...1525739P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Paulot_etal_ACPD_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We update and evaluate the treatment of nitrate aerosols in the Geophysical Fluid Dynamics Laboratory (GFDL) atmospheric model (AM3). Accounting for the radiative effects of nitrate aerosols generally improves the simulated aerosol optical depth, although nitrate concentrations at the surface are biased high. This bias can be reduced by increasing the deposition of nitrate to account for the near-surface volatilization of ammonium nitrate or by neglecting the heterogeneous production of nitric acid to account for the inhibition of N_2O_5 reactive uptake at high nitrate concentrations. Globally, uncertainties in these processes can impact the simulated nitrate optical depth by up to 25  much more than the impact of uncertainties in the seasonality of ammonia emissions (6  or in the uptake of nitric acid on dust (13 . Our best estimate for present-day fine nitrate optical depth at 550 nm is 0.006 (0.005-0.008). We only find a modest increase of nitrate optical depth (lt 30  in response to the projected changes in the emissions of SO_2 (-40  and ammonia (+38  from 2010 to 2050. Nitrate burden is projected to increase in the tropics and in the free troposphere, but to decrease at the surface in the midlatitudes because of lower nitric acid concentrations. Our results suggest that better constraints on the heterogeneous chemistry of nitric acid on dust, on tropical ammonia emissions, and on the transport of ammonia to the free troposphere are needed to improve projections of aerosol optical depth.</td>
</tr>
<tr id="bib_Paulot_etal_ACPD_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Paulot_etal_ACPD_2015a,
  author = {Paulot, F. and Ginoux, P. and Cooke, W. F. and Donner, L. J. and Fan, S. and Lin, M. and Mao, J. and Naik, V. and Horowitz, L. W.},
  title = {Sensitivity of nitrate aerosols to ammonia emissions and to nitrate chemistry: implications for present and future nitrate optical depth},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2015},
  volume = {15},
  pages = {25739-25788},
  url = {http://adsabs.harvard.edu/abs/2015ACPD...1525739P},
  doi = {https://doi.org/10.5194/acpd-15-25739-2015}
}
</pre></td>
</tr>
<tr id="Quaas_etal_ACPD_2009a" class="entry">
	<td>Quaas, J., Ming, Y., Menon, S., Takemura, T., Wang, M., Penner, J.E., Gettelman, A., Lohmann, U., Bellouin, N., Boucher, O., Sayer, A.M., Thomas, G.E., McComiskey, A., Feingold, G., Hoose, C., Kristj&aacute;nsson, J.E., Liu, X., Balkanski, Y., Donner, L.J., Ginoux, P.A., Stier, P., Feichter, J., Sednev, I., Bauer, S.E., Koch, D., Grainger, R.G., Kirkev&aring;g, A., Iversen, T., Seland,  Easter, R., Ghan, S.J., Rasch, P.J., Morrison, H., Lamarque, J.-F., Iacono, M.J., Kinne, S. and Schulz, M.</td>
	<td>Aerosol indirect effects - general circulation model intercomparison and evaluation with satellite data <p class="infolinks">[<a href="javascript:toggleInfo('Quaas_etal_ACPD_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Quaas_etal_ACPD_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 9, pp. 12731-12779&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009ACPD....912731Q">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Quaas_etal_ACPD_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosol indirect effects continue to constitute one of the most
<br>important uncertainties for anthropogenic climate perturbations. Within
<br>the international AEROCOM initiative, the representation of
<br>aerosol-cloud-radiation interactions in ten different general
<br>circulation models (GCMs) is evaluated using three satellite datasets.
<br>The focus is on stratiform liquid water clouds since most GCMs do not
<br>include ice nucleation effects, and none of the models explicitly
<br>parameterizes aerosol effects on convective clouds. We compute
<br>statistical relationships between aerosol optical depth
<br>(&tau;_a) and various cloud and radiation quantities in a
<br>manner that is consistent between the models and the satellite data. It
<br>is found that the model-simulated influence of aerosols on cloud droplet
<br>number concentration (N_d) compares relatively well to the
<br>satellite data at least over the ocean. The relationship between
<br>&tau;_a and liquid water path is simulated much too strongly
<br>by the models. It is shown that this is partly related to the
<br>representation of the second aerosol indirect effect in terms of
<br>autoconversion. A positive relationship between total cloud fraction
<br>(f_cld) and &tau;_a as found in the satellite data
<br>is simulated by the majority of the models, albeit less strongly than
<br>that in the satellite data in most of them. In a discussion of the
<br>hypotheses proposed in the literature to explain the satellite-derived
<br>strong f_cld - &tau;_a relationship, our
<br>results indicate that none can be identified as unique explanation.
<br>Relationships similar to the ones found in satellite data between
<br>&tau;_a and cloud top temperature or outgoing long-wave
<br>radiation (OLR) are simulated by only a few GCMs. The GCMs that simulate
<br>a negative OLR - &tau;_a relationship show a strong
<br>positive correlation between &tau;_a and f_cld. The
<br>short-wave total aerosol radiative forcing as simulated by the GCMs is
<br>strongly influenced by the simulated anthropogenic fraction of
<br>&tau;_a, and parameterisation assumptions such as a lower
<br>bound on N_d. Nevertheless, the strengths of the statistical
<br>relationships are good predictors for the aerosol forcings in the
<br>models. An estimate of the total short-wave aerosol forcing inferred
<br>from the combination of these predictors for the modelled forcings with
<br>the satellite-derived statistical relationships yields a global annual
<br>mean value of -1.5plusmn0.5 Wm^-2. An
<br>alternative estimate obtained by scaling the simulated clear- and
<br>cloudy-sky forcings with estimates of anthropogenic &tau;_a
<br>and satellite-retrieved N_d - &tau;_a
<br>regression slopes, respectively, yields a global annual mean clear-sky
<br>(aerosol direct effect) estimate of -0.4plusmn0.2
<br>Wm^-2 and a cloudy-sky (aerosol indirect effect)
<br>estimate of -0.7plusmn0.5 Wm^-2, with a total
<br>estimate of -1.2plusmn0.4 Wm^-2.
<br></td>
</tr>
<tr id="bib_Quaas_etal_ACPD_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Quaas_etal_ACPD_2009a,
  author = {Quaas, J. and Ming, Y. and Menon, S. and Takemura, T. and Wang, M. and Penner, J. E. and Gettelman, A. and Lohmann, U. and Bellouin, N. and Boucher, O. and Sayer, A. M. and Thomas, G. E. and McComiskey, A. and Feingold, G. and Hoose, C. and Kristj&aacute;nsson, J. E. and Liu, X. and Balkanski, Y. and Donner, L. J. and Ginoux, P. A. and Stier, P. and Feichter, J. and Sednev, I. and Bauer, S. E. and Koch, D. and Grainger, R. G. and Kirkev&aring;g, A. and Iversen, T. and Seland, O. and Easter, R. and Ghan, S. J. and Rasch, P. J. and Morrison, H. and Lamarque, J.-F. and Iacono, M. J. and Kinne, S. and Schulz, M.},
  title = {Aerosol indirect effects - general circulation model intercomparison and evaluation with satellite data},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2009},
  volume = {9},
  pages = {12731-12779},
  url = {http://adsabs.harvard.edu/abs/2009ACPD....912731Q}
}
</pre></td>
</tr>
<tr id="Shindell_etal_ACPD_2012a" class="entry">
	<td>Shindell, D.T., Lamarque, J.-F., Schulz, M., Flanner, M., Jiao, C., Chin, M., Young, P., Lee, Y.H., Rotstayn, L., Milly, G., Faluvegi, G., Balkanski, Y., Collins, W.J., Conley, A.J., Dalsoren, S., Easter, R., Ghan, S., Horowitz, L., Liu, X., Myhre, G., Nagashima, T., Naik, V., Rumbold, S., Skeie, R., Sudo, K., Szopa, S., Takemura, T., Voulgarakis, A. and Yoon, J.-H.</td>
	<td>Radiative forcing in the ACCMIP historical and future climate simulations <p class="infolinks">[<a href="javascript:toggleInfo('Shindell_etal_ACPD_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Shindell_etal_ACPD_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics Discussions<br/>Vol. 12, pp. 21105-21210&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acpd-12-21105-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACPD...1221105S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Shindell_etal_ACPD_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A primary goal of the Atmospheric Chemistry and Climate Model
<br>Intercomparison Project (ACCMIP) was to characterize the short-lived
<br>drivers of preindustrial to 2100 climate change in the current
<br>generation of climate models. Here we evaluate historical and future
<br>radiative forcing in the 10 ACCMIP models that included aerosols, 8 of
<br>which also participated in the Coupled Model Intercomparison Project
<br>phase 5 (CMIP5). <BR /> The models generally reproduce present-day
<br>climatological total aerosol optical depth (AOD) relatively well. They
<br>have quite different contributions from various aerosol components to
<br>this total, however, and most appear to underestimate AOD over East
<br>Asia. The models generally capture 1980-2000 AOD trends fairly well,
<br>though they underpredict AOD increases over the Yellow/Eastern Sea. They
<br>appear to strongly underestimate absorbing AOD, especially in East Asia,
<br>South and Southeast Asia, South America and Southern Hemisphere Africa.
<br><BR /> We examined both the conventional direct radiative forcing at the
<br>tropopause (RF) and the forcing including rapid adjustments (adjusted
<br>forcing; AF, including direct and indirect effects). The models'
<br>calculated all aerosol all-sky 1850 to 2000 global mean annual average
<br>RF ranges from -0.06 to -0.49 W m^-2, with a mean of -0.26 W
<br>m^-2 and a median of -0.27 W m^-2. Adjusting for
<br>missing aerosol components in some models brings the range to -0.12 to
<br>-0.62 W m^-2, with a mean of -0.39 W m^-2. Screening
<br>the models based on their ability to capture spatial patterns and
<br>magnitudes of AOD and AOD trends yields a quality-controlled mean of
<br>-0.42 W m^-2 and range of -0.33 to -0.50 W m^-2
<br>(accounting for missing components). The CMIP5 subset of ACCMIP models
<br>spans -0.06 to -0.49 W m^-2, suggesting some CMIP5 simulations
<br>likely have too little aerosol RF. A substantial, but not well
<br>quantified, contribution to historical aerosol RF may come from climate
<br>feedbacks (35 to -58 . The mean aerosol AF during this period is -1.12
<br>W m^-2 (median value -1.16 W m^-2, range -0.72 to
<br>-1.44 W m^-2), indicating that adjustments to aerosols, which
<br>include cloud, water vapor and temperature, lead to stronger forcing
<br>than the aerosol direct RF. Both negative aerosol RF and AF are greatest
<br>over and near Europe, South and East Asia and North America during 1850
<br>to 2000. AF, however, is positive over both polar regions, the Sahara,
<br>and the Karakoram. Annual average AF is stronger than 0.5 W
<br>m^-2 over parts of the Arctic and more than 1.5 W
<br>m^-2 during boreal summer. Examination of the regional pattern
<br>of RF and AF shows that the multi-model spread relative to the mean of
<br>AF is typically the same or smaller than that for RF over areas with
<br>substantial forcing. <BR /> Historical aerosol RF peaks in nearly all
<br>models around 1980, declining thereafter. Aerosol RF declines greatly in
<br>most models over the 21st century and is only weakly sensitive to the
<br>particular Representative Concentration Pathway (RCP). One model,
<br>however, shows approximate stabilization at current RF levels under RCP
<br>8.5, while two others show increasingly negative RF due to the influence
<br>of nitrate aerosols (which are not included in most models). Aerosol AF,
<br>in contrast, continues to become more negative during 1980 to 2000
<br>despite the turnaround in RF. Total anthropogenic composition forcing
<br>(RF due to well-mixed greenhouse gases (WMGHGs) and ozone plus aerosol
<br>AF) shows substantial masking of greenhouse forcing by aerosols towards
<br>the end of the 20th century and in the early 21st century at the
<br>global scale. Regionally, net forcing is negative over most
<br>industrialized and biomass burning regions through 1980, but remains
<br>strongly negative only over East and Southeast Asia by 2000 and only
<br>over a very small part of Southeast Asia by 2030 (under RCP8.5). Net
<br>forcing is strongly positive by 1980 over the Sahara, Arabian peninsula,
<br>the Arctic, Southern Hemisphere South America, Australia and most of the
<br>oceans. Both the magnitude of and area covered by positive forcing
<br>expand steadily thereafter. <BR /> There is no clear relationship
<br>between aerosol AF and climate sensitivity in the CMIP5 subset of ACCMIP
<br>models. There is a clear link between the strength of aerosol+ozone
<br>forcing and the global mean historical climate response to anthropogenic
<br>non-WMGHG forcing (ANWF). The models show  20-35&#37; greater climate
<br>sensitivity to ANWF than to WMGHG forcing, at least in part due to
<br>geographic differences in climate sensitivity. These lead to  50&#37; more
<br>warming in the Northern Hemisphere in response to increasing WMGHGs.
<br>This interhemispheric asymmetry is enhanced for ANWF by an additional
<br>10-30%. At smaller spatial scales, response to ANWF and WMGHGs show
<br>distinct differences.
<br></td>
</tr>
<tr id="bib_Shindell_etal_ACPD_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Shindell_etal_ACPD_2012a,
  author = {Shindell, D. T. and Lamarque, J.-F. and Schulz, M. and Flanner, M. and Jiao, C. and Chin, M. and Young, P. and Lee, Y. H. and Rotstayn, L. and Milly, G. and Faluvegi, G. and Balkanski, Y. and Collins, W. J. and Conley, A. J. and Dalsoren, S. and Easter, R. and Ghan, S. and Horowitz, L. and Liu, X. and Myhre, G. and Nagashima, T. and Naik, V. and Rumbold, S. and Skeie, R. and Sudo, K. and Szopa, S. and Takemura, T. and Voulgarakis, A. and Yoon, J.-H.},
  title = {Radiative forcing in the ACCMIP historical and future climate simulations},
  journal = {Atmospheric Chemistry &amp; Physics Discussions},
  year = {2012},
  volume = {12},
  pages = {21105-21210},
  url = {http://adsabs.harvard.edu/abs/2012ACPD...1221105S},
  doi = {https://doi.org/10.5194/acpd-12-21105-2012}
}
</pre></td>
</tr>
<tr id="Asmi_etal_ACP_2016a" class="entry">
	<td>Asmi, E., Kondratyev, V., Brus, D., Laurila, T., Lihavainen, H., Backman, J., Vakkari, V., Aurela, M., Hatakka, J., Viisanen, Y., Uttal, T., Ivakhov, V. and Makshtas, A.</td>
	<td>Aerosol size distribution seasonal characteristics measured in Tiksi, Russian Arctic <p class="infolinks">[<a href="javascript:toggleInfo('Asmi_etal_ACP_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Asmi_etal_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16, pp. 1271-1287&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-1271-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016ACP....16.1271A">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Asmi_etal_ACP_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Four years of continuous aerosol number size distribution measurements from the Arctic Climate Observatory in Tiksi, Russia, are analyzed. Tiksi is located in a region where in situ information on aerosol particle properties has not been previously available. Particle size distributions were measured with a differential mobility particle sizer (in the diameter range of 7-500 nm) and with an aerodynamic particle sizer (in the diameter range of 0.5-10 &mu;m). Source region effects on particle modal features and number, and mass concentrations are presented for different seasons. The monthly median total aerosol number concentration in Tiksi ranges from 184 cm^-3 in November to 724 cm^-3 in July, with a local maximum in March of 481 cm^-3. The total mass concentration has a distinct maximum in February-March of 1.72-2.38 &mu;g m^-3 and two minimums in June (0.42 &mu;g m^-3) and in September-October (0.36-0.57 &mu;g m^-3). These seasonal cycles in number and mass concentrations are related to isolated processes and phenomena such as Arctic haze in early spring, which increases accumulation and coarse-mode numbers, and secondary particle formation in spring and summer, which affects the nucleation and Aitken mode particle concentrations. Secondary particle formation was frequently observed in Tiksi and was shown to be slightly more common in marine, in comparison to continental, air flows. Particle formation rates were the highest in spring, while the particle growth rates peaked in summer. These results suggest two different origins for secondary particles, anthropogenic pollution being the important source in spring and biogenic emissions being significant in summer. The impact of temperature-dependent natural emissions on aerosol and cloud condensation nuclei numbers was significant: the increase in both the particle mass and the CCN (cloud condensation nuclei) number with temperature was found to be higher than in any previous study done over the boreal forest region. In addition to the precursor emissions of biogenic volatile organic compounds, the frequent Siberian forest fires, although far away, are suggested to play a role in Arctic aerosol composition during the warmest months. Five fire events were isolated based on clustering analysis, and the particle mass and cloud condensation nuclei number were shown to be somewhat affected by these events. In addition, during calm and cold months, aerosol concentrations were occasionally increased by local aerosol sources in trapping inversions. These results provide valuable information on interannual cycles and sources of Arctic aerosols.</td>
</tr>
<tr id="bib_Asmi_etal_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Asmi_etal_ACP_2016a,
  author = {Asmi, E. and Kondratyev, V. and Brus, D. and Laurila, T. and Lihavainen, H. and Backman, J. and Vakkari, V. and Aurela, M. and Hatakka, J. and Viisanen, Y. and Uttal, T. and Ivakhov, V. and Makshtas, A.},
  title = {Aerosol size distribution seasonal characteristics measured in Tiksi, Russian Arctic},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2016},
  volume = {16},
  pages = {1271-1287},
  url = {http://adsabs.harvard.edu/abs/2016ACP....16.1271A},
  doi = {https://doi.org/10.5194/acp-16-1271-2016}
}
</pre></td>
</tr>
<tr id="Astitha_etal_ACP_2012a" class="entry">
	<td>Astitha, M., Lelieveld, J., Abdel Kader, M., Pozzer, A. and de Meij, A.</td>
	<td>Parameterization of dust emissions in the global atmospheric chemistry-climate model EMAC: impact of nudging and soil properties <p class="infolinks">[<a href="javascript:toggleInfo('Astitha_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Astitha_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 11057-11083&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-11057-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....1211057A">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Astitha_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Airborne desert dust influences radiative transfer, atmospheric chemistry and dynamics, as well as nutrient transport and deposition. It directly and indirectly affects climate on regional and global scales. Two versions of a parameterization scheme to compute desert dust emissions are incorporated into the atmospheric chemistry general circulation model EMAC (ECHAM5/MESSy2.41 Atmospheric Chemistry). One uses a globally uniform soil particle size distribution, whereas the other explicitly accounts for different soil textures worldwide. We have tested these two versions and investigated the sensitivity to input parameters, using remote sensing data from the Aerosol Robotic Network (AERONET) and dust concentrations and deposition measurements from the AeroCom dust benchmark database (and others). The two versions are shown to produce similar atmospheric dust loads in the N-African region, while they deviate in the Asian, Middle Eastern and S-American regions. The dust outflow from Africa over the Atlantic Ocean is accurately simulated by both schemes, in magnitude, location and seasonality. Approximately 70&#37; of the modelled annual deposition data and 70-75&#37; of the modelled monthly aerosol optical depth (AOD) in the Atlantic Ocean stations lay in the range 0.5 to 2 times the observations for all simulations. The two versions have similar performance, even though the total annual source differs by &tilde;50 which underscores the importance of transport and deposition processes (being the same for both versions). Even though the explicit soil particle size distribution is considered more realistic, the simpler scheme appears to perform better in several locations. This paper discusses the differences between the two versions of the dust emission scheme, focusing on their limitations and strengths in describing the global dust cycle and suggests possible future improvements.</td>
</tr>
<tr id="bib_Astitha_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Astitha_etal_ACP_2012a,
  author = {Astitha, M. and Lelieveld, J. and Abdel Kader, M. and Pozzer, A. and de Meij, A.},
  title = {Parameterization of dust emissions in the global atmospheric chemistry-climate model EMAC: impact of nudging and soil properties},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {11057-11083},
  url = {http://adsabs.harvard.edu/abs/2012ACP....1211057A},
  doi = {https://doi.org/10.5194/acp-12-11057-2012}
}
</pre></td>
</tr>
<tr id="Balkanski_etal_ACP_2007a" class="entry">
	<td>Balkanski, Y., Schulz, M., Claquin, T. and Guibert, S.</td>
	<td>Reevaluation of Mineral aerosol radiative forcings suggests a better agreement with satellite and AERONET data <p class="infolinks">[<a href="javascript:toggleInfo('Balkanski_etal_ACP_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Balkanski_etal_ACP_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 7, pp. 81-95&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2007ACP.....7...81B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Balkanski_etal_ACP_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Modelling studies and satellite retrievals do not agree on the amplitude
<br>and/or sign of the direct radiative perturbation from dust. Modelling
<br>studies have systematically overpredicted mineral dust absorption
<br>compared to estimates based upon satellite retrievals. In this paper we
<br>first point out the source of this discrepancy, which originates from
<br>the shortwave refractive index of dust used in models. The imaginary
<br>part of the refractive index retrieved from AERONET over the range 300
<br>to 700 nm is 3 to 6 times smaller than that used previously to model
<br>dust. We attempt to constrain these refractive indices using a
<br>mineralogical database and varying the abundances of iron oxides (the
<br>main absorber in the visible). We first consider the optically active
<br>mineral constituents of dust and compute the refractive indices from
<br>internal and external mixtures of minerals with relative amounts
<br>encountered in parent soils. We then compute the radiative perturbation
<br>due to mineral aerosols for internally and externally mixed minerals for
<br>3 different hematite contents, 0.9 1.5&#37; and 2.7&#37; by volume. These
<br>constant amounts of hematite allow bracketing the influence of dust
<br>aerosol when it is respectively an inefficient, standard and a very
<br>efficient absorber. These values represent low, central and high content
<br>of iron oxides in dust determined from the mineralogical database. Linke
<br>et al. (2006) determined independently that iron-oxides represent 1.0 to
<br>2.5&#37; by volume using x-Ray fluorescence on 4 different samples collected
<br>over Morocco and Egypt. Based upon values of the refractive index
<br>retrieved from AERONET, we show that the best agreement between 440 and
<br>1020 nm occurs for mineral dust internally mixed with 1.5&#37; volume
<br>weighted hematite. This representation of mineral dust allows us to
<br>compute, using a general circulation model, a new global estimate of
<br>mineral dust perturbation between -0.47 and -0.24 Wm^-2
<br>at the top of the atmosphere, and between -0.81 and -1.13
<br>Wm^-2 at the surface for both shortwave and longwave
<br>wavelengths. The anthropogenic dust fraction is thought to account for
<br>between 10 and 50&#37; of the total dust load present in the atmosphere. We
<br>estimate a top of the atmosphere forcing between -0.03 and -0.25
<br>Wm^-2, which is markedly different that the IPCC range
<br>of -0.6 to +0.4 Wm^-2 (IPCC, 2001). The 24-h average
<br>atmospheric heating by mineral dust during summer over the tropical
<br>Atlantic region (15deg N-25deg N; 45deg W-15deg W) is in the
<br>range +22 to +32 Wm^-2 &tau;^-1 which
<br>compares well with the 30plusmn4 Wm^-2
<br>&tau;^-1 measured by Li et al. (2004) over that same
<br>region. The refractive indices from Patterson et al. (1977) and from
<br>Volz (1973) overestimate by a factor of 2 the energy absorbed in the
<br>column during summer over the same region. This discrepancy is due to
<br>too large absorption in the visible but we could not determine if this
<br>is linked to the sample studied by Patterson et al. (1997) or to the
<br>method used in determining the refractive index.
<br></td>
</tr>
<tr id="bib_Balkanski_etal_ACP_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Balkanski_etal_ACP_2007a,
  author = {Balkanski, Y. and Schulz, M. and Claquin, T. and Guibert, S.},
  title = {Reevaluation of Mineral aerosol radiative forcings suggests a better agreement with satellite and AERONET data},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2007},
  volume = {7},
  pages = {81-95},
  url = {http://adsabs.harvard.edu/abs/2007ACP.....7...81B}
}
</pre></td>
</tr>
<tr id="Balkanski_etal_ACP_2010a" class="entry">
	<td>Balkanski, Y., Myhre, G., Gauss, M., R&auml;del, G., Highwood, E.J. and Shine, K.P.</td>
	<td>Direct radiative effect of aerosols emitted by transport: from road, shipping and aviation <p class="infolinks">[<a href="javascript:toggleInfo('Balkanski_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Balkanski_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 4477-4489&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2010ACP....10.4477B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Balkanski_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosols and their precursors are emitted abundantly by transport
<br>activities. Transportation constitutes one of the fastest growing
<br>activities and its growth is predicted to increase significantly in the
<br>future. Previous studies have estimated the aerosol direct radiative
<br>forcing from one transport sub-sector, but only one study to our
<br>knowledge estimated the range of radiative forcing from the main aerosol
<br>components (sulphate, black carbon (BC) and organic carbon) for the
<br>whole transportation sector. In this study, we compare results from two
<br>different chemical transport models and three radiation codes under
<br>different hypothesis of mixing: internal and external mixing using
<br>emission inventories for the year 2000. The main results from this study
<br>consist of a positive direct radiative forcing for aerosols emitted by
<br>road traffic of +20plusmn11 mW m^-2 for an externally
<br>mixed aerosol, and of +32plusmn13 mW m^-2 when BC is
<br>internally mixed. These direct radiative forcings are much higher than
<br>the previously published estimate of +3plusmn11 mW
<br>m^-2. For transport activities from shipping, the net
<br>direct aerosol radiative forcing is negative. This forcing is dominated
<br>by the contribution of the sulphate. For both an external and an
<br>internal mixture, the radiative forcing from shipping is estimated at
<br>-26plusmn4 mW m^-2. These estimates are in very
<br>good agreement with the range of a previously published one (from
<br>-46 to -13 mW m^-2) but with a much narrower
<br>range. By contrast, the direct aerosol forcing from aviation is
<br>estimated to be small, and in the range -0.9 to +0.3 mW
<br>m^-2.
<br></td>
</tr>
<tr id="bib_Balkanski_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Balkanski_etal_ACP_2010a,
  author = {Balkanski, Y. and Myhre, G. and Gauss, M. and R&auml;del, G. and Highwood, E. J. and Shine, K. P.},
  title = {Direct radiative effect of aerosols emitted by transport: from road, shipping and aviation},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {4477-4489},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.4477B}
}
</pre></td>
</tr>
<tr id="Bian_etal_ACP_2009a" class="entry">
	<td>Bian, H., Chin, M., Rodriguez, J.M., Yu, H., Penner, J.E. and Strahan, S.</td>
	<td>Sensitivity of aerosol optical thickness and aerosol direct radiative effect to relative humidity <p class="infolinks">[<a href="javascript:toggleInfo('Bian_etal_ACP_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Bian_etal_ACP_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 9, pp. 2375-2386&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009ACP.....9.2375B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Bian_etal_ACP_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present a sensitivity study of the effects of spatial and temporal resolution of atmospheric relative humidity (RH) on calculated aerosol optical thickness (AOT) and the aerosol direct radiative effects (DRE) in a global model. We carry out different modeling experiments using the same aerosol fields simulated in the Global Modeling Initiative (GMI) model at a resolution of 2deg latitude by 2.5deg longitude, using time-averaged fields archived every three hours by the Goddard Earth Observation System Version 4 (GEOS-4), but we change the horizontal and temporal resolution of the relative humidity fields. We find that, on a global average, the AOT calculated using RH at a 1deg&times;1.25deg horizontal resolution is 11&#37; higher than that using RH at a 2deg&times;2.5deg resolution, and the corresponding DRE at the top of the atmosphere is 8-9&#37; and 15&#37; more negative (i.e., more cooling) for total aerosols and anthropogenic aerosol alone, respectively, in the finer spatial resolution case. The difference is largest over surface escarpment regions (e.g. gt200&#37; over the Andes Mountains) where RH varies substantially with surface terrain. The largest zonal mean AOT difference occurs at 50-60deg N (16-21, where AOT is also relatively larger. A similar impact is also found when the time resolution of RH is increased. This increase of AOT and aerosol cooling with the increase of model resolution is due to the highly non-linear relationship between RH and the aerosol mass extinction efficiency (MEE) at high RH (gt80. Our study is a specific example of the uncertainty in model results highlighted by multi-model comparisons such as AeroCom, and points out one of the many inter-model differences that can contribute to the overall spread among models.</td>
</tr>
<tr id="bib_Bian_etal_ACP_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Bian_etal_ACP_2009a,
  author = {Bian, H. and Chin, M. and Rodriguez, J. M. and Yu, H. and Penner, J. E. and Strahan, S.},
  title = {Sensitivity of aerosol optical thickness and aerosol direct radiative effect to relative humidity},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2009},
  volume = {9},
  pages = {2375-2386},
  url = {http://adsabs.harvard.edu/abs/2009ACP.....9.2375B}
}
</pre></td>
</tr>
<tr id="Bian_etal_ACP_2017a" class="entry">
	<td>Bian, H., Chin, M., Hauglustaine, D.A., Schulz, M., Myhre, G., Bauer, S.E., Lund, M.T., Karydis, V.A., Kucsera, T.L., Pan, X., Pozzer, A., Skeie, R.B., Steenrod, S.D., Sudo, K., Tsigaridis, K., Tsimpidi, A.P. and Tsyro, S.G.</td>
	<td>Investigation of global particulate nitrate from the AeroCom phase III experiment <p class="infolinks">[<a href="javascript:toggleInfo('Bian_etal_ACP_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Bian_etal_ACP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 17, pp. 12911-12940&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-12911-2017">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017ACP....1712911B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Bian_etal_ACP_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: An assessment of global particulate nitrate and ammonium aerosol based on simulations from nine models participating in the Aerosol Comparisons between Observations and Models (AeroCom) phase III study is presented. A budget analysis was conducted to understand the typical magnitude, distribution, and diversity of the aerosols and their precursors among the models. To gain confidence regarding model performance, the model results were evaluated with various observations globally, including ground station measurements over North America, Europe, and east Asia for tracer concentrations and dry and wet depositions, as well as with aircraft measurements in the Northern Hemisphere mid-to-high latitudes for tracer vertical distributions. Given the unique chemical and physical features of the nitrate occurrence, we further investigated the similarity and differentiation among the models by examining (1) the pH-dependent NH_3 wet deposition; (2) the nitrate formation via heterogeneous chemistry on the surface of dust and sea salt particles or thermodynamic equilibrium calculation including dust and sea salt ions; and (3) the nitrate coarse-mode fraction (i.e., coarse/total). It is found that HNO_3, which is simulated explicitly based on full O_3-HO_x-NO_x-aerosol chemistry by all models, differs by up to a factor of 9 among the models in its global tropospheric burden. This partially contributes to a large difference in NO_3^-, whose atmospheric burden differs by up to a factor of 13. The atmospheric burdens of NH_3 and NH_4^+ differ by 17 and 4, respectively. Analyses at the process level show that the large diversity in atmospheric burdens of NO_3^-, NH_3, and NH_4^+ is also related to deposition processes. Wet deposition seems to be the dominant process in determining the diversity in NH_3 and NH_4^+ lifetimes. It is critical to correctly account for contributions of heterogeneous chemical production of nitrate on dust and sea salt, because this process overwhelmingly controls atmospheric nitrate production (typically gt 80  and determines the coarse- and fine-mode distribution of nitrate aerosol.</td>
</tr>
<tr id="bib_Bian_etal_ACP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Bian_etal_ACP_2017a,
  author = {Bian, H. and Chin, M. and Hauglustaine, D. A. and Schulz, M. and Myhre, G. and Bauer, S. E. and Lund, M. T. and Karydis, V. A. and Kucsera, T. L. and Pan, X. and Pozzer, A. and Skeie, R. B. and Steenrod, S. D. and Sudo, K. and Tsigaridis, K. and Tsimpidi, A. P. and Tsyro, S. G.},
  title = {Investigation of global particulate nitrate from the AeroCom phase III experiment},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2017},
  volume = {17},
  pages = {12911-12940},
  url = {http://adsabs.harvard.edu/abs/2017ACP....1712911B},
  doi = {https://doi.org/10.5194/acp-17-12911-2017}
}
</pre></td>
</tr>
<tr id="Boose_etal_ACP_2016a" class="entry">
	<td>Boose, Y., Sierau, B., Garc\ia, M.I., Rodr\iguez, S., Alastuey, A., Linke, C., Schnaiter, M., Kupiszewski, P., Kanji, Z.A. and Lohmann, U.</td>
	<td>Ice nucleating particles in the Saharan Air Layer <p class="infolinks">[<a href="javascript:toggleInfo('Boose_etal_ACP_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Boose_etal_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16, pp. 9067-9087&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-9067-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016ACP....16.9067B">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Boose_etal_ACP_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This study aims at quantifying the ice nucleation properties of desert dust in the Saharan Air Layer (SAL), the warm, dry and dust-laden layer that expands from North Africa to the Americas. By measuring close to the dust's emission source, before aging processes during the transatlantic advection potentially modify the dust properties, the study fills a gap between in situ measurements of dust ice nucleating particles (INPs) far away from the Sahara and laboratory studies of ground-collected soil. Two months of online INP concentration measurements are presented, which were part of the two CALIMA campaigns at the Iza&ntilde;a observatory in Tenerife, Spain (2373 m a.s.l.), in the summers of 2013 and 2014. INP concentrations were measured in the deposition and condensation mode at temperatures between 233 and 253 K with the Portable Ice Nucleation Chamber (PINC). Additional aerosol information such as bulk chemical composition, concentration of fluorescent biological particles as well as the particle size distribution was used to investigate observed variations in the INP concentration. <BR /><BR /> The concentration of INPs was found to range between 0.2 std L^-1 in the deposition mode and up to 2500 std L^-1 in the condensation mode at 240 K. It correlates well with the abundance of aluminum, iron, magnesium and manganese (R: 0.43-0.67) and less with that of calcium, sodium or carbonate. These observations are consistent with earlier results from laboratory studies which showed a higher ice nucleation efficiency of certain feldspar and clay minerals compared to other types of mineral dust. We find that an increase of ammonium sulfate, linked to anthropogenic emissions in upwind distant anthropogenic sources, mixed with the desert dust has a small positive effect on the condensation mode INP per dust mass ratio but no effect on the deposition mode INP. Furthermore, the relative abundance of biological particles was found to be significantly higher in INPs compared to the ambient aerosol. Overall, this suggests that atmospheric aging processes in the SAL can lead to an increase in ice nucleation ability of mineral dust from the Sahara. INP concentrations predicted with two common parameterization schemes, which were derived mostly from atmospheric measurements far away from the Sahara but influenced by Asian and Saharan dust, were found to be higher based on the aerosol load than we observed in the SAL, further suggesting aging effects of INPs in the SAL.</td>
</tr>
<tr id="bib_Boose_etal_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Boose_etal_ACP_2016a,
  author = {Boose, Y. and Sierau, B. and Garc\ia, M. I. and Rodr\iguez, S. and Alastuey, A. and Linke, C. and Schnaiter, M. and Kupiszewski, P. and Kanji, Z. A. and Lohmann, U.},
  title = {Ice nucleating particles in the Saharan Air Layer},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2016},
  volume = {16},
  pages = {9067-9087},
  url = {http://adsabs.harvard.edu/abs/2016ACP....16.9067B},
  doi = {https://doi.org/10.5194/acp-16-9067-2016}
}
</pre></td>
</tr>
<tr id="Caponi_etal_ACP_2017a" class="entry">
	<td>Caponi, L., Formenti, P., Massab&oacute;, D., Di Biagio, C., Cazaunau, M., Pangui, E., Chevaillier, S., Landrot, G., Andreae, M.O., Kandler, K., Piketh, S., Saeed, T., Seibert, D., Williams, E., Balkanski, Y., Prati, P. and Doussin, J.-F.</td>
	<td>Spectral- and size-resolved mass absorption efficiency of mineral dust aerosols in the shortwave spectrum: a simulation chamber study <p class="infolinks">[<a href="javascript:toggleInfo('Caponi_etal_ACP_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Caponi_etal_ACP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 17, pp. 7175-7191&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-7175-2017">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017ACP....17.7175C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Caponi_etal_ACP_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper presents new laboratory measurements of the mass absorption
<br>efficiency (MAE) between 375 and 850 nm for 12 individual samples of
<br>mineral dust from different source areas worldwide and in two size
<br>classes: PM_10. 6 (mass fraction of particles of aerodynamic
<br>diameter lower than 10.6 microm) and PM_2. 5 (mass fraction
<br>of particles of aerodynamic diameter lower than 2.5 microm). The
<br>experiments were performed in the CESAM simulation chamber using mineral
<br>dust generated from natural parent soils and included optical and
<br>gravimetric analyses. <BR /><BR /> The results show that the MAE values
<br>are lower for the PM_10. 6 mass fraction (range 37-135 &times;
<br>10^-3 m^2 g^-1 at 375 nm) than for the
<br>PM_2. 5 (range 95-711 &times; 10^-3 m^2
<br>g^-1 at 375 nm) and decrease with increasing wavelength as
<br>&lambda;^-AAE, where the &Aring;ngstr&ouml;m absorption
<br>exponent (AAE) averages between 3.3 and 3.5, regardless of size. The
<br>size independence of AAE suggests that, for a given size distribution,
<br>the dust composition did not vary with size for this set of samples.
<br>Because of its high atmospheric concentration, light absorption by
<br>mineral dust can be competitive with black and brown carbon even during
<br>atmospheric transport over heavy polluted regions, when dust
<br>concentrations are significantly lower than at emission. The AAE values
<br>of mineral dust are higher than for black carbon (tildeampthinsp;1)
<br>but in the same range as light-absorbing organic (brown) carbon. As a
<br>result, depending on the environment, there can be some ambiguity in
<br>apportioning the aerosol absorption optical depth (AAOD) based on
<br>spectral dependence, which is relevant to the development of remote
<br>sensing of light-absorbing aerosols and their assimilation in climate
<br>models. We suggest that the sample-to-sample variability in our dataset
<br>of MAE values is related to regional differences in the mineralogical
<br>composition of the parent soils. Particularly in the PM_2. 5
<br>fraction, we found a strong linear correlation between the dust
<br>light-absorption properties and elemental iron rather than the iron
<br>oxide fraction, which could ease the application and the validation of
<br>climate models that now start to include the representation of the dust
<br>composition, as well as for remote sensing of dust absorption in the
<br>UV-vis spectral region.
<br></td>
</tr>
<tr id="bib_Caponi_etal_ACP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Caponi_etal_ACP_2017a,
  author = {Caponi, L. and Formenti, P. and Massab&oacute;, D. and Di Biagio, C. and Cazaunau, M. and Pangui, E. and Chevaillier, S. and Landrot, G. and Andreae, M. O. and Kandler, K. and Piketh, S. and Saeed, T. and Seibert, D. and Williams, E. and Balkanski, Y. and Prati, P. and Doussin, J.-F.},
  title = {Spectral- and size-resolved mass absorption efficiency of mineral dust aerosols in the shortwave spectrum: a simulation chamber study},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2017},
  volume = {17},
  pages = {7175-7191},
  url = {http://adsabs.harvard.edu/abs/2017ACP....17.7175C},
  doi = {https://doi.org/10.5194/acp-17-7175-2017}
}
</pre></td>
</tr>
<tr id="Cazorla_etal_ACP_2017a" class="entry">
	<td>Cazorla, A., Andr&eacute;s Casquero-Vera, J., Rom&aacute;n, R., Guerrero-Rascado, J.L., Toledano, C., Cachorro, V.E., Orza, J.A.G., Cancillo, M.L., Serrano, A., Titos, G., Pandolfi, M., Alastuey, A., Hanrieder, N. and Alados-Arboledas, L.</td>
	<td>Near-real-time processing of a ceilometer network assisted with sun-photometer data: monitoring a dust outbreak over the Iberian Peninsula <p class="infolinks">[<a href="javascript:toggleInfo('Cazorla_etal_ACP_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Cazorla_etal_ACP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 17, pp. 11861-11876&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-11861-2017">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017ACP....1711861C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Cazorla_etal_ACP_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The interest in the use of ceilometers for optical aerosol characterization has increased in the last few years. They operate continuously almost unattended and are also much less expensive than lidars; hence, they can be distributed in dense networks over large areas. However, due to the low signal-to-noise ratio it is not always possible to obtain particle backscatter coefficient profiles, and the vast number of data generated require an automated and unsupervised method that ensures the quality of the profiles inversions. <BR /><BR /> In this work we describe a method that uses aerosol optical depth (AOD) measurements from the AERONET network that it is applied for the calibration and automated quality assurance of inversion of ceilometer profiles. The method is compared with independent inversions obtained by co-located multiwavelength lidar measurements. A difference smaller than 15 &#37; in backscatter is found between both instruments. This method is continuously and automatically applied to the Iberian Ceilometer Network (ICENET) and a case example during an unusually intense dust outbreak affecting the Iberian Peninsula between 20 and 24 February 2016 is shown. Results reveal that it is possible to obtain quantitative optical aerosol properties (particle backscatter coefficient) and discriminate the quality of these retrievals with ceilometers over large areas. This information has a great potential for alert systems and model assimilation and evaluation.</td>
</tr>
<tr id="bib_Cazorla_etal_ACP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Cazorla_etal_ACP_2017a,
  author = {Cazorla, A. and Andr&eacute;s Casquero-Vera, J. and Rom&aacute;n, R. and Guerrero-Rascado, J. L. and Toledano, C. and Cachorro, V. E. and Orza, J. A. G. and Cancillo, M. L. and Serrano, A. and Titos, G. and Pandolfi, M. and Alastuey, A. and Hanrieder, N. and Alados-Arboledas, L.},
  title = {Near-real-time processing of a ceilometer network assisted with sun-photometer data: monitoring a dust outbreak over the Iberian Peninsula},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2017},
  volume = {17},
  pages = {11861-11876},
  url = {http://adsabs.harvard.edu/abs/2017ACP....1711861C},
  doi = {https://doi.org/10.5194/acp-17-11861-2017}
}
</pre></td>
</tr>
<tr id="Che_etal_ACP_2016a" class="entry">
	<td>Che, Y., Xue, Y., Mei, L., Guang, J., She, L., Guo, J., Hu, Y., Xu, H., He, X., Di, A. and Fan, C.</td>
	<td>Technical note: Intercomparison of three AATSR Level 2 (L2) AOD products over China <p class="infolinks">[<a href="javascript:toggleInfo('Che_etal_ACP_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Che_etal_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16, pp. 9655-9674&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-9655-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016ACP....16.9655C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Che_etal_ACP_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: One of four main focus areas of the PEEX initiative is to establish and sustain long-term, continuous, and comprehensive ground-based, airborne, and seaborne observation infrastructure together with satellite data. The Advanced Along-Track Scanning Radiometer (AATSR) aboard ENVISAT is used to observe the Earth in dual view. The AATSR data can be used to retrieve aerosol optical depth (AOD) over both land and ocean, which is an important parameter in the characterization of aerosol properties. In recent years, aerosol retrieval algorithms have been developed both over land and ocean, taking advantage of the features of dual view, which can help eliminate the contribution of Earth's surface to top-of-atmosphere (TOA) reflectance. The Aerosolcci project, as a part of the Climate Change Initiative (CCI), provides users with three AOD retrieval algorithms for AATSR data, including the Swansea algorithm (SU), the ATSR-2ATSR dual-view aerosol retrieval algorithm (ADV), and the Oxford-RAL Retrieval of Aerosol and Cloud algorithm (ORAC). The validation team of the Aerosol-CCI project has validated AOD (both Level 2 and Level 3 products) and AE (&Aring;ngstr&ouml;m Exponent) (Level 2 product only) against the AERONET data in a round-robin evaluation using the validation tool of the AeroCOM (Aerosol Comparison between Observations and Models) project. For the purpose of evaluating different performances of these three algorithms in calculating AODs over mainland China, we introduce ground-based data from CARSNET (China Aerosol Remote Sensing Network), which was designed for aerosol observations in China. Because China is vast in territory and has great differences in terms of land surfaces, the combination of the AERONET and CARSNET data can validate the L2 AOD products more comprehensively. The validation results show different performances of these products in 2007, 2008, and 2010. The SU algorithm performs very well over sites with different surface conditions in mainland China from March to October, but it slightly underestimates AOD over barren or sparsely vegetated surfaces in western China, with mean bias error (MBE) ranging from 0.05 to 0.10. The ADV product has the same precision with a low root mean square error (RMSE) smaller than 0.2 over most sites and the same error distribution as the SU product. The main limits of the ADV algorithm are underestimation and applicability; underestimation is particularly obvious over the sites of Datong, Lanzhou, and Urumchi, where the dominant land cover is grassland, with an MBE larger than 0.2, and the main aerosol sources are coal combustion and dust. The ORAC algorithm has the ability to retrieve AOD at different ranges, including high AOD (larger than 1.0); however, the stability deceases significantly with increasing AOD, especially when AOD gt 1.0. In addition, the ORAC product is consistent with the CARSNET product in winter (December, January, and February), whereas other validation results lack matches during winter.</td>
</tr>
<tr id="bib_Che_etal_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Che_etal_ACP_2016a,
  author = {Che, Y. and Xue, Y. and Mei, L. and Guang, J. and She, L. and Guo, J. and Hu, Y. and Xu, H. and He, X. and Di, A. and Fan, C.},
  title = {Technical note: Intercomparison of three AATSR Level 2 (L2) AOD products over China},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2016},
  volume = {16},
  pages = {9655-9674},
  url = {http://adsabs.harvard.edu/abs/2016ACP....16.9655C},
  doi = {https://doi.org/10.5194/acp-16-9655-2016}
}
</pre></td>
</tr>
<tr id="Chin_etal_ACP_2007a" class="entry">
	<td>Chin, M., Diehl, T., Ginoux, P. and Malm, W.</td>
	<td>Intercontinental transport of pollution and dust aerosols: implications for regional air quality <p class="infolinks">[<a href="javascript:toggleInfo('Chin_etal_ACP_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Chin_etal_ACP_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 7, pp. 5501-5517&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2007ACP.....7.5501C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Chin_etal_ACP_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We use the global model GOCART to examine the impact of pollution and dust aerosols emitted from their major sources on surface fine particulate matter concentrations at regional and hemispheric scales. Focusing on the North America region in 2001, we use measurements from the IMPROVE network in the United States to evaluate the model-simulated surface concentrations of the ``reconstructed fine mass'' (RCFM) and its components of ammonium sulfate, black carbon (BC), organic matter (OM), and fine mode dust. We then quantify the RCFM budget in terms of the RCFM chemical composition, source type, and region of origin to find that in the eastern U.S., ammonium sulfate is the dominant RCFM component (&tilde;60 whereas in the western U.S., dust and OM are just as important as sulfate but have considerable seasonal variations, especially in the NW. On an annual average, pollution aerosol (defined as aerosols from fuel combustion for industrial and transportation uses) from North America accounts for 65-70&#37; of the surface RCFM in the eastern U.S. and for a lower proportion of 30-40&#37; in the western U.S.; by contrast, pollution from outside of North America contributes to just 2-6&#37; (&tilde;0.2 &mu;g m^-3) of the total RCFM over the U.S. In comparison, long-range transport of dust brings 3 to 4 times more fine particles than the transport of pollution to the U.S. (0.5-0.8 &mu;g m^-3 on an annual average) with a maximum influence in spring and over the NW. Of the major pollution regions, Europe has the largest potential to affect the surface aerosol concentrations in other continents due to its shorter distance from receptor continents and its larger fraction of sulfate-producing precursor gas in the outflow. With the IPCC emission scenario for the year 2000, we find that European emissions increase levels of ammonium sulfate by 1-5 &mu;g m^-3 over the surface of northern Africa and western Asia, and its contribution to eastern Asia (ge0.2 &mu;g m^-3) is twice as much as the Asian contribution to North America. Asia and North America pollution emissions exert strong impacts on their neighboring oceans, but their influences over other continents are relatively small (le10 due to long traveling distances across the oceans and efficient removal during transport. Among the major dust source regions, Asia displays a significant influence over large areas in the northern hemisphere except over the North Atlantic and the tropics, where African dust dominates. We also notice that the African dust and European pollution can travel eastward through a pathway spanning across Asia and North Pacific to western North America; such a pathway is difficult to detect because these aerosols usually merge and travel together with Asian dust and pollution labeled as ``Asian outflow''.</td>
</tr>
<tr id="bib_Chin_etal_ACP_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Chin_etal_ACP_2007a,
  author = {Chin, M. and Diehl, T. and Ginoux, P. and Malm, W.},
  title = {Intercontinental transport of pollution and dust aerosols: implications for regional air quality},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2007},
  volume = {7},
  pages = {5501-5517},
  url = {http://adsabs.harvard.edu/abs/2007ACP.....7.5501C}
}
</pre></td>
</tr>
<tr id="Deandreis_etal_ACP_2012a" class="entry">
	<td>D&eacute;andreis, C., Balkanski, Y., Dufresne, J.L. and Cozic, A.</td>
	<td>Radiative forcing estimates of sulfate aerosol in coupled climate-chemistry models with emphasis on the role of the temporal variability <p class="infolinks">[<a href="javascript:toggleInfo('Deandreis_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Deandreis_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 5583-5602&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-5583-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12.5583D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Deandreis_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper describes the impact on the sulfate aerosol radiative effects
<br>of coupling the radiative code of a global circulation model with a
<br>chemistry-aerosol module. With this coupling, temporal variations of
<br>sulfate aerosol concentrations influence the estimate of aerosol
<br>radiative impacts. Effects of this coupling have been assessed on net
<br>fluxes, radiative forcing and temperature for the direct and first
<br>indirect effects of sulfate. <BR /><BR /> The direct effect respond
<br>almost linearly to rapid changes in concentrations whereas the first
<br>indirect effect shows a strong non-linearity. In particular, sulfate
<br>temporal variability causes a modification of the short wave net fluxes
<br>at the top of the atmosphere of +0.24 and +0.22 W m^-2 for the
<br>present and preindustrial periods, respectively. This change is small
<br>compared to the value of the net flux at the top of the atmosphere
<br>(about 240 W m^-2). The effect is more important in regions
<br>with low-level clouds and intermediate sulfate aerosol concentrations
<br>(from 0.1 to 0.8 &mu;g (SO_4) m^-3 in our model).
<br><BR /><BR /> The computation of the aerosol direct radiative forcing is
<br>quite straightforward and the temporal variability has little effect on
<br>its mean value. In contrast, quantifying the first indirect radiative
<br>forcing requires tackling technical issues first. We show that the
<br>preindustrial sulfate concentrations have to be calculated with the same
<br>meteorological trajectory used for computing the present ones. If this
<br>condition is not satisfied, it introduces an error on the estimation of
<br>the first indirect radiative forcing. Solutions are proposed to assess
<br>radiative forcing properly. In the reference method, the coupling
<br>between chemistry and climate results in a global average increase of 8&#37; <br>in the first indirect radiative forcing. This change reaches 50&#37; in the
<br>most sensitive regions. However, the reference method is not suited to
<br>run long climate simulations. We present other methods that are simpler
<br>to implement in a coupled chemistry/climate model and that offer the
<br>possibility to assess radiative forcing.
<br></td>
</tr>
<tr id="bib_Deandreis_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Deandreis_etal_ACP_2012a,
  author = {D&eacute;andreis, C. and Balkanski, Y. and Dufresne, J. L. and Cozic, A.},
  title = {Radiative forcing estimates of sulfate aerosol in coupled climate-chemistry models with emphasis on the role of the temporal variability},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {5583-5602},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12.5583D},
  doi = {https://doi.org/10.5194/acp-12-5583-2012}
}
</pre></td>
</tr>
<tr id="Dentener_etal_ACP_2006a" class="entry">
	<td>Dentener, F., Kinne, S., Bond, T., Boucher, O., Cofala, J., Generoso, S., Ginoux, P., Gong, S., Hoelzemann, J.J., Ito, A., Marelli, L., Penner, J.E., Putaud, J.-P., Textor, C., Schulz, M., van der Werf, G.R. and Wilson, J.</td>
	<td>Emissions of primary aerosol and precursor gases in the years 2000 and 1750 prescribed data-sets for AeroCom <p class="infolinks">[<a href="javascript:toggleInfo('Dentener_etal_ACP_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dentener_etal_ACP_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 6, pp. 4321-4344&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2006ACP.....6.4321D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dentener_etal_ACP_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Inventories for global aerosol and aerosol precursor emissions have been collected (based on published inventories and published simulations), assessed and prepared for the year 2000 (present-day conditions) and for the year 1750 (pre-industrial conditions). These global datasets establish a comprehensive source for emission input to global modeling, when simulating the aerosol impact on climate with state-of-the-art aerosol component modules. As these modules stratify aerosol into dust, sea-salt, sulfate, organic matter and soot, for all these aerosol types global fields on emission strength and recommendations for injection altitude and particulate size are provided. Temporal resolution varies between daily (dust and sea-salt), monthly (wild-land fires) and annual (all other emissions). These datasets benchmark aerosol emissions according to the knowledge in the year 2004. They are intended to serve as systematic constraints in sensitivity studies of the AeroCom initiative, which seeks to quantify (actual) uncertainties in aerosol global modeling.</td>
</tr>
<tr id="bib_Dentener_etal_ACP_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dentener_etal_ACP_2006a,
  author = {Dentener, F. and Kinne, S. and Bond, T. and Boucher, O. and Cofala, J. and Generoso, S. and Ginoux, P. and Gong, S. and Hoelzemann, J. J. and Ito, A. and Marelli, L. and Penner, J. E. and Putaud, J.-P. and Textor, C. and Schulz, M. and van der Werf, G. R. and Wilson, J.},
  title = {Emissions of primary aerosol and precursor gases in the years 2000 and 1750 prescribed data-sets for AeroCom},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2006},
  volume = {6},
  pages = {4321-4344},
  url = {http://adsabs.harvard.edu/abs/2006ACP.....6.4321D}
}
</pre></td>
</tr>
<tr id="Dubovik_etal_ACP_2008a" class="entry">
	<td>Dubovik, O., Lapyonok, T., Kaufman, Y.J., Chin, M., Ginoux, P., Kahn, R.A. and Sinyuk, A.</td>
	<td>Retrieving global aerosol sources from satellites using inverse modeling <p class="infolinks">[<a href="javascript:toggleInfo('Dubovik_etal_ACP_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dubovik_etal_ACP_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 8, pp. 209-250&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2008ACP.....8..209D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dubovik_etal_ACP_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Understanding aerosol effects on global climate requires knowing the global distribution of tropospheric aerosols. By accounting for aerosol sources, transports, and removal processes, chemical transport models simulate the global aerosol distribution using archived meteorological fields. We develop an algorithm for retrieving global aerosol sources from satellite observations of aerosol distribution by inverting the GOCART aerosol transport model.    The inversion is based on a generalized, multi-term least-squares-type fitting, allowing flexible selection and refinement of a priori algorithm constraints. For example, limitations can be placed on retrieved quantity partial derivatives, to constrain global aerosol emission space and time variability in the results. Similarities and differences between commonly used inverse modeling and remote sensing techniques are analyzed. To retain the high space and time resolution of long-period, global observational records, the algorithm is expressed using adjoint operators.    Successful global aerosol emission retrievals at 2deg&times;2.5 resolution were obtained by inverting GOCART aerosol transport model output, assuming constant emissions over the diurnal cycle, and neglecting aerosol compositional differences. In addition, fine and coarse mode aerosol emission sources were inverted separately from MODIS fine and coarse mode aerosol optical thickness data, respectively. These assumptions are justified, based on observational coverage and accuracy limitations, producing valuable aerosol source locations and emission strengths. From two weeks of daily MODIS observations during August 2000, the global placement of fine mode aerosol sources agreed with available independent knowledge, even though the inverse method did not use any a priori information about aerosol sources, and was initialized with a ``zero aerosol emission'' assumption. Retrieving coarse mode aerosol emissions was less successful, mainly because MODIS aerosol data over highly reflecting desert dust sources is lacking.    The broader implications of applying our approach are also discussed.</td>
</tr>
<tr id="bib_Dubovik_etal_ACP_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dubovik_etal_ACP_2008a,
  author = {Dubovik, O. and Lapyonok, T. and Kaufman, Y. J. and Chin, M. and Ginoux, P. and Kahn, R. A. and Sinyuk, A.},
  title = {Retrieving global aerosol sources from satellites using inverse modeling},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2008},
  volume = {8},
  pages = {209-250},
  url = {http://adsabs.harvard.edu/abs/2008ACP.....8..209D}
}
</pre></td>
</tr>
<tr id="Fuzzi_etal_ACP_2015a" class="entry">
	<td>Fuzzi, S., Baltensperger, U., Carslaw, K., Decesari, S., Denier van der Gon, H., Facchini, M.C., Fowler, D., Koren, I., Langford, B., Lohmann, U., Nemitz, E., Pandis, S., Riipinen, I., Rudich, Y., Schaap, M., Slowik, J.G., Spracklen, D.V., Vignati, E., Wild, M., Williams, M. and Gilardoni, S.</td>
	<td>Particulate matter, air quality and climate: lessons learned and future needs <p class="infolinks">[<a href="javascript:toggleInfo('Fuzzi_etal_ACP_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Fuzzi_etal_ACP_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 15, pp. 8217-8299&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-15-8217-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACP....15.8217F">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Fuzzi_etal_ACP_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The literature on atmospheric particulate matter (PM), or atmospheric aerosol, has increased enormously over the last 2 decades and amounts now to some 1500-2000 papers per year in the refereed literature. This is in part due to the enormous advances in measurement technologies, which have allowed for an increasingly accurate understanding of the chemical composition and of the physical properties of atmospheric particles and of their processes in the atmosphere. The growing scientific interest in atmospheric aerosol particles is due to their high importance for environmental policy. In fact, particulate matter constitutes one of the most challenging problems both for air quality and for climate change policies. In this context, this paper reviews the most recent results within the atmospheric aerosol sciences and the policy needs, which have driven much of the increase in monitoring and mechanistic research over the last 2 decades. <BR /><BR /> The synthesis reveals many new processes and developments in the science underpinning climate-aerosol interactions and effects of PM on human health and the environment. However, while airborne particulate matter is responsible for globally important influences on premature human mortality, we still do not know the relative importance of the different chemical components of PM for these effects. Likewise, the magnitude of the overall effects of PM on climate remains highly uncertain. Despite the uncertainty there are many things that could be done to mitigate local and global problems of atmospheric PM. Recent analyses have shown that reducing black carbon (BC) emissions, using known control measures, would reduce global warming and delay the time when anthropogenic effects on global temperature would exceed 2 degC. Likewise, cost-effective control measures on ammonia, an important agricultural precursor gas for secondary inorganic aerosols (SIA), would reduce regional eutrophication and PM concentrations in large areas of Europe, China and the USA. Thus, there is much that could be done to reduce the effects of atmospheric PM on the climate and the health of the environment and the human population. <BR /><BR /> A prioritized list of actions to mitigate the full range of effects of PM is currently undeliverable due to shortcomings in the knowledge of aerosol science; among the shortcomings, the roles of PM in global climate and the relative roles of different PM precursor sources and their response to climate and land use change over the remaining decades of this century are prominent. In any case, the evidence from this paper strongly advocates for an integrated approach to air quality and climate policies.</td>
</tr>
<tr id="bib_Fuzzi_etal_ACP_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Fuzzi_etal_ACP_2015a,
  author = {Fuzzi, S. and Baltensperger, U. and Carslaw, K. and Decesari, S. and Denier van der Gon, H. and Facchini, M. C. and Fowler, D. and Koren, I. and Langford, B. and Lohmann, U. and Nemitz, E. and Pandis, S. and Riipinen, I. and Rudich, Y. and Schaap, M. and Slowik, J. G. and Spracklen, D. V. and Vignati, E. and Wild, M. and Williams, M. and Gilardoni, S.},
  title = {Particulate matter, air quality and climate: lessons learned and future needs},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2015},
  volume = {15},
  pages = {8217-8299},
  url = {http://adsabs.harvard.edu/abs/2015ACP....15.8217F},
  doi = {https://doi.org/10.5194/acp-15-8217-2015}
}
</pre></td>
</tr>
<tr id="Ginoux_etal_ACP_2012a" class="entry">
	<td>Ginoux, P., Clarisse, L., Clerbaux, C., Coheur, P.-F., Dubovik, O., Hsu, N.C. and Van Damme, M.</td>
	<td>Mixing of dust and NH_3 observed globally over anthropogenic dust sources <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 7351-7363&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-7351-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12.7351G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The global distribution of dust column burden derived from MODIS Deep Blue aerosol products is compared to NH_3 column burden retrieved from IASI infrared spectra. We found similarities in their spatial distributions, in particular their hot spots are often collocated over croplands and to a lesser extent pastures. Globally, we found 22&#37; of dust burden collocated with NH_3, with only 1&#37; difference between land-use databases. This confirms the importance of anthropogenic dust from agriculture. Regionally, the Indian subcontinent has the highest amount of dust mixed with NH_3 (26, mostly over cropland and during the pre-monsoon season. North Africa represents 50&#37; of total dust burden but accounts for only 4&#37; of mixed dust, which is found over croplands and pastures in Sahel and the coastal region of the Mediterranean. In order to evaluate the radiative effect of this mixing on dust optical properties, we derive the mass extinction efficiency for various mixtures of dust and NH_3, using AERONET sunphotometers data. We found that for dusty days the coarse mode mass extinction efficiency decreases from 0.62 to 0.48 m^2 g^-1 as NH_3 burden increases from 0 to 40 mg m^-2. The fine mode extinction efficiency, ranging from 4 to 16 m^2 g^-1, does not appear to depend on NH_3 concentration or relative humidity but rather on mineralogical composition and mixing with other aerosols. Our results imply that a significant amount of dust is already mixed with ammonium salt before its long range transport. This in turn will affect dust lifetime, and its interactions with radiation and cloud properties.</td>
</tr>
<tr id="bib_Ginoux_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal_ACP_2012a,
  author = {Ginoux, P. and Clarisse, L. and Clerbaux, C. and Coheur, P.-F. and Dubovik, O. and Hsu, N. C. and Van Damme, M.},
  title = {Mixing of dust and NH_3 observed globally over anthropogenic dust sources},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {7351-7363},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12.7351G},
  doi = {https://doi.org/10.5194/acp-12-7351-2012}
}
</pre></td>
</tr>
<tr id="Glaeser_etal_ACP_2012a" class="entry">
	<td>Gl&auml;ser, G., Kerkweg, A. and Wernli, H.</td>
	<td>The Mineral Dust Cycle in EMAC 2.40: sensitivity to the spectral resolution and the dust emission scheme <p class="infolinks">[<a href="javascript:toggleInfo('Glaeser_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Glaeser_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 1611-1627&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-1611-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12.1611G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Glaeser_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This first detailed analysis of the mineral dust cycle in the ECHAM5/MESSy Atmospheric Chemistry (EMAC) model system investigates the performance of two dust emission schemes, following the approach of Balkanski et al. (2004) and Tegen et al. (2002), respectively, and the influence of the horizontal model resolution. Here the spectral resolutions T42, T63, T85, and T106 are investigated. A basic sulphur chemistry, enabling the coating of insoluble dust particles to make them soluble, is employed in order to realistically describe the ageing and wet deposition of mineral dust. Independent of the dust emission scheme the five-year simulations with the horizontal resolutions T42 and T63 produce unrealistically high emissions at some grid points in the Tarim Basin in Central Asia, leading to very high dust loads in polar regions. With these coarse resolutions, dust source grid points in the basin and elevated grid points of the Himalayas with high wind speeds cannot be distinguished, causing this overestimation. In T85 and T106 these regions are well separated and considerably less dust is emitted there. With the chosen model setup, the dust emission scheme by Balkanski et al. (2004) places the global maximum of emissions in the Thar Desert in India. This is unrealistic as the Sahara Desert is known to be the largest dust source in the world. This is the main deficiency of this scheme compared to the one by Tegen et al. (2002), which, based on a qualitative comparison to AEROCOM data, produces a very reasonable distribution of emissions and dust loads in simulations with resolutions T85 and T106. For future climate simulations with EMAC focusing on mineral dust, we recommend to use the dust emission scheme by Tegen et al. (2002) and a model resolution of at least T85. Simulations of two selected episodes and comparison to observational data sets show that in this model configuration EMAC is able to realistically simulate also intense, episodic events of dust emission and long-range transport.</td>
</tr>
<tr id="bib_Glaeser_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Glaeser_etal_ACP_2012a,
  author = {Gl&auml;ser, G. and Kerkweg, A. and Wernli, H.},
  title = {The Mineral Dust Cycle in EMAC 2.40: sensitivity to the spectral resolution and the dust emission scheme},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {1611-1627},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12.1611G},
  doi = {https://doi.org/10.5194/acp-12-1611-2012}
}
</pre></td>
</tr>
<tr id="Goto_etal_ACP_2011a" class="entry">
	<td>Goto, D., Nakajima, T., Takemura, T. and Sudo, K.</td>
	<td>A study of uncertainties in the sulfate distribution and its radiative forcing associated with sulfur chemistry in a global aerosol model <p class="infolinks">[<a href="javascript:toggleInfo('Goto_etal_ACP_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Goto_etal_ACP_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 11, pp. 10889-10910&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-11-10889-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011ACP....1110889G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Goto_etal_ACP_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The direct radiative forcing by sulfate aerosols is still uncertain, mainly because the uncertainties are largely derived from differences in sulfate column burdens and its vertical distributions among global aerosol models. One possible reason for the large difference in the computed values is that the radiative forcing delicately depends on various simplifications of the sulfur processes made in the models. In this study, therefore, we investigated impacts of different parts of the sulfur chemistry module in a global aerosol model, SPRINTARS, on the sulfate distribution and its radiative forcing. Important studies were effects of simplified and more physical-based sulfur processes in terms of treatment of sulfur chemistry, oxidant chemistry, and dry deposition process of sulfur components. The results showed that the difference in the aqueous-phase sulfur chemistry among these treatments has the largest impact on the sulfate distribution. Introduction of all the improvements mentioned above brought the model values noticeably closer to in-situ measurements than those in the simplified methods used in the original SPRINTARS model. At the same time, these improvements also brought the computed sulfate column burdens and its vertical distributions into good agreement with other AEROCOM model values. The global annual mean radiative forcing due to the direct effect of anthropogenic sulfate aerosol was thus estimated to be -0.26 W m^-2 (-0.30 W m^-2 with a different SO_2 inventory), whereas the original SPRINTARS model showed -0.18 W m^-2 (-0.21 W m^-2 with a different SO_2 inventory). The magnitude of the difference between original and improved methods was approximately 50&#37; of the uncertainty among estimates by the world's global aerosol models reported by the IPCC-AR4 assessment report. Findings in the present study, therefore, may suggest that the model differences in the simplifications of the sulfur processes are still a part of the large uncertainty in their simulated radiative forcings.</td>
</tr>
<tr id="bib_Goto_etal_ACP_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Goto_etal_ACP_2011a,
  author = {Goto, D. and Nakajima, T. and Takemura, T. and Sudo, K.},
  title = {A study of uncertainties in the sulfate distribution and its radiative forcing associated with sulfur chemistry in a global aerosol model},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2011},
  volume = {11},
  pages = {10889-10910},
  url = {http://adsabs.harvard.edu/abs/2011ACP....1110889G},
  doi = {https://doi.org/10.5194/acp-11-10889-2011}
}
</pre></td>
</tr>
<tr id="Hauglustaine_etal_ACP_2014a" class="entry">
	<td>Hauglustaine, D.A., Balkanski, Y. and Schulz, M.</td>
	<td>A global model simulation of present and future nitrate aerosols and their direct radiative forcing of climate <p class="infolinks">[<a href="javascript:toggleInfo('Hauglustaine_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Hauglustaine_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14(20), pp. 11031-11063&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-11031-2014">DOI</a> <a href="www.atmos-chem-phys.net/14/11031/2014/">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Hauglustaine_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The ammonia cycle and nitrate particle formation are introduced into the
<br>LMDz-INCA (Laboratoire de M&eacute;t&eacute;orologie Dynamique, version
<br>4 - INteraction with Chemistry and Aerosols, version 3) global model. An
<br>important aspect of this new model is that both fine nitrate particle
<br>formation in the accumulation mode and coarse nitrate forming on
<br>existing dust and sea-salt particles are considered. The model simulates
<br>distributions of nitrates and related species in agreement with previous
<br>studies and observations. The calculated present-day total nitrate
<br>direct radiative forcing since the pre-industrial is -0.056 W
<br>m^-2. This forcing corresponds to 18&#37; of the sulfate forcing.
<br>Fine particles largely dominate the nitrate forcing, representing close
<br>to 90&#37; of this value. The model has been used to investigate the future
<br>changes in nitrates and direct radiative forcing of climate based on
<br>snapshot simulations for the four representative concentration pathway
<br>(RCP) scenarios and for the 2030, 2050, and 2100 time horizons. Due to a
<br>decrease in fossil fuel emissions in the future, the concentration of
<br>most of the species involved in the nitrate-ammonium-sulfate system drop
<br>by 2100 except for ammonia, which originates from agricultural practices
<br>and for which emissions significantly increase in the future. Despite
<br>the decrease of nitrate surface levels in Europe and North America, the
<br>global burden of accumulation mode nitrates increases by up to a factor
<br>of 2.6 in 2100. This increase in ammonium nitrate in the future arises
<br>despite decreasing NO_x emissions due to increased
<br>availability of ammonia to form ammonium nitrate. The total aerosol
<br>direct forcing decreases from its present-day value of -0.234 W
<br>m^-2 to a range of -0.070 to -0.130 W m^-2 in 2100
<br>based on the considered scenario. The direct forcing decreases for all
<br>aerosols except for nitrates, for which the direct negative forcing
<br>increases to a range of -0.060 to -0.115 W m^-2 in 2100.
<br>Including nitrates in the radiative forcing calculations increases the
<br>total direct forcing of aerosols by a factor of 1.3 in 2000, by a factor
<br>of 1.7-2.6 in 2030, by 1.9-4.8 in 2050, and by 6.4-8.6 in 2100. These
<br>results show that the agricultural emissions of ammonia will play a key
<br>role in the future mitigation of climate change, with nitrates becoming
<br>the dominant contributor to the anthropogenic aerosol optical depth
<br>during the second half of the 21st century and significantly increasing
<br>the calculated aerosol direct forcing. This significant increase in the
<br>influence that nitrate exerts on climate in the future will at the same
<br>time affect regional air quality and nitrogen deposition to the
<br>ecosystem.
<br></td>
</tr>
<tr id="bib_Hauglustaine_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Hauglustaine_etal_ACP_2014a,
  author = {D. A. Hauglustaine and Y. Balkanski and M. Schulz},
  title = {A global model simulation of present and future nitrate aerosols and their direct radiative forcing of climate},
  journal = {Atmospheric Chemistry &amp; Physics},
  publisher = {Copernicus GmbH},
  year = {2014},
  volume = {14},
  number = {20},
  pages = {11031--11063},
  url = {www.atmos-chem-phys.net/14/11031/2014/},
  doi = {https://doi.org/10.5194/acp-14-11031-2014}
}
</pre></td>
</tr>
<tr id="Holben_etal_ACP_2018a" class="entry">
	<td>Holben, B.N., Kim, J., Sano, I., Mukai, S., Eck, T.F., Giles, D.M., Schafer, J.S., Sinyuk, A., Slutsker, I., Smirnov, A., Sorokin, M., Anderson, B.E., Che, H., Choi, M., Crawford, J.H., Ferrare, R.A., Garay, M.J., Jeong, U., Kim, M., Kim, W., Knox, N., Li, Z., Lim, H.S., Liu, Y., Maring, H., Nakata, M., Pickering, K.E., Piketh, S., Redemann, J., Reid, J.S., Salinas, S., Seo, S., Tan, F., Tripathi, S.N., Toon, O.B. and Xiao, Q.</td>
	<td>An overview of mesoscale aerosol processes, comparisons, and validation studies from DRAGON networks <p class="infolinks">[<a href="javascript:toggleInfo('Holben_etal_ACP_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Holben_etal_ACP_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 655-671&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-655-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....18..655H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Holben_etal_ACP_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Over the past 24 years, the AErosol RObotic NETwork (AERONET) program has provided highly accurate remote-sensing characterization of aerosol optical and physical properties for an increasingly extensive geographic distribution including all continents and many oceanic island and coastal sites. The measurements and retrievals from the AERONET global network have addressed satellite and model validation needs very well, but there have been challenges in making comparisons to similar parameters from in situ surface and airborne measurements. Additionally, with improved spatial and temporal satellite remote sensing of aerosols, there is a need for higher spatial-resolution ground-based remote-sensing networks. An effort to address these needs resulted in a number of field campaign networks called Distributed Regional Aerosol Gridded Observation Networks (DRAGONs) that were designed to provide a database for in situ and remote-sensing comparison and analysis of local to mesoscale variability in aerosol properties. This paper describes the DRAGON deployments that will continue to contribute to the growing body of research related to meso- and microscale aerosol features and processes. The research presented in this special issue illustrates the diversity of topics that has resulted from the application of data from these networks.</td>
</tr>
<tr id="bib_Holben_etal_ACP_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Holben_etal_ACP_2018a,
  author = {Holben, B. N. and Kim, J. and Sano, I. and Mukai, S. and Eck, T. F. and Giles, D. M. and Schafer, J. S. and Sinyuk, A. and Slutsker, I. and Smirnov, A. and Sorokin, M. and Anderson, B. E. and Che, H. and Choi, M. and Crawford, J. H. and Ferrare, R. A. and Garay, M. J. and Jeong, U. and Kim, M. and Kim, W. and Knox, N. and Li, Z. and Lim, H. S. and Liu, Y. and Maring, H. and Nakata, M. and Pickering, K. E. and Piketh, S. and Redemann, J. and Reid, J. S. and Salinas, S. and Seo, S. and Tan, F. and Tripathi, S. N. and Toon, O. B. and Xiao, Q.},
  title = {An overview of mesoscale aerosol processes, comparisons, and validation studies from DRAGON networks},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {655-671},
  url = {http://adsabs.harvard.edu/abs/2018ACP....18..655H},
  doi = {https://doi.org/10.5194/acp-18-655-2018}
}
</pre></td>
</tr>
<tr id="HooseMoehler_ACP_2012a" class="entry">
	<td>Hoose, C. and M&ouml;hler, O.</td>
	<td>Heterogeneous ice nucleation on atmospheric aerosols: a review of results from laboratory experiments <p class="infolinks">[<a href="javascript:toggleInfo('HooseMoehler_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('HooseMoehler_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 9817-9854&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-9817-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12.9817H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_HooseMoehler_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A small subset of the atmospheric aerosol population has the ability to
<br>induce ice formation at conditions under which ice would not form
<br>without them (heterogeneous ice nucleation). While no closed theoretical
<br>description of this process and the requirements for good ice nuclei is
<br>available, numerous studies have attempted to quantify the ice
<br>nucleation ability of different particles empirically in laboratory
<br>experiments. In this article, an overview of these results is provided.
<br>Ice nucleation ``onset'' conditions for various mineral dust, soot,
<br>biological, organic and ammonium sulfate particles are summarized.
<br>Typical temperature-supersaturation regions can be identified for the
<br>``onset'' of ice nucleation of these different particle types, but the
<br>various particle sizes and activated fractions reported in different
<br>studies have to be taken into account when comparing results obtained
<br>with different methodologies. When intercomparing only data obtained
<br>under the same conditions, it is found that dust mineralogy is not a
<br>consistent predictor of higher or lower ice nucleation ability. However,
<br>the broad majority of studies agrees on a reduction of deposition
<br>nucleation by various coatings on mineral dust. The ice nucleation
<br>active surface site (INAS) density is discussed as a simple and
<br>empirical normalized measure for ice nucleation activity. For most
<br>immersion and condensation freezing measurements on mineral dust,
<br>estimates of the temperature-dependent INAS density agree within about
<br>two orders of magnitude. For deposition nucleation on dust, the spread
<br>is significantly larger, but a general trend of increasing INAS
<br>densities with increasing supersaturation is found. For soot, the
<br>presently available results are divergent. Estimated average INAS
<br>densities are high for ice-nucleation active bacteria at high subzero
<br>temperatures. At the same time, it is shown that INAS densities of some
<br>other biological aerosols, like certain pollen grains, fungal spores and
<br>diatoms, tend to be similar to those of dust. These particles may owe
<br>their high ice nucleation onsets to their large sizes.
<br>Surface-area-dependent parameterizations of heterogeneous ice nucleation
<br>are discussed. For immersion freezing on mineral dust, fitted INAS
<br>densities are available, but should not be used outside the temperature
<br>interval of the data they were based on. Classical nucleation theory, if
<br>employed with only one fitted contact angle, does not reproduce the
<br>observed temperature dependence for immersion nucleation, the
<br>temperature and supersaturation dependence for deposition nucleation,
<br>and the time dependence of ice nucleation. Formulations of classical
<br>nucleation theory with distributions of contact angles offer
<br>possibilities to overcome these weaknesses.
<br></td>
</tr>
<tr id="bib_HooseMoehler_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{HooseMoehler_ACP_2012a,
  author = {Hoose, C. and M&ouml;hler, O.},
  title = {Heterogeneous ice nucleation on atmospheric aerosols: a review of results from laboratory experiments},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {9817-9854},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12.9817H},
  doi = {https://doi.org/10.5194/acp-12-9817-2012}
}
</pre></td>
</tr>
<tr id="Horowitz_etal_ACP_2017a" class="entry">
	<td>Horowitz, H.M., Garland, R.M., Thatcher, M., Landman, W.A., Dedekind, Z., van der Merwe, J. and Engelbrecht, F.A.</td>
	<td>Evaluation of climate model aerosol seasonal and spatial variability over Africa using AERONET <p class="infolinks">[<a href="javascript:toggleInfo('Horowitz_etal_ACP_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Horowitz_etal_ACP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 17, pp. 13999-14023&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-13999-2017">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017ACP....1713999H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Horowitz_etal_ACP_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The sensitivity of climate models to the characterization of African aerosol particles is poorly understood. Africa is a major source of dust and biomass burning aerosols and this represents an important research gap in understanding the impact of aerosols on radiative forcing of the climate system. Here we evaluate the current representation of aerosol particles in the Conformal Cubic Atmospheric Model (CCAM) with ground-based remote retrievals across Africa, and additionally provide an analysis of observed aerosol optical depth at 550 nm (AOD_550 nm) and &Aring;ngstr&ouml;m exponent data from 34 Aerosol Robotic Network (AERONET) sites. Analysis of the 34 long-term AERONET sites confirms the importance of dust and biomass burning emissions to the seasonal cycle and magnitude of AOD_550 nm across the continent and the transport of these emissions to regions outside of the continent. In general, CCAM captures the seasonality of the AERONET data across the continent. The magnitude of modeled and observed multiyear monthly average AOD_550 nm overlap within plusmn1 standard deviation of each other for at least 7 months at all sites except the R&eacute;union St Denis Island site (R&eacute;union St. Denis). The timing of modeled peak AOD_550 nm in southern Africa occurs 1 month prior to the observed peak, which does not align with the timing of maximum fire counts in the region. For the western and northern African sites, it is evident that CCAM currently overestimates dust in some regions while others (e.g., the Arabian Peninsula) are better characterized. This may be due to overestimated dust lifetime, or that the characterization of the soil for these areas needs to be updated with local information. The CCAM simulated AOD_550 nm for the global domain is within the spread of previously published results from CMIP5 and AeroCom experiments for black carbon, organic carbon, and sulfate aerosols. The model's performance provides confidence for using the model to estimate large-scale regional impacts of African aerosols on radiative forcing, but local feedbacks between dust aerosols and climate over northern Africa and the Mediterranean may be overestimated.</td>
</tr>
<tr id="bib_Horowitz_etal_ACP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Horowitz_etal_ACP_2017a,
  author = {Horowitz, H. M. and Garland, R. M. and Thatcher, M. and Landman, W. A. and Dedekind, Z. and van der Merwe, J. and Engelbrecht, F. A.},
  title = {Evaluation of climate model aerosol seasonal and spatial variability over Africa using AERONET},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2017},
  volume = {17},
  pages = {13999-14023},
  url = {http://adsabs.harvard.edu/abs/2017ACP....1713999H},
  doi = {https://doi.org/10.5194/acp-17-13999-2017}
}
</pre></td>
</tr>
<tr id="Huneeus_etal_ACP_2011a" class="entry">
	<td>Huneeus, N., Schulz, M., Balkanski, Y., Griesfeller, J., Prospero, J., Kinne, S., Bauer, S., Boucher, O., Chin, M., Dentener, F., Diehl, T., Easter, R., Fillmore, D., Ghan, S., Ginoux, P., Grini, A., Horowitz, L., Koch, D., Krol, M.C., Landing, W., Liu, X., Mahowald, N., Miller, R., Morcrette, J.-J., Myhre, G., Penner, J., Perlwitz, J., Stier, P., Takemura, T. and Zender, C.S.</td>
	<td>Global dust model intercomparison in AeroCom phase I <p class="infolinks">[<a href="javascript:toggleInfo('Huneeus_etal_ACP_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Huneeus_etal_ACP_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 11(15), pp. 7781-7816&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-11-7781-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011ACP....11.7781H">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Huneeus_etal_ACP_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This study presents the results of a broad intercomparison of a total of
<br>15 global aerosol models within the AeroCom project. Each model is
<br>compared to observations related to desert dust aerosols, their direct
<br>radiative effect, and their impact on the biogeochemical cycle, i.e.,
<br>aerosol optical depth (AOD) and dust deposition. Additional comparisons
<br>to Angstr&ouml;m exponent (AE), coarse mode AOD and dust surface
<br>concentrations are included to extend the assessment of model
<br>performance and to identify common biases present in models. These data
<br>comprise a benchmark dataset that is proposed for model inspection and
<br>future dust model development. There are large differences among the
<br>global models that simulate the dust cycle and its impact on climate. In
<br>general, models simulate the climatology of vertically integrated
<br>parameters (AOD and AE) within a factor of two whereas the total
<br>deposition and surface concentration are reproduced within a factor of
<br>10. In addition, smaller mean normalized bias and root mean square
<br>errors are obtained for the climatology of AOD and AE than for total
<br>deposition and surface concentration. Characteristics of the datasets
<br>used and their uncertainties may influence these differences. Large
<br>uncertainties still exist with respect to the deposition fluxes in the
<br>southern oceans. Further measurements and model studies are necessary to
<br>assess the general model performance to reproduce dust deposition in
<br>ocean regions sensible to iron contributions. Models overestimate the
<br>wet deposition in regions dominated by dry deposition. They generally
<br>simulate more realistic surface concentration at stations downwind of
<br>the main sources than at remote ones. Most models simulate the gradient
<br>in AOD and AE between the different dusty regions. However the
<br>seasonality and magnitude of both variables is better simulated at
<br>African stations than Middle East ones. The models simulate the offshore
<br>transport of West Africa throughout the year but they overestimate the
<br>AOD and they transport too fine particles. The models also reproduce the
<br>dust transport across the Atlantic in the summer in terms of both AOD
<br>and AE but not so well in winter-spring nor the southward displacement
<br>of the dust cloud that is responsible of the dust transport into South
<br>America. Based on the dependency of AOD on aerosol burden and size
<br>distribution we use model bias with respect to AOD and AE to infer the
<br>bias of the dust emissions in Africa and the Middle East. According to
<br>this analysis we suggest that a range of possible emissions for North
<br>Africa is 400 to 2200 Tg yr^-1 and in the Middle East 26 to
<br>526 Tg yr^-1.
<br></td>
</tr>
<tr id="bib_Huneeus_etal_ACP_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Huneeus_etal_ACP_2011a,
  author = {Huneeus, N. and Schulz, M. and Balkanski, Y. and Griesfeller, J. and Prospero, J. and Kinne, S. and Bauer, S. and Boucher, O. and Chin, M. and Dentener, F. and Diehl, T. and Easter, R. and Fillmore, D. and Ghan, S. and Ginoux, P. and Grini, A. and Horowitz, L. and Koch, D. and Krol, M. C. and Landing, W. and Liu, X. and Mahowald, N. and Miller, R. and Morcrette, J.-J. and Myhre, G. and Penner, J. and Perlwitz, J. and Stier, P. and Takemura, T. and Zender, C. S.},
  title = {Global dust model intercomparison in AeroCom phase I},
  journal = {Atmospheric Chemistry &amp; Physics},
  publisher = {Copernicus GmbH},
  year = {2011},
  volume = {11},
  number = {15},
  pages = {7781-7816},
  url = {http://adsabs.harvard.edu/abs/2011ACP....11.7781H},
  doi = {https://doi.org/10.5194/acp-11-7781-2011}
}
</pre></td>
</tr>
<tr id="Jiao_etal_ACP_2014a" class="entry">
	<td>Jiao, C., Flanner, M.G., Balkanski, Y., Bauer, S.E., Bellouin, N., Berntsen, T.K., Bian, H., Carslaw, K.S., Chin, M., De Luca, N., Diehl, T., Ghan, S.J., Iversen, T., Kirkev&aring;g, A., Koch, D., Liu, X., Mann, G.W., Penner, J.E., Pitari, G., Schulz, M., Seland, &Oslash;., Skeie, R.B., Steenrod, S.D., Stier, P., Takemura, T., Tsigaridis, K., van Noije, T., Yun, Y. and Zhang, K.</td>
	<td>An AeroCom assessment of black carbon in Arctic snow and sea ice <p class="infolinks">[<a href="javascript:toggleInfo('Jiao_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Jiao_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14, pp. 2399-2417&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-2399-2014">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014ACP....14.2399J">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Jiao_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Though many global aerosols models prognose surface deposition, only a few models have been used to directly simulate the radiative effect from black carbon (BC) deposition to snow and sea ice. Here, we apply aerosol deposition fields from 25 models contributing to two phases of the Aerosol Comparisons between Observations and Models (AeroCom) project to simulate and evaluate within-snow BC concentrations and radiative effect in the Arctic. We accomplish this by driving the offline land and sea ice components of the Community Earth System Model with different deposition fields and meteorological conditions from 2004 to 2009, during which an extensive field campaign of BC measurements in Arctic snow occurred. We find that models generally underestimate BC concentrations in snow in northern Russia and Norway, while overestimating BC amounts elsewhere in the Arctic. Although simulated BC distributions in snow are poorly correlated with measurements, mean values are reasonable. The multi-model mean (range) bias in BC concentrations, sampled over the same grid cells, snow depths, and months of measurements, are -4.4 (-13.2 to +10.7) ng g^-1 for an earlier phase of AeroCom models (phase I), and +4.1 (-13.0 to +21.4) ng g^-1 for a more recent phase of AeroCom models (phase II), compared to the observational mean of 19.2 ng g^-1. Factors determining model BC concentrations in Arctic snow include Arctic BC emissions, transport of extra-Arctic aerosols, precipitation, deposition efficiency of aerosols within the Arctic, and meltwater removal of particles in snow. Sensitivity studies show that the model-measurement evaluation is only weakly affected by meltwater scavenging efficiency because most measurements were conducted in non-melting snow. The Arctic (60-90deg N) atmospheric residence time for BC in phase II models ranges from 3.7 to 23.2 days, implying large inter-model variation in local BC deposition efficiency. Combined with the fact that most Arctic BC deposition originates from extra-Arctic emissions, these results suggest that aerosol removal processes are a leading source of variation in model performance. The multi-model mean (full range) of Arctic radiative effect from BC in snow is 0.15 (0.07-0.25) W m^-2 and 0.18 (0.06-0.28) W m^-2 in phase I and phase II models, respectively. After correcting for model biases relative to observed BC concentrations in different regions of the Arctic, we obtain a multi-model mean Arctic radiative effect of 0.17 W m^-2 for the combined AeroCom ensembles. Finally, there is a high correlation between modeled BC concentrations sampled over the observational sites and the Arctic as a whole, indicating that the field campaign provided a reasonable sample of the Arctic.</td>
</tr>
<tr id="bib_Jiao_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Jiao_etal_ACP_2014a,
  author = {Jiao, C. and Flanner, M. G. and Balkanski, Y. and Bauer, S. E. and Bellouin, N. and Berntsen, T. K. and Bian, H. and Carslaw, K. S. and Chin, M. and De Luca, N. and Diehl, T. and Ghan, S. J. and Iversen, T. and Kirkev&aring;g, A. and Koch, D. and Liu, X. and Mann, G. W. and Penner, J. E. and Pitari, G. and Schulz, M. and Seland, &Oslash;. and Skeie, R. B. and Steenrod, S. D. and Stier, P. and Takemura, T. and Tsigaridis, K. and van Noije, T. and Yun, Y. and Zhang, K.},
  title = {An AeroCom assessment of black carbon in Arctic snow and sea ice},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2014},
  volume = {14},
  pages = {2399-2417},
  url = {http://adsabs.harvard.edu/abs/2014ACP....14.2399J},
  doi = {https://doi.org/10.5194/acp-14-2399-2014}
}
</pre></td>
</tr>
<tr id="Journet_etal_ACP_2014a" class="entry">
	<td>Journet, E., Balkanski, Y. and Harrison, S.P.</td>
	<td>A new data set of soil mineralogy for dust-cycle modeling <p class="infolinks">[<a href="javascript:toggleInfo('Journet_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Journet_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14, pp. 3801-3816&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-3801-2014">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014ACP....14.3801J">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Journet_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The mineralogy of airborne dust affects the impact of dust particles on
<br>direct and indirect radiative forcing, on atmospheric chemistry and on
<br>biogeochemical cycling. It is determined partly by the mineralogy of the
<br>dust-source regions and partly by size-dependent fractionation during
<br>erosion and transport. Here we present a data set that characterizes the
<br>clay and silt-sized fractions of global soil units in terms of the
<br>abundance of 12 minerals that are important for dust-climate
<br>interactions: quartz, feldspars, illite, smectite, kaolinite, chlorite,
<br>vermiculite, mica, calcite, gypsum, hematite and goethite. The basic
<br>mineralogical information is derived from the literature, and is then
<br>expanded following explicit rules, in order to characterize as many soil
<br>units as possible. We present three alternative realizations of the
<br>mineralogical maps, taking the uncertainties in the mineralogical data
<br>into account. We examine the implications of the new database for
<br>calculations of the single scattering albedo of airborne dust and thus
<br>for dust radiative forcing.
<br></td>
</tr>
<tr id="bib_Journet_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Journet_etal_ACP_2014a,
  author = {Journet, E. and Balkanski, Y. and Harrison, S. P.},
  title = {A new data set of soil mineralogy for dust-cycle modeling},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2014},
  volume = {14},
  pages = {3801-3816},
  url = {http://adsabs.harvard.edu/abs/2014ACP....14.3801J},
  doi = {https://doi.org/10.5194/acp-14-3801-2014}
}
</pre></td>
</tr>
<tr id="Kinne_etal_ACP_2006a" class="entry">
	<td>Kinne, S., Schulz, M., Textor, C., Guibert, S., Balkanski, Y., Bauer, S.E., Berntsen, T., Berglen, T.F., Boucher, O., Chin, M., Collins, W., Dentener, F., Diehl, T., Easter, R., Feichter, J., Fillmore, D., Ghan, S., Ginoux, P., Gong, S., Grini, A., Hendricks, J., Herzog, M., Horowitz, L., Isaksen, I., Iversen, T., Kirkev&aring;g, A., Kloster, S., Koch, D., Kristjansson, J.E., Krol, M., Lauer, A., Lamarque, J.F., Lesins, G., Liu, X., Lohmann, U., Montanaro, V., Myhre, G., Penner, J., Pitari, G., Reddy, S., Seland, O., Stier, P., Takemura, T. and Tie, X.</td>
	<td>An AeroCom initial assessment - optical properties in aerosol component modules of global models <p class="infolinks">[<a href="javascript:toggleInfo('Kinne_etal_ACP_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kinne_etal_ACP_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 6, pp. 1815-1834&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2006ACP.....6.1815K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kinne_etal_ACP_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The AeroCom exercise diagnoses multi-component aerosol modules in global modeling. In an initial assessment simulated global distributions for mass and mid-visible aerosol optical thickness (aot) were compared among 20 different modules. Model diversity was also explored in the context of previous comparisons. For the component combined aot general agreement has improved for the annual global mean. At 0.11 to 0.14, simulated aot values are at the lower end of global averages suggested by remote sensing from ground (AERONET ca. 0.135) and space (satellite composite ca. 0.15). More detailed comparisons, however, reveal that larger differences in regional distribution and significant differences in compositional mixture remain. Of particular concern are large model diversities for contributions by dust and carbonaceous aerosol, because they lead to significant uncertainty in aerosol absorption (aab). Since aot and aab, both, influence the aerosol impact on the radiative energy-balance, the aerosol (direct) forcing uncertainty in modeling is larger than differences in aot might suggest. New diagnostic approaches are proposed to trace model differences in terms of aerosol processing and transport: These include the prescription of common input (e.g. amount, size and injection of aerosol component emissions) and the use of observational capabilities from ground (e.g. measurements networks) or space (e.g. correlations between aerosol and clouds).</td>
</tr>
<tr id="bib_Kinne_etal_ACP_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kinne_etal_ACP_2006a,
  author = {Kinne, S. and Schulz, M. and Textor, C. and Guibert, S. and Balkanski, Y. and Bauer, S. E. and Berntsen, T. and Berglen, T. F. and Boucher, O. and Chin, M. and Collins, W. and Dentener, F. and Diehl, T. and Easter, R. and Feichter, J. and Fillmore, D. and Ghan, S. and Ginoux, P. and Gong, S. and Grini, A. and Hendricks, J. and Herzog, M. and Horowitz, L. and Isaksen, I. and Iversen, T. and Kirkev&aring;g, A. and Kloster, S. and Koch, D. and Kristjansson, J. E. and Krol, M. and Lauer, A. and Lamarque, J. F. and Lesins, G. and Liu, X. and Lohmann, U. and Montanaro, V. and Myhre, G. and Penner, J. and Pitari, G. and Reddy, S. and Seland, O. and Stier, P. and Takemura, T. and Tie, X.},
  title = {An AeroCom initial assessment - optical properties in aerosol component modules of global models},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2006},
  volume = {6},
  pages = {1815-1834},
  url = {http://adsabs.harvard.edu/abs/2006ACP.....6.1815K}
}
</pre></td>
</tr>
<tr id="Koch_etal_ACP_2009a" class="entry">
	<td>Koch, D., Schulz, M., Kinne, S., McNaughton, C., Spackman, J.R., Balkanski, Y., Bauer, S., Berntsen, T., Bond, T.C., Boucher, O., Chin, M., Clarke, A., de Luca, N., Dentener, F., Diehl, T., Dubovik, O., Easter, R., Fahey, D.W., Feichter, J., Fillmore, D., Freitag, S., Ghan, S., Ginoux, P., Gong, S., Horowitz, L., Iversen, T., Kirkev&aring;g, A., Klimont, Z., Kondo, Y., Krol, M., Liu, X., Miller, R., Montanaro, V., Moteki, N., Myhre, G., Penner, J.E., Perlwitz, J., Pitari, G., Reddy, S., Sahu, L., Sakamoto, H., Schuster, G., Schwarz, J.P., Seland, &Oslash;., Stier, P., Takegawa, N., Takemura, T., Textor, C., van Aardenne, J.A. and Zhao, Y.</td>
	<td>Evaluation of black carbon estimations in global aerosol models <p class="infolinks">[<a href="javascript:toggleInfo('Koch_etal_ACP_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Koch_etal_ACP_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 9, pp. 9001-9026&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009ACP.....9.9001K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Koch_etal_ACP_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We evaluate black carbon (BC) model predictions from the AeroCom model
<br>intercomparison project by considering the diversity among year 2000
<br>model simulations and comparing model predictions with available
<br>measurements. These model-measurement intercomparisons include BC
<br>surface and aircraft concentrations, aerosol absorption optical depth
<br>(AAOD) retrievals from AERONET and Ozone Monitoring Instrument (OMI) and
<br>BC column estimations based on AERONET. In regions other than Asia, most
<br>models are biased high compared to surface concentration measurements.
<br>However compared with (column) AAOD or BC burden retreivals, the models
<br>are generally biased low. The average ratio of model to retrieved AAOD
<br>is less than 0.7 in South American and 0.6 in African biomass burning
<br>regions; both of these regions lack surface concentration measurements.
<br>In Asia the average model to observed ratio is 0.7 for AAOD and 0.5 for
<br>BC surface concentrations. Compared with aircraft measurements over the
<br>Americas at latitudes between 0 and 50N, the average model is a factor
<br>of 8 larger than observed, and most models exceed the measured BC
<br>standard deviation in the mid to upper troposphere. At higher latitudes
<br>the average model to aircraft BC ratio is 0.4 and models underestimate
<br>the observed BC loading in the lower and middle troposphere associated
<br>with springtime Arctic haze. Low model bias for AAOD but overestimation
<br>of surface and upper atmospheric BC concentrations at lower latitudes
<br>suggests that most models are underestimating BC absorption and should
<br>improve estimates for refractive index, particle size, and optical
<br>effects of BC coating. Retrieval uncertainties and/or differences with
<br>model diagnostic treatment may also contribute to the model-measurement
<br>disparity. Largest AeroCom model diversity occurred in northern Eurasia
<br>and the remote Arctic, regions influenced by anthropogenic sources.
<br>Changing emissions, aging, removal, or optical properties within a
<br>single model generated a smaller change in model predictions than the
<br>range represented by the full set of AeroCom models. Upper tropospheric
<br>concentrations of BC mass from the aircraft measurements are suggested
<br>to provide a unique new benchmark to test scavenging and vertical
<br>dispersion of BC in global models.
<br></td>
</tr>
<tr id="bib_Koch_etal_ACP_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Koch_etal_ACP_2009a,
  author = {Koch, D. and Schulz, M. and Kinne, S. and McNaughton, C. and Spackman, J. R. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Bond, T. C. and Boucher, O. and Chin, M. and Clarke, A. and de Luca, N. and Dentener, F. and Diehl, T. and Dubovik, O. and Easter, R. and Fahey, D. W. and Feichter, J. and Fillmore, D. and Freitag, S. and Ghan, S. and Ginoux, P. and Gong, S. and Horowitz, L. and Iversen, T. and Kirkev&aring;g, A. and Klimont, Z. and Kondo, Y. and Krol, M. and Liu, X. and Miller, R. and Montanaro, V. and Moteki, N. and Myhre, G. and Penner, J. E. and Perlwitz, J. and Pitari, G. and Reddy, S. and Sahu, L. and Sakamoto, H. and Schuster, G. and Schwarz, J. P. and Seland, &Oslash;. and Stier, P. and Takegawa, N. and Takemura, T. and Textor, C. and van Aardenne, J. A. and Zhao, Y.},
  title = {Evaluation of black carbon estimations in global aerosol models},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2009},
  volume = {9},
  pages = {9001-9026},
  url = {http://adsabs.harvard.edu/abs/2009ACP.....9.9001K}
}
</pre></td>
</tr>
<tr id="Koch_etal_ACP_2010a" class="entry">
	<td>Koch, D., Schulz, M., Kinne, S., McNaughton, C., Spackman, J.R., Balkanski, Y., Bauer, S., Berntsen, T., Bond, T.C., Boucher, O., Chin, M., Clarke, A., de Luca, N., Dentener, F., Diehl, T., Dubovik, O., Easter, R., Fahey, D.W., Feichter, J., Fillmore, D., Freitag, S., Ghan, S., Ginoux, P., Gong, S., Horowitz, L., Iversen, T., Kirkev&aring;g, A., Klimont, Z., Kondo, Y., Krol, M., Liu, X., Miller, R., Montanaro, V., Moteki, N., Myhre, G., Penner, J.E., Perlwitz, J., Pitari, G., Reddy, S., Sahu, L., Sakamoto, H., Schuster, G., Schwarz, J.P., Seland, &Oslash;., Stier, P., Takegawa, N., Takemura, T., Textor, C., van Aardenne, J.A. and Zhao, Y.</td>
	<td>Corrigendum to ``Evaluation of black carbon estimations in global aerosol models'' published in Atmos. Chem. Phys., 9, 9001-9026, 2009 <p class="infolinks">[<a href="javascript:toggleInfo('Koch_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Koch_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 79-81&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2010ACP....10...79K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Koch_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: No abstract available.</td>
</tr>
<tr id="bib_Koch_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Koch_etal_ACP_2010a,
  author = {Koch, D. and Schulz, M. and Kinne, S. and McNaughton, C. and Spackman, J. R. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Bond, T. C. and Boucher, O. and Chin, M. and Clarke, A. and de Luca, N. and Dentener, F. and Diehl, T. and Dubovik, O. and Easter, R. and Fahey, D. W. and Feichter, J. and Fillmore, D. and Freitag, S. and Ghan, S. and Ginoux, P. and Gong, S. and Horowitz, L. and Iversen, T. and Kirkev&aring;g, A. and Klimont, Z. and Kondo, Y. and Krol, M. and Liu, X. and Miller, R. and Montanaro, V. and Moteki, N. and Myhre, G. and Penner, J. E. and Perlwitz, J. and Pitari, G. and Reddy, S. and Sahu, L. and Sakamoto, H. and Schuster, G. and Schwarz, J. P. and Seland, &Oslash;. and Stier, P. and Takegawa, N. and Takemura, T. and Textor, C. and van Aardenne, J. A. and Zhao, Y.},
  title = {Corrigendum to ``Evaluation of black carbon estimations in global aerosol models'' published in Atmos. Chem. Phys., 9, 9001-9026, 2009},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {79-81},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10...79K}
}
</pre></td>
</tr>
<tr id="Kok_ACP_2011a" class="entry">
	<td>Kok, J.F.</td>
	<td>Does the size distribution of mineral dust aerosols depend on the wind speed at emission? <p class="infolinks">[<a href="javascript:toggleInfo('Kok_ACP_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Kok_ACP_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 11, pp. 10149-10156&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-11-10149-2011">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011ACP....1110149K">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Kok_ACP_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The size distribution of mineral dust aerosols partially determines
<br>their interactions with clouds, radiation, ecosystems, and other
<br>components of the Earth system. Several theoretical models predict that
<br>the dust size distribution depends on the wind speed at emission, with
<br>larger wind speeds predicted to produce smaller aerosols. The present
<br>study investigates this prediction using a compilation of published
<br>measurements of the size-resolved vertical dust flux emitted by eroding
<br>soils. Surprisingly, these measurements indicate that the size
<br>distribution of naturally emitted dust aerosols is independent of the
<br>wind speed. The recently formulated brittle fragmentation theory of dust
<br>emission is consistent with this finding, whereas other theoretical
<br>models are not. The independence of the emitted dust size distribution
<br>with wind speed simplifies both the interpretation of geological records
<br>of dust deposition and the parameterization of dust emission in
<br>atmospheric circulation models.
<br></td>
</tr>
<tr id="bib_Kok_ACP_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Kok_ACP_2011a,
  author = {Kok, J. F.},
  title = {Does the size distribution of mineral dust aerosols depend on the wind speed at emission?},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2011},
  volume = {11},
  pages = {10149-10156},
  url = {http://adsabs.harvard.edu/abs/2011ACP....1110149K},
  doi = {https://doi.org/10.5194/acp-11-10149-2011}
}
</pre></td>
</tr>
<tr id="Marticorena_etal_ACP_2010a" class="entry">
	<td>Marticorena, B., Chatenet, B., Rajot, J.L., Traor&eacute;, S., Coulibaly, M., Diallo, A., Kon&eacute;, I., Maman, A., Ndiaye, T. and Zakou, A.</td>
	<td>Temporal variability of mineral dust concentrations over West Africa: analyses of a pluriannual monitoring from the AMMA Sahelian Dust Transect <p class="infolinks">[<a href="javascript:toggleInfo('Marticorena_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Marticorena_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 8899-8915&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-10-8899-2010">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ACP....10.8899M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Marticorena_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Sahelian belt is known to be a region where atmospheric levels of
<br>suspended mineral dust are among the highest observed on Earth. In the
<br>framework of the AMMA (African Monsoon Multidisciplinary Analysis)
<br>International Program, a transect of 3 ground based stations, the
<br>``Sahelian Dust Transect'' (SDT), has been deployed in order to obtain
<br>quantitative information on the mineral dust content and its variability
<br>over the Sahel. The three stations, namely Banizoumbou (Niger), Cinzana
<br>(Mali) and M'Bour (Senegal) are aligned around 14deg N along the
<br>east-westward main pathway of the Saharan and Sahelian dust towards the
<br>Atlantic Ocean. We discuss data collected between January 2006 and
<br>December 2008 to investigate the main characteristics of the mineral
<br>dust concentration over West Africa and their connection with the
<br>dominant meteorological situations. The succession of the dry season
<br>during which the Sahel is under the influence of the dry Harmattan wind
<br>and the wet season induced by the entrance of the monsoon flow is
<br>clearly identified from the basic meteorological parameters (air
<br>temperature and moisture, wind direction). Atmospheric dust
<br>concentrations at the three stations exhibit a similar seasonal cycle,
<br>with a monthly maximum during the dry season and a minimum occurring
<br>during the rainy season, indicating that the general pattern of dust
<br>concentration is similar at regional scale. This seasonal cycle of the
<br>dust concentrations is not phased with the seasonal cycle of surface
<br>wind velocity locally measured, suggesting that it is mainly controlled
<br>by Saharan dust transport. Local dust emissions induced by strong
<br>surface winds are responsible for the occurrence of extremely high daily
<br>concentrations observed at the beginning of the rainy season. A decrease
<br>in the dust concentration is observed when moving from Niger to Senegal.
<br></td>
</tr>
<tr id="bib_Marticorena_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Marticorena_etal_ACP_2010a,
  author = {Marticorena, B. and Chatenet, B. and Rajot, J. L. and Traor&eacute;, S. and Coulibaly, M. and Diallo, A. and Kon&eacute;, I. and Maman, A. and Ndiaye, T. and Zakou, A.},
  title = {Temporal variability of mineral dust concentrations over West Africa: analyses of a pluriannual monitoring from the AMMA Sahelian Dust Transect},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {8899-8915},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.8899M},
  doi = {https://doi.org/10.5194/acp-10-8899-2010}
}
</pre></td>
</tr>
<tr id="Molina_etal_ACP_2010a" class="entry">
	<td>Molina, L.T., Madronich, S., Gaffney, J.S., Apel, E., de Foy, B., Fast, J., Ferrare, R., Herndon, S., Jimenez, J.L., Lamb, B., Osornio-Vargas, A.R., Russell, P., Schauer, J.J., Stevens, P.S., Volkamer, R. and Zavala, M.</td>
	<td>An overview of the MILAGRO 2006 Campaign: Mexico City emissions and their transport and transformation <p class="infolinks">[<a href="javascript:toggleInfo('Molina_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Molina_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 8697-8760&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-10-8697-2010">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ACP....10.8697M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Molina_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: MILAGRO (Megacity Initiative: Local And Global Research Observations) is an international collaborative project to examine the behavior and the export of atmospheric emissions from a megacity. The Mexico City Metropolitan Area (MCMA) - one of the world's largest megacities and North America's most populous city - was selected as the case study to characterize the sources, concentrations, transport, and transformation processes of the gases and fine particles emitted to the MCMA atmosphere and to evaluate the regional and global impacts of these emissions. The findings of this study are relevant to the evolution and impacts of pollution from many other megacities. <BR /><BR /> The measurement phase consisted of a month-long series of carefully coordinated observations of the chemistry and physics of the atmosphere in and near Mexico City during March 2006, using a wide range of instruments at ground sites, on aircraft and satellites, and enlisting over 450 scientists from 150 institutions in 30 countries. Three ground supersites were set up to examine the evolution of the primary emitted gases and fine particles. Additional platforms in or near Mexico City included mobile vans containing scientific laboratories and mobile and stationary upward-looking lidars. Seven instrumented research aircraft provided information about the atmosphere over a large region and at various altitudes. Satellite-based instruments peered down into the atmosphere, providing even larger geographical coverage. The overall campaign was complemented by meteorological forecasting and numerical simulations, satellite observations and surface networks. Together, these research observations have provided the most comprehensive characterization of the MCMA's urban and regional atmospheric composition and chemistry that will take years to analyze and evaluate fully. <BR /><BR /> In this paper we review over 120 papers resulting from the MILAGRO/INTEX-B Campaign that have been published or submitted, as well as relevant papers from the earlier MCMA-2003 Campaign, with the aim of providing a road map for the scientific community interested in understanding the emissions from a megacity such as the MCMA and their impacts on air quality and climate. <BR /><BR /> This paper describes the measurements performed during MILAGRO and the results obtained on MCMA's atmospheric meteorology and dynamics, emissions of gases and fine particles, sources and concentrations of volatile organic compounds, urban and regional photochemistry, ambient particulate matter, aerosol radiative properties, urban plume characterization, and health studies. A summary of key findings from the field study is presented.</td>
</tr>
<tr id="bib_Molina_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Molina_etal_ACP_2010a,
  author = {Molina, L. T. and Madronich, S. and Gaffney, J. S. and Apel, E. and de Foy, B. and Fast, J. and Ferrare, R. and Herndon, S. and Jimenez, J. L. and Lamb, B. and Osornio-Vargas, A. R. and Russell, P. and Schauer, J. J. and Stevens, P. S. and Volkamer, R. and Zavala, M.},
  title = {An overview of the MILAGRO 2006 Campaign: Mexico City emissions and their transport and transformation},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {8697-8760},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.8697M},
  doi = {https://doi.org/10.5194/acp-10-8697-2010}
}
</pre></td>
</tr>
<tr id="Myhre_etal_ACP_2013a" class="entry">
	<td>Myhre, G., Samset, B.H., Schulz, M., Balkanski, Y., Bauer, S., Berntsen, T.K., Bian, H., Bellouin, N., Chin, M., Diehl, T., Easter, R.C., Feichter, J., Ghan, S.J., Hauglustaine, D., Iversen, T., Kinne, S., Kirkev&aring;g, A., Lamarque, J.-F., Lin, G., Liu, X., Lund, M.T., Luo, G., Ma, X., van Noije, T., Penner, J.E., Rasch, P.J., Ruiz, A., Seland, &Oslash;., Skeie, R.B., Stier, P., Takemura, T., Tsigaridis, K., Wang, P., Wang, Z., Xu, L., Yu, H., Yu, F., Yoon, J.-H., Zhang, K., Zhang, H. and Zhou, C.</td>
	<td>Radiative forcing of the direct aerosol effect from AeroCom Phase II simulations <p class="infolinks">[<a href="javascript:toggleInfo('Myhre_etal_ACP_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Myhre_etal_ACP_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 13(4), pp. 1853-1877&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-13-1853-2013">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013ACP....13.1853M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Myhre_etal_ACP_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We report on the AeroCom Phase II direct aerosol effect (DAE) experiment
<br>where 16 detailed global aerosol models have been used to simulate the
<br>changes in the aerosol distribution over the industrial era. All 16
<br>models have estimated the radiative forcing (RF) of the anthropogenic
<br>DAE, and have taken into account anthropogenic sulphate, black carbon
<br>(BC) and organic aerosols (OA) from fossil fuel, biofuel, and biomass
<br>burning emissions. In addition several models have simulated the DAE of
<br>anthropogenic nitrate and anthropogenic influenced secondary organic
<br>aerosols (SOA). The model simulated all-sky RF of the DAE from total
<br>anthropogenic aerosols has a range from -0.58 to -0.02 Wm^-2,
<br>with a mean of -0.27 Wm^-2 for the 16 models. Several models
<br>did not include nitrate or SOA and modifying the estimate by accounting
<br>for this with information from the other AeroCom models reduces the
<br>range and slightly strengthens the mean. Modifying the model estimates
<br>for missing aerosol components and for the time period 1750 to 2010
<br>results in a mean RF for the DAE of -0.35 Wm^-2. Compared to
<br>AeroCom Phase I (Schulz et al., 2006) we find very similar spreads in
<br>both total DAE and aerosol component RF. However, the RF of the total
<br>DAE is stronger negative and RF from BC from fossil fuel and biofuel
<br>emissions are stronger positive in the present study than in the
<br>previous AeroCom study. We find a tendency for models having a strong
<br>(positive) BC RF to also have strong (negative) sulphate or OA RF. This
<br>relationship leads to smaller uncertainty in the total RF of the DAE
<br>compared to the RF of the sum of the individual aerosol components. The
<br>spread in results for the individual aerosol components is substantial,
<br>and can be divided into diversities in burden, mass extinction
<br>coefficient (MEC), and normalized RF with respect to AOD. We find that
<br>these three factors give similar contributions to the spread in results.
<br></td>
</tr>
<tr id="bib_Myhre_etal_ACP_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Myhre_etal_ACP_2013a,
  author = {Myhre, G. and Samset, B. H. and Schulz, M. and Balkanski, Y. and Bauer, S. and Berntsen, T. K. and Bian, H. and Bellouin, N. and Chin, M. and Diehl, T. and Easter, R. C. and Feichter, J. and Ghan, S. J. and Hauglustaine, D. and Iversen, T. and Kinne, S. and Kirkev&aring;g, A. and Lamarque, J.-F. and Lin, G. and Liu, X. and Lund, M. T. and Luo, G. and Ma, X. and van Noije, T. and Penner, J. E. and Rasch, P. J. and Ruiz, A. and Seland, &Oslash;. and Skeie, R. B. and Stier, P. and Takemura, T. and Tsigaridis, K. and Wang, P. and Wang, Z. and Xu, L. and Yu, H. and Yu, F. and Yoon, J.-H. and Zhang, K. and Zhang, H. and Zhou, C.},
  title = {Radiative forcing of the direct aerosol effect from AeroCom Phase II simulations},
  journal = {Atmospheric Chemistry &amp; Physics},
  publisher = {Copernicus GmbH},
  year = {2013},
  volume = {13},
  number = {4},
  pages = {1853-1877},
  url = {http://adsabs.harvard.edu/abs/2013ACP....13.1853M},
  doi = {https://doi.org/10.5194/acp-13-1853-2013}
}
</pre></td>
</tr>
<tr id="Nickovic_etal_ACP_2012a" class="entry">
	<td>Nickovic, S., Vukovic, A., Vujadinovic, M., Djurdjevic, V. and Pejanovic, G.</td>
	<td>Technical Note: High-resolution mineralogical database of dust-productive soils for atmospheric dust modeling <p class="infolinks">[<a href="javascript:toggleInfo('Nickovic_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Nickovic_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 845-855&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-845-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12..845N">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Nickovic_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust storms and associated mineral aerosol transport are driven
<br>primarily by meso- and synoptic-scale atmospheric processes. It is
<br>therefore essential that the dust aerosol process and background
<br>atmospheric conditions that drive dust emissions and atmospheric
<br>transport are represented with sufficiently well-resolved spatial and
<br>temporal features. The effects of airborne dust interactions with the
<br>environment determine the mineral composition of dust particles. The
<br>fractions of various minerals in aerosol are determined by the mineral
<br>composition of arid soils; therefore, a high-resolution specification of
<br>the mineral and physical properties of dust sources is needed. <BR />
<br>Several current dust atmospheric models simulate and predict the
<br>evolution of dust concentrations; however, in most cases, these models
<br>do not consider the fractions of minerals in the dust. The accumulated
<br>knowledge about the impacts of the mineral composition in dust on
<br>weather and climate processes emphasizes the importance of including
<br>minerals in modeling systems. Accordingly, in this study, we developed a
<br>global dataset consisting of the mineral composition of the current
<br>potentially dust-producing soils. In our study, we (a) mapped mineral
<br>data to a high-resolution 30 s grid, (b) included several
<br>mineral-carrying soil types in dust-productive regions that were not
<br>considered in previous studies, and (c) included phosphorus.
<br></td>
</tr>
<tr id="bib_Nickovic_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Nickovic_etal_ACP_2012a,
  author = {Nickovic, S. and Vukovic, A. and Vujadinovic, M. and Djurdjevic, V. and Pejanovic, G.},
  title = {Technical Note: High-resolution mineralogical database of dust-productive soils for atmospheric dust modeling},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {845-855},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12..845N},
  doi = {https://doi.org/10.5194/acp-12-845-2012}
}
</pre></td>
</tr>
<tr id="OckoGinoux_ACP_2017a" class="entry">
	<td>Ocko, I.B. and Ginoux, P.A.</td>
	<td>Comparing multiple model-derived aerosol optical properties to spatially collocated ground-based and satellite measurements <p class="infolinks">[<a href="javascript:toggleInfo('OckoGinoux_ACP_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('OckoGinoux_ACP_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 17, pp. 4451-4475&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-17-4451-2017">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017ACP....17.4451O">URL</a>&nbsp;</td>
</tr>
<tr id="abs_OckoGinoux_ACP_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Anthropogenic aerosols are a key factor governing Earth's climate and play a central role in human-caused climate change. However, because of aerosols' complex physical, optical, and dynamical properties, aerosols are one of the most uncertain aspects of climate modeling. Fortunately, aerosol measurement networks over the past few decades have led to the establishment of long-term observations for numerous locations worldwide. Further, the availability of datasets from several different measurement techniques (such as ground-based and satellite instruments) can help scientists increasingly improve modeling efforts. This study explores the value of evaluating several model-simulated aerosol properties with data from spatially collocated instruments. We compare aerosol optical depth (AOD; total, scattering, and absorption), single-scattering albedo (SSA), &Aring;ngstr&ouml;m exponent (&alpha;), and extinction vertical profiles in two prominent global climate models (Geophysical Fluid Dynamics Laboratory, GFDL, CM2.1 and CM3) to seasonal observations from collocated instruments (AErosol RObotic NETwork, AERONET, and Cloud-Aerosol Lidar with Orthogonal Polarization, CALIOP) at seven polluted and biomass burning regions worldwide. We find that a multi-parameter evaluation provides key insights on model biases, data from collocated instruments can reveal underlying aerosol-governing physics, column properties wash out important vertical distinctions, and ltqgtimprovedlt/qgt models does not mean all aspects are improved. We conclude that it is important to make use of all available data (parameters and instruments) when evaluating aerosol properties derived by models.</td>
</tr>
<tr id="bib_OckoGinoux_ACP_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{OckoGinoux_ACP_2017a,
  author = {Ocko, I. B. and Ginoux, P. A.},
  title = {Comparing multiple model-derived aerosol optical properties to spatially collocated ground-based and satellite measurements},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2017},
  volume = {17},
  pages = {4451-4475},
  url = {http://adsabs.harvard.edu/abs/2017ACP....17.4451O},
  doi = {https://doi.org/10.5194/acp-17-4451-2017}
}
</pre></td>
</tr>
<tr id="Paulot_etal_ACP_2016a" class="entry">
	<td>Paulot, F., Ginoux, P., Cooke, W.F., Donner, L.J., Fan, S., Lin, M.-Y., Mao, J., Naik, V. and Horowitz, L.W.</td>
	<td>Sensitivity of nitrate aerosols to ammonia emissions and to nitrate chemistry: implications for present and future nitrate optical depth <p class="infolinks">[<a href="javascript:toggleInfo('Paulot_etal_ACP_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Paulot_etal_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16, pp. 1459-1477&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-1459-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016ACP....16.1459P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Paulot_etal_ACP_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We update and evaluate the treatment of nitrate aerosols in the Geophysical Fluid Dynamics Laboratory (GFDL) atmospheric model (AM3). Accounting for the radiative effects of nitrate aerosols generally improves the simulated aerosol optical depth, although nitrate concentrations at the surface are biased high. This bias can be reduced by increasing the deposition of nitrate to account for the near-surface volatilization of ammonium nitrate or by neglecting the heterogeneous production of nitric acid to account for the inhibition of N_2O_5 reactive uptake at high nitrate concentrations. Globally, uncertainties in these processes can impact the simulated nitrate optical depth by up to 25  much more than the impact of uncertainties in the seasonality of ammonia emissions (6  or in the uptake of nitric acid on dust (13 . Our best estimate for fine nitrate optical depth at 550 nm in 2010 is 0.006 (0.005-0.008). In wintertime, nitrate aerosols are simulated to account for over 30 &#37; of the aerosol optical depth over western Europe and North America. Simulated nitrate optical depth increases by less than 30 &#37; (0.0061-0.010) in response to projected changes in anthropogenic emissions from 2010 to 2050 (e.g., -40 &#37; for SO_2 and +38 &#37; for ammonia). This increase is primarily driven by greater concentrations of nitrate in the free troposphere, while surface nitrate concentrations decrease in the midlatitudes following lower concentrations of nitric acid. With the projected increase of ammonia emissions, we show that better constraints on the vertical distribution of ammonia (e.g., convective transport and biomass burning injection) and on the sources and sinks of nitric acid (e.g., heterogeneous reaction on dust) are needed to improve estimates of future nitrate optical depth.</td>
</tr>
<tr id="bib_Paulot_etal_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Paulot_etal_ACP_2016a,
  author = {Paulot, F. and Ginoux, P. and Cooke, W. F. and Donner, L. J. and Fan, S. and Lin, M.-Y. and Mao, J. and Naik, V. and Horowitz, L. W.},
  title = {Sensitivity of nitrate aerosols to ammonia emissions and to nitrate chemistry: implications for present and future nitrate optical depth},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2016},
  volume = {16},
  pages = {1459-1477},
  url = {http://adsabs.harvard.edu/abs/2016ACP....16.1459P},
  doi = {https://doi.org/10.5194/acp-16-1459-2016}
}
</pre></td>
</tr>
<tr id="Paulot_etal_ACP_2018a" class="entry">
	<td>Paulot, F., Paynter, D., Ginoux, P., Naik, V. and Horowitz, L.W.</td>
	<td>Changes in the aerosol direct radiative forcing from 2001 to 2015: observational constraints and regional mechanisms <p class="infolinks">[<a href="javascript:toggleInfo('Paulot_etal_ACP_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Paulot_etal_ACP_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 13265-13281&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-13265-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....1813265P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Paulot_etal_ACP_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present estimates of changes in the direct aerosol effects (DRE) and its anthropogenic component (DRF) from 2001 to 2015 using the GFDL chemistry-climate model AM3 driven by CMIP6 historical emissions. AM3 is evaluated against observed changes in the clear-sky shortwave direct aerosol effect (DRE_sw^clr) derived from the Clouds and the Earth's Radiant Energy System (CERES) over polluted regions. From 2001 to 2015, observations suggest that DRE_clr^sw increases (i.e., less radiation is scattered to space by aerosols) over western Europe (0.7-1 W m^-2 decade^-1) and the eastern US (0.9-1.4 W m^-2 decade^-1), decreases over India (-1 to -1.6 W m^-2 decade^-1), and does not change significantly over eastern China. AM3 captures these observed regional changes in DRE_clr^sw well in the US and western Europe, where they are dominated by the decline of sulfate aerosols, but not in Asia, where the model overestimates the decrease of DRE_clr^sw. Over India, the model bias can be partly attributed to a decrease of the dust optical depth, which is not captured by our model and offsets some of the increase of anthropogenic aerosols. Over China, we find that the decline of SO_2 emissions after 2007 is not represented in the CMIP6 emission inventory. Accounting for this decline, using the Modular Emission Inventory for China, and for the heterogeneous oxidation of SO_2 significantly reduces the model bias. For both India and China, our simulations indicate that nitrate and black carbon contribute more to changes in DRE_clr^sw than in the US and Europe. Indeed, our model suggests that black carbon (+0.12 W m^-2) dominates the relatively weak change in DRF from 2001 to 2015 (+0.03 W m^-2). Over this period, the changes in the forcing from nitrate and sulfate are both small and of the same magnitude (-0.03 W m^-2 each). This is in sharp contrast to the forcing from 1850 to 2001 in which forcings by sulfate and black carbon largely cancel each other out, with minor contributions from nitrate. The differences between these time periods can be well understood from changes in emissions alone for black carbon but not for nitrate and sulfate; this reflects non-linear changes in the photochemical production of nitrate and sulfate associated with changes in both the magnitude and spatial distribution of anthropogenic emissions.</td>
</tr>
<tr id="bib_Paulot_etal_ACP_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Paulot_etal_ACP_2018a,
  author = {Paulot, F. and Paynter, D. and Ginoux, P. and Naik, V. and Horowitz, L. W.},
  title = {Changes in the aerosol direct radiative forcing from 2001 to 2015: observational constraints and regional mechanisms},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {13265-13281},
  url = {http://adsabs.harvard.edu/abs/2018ACP....1813265P},
  doi = {https://doi.org/10.5194/acp-18-13265-2018}
}
</pre></td>
</tr>
<tr id="Perlwitz_etal_ACP_2015a" class="entry">
	<td>Perlwitz, J.P., P&eacute;rez Garc\ia-Pando, C. and Miller, R.L.</td>
	<td>Predicting the mineral composition of dust aerosols - Part 1: Representing key processes <p class="infolinks">[<a href="javascript:toggleInfo('Perlwitz_etal_ACP_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Perlwitz_etal_ACP_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 15, pp. 11593-11627&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-15-11593-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACP....1511593P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Perlwitz_etal_ACP_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Soil dust aerosols created by wind erosion are typically assigned globally uniform physical and chemical properties within Earth system models, despite known regional variations in the mineral content of the parent soil. Mineral composition of the aerosol particles is important to their interaction with climate, including shortwave absorption and radiative forcing, nucleation of cloud droplets and ice crystals, heterogeneous formation of sulfates and nitrates, and atmospheric processing of iron into bioavailable forms that increase the productivity of marine phytoplankton. Here, aerosol mineral composition is derived by extending a method that provides the composition of a wet-sieved soil. The extension accounts for measurements showing significant differences between the mineral fractions of the wet-sieved soil and the emitted aerosol concentration. For example, some phyllosilicate aerosols are more prevalent at silt sizes, even though they are nearly absent at these diameters in a soil whose aggregates are dispersed by wet sieving. We calculate the emitted mass of each mineral with respect to size by accounting for the disintegration of soil aggregates during wet sieving. These aggregates are emitted during mobilization and fragmentation of the original undispersed soil that is subject to wind erosion. The emitted aggregates are carried far downwind from their parent soil. The soil mineral fractions used to calculate the aggregates also include larger particles that are suspended only in the vicinity of the source. We calculate the emitted size distribution of these particles using a normalized distribution derived from aerosol measurements. In addition, a method is proposed for mixing minerals with small impurities composed of iron oxides. These mixtures are important for transporting iron far from the dust source, because pure iron oxides are more dense and vulnerable to gravitational removal than most minerals comprising dust aerosols. A limited comparison to measurements from North Africa shows that the model extensions result in better agreement, consistent with a more extensive comparison to global observations as well as measurements of elemental composition downwind of the Sahara, as described in companion articles.</td>
</tr>
<tr id="bib_Perlwitz_etal_ACP_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Perlwitz_etal_ACP_2015a,
  author = {Perlwitz, J. P. and P&eacute;rez Garc\ia-Pando, C. and Miller, R. L.},
  title = {Predicting the mineral composition of dust aerosols - Part 1: Representing key processes},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2015},
  volume = {15},
  pages = {11593-11627},
  url = {http://adsabs.harvard.edu/abs/2015ACP....1511593P},
  doi = {https://doi.org/10.5194/acp-15-11593-2015}
}
</pre></td>
</tr>
<tr id="PuGinoux_ACP_2016a" class="entry">
	<td>Pu, B. and Ginoux, P.</td>
	<td>The impact of the Pacific Decadal Oscillation on springtime dust activity in Syria <p class="infolinks">[<a href="javascript:toggleInfo('PuGinoux_ACP_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('PuGinoux_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16, pp. 13431-13448&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-13431-2016">DOI</a> <a href="http://adsabs.harvard.edu/abs/2016ACP....1613431P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_PuGinoux_ACP_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The increasing trend of aerosol optical depth in the Middle East and a recent severe dust storm in Syria have raised questions as to whether dust storms will increase and promoted investigations on the dust activities driven by the natural climate variability underlying the ongoing human perturbations such as the Syrian civil war. This study examined the influences of the Pacific Decadal Oscillation (PDO) on dust activities in Syria using an innovative dust optical depth (DOD) dataset derived from Moderate Resolution Imaging Spectroradiometer (MODIS) Deep Blue aerosol products. A significantly negative correlation is found between the Syrian DOD and the PDO in spring from 2003 to 2015. High DOD in spring is associated with lower geopotential height over the Middle East, Europe, and North Africa, accompanied by near-surface anomalous westerly winds over the Mediterranean basin and southerly winds over the eastern Arabian Peninsula. These large-scale patterns promote the formation of the cyclones over the Middle East to trigger dust storms and also facilitate the transport of dust from North Africa, Iraq, and Saudi Arabia to Syria, where the transported dust dominates the seasonal mean DOD in spring. A negative PDO not only creates circulation anomalies favorable to high DOD in Syria but also suppresses precipitation in dust source regions over the eastern and southern Arabian Peninsula and northeastern Africa.<BR /><BR />On the daily scale, in addition to the favorable large-scale condition associated with a negative PDO, enhanced atmospheric instability in Syria (associated with increased precipitation in Turkey and northern Syria) is also critical for the development of strong springtime dust storms in Syria.</td>
</tr>
<tr id="bib_PuGinoux_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{PuGinoux_ACP_2016a,
  author = {Pu, B. and Ginoux, P.},
  title = {The impact of the Pacific Decadal Oscillation on springtime dust activity in Syria},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2016},
  volume = {16},
  pages = {13431-13448},
  url = {http://adsabs.harvard.edu/abs/2016ACP....1613431P},
  doi = {https://doi.org/10.5194/acp-16-13431-2016}
}
</pre></td>
</tr>
<tr id="PuGinoux_ACP_2018a" class="entry">
	<td>Pu, B. and Ginoux, P.</td>
	<td>How reliable are CMIP5 models in simulating dust optical depth? <p class="infolinks">[<a href="javascript:toggleInfo('PuGinoux_ACP_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('PuGinoux_ACP_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 12491-12510&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-12491-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....1812491P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_PuGinoux_ACP_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust aerosol plays an important role in the climate system by affecting the radiative and energy balances. Biases in dust modeling may result in biases in simulating global energy budget and regional climate. It is thus very important to understand how well dust is simulated in the Coupled Model Intercomparison Project Phase 5 (CMIP5) models. Here seven CMIP5 models using interactive dust emission schemes are examined against satellite-derived dust optical depth (DOD) during 2004-2016.  It is found that multi-model mean can largely capture the global spatial pattern and zonal mean of DOD over land in present-day climatology in MAM and JJA. Global mean land DOD is underestimated by -25.2 &#37; in MAM to -6.4 &#37; in DJF. While seasonal cycle, magnitude, and spatial pattern are generally captured by the multi-model mean over major dust source regions such as North Africa and the Middle East, these variables are not so well represented by most of the models in South Africa and Australia. Interannual variations in DOD are not captured by most of the models or by the multi-model mean. Models also do not capture the observed connections between DOD and local controlling factors such as surface wind speed, bareness, and precipitation. The constraints from surface bareness are largely underestimated while the influences of surface wind and precipitation are overestimated.  Projections of DOD change in the late half of the 21st century under the Representative Concentration Pathways 8.5 scenario in which the multi-model mean is compared with that projected by a regression model. Despite the uncertainties associated with both projections, results show some similarities between the two, e.g., DOD pattern over North Africa in DJF and JJA, an increase in DOD in the central Arabian Peninsula in all seasons, and a decrease over northern China from MAM to SON.</td>
</tr>
<tr id="bib_PuGinoux_ACP_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{PuGinoux_ACP_2018a,
  author = {Pu, B. and Ginoux, P.},
  title = {How reliable are CMIP5 models in simulating dust optical depth?},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {12491-12510},
  url = {http://adsabs.harvard.edu/abs/2018ACP....1812491P},
  doi = {https://doi.org/10.5194/acp-18-12491-2018}
}
</pre></td>
</tr>
<tr id="PuGinoux_ACP_2018b" class="entry">
	<td>Pu, B. and Ginoux, P.</td>
	<td>Climatic factors contributing to long-term variations in surface fine dust concentration in the United States <p class="infolinks">[<a href="javascript:toggleInfo('PuGinoux_ACP_2018b','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('PuGinoux_ACP_2018b','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 4201-4215&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-4201-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....18.4201P">URL</a>&nbsp;</td>
</tr>
<tr id="abs_PuGinoux_ACP_2018b" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: High concentrations of dust particles can cause respiratory problems and increase non-accidental mortality. Studies found fine dust (with an aerodynamic diameter of less than 2.5 microm) is an important component of the total PM_2.5 mass in the western and central US in spring and summer and has positive trends. This work examines climatic factors influencing long-term variations in surface fine dust concentration in the US using station data from the Interagency Monitoring Protected Visual Environments (IMPROVE) network during 1990-2015. The variations in the fine dust concentration can be largely explained by the variations in precipitation, surface bareness, and 10 m wind speed. Moreover, including convective parameters such as convective inhibition (CIN) and convective available potential energy (CAPE) that reveal the stability of the atmosphere better explains the variations and trends over the Great Plains from spring to fall.<BR /><BR />While the positive trend of fine dust concentration in the southwestern US in spring is associated with precipitation deficit, the increase in fine dust over the central Great Plains in summer is largely associated with enhanced CIN and weakened CAPE, which are caused by increased atmospheric stability due to surface drying and lower-troposphere warming. The strengthening of the Great Plains low-level jet also contributes to the increase in fine dust concentration in the central Great Plains in summer via its positive correlation with surface winds and negative correlation with CIN.<BR /><BR />Summer dusty days in the central Great Plains are usually associated with a westward extension of the North Atlantic subtropical high that intensifies the Great Plains low-level jet and also results in a stable atmosphere with subsidence and reduced precipitation.</td>
</tr>
<tr id="bib_PuGinoux_ACP_2018b" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{PuGinoux_ACP_2018b,
  author = {Pu, B. and Ginoux, P.},
  title = {Climatic factors contributing to long-term variations in surface fine dust concentration in the United States},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {4201-4215},
  url = {http://adsabs.harvard.edu/abs/2018ACP....18.4201P},
  doi = {https://doi.org/10.5194/acp-18-4201-2018}
}
</pre></td>
</tr>
<tr id="Quaas_etal_ACP_2009a" class="entry">
	<td>Quaas, J., Ming, Y., Menon, S., Takemura, T., Wang, M., Penner, J.E., Gettelman, A., Lohmann, U., Bellouin, N., Boucher, O., Sayer, A.M., Thomas, G.E., McComiskey, A., Feingold, G., Hoose, C., Kristj&aacute;nsson, J.E., Liu, X., Balkanski, Y., Donner, L.J., Ginoux, P.A., Stier, P., Grandey, B., Feichter, J., Sednev, I., Bauer, S.E., Koch, D., Grainger, R.G., Kirkev&aring;g, A., Iversen, T., Seland, &Oslash;., Easter, R., Ghan, S.J., Rasch, P.J., Morrison, H., Lamarque, J.-F., Iacono, M.J., Kinne, S. and Schulz, M.</td>
	<td>Aerosol indirect effects - general circulation model intercomparison and evaluation with satellite data <p class="infolinks">[<a href="javascript:toggleInfo('Quaas_etal_ACP_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Quaas_etal_ACP_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 9, pp. 8697-8717&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009ACP.....9.8697Q">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Quaas_etal_ACP_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosol indirect effects continue to constitute one of the most
<br>important uncertainties for anthropogenic climate perturbations. Within
<br>the international AEROCOM initiative, the representation of
<br>aerosol-cloud-radiation interactions in ten different general
<br>circulation models (GCMs) is evaluated using three satellite datasets.
<br>The focus is on stratiform liquid water clouds since most GCMs do not
<br>include ice nucleation effects, and none of the model explicitly
<br>parameterises aerosol effects on convective clouds. We compute
<br>statistical relationships between aerosol optical depth
<br>(&tau;_a) and various cloud and radiation quantities in a
<br>manner that is consistent between the models and the satellite data. It
<br>is found that the model-simulated influence of aerosols on cloud droplet
<br>number concentration (N_d) compares relatively well to the
<br>satellite data at least over the ocean. The relationship between
<br>&tau;_a and liquid water path is simulated much too strongly
<br>by the models. This suggests that the implementation of the second
<br>aerosol indirect effect mainly in terms of an autoconversion
<br>parameterisation has to be revisited in the GCMs. A positive
<br>relationship between total cloud fraction (f_cld) and
<br>&tau;_a as found in the satellite data is simulated by the
<br>majority of the models, albeit less strongly than that in the satellite
<br>data in most of them. In a discussion of the hypotheses proposed in the
<br>literature to explain the satellite-derived strong
<br>f_cld-&tau;_a relationship, our results
<br>indicate that none can be identified as a unique explanation.
<br>Relationships similar to the ones found in satellite data between
<br>&tau;_a and cloud top temperature or outgoing long-wave
<br>radiation (OLR) are simulated by only a few GCMs. The GCMs that simulate
<br>a negative OLR-&tau;_a relationship show a strong
<br>positive correlation between &tau;_a and f_cld. The
<br>short-wave total aerosol radiative forcing as simulated by the GCMs is
<br>strongly influenced by the simulated anthropogenic fraction of
<br>&tau;_a, and parameterisation assumptions such as a lower
<br>bound on N_d. Nevertheless, the strengths of the statistical
<br>relationships are good predictors for the aerosol forcings in the
<br>models. An estimate of the total short-wave aerosol forcing inferred
<br>from the combination of these predictors for the modelled forcings with
<br>the satellite-derived statistical relationships yields a global annual
<br>mean value of -1.5plusmn0.5 Wm^-2. In an
<br>alternative approach, the radiative flux perturbation due to
<br>anthropogenic aerosols can be broken down into a component over the
<br>cloud-free portion of the globe (approximately the aerosol direct
<br>effect) and a component over the cloudy portion of the globe
<br>(approximately the aerosol indirect effect). An estimate obtained by
<br>scaling these simulated clear- and cloudy-sky forcings with estimates of
<br>anthropogenic &tau;_a and satellite-retrieved
<br>N_d-&tau;_a regression slopes, respectively,
<br>yields a global, annual-mean aerosol direct effect estimate of
<br>-0.4plusmn0.2 Wm^-2 and a cloudy-sky (aerosol
<br>indirect effect) estimate of -0.7plusmn0.5
<br>Wm^-2, with a total estimate of -1.2plusmn0.4
<br>Wm^-2.
<br></td>
</tr>
<tr id="bib_Quaas_etal_ACP_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Quaas_etal_ACP_2009a,
  author = {Quaas, J. and Ming, Y. and Menon, S. and Takemura, T. and Wang, M. and Penner, J. E. and Gettelman, A. and Lohmann, U. and Bellouin, N. and Boucher, O. and Sayer, A. M. and Thomas, G. E. and McComiskey, A. and Feingold, G. and Hoose, C. and Kristj&aacute;nsson, J. E. and Liu, X. and Balkanski, Y. and Donner, L. J. and Ginoux, P. A. and Stier, P. and Grandey, B. and Feichter, J. and Sednev, I. and Bauer, S. E. and Koch, D. and Grainger, R. G. and Kirkev&aring;g, A. and Iversen, T. and Seland, &Oslash;. and Easter, R. and Ghan, S. J. and Rasch, P. J. and Morrison, H. and Lamarque, J.-F. and Iacono, M. J. and Kinne, S. and Schulz, M.},
  title = {Aerosol indirect effects - general circulation model intercomparison and evaluation with satellite data},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2009},
  volume = {9},
  pages = {8697-8717},
  url = {http://adsabs.harvard.edu/abs/2009ACP.....9.8697Q}
}
</pre></td>
</tr>
<tr id="Ridley_etal_ACP_2014a" class="entry">
	<td>Ridley, D.A., Heald, C.L. and Prospero, J.M.</td>
	<td>What controls the recent changes in African mineral dust aerosol across the Atlantic? <p class="infolinks">[<a href="javascript:toggleInfo('Ridley_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ridley_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14, pp. 5735-5747&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-5735-2014">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014ACP....14.5735R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ridley_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust from Africa strongly perturbs the radiative balance over the
<br>Atlantic, with emissions that are highly variable from year to year. We
<br>show that the aerosol optical depth (AOD) of dust over the mid-Atlantic
<br>observed by the AVHRR satellite has decreased by approximately 10&#37; per
<br>decade from 1982 to 2008. This downward trend persists through both
<br>winter and summer close to source and is also observed in dust surface
<br>concentration measurements downwind in Barbados during summer. The
<br>GEOS-Chem model, driven with MERRA re-analysis meteorology and using a
<br>new dust source activation scheme, reproduces the observed trend and is
<br>used to quantify the factors contributing to this trend and the observed
<br>variability from 1982 to 2008. We find that changes in dustiness over
<br>the east mid-Atlantic are almost entirely mediated by a reduction in
<br>surface winds over dust source regions in Africa and are not directly
<br>linked with changes in land use or vegetation cover. The global mean
<br>all-sky direct radiative effect (DRE) of African dust is -0.18
<br>Wm^-2 at top of atmosphere, accounting for 46&#37; of the global
<br>dust total, with a regional DRE of -7.4 plusmn 1.5 Wm^-2 at
<br>the surface of the mid-Atlantic, varying by over 6.0 Wm^-2
<br>from year to year, with a trend of +1.3 Wm^-2 per decade.
<br>These large interannual changes and the downward trend highlight the
<br>importance of climate feedbacks on natural aerosol abundance. Our
<br>analysis of the CMIP5 models suggests that the decreases in the indirect
<br>anthropogenic aerosol forcing over the North Atlantic in recent decades
<br>may be responsible for the observed climate response in African dust,
<br>indicating a potential amplification of anthropogenic aerosol radiative
<br>impacts in the Atlantic via natural mineral dust aerosol.
<br></td>
</tr>
<tr id="bib_Ridley_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ridley_etal_ACP_2014a,
  author = {Ridley, D. A. and Heald, C. L. and Prospero, J. M.},
  title = {What controls the recent changes in African mineral dust aerosol across the Atlantic?},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2014},
  volume = {14},
  pages = {5735-5747},
  url = {http://adsabs.harvard.edu/abs/2014ACP....14.5735R},
  doi = {https://doi.org/10.5194/acp-14-5735-2014}
}
</pre></td>
</tr>
<tr id="Ridley_etal_ACP_2016a" class="entry">
	<td>Ridley, D.A., Heald, C.L., Kok, J.F. and Zhao, C.</td>
	<td>An observationally constrained estimate of global dust aerosol optical depth <p class="infolinks">[<a href="javascript:toggleInfo('Ridley_etal_ACP_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 16(23), pp. 15097-15117&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-16-15097-2016">DOI</a> &nbsp;</td>
</tr>
<tr id="bib_Ridley_etal_ACP_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ridley_etal_ACP_2016a,
  author = {David A. Ridley and Colette L. Heald and Jasper F. Kok and Chun Zhao},
  title = {An observationally constrained estimate of global dust aerosol optical depth},
  journal = {Atmospheric Chemistry &amp; Physics},
  publisher = {Copernicus GmbH},
  year = {2016},
  volume = {16},
  number = {23},
  pages = {15097--15117},
  doi = {https://doi.org/10.5194/acp-16-15097-2016}
}
</pre></td>
</tr>
<tr id="Ryder_etal_ACP_2015a" class="entry">
	<td>Ryder, C.L., McQuaid, J.B., Flamant, C., Rosenberg, P.D., Washington, R., Brindley, H.E., Highwood, E.J., Marsham, J.H., Parker, D.J., Todd, M.C., Banks, J.R., Brooke, J.K., Engelstaedter, S., Estelles, V., Formenti, P., Garcia-Carreras, L., Kocha, C., Marenco, F., Sodemann, H., Allen, C.J.T., Bourdon, A., Bart, M., Cavazos-Guerra, C., Chevaillier, S., Crosier, J., Darbyshire, E., Dean, A.R., Dorsey, J.R., Kent, J., O'Sullivan, D., Schepanski, K., Szpek, K., Trembath, J. and Woolley, A.</td>
	<td>Advances in understanding mineral dust and boundary layer processes over the Sahara from Fennec aircraft observations <p class="infolinks">[<a href="javascript:toggleInfo('Ryder_etal_ACP_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ryder_etal_ACP_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 15, pp. 8479-8520&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-15-8479-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACP....15.8479R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ryder_etal_ACP_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Fennec climate programme aims to improve understanding of the Saharan climate system through a synergy of observations and modelling. We present a description of the Fennec airborne observations during 2011 and 2012 over the remote Sahara (Mauritania and Mali) and the advances in the understanding of mineral dust and boundary layer processes they have provided. Aircraft instrumentation aboard the UK FAAM BAe146 and French SAFIRE (Service des Avions Fran&cedil; cais Instrument&eacute;s pour la Recherche en Environnement) Falcon 20 is described, with specific focus on instrumentation specially developed for and relevant to Saharan meteorology and dust. Flight locations, aims and associated meteorology are described. Examples and applications of aircraft measurements from the Fennec flights are presented, highlighting new scientific results delivered using a synergy of different instruments and aircraft. These include (1) the first airborne measurement of dust particles sizes of up to 300 microns and associated dust fluxes in the Saharan atmospheric boundary layer (SABL), (2) dust uplift from the breakdown of the nocturnal low-level jet before becoming visible in SEVIRI (Spinning Enhanced Visible Infra-Red Imager) satellite imagery, (3) vertical profiles of the unique vertical structure of turbulent fluxes in the SABL, (4) in situ observations of processes in SABL clouds showing dust acting as cloud condensation nuclei (CCN) and ice nuclei (IN) at -15 degC, (5) dual-aircraft observations of the SABL dynamics, thermodynamics and composition in the Saharan heat low region (SHL), (6) airborne observations of a dust storm associated with a cold pool (haboob) issued from deep convection over the Atlas Mountains, (7) the first airborne chemical composition measurements of dust in the SHL region with differing composition, sources (determined using Lagrangian backward trajectory calculations) and absorption properties between 2011 and 2012, (8) coincident ozone and dust surface area measurements suggest coarser particles provide a route for ozone depletion, (9) discrepancies between airborne coarse-mode size distributions and AERONET (AERosol Robotic NETwork) sunphotometer retrievals under light dust loadings. These results provide insights into boundary layer and dust processes in the SHL region - a region of substantial global climatic importance.</td>
</tr>
<tr id="bib_Ryder_etal_ACP_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ryder_etal_ACP_2015a,
  author = {Ryder, C. L. and McQuaid, J. B. and Flamant, C. and Rosenberg, P. D. and Washington, R. and Brindley, H. E. and Highwood, E. J. and Marsham, J. H. and Parker, D. J. and Todd, M. C. and Banks, J. R. and Brooke, J. K. and Engelstaedter, S. and Estelles, V. and Formenti, P. and Garcia-Carreras, L. and Kocha, C. and Marenco, F. and Sodemann, H. and Allen, C. J. T. and Bourdon, A. and Bart, M. and Cavazos-Guerra, C. and Chevaillier, S. and Crosier, J. and Darbyshire, E. and Dean, A. R. and Dorsey, J. R. and Kent, J. and O'Sullivan, D. and Schepanski, K. and Szpek, K. and Trembath, J. and Woolley, A.},
  title = {Advances in understanding mineral dust and boundary layer processes over the Sahara from Fennec aircraft observations},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2015},
  volume = {15},
  pages = {8479-8520},
  url = {http://adsabs.harvard.edu/abs/2015ACP....15.8479R},
  doi = {https://doi.org/10.5194/acp-15-8479-2015}
}
</pre></td>
</tr>
<tr id="Ryder_etal_ACP_2018a" class="entry">
	<td>Ryder, C.L., Marenco, F., Brooke, J.K., Estelles, V., Cotton, R., Formenti, P., McQuaid, J.B., Price, H.C., Liu, D., Ausset, P., Rosenberg, P.D., Taylor, J.W., Choularton, T., Bower, K., Coe, H., Gallagher, M., Crosier, J., Lloyd, G., Highwood, E.J. and Murray, B.J.</td>
	<td>Coarse-mode mineral dust size distributions, composition and optical properties from AER-D aircraft measurements over the tropical eastern Atlantic <p class="infolinks">[<a href="javascript:toggleInfo('Ryder_etal_ACP_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ryder_etal_ACP_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 17225-17257&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-17225-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....1817225R">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ryder_etal_ACP_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Mineral dust is an important component of the climate system, affecting the radiation balance, cloud properties, biogeochemical cycles, regional circulation and precipitation, as well as having negative effects on aviation, solar energy generation and human health. Dust size and composition has an impact on all these processes. However, changes in dust size distribution and composition during transport, particularly for coarse particles, are poorly understood and poorly represented in climate models. Here we present new in situ airborne observations of dust in the Saharan Air Layer (SAL) and the marine boundary layer (MBL) at the beginning of its transatlantic transport pathway, from the AERosol Properties - Dust (AER-D) fieldwork in August 2015, within the peak season of North African dust export. This study focuses on coarse-mode dust properties, including size distribution, mass loading, shape, composition, refractive indices and optical properties. Size distributions from 0.1 to 100 microm diameter (d) are presented, fully incorporating the coarse and giant modes of dust. Within the MBL, mean effective diameter (d_eff) and volume median diameter (VMD) were 4.6 and 6.0 microm respectively, giant particles with a mode at 20-30 microm were observed, and composition was dominated by quartz and alumino-silicates at d gt 1 microm. Within the SAL, particles larger than 20 microm diameter were always present up to 5 km altitude, in concentrations over 10^-5 cm^-3, constituting up to 40 &#37; of total dust mass. Mean d_eff and VMD were 4.0 and 5.5 microm respectively. Larger particles were detected in the SAL than can be explained by sedimentation theory alone. Coarse-mode composition was dominated by quartz and alumino-silicates; the accumulation mode showed a strong contribution from sulfate-rich and sea salt particles. In the SAL, measured single scattering albedos (SSAs) at 550 nm representing d lt 2.5 microm were 0.93 to 0.98 (mean 0.97). Optical properties calculated for the full size distribution (0.1 lt d lt 100 microm) resulted in lower SSAs of 0.91-0.98 (mean 0.95) and mass extinction coefficients of 0.27-0.35 m^2 g^-1 (mean 0.32 m^2 g^-1). Variability in SSA was mainly controlled by variability in dust composition (principally iron) rather than by variations in the size distribution, in contrast with previous observations over the Sahara where size is the dominant influence. It is important that models are able to capture the variability and evolution of both dust composition and size distribution with transport in order to accurately represent the impacts of dust on climate. These results provide a new SAL dust dataset, fully representing coarse and giant particles, to aid model validation and development.</td>
</tr>
<tr id="bib_Ryder_etal_ACP_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ryder_etal_ACP_2018a,
  author = {Ryder, C. L. and Marenco, F. and Brooke, J. K. and Estelles, V. and Cotton, R. and Formenti, P. and McQuaid, J. B. and Price, H. C. and Liu, D. and Ausset, P. and Rosenberg, P. D. and Taylor, J. W. and Choularton, T. and Bower, K. and Coe, H. and Gallagher, M. and Crosier, J. and Lloyd, G. and Highwood, E. J. and Murray, B. J.},
  title = {Coarse-mode mineral dust size distributions, composition and optical properties from AER-D aircraft measurements over the tropical eastern Atlantic},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {17225-17257},
  url = {http://adsabs.harvard.edu/abs/2018ACP....1817225R},
  doi = {https://doi.org/10.5194/acp-18-17225-2018}
}
</pre></td>
</tr>
<tr id="Salzmann_etal_ACP_2010a" class="entry">
	<td>Salzmann, M., Ming, Y., Golaz, J.-C., Ginoux, P.A., Morrison, H., Gettelman, A., Kr&auml;mer, M. and Donner, L.J.</td>
	<td>Two-moment bulk stratiform cloud microphysics in the GFDL AM3 GCM: description, evaluation, and sensitivity tests <p class="infolinks">[<a href="javascript:toggleInfo('Salzmann_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Salzmann_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 8037-8064&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-10-8037-2010">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ACP....10.8037S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Salzmann_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A new stratiform cloud scheme including a two-moment bulk microphysics module, a cloud cover parameterization allowing ice supersaturation, and an ice nucleation parameterization has been implemented into the recently developed GFDL AM3 general circulation model (GCM) as part of an effort to treat aerosol-cloud-radiation interactions more realistically. Unlike the original scheme, the new scheme facilitates the study of cloud-ice-aerosol interactions via influences of dust and sulfate on ice nucleation. While liquid and cloud ice water path associated with stratiform clouds are similar for the new and the original scheme, column integrated droplet numbers and global frequency distributions (PDFs) of droplet effective radii differ significantly. This difference is in part due to a difference in the implementation of the Wegener-Bergeron-Findeisen (WBF) mechanism, which leads to a larger contribution from super-cooled droplets in the original scheme. Clouds are more likely to be either completely glaciated or liquid due to the WBF mechanism in the new scheme. Super-saturations over ice simulated with the new scheme are in qualitative agreement with observations, and PDFs of ice numbers and effective radii appear reasonable in the light of observations. Especially, the temperature dependence of ice numbers qualitatively agrees with in-situ observations. The global average long-wave cloud forcing decreases in comparison to the original scheme as expected when super-saturation over ice is allowed. Anthropogenic aerosols lead to a larger decrease in short-wave absorption (SWABS) in the new model setup, but outgoing long-wave radiation (OLR) decreases as well, so that the net effect of including anthropogenic aerosols on the net radiation at the top of the atmosphere (netradTOA = SWABS-OLR) is of similar magnitude for the new and the original scheme.</td>
</tr>
<tr id="bib_Salzmann_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Salzmann_etal_ACP_2010a,
  author = {Salzmann, M. and Ming, Y. and Golaz, J.-C. and Ginoux, P. A. and Morrison, H. and Gettelman, A. and Kr&auml;mer, M. and Donner, L. J.},
  title = {Two-moment bulk stratiform cloud microphysics in the GFDL AM3 GCM: description, evaluation, and sensitivity tests},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {8037-8064},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.8037S},
  doi = {https://doi.org/10.5194/acp-10-8037-2010}
}
</pre></td>
</tr>
<tr id="Samset_etal_ACP_2013a" class="entry">
	<td>Samset, B.H., Myhre, G., Schulz, M., Balkanski, Y., Bauer, S., Berntsen, T.K., Bian, H., Bellouin, N., Diehl, T., Easter, R.C., Ghan, S.J., Iversen, T., Kinne, S., Kirkev&aring;g, A., Lamarque, J.-F., Lin, G., Liu, X., Penner, J.E., Seland, &Oslash;., Skeie, R.B., Stier, P., Takemura, T., Tsigaridis, K. and Zhang, K.</td>
	<td>Black carbon vertical profiles strongly affect its radiative forcing uncertainty <p class="infolinks">[<a href="javascript:toggleInfo('Samset_etal_ACP_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Samset_etal_ACP_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 13, pp. 2423-2434&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-13-2423-2013">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013ACP....13.2423S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Samset_etal_ACP_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The impact of black carbon (BC) aerosols on the global radiation balance
<br>is not well constrained. Here twelve global aerosol models are used to
<br>show that at least 20&#37; of the present uncertainty in modeled BC direct
<br>radiative forcing (RF) is due to diversity in the simulated vertical
<br>profile of BC mass. Results are from phases 1 and 2 of the global
<br>aerosol model intercomparison project (AeroCom). Additionally, a
<br>significant fraction of the variability is shown to come from high
<br>altitudes, as, globally, more than 40&#37; of the total BC RF is exerted
<br>above 5 km. BC emission regions and areas with transported BC are found
<br>to have differing characteristics. These insights into the importance of
<br>the vertical profile of BC lead us to suggest that observational studies
<br>are needed to better characterize the global distribution of BC,
<br>including in the upper troposphere.
<br></td>
</tr>
<tr id="bib_Samset_etal_ACP_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Samset_etal_ACP_2013a,
  author = {Samset, B. H. and Myhre, G. and Schulz, M. and Balkanski, Y. and Bauer, S. and Berntsen, T. K. and Bian, H. and Bellouin, N. and Diehl, T. and Easter, R. C. and Ghan, S. J. and Iversen, T. and Kinne, S. and Kirkev&aring;g, A. and Lamarque, J.-F. and Lin, G. and Liu, X. and Penner, J. E. and Seland, &Oslash;. and Skeie, R. B. and Stier, P. and Takemura, T. and Tsigaridis, K. and Zhang, K.},
  title = {Black carbon vertical profiles strongly affect its radiative forcing uncertainty},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2013},
  volume = {13},
  pages = {2423-2434},
  url = {http://adsabs.harvard.edu/abs/2013ACP....13.2423S},
  doi = {https://doi.org/10.5194/acp-13-2423-2013}
}
</pre></td>
</tr>
<tr id="Samset_etal_ACP_2014a" class="entry">
	<td>Samset, B.H., Myhre, G., Herber, A., Kondo, Y., Li, S.-M., Moteki, N., Koike, M., Oshima, N., Schwarz, J.P., Balkanski, Y., Bauer, S.E., Bellouin, N., Berntsen, T.K., Bian, H., Chin, M., Diehl, T., Easter, R.C., Ghan, S.J., Iversen, T., Kirkev&aring;g, A., Lamarque, J.-F., Lin, G., Liu, X., Penner, J.E., Schulz, M., Seland, &Oslash;., Skeie, R.B., Stier, P., Takemura, T., Tsigaridis, K. and Zhang, K.</td>
	<td>Modelled black carbon radiative forcing and atmospheric lifetime in AeroCom Phase II constrained by aircraft observations <p class="infolinks">[<a href="javascript:toggleInfo('Samset_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Samset_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14, pp. 12465-12477&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-12465-2014">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014ACP....1412465S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Samset_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Atmospheric black carbon (BC) absorbs solar radiation, and exacerbates
<br>global warming through exerting positive radiative forcing (RF).
<br>However, the contribution of BC to ongoing changes in global climate is
<br>under debate. Anthropogenic BC emissions, and the resulting distribution
<br>of BC concentration, are highly uncertain. In particular, long-range
<br>transport and processes affecting BC atmospheric lifetime are poorly
<br>understood. Here we discuss whether recent assessments may have
<br>overestimated present-day BC radiative forcing in remote regions. We
<br>compare vertical profiles of BC concentration from four recent aircraft
<br>measurement campaigns to simulations by 13 aerosol models participating
<br>in the AeroCom Phase II intercomparison. An atmospheric lifetime of BC
<br>of less than 5 days is shown to be essential for reproducing
<br>observations in remote ocean regions, in line with other recent studies.
<br>Adjusting model results to measurements in remote regions, and at high
<br>altitudes, leads to a 25&#37; reduction in AeroCom Phase II median direct BC
<br>forcing, from fossil fuel and biofuel burning, over the industrial era.
<br>The sensitivity of modelled forcing to BC vertical profile and lifetime
<br>highlights an urgent need for further flight campaigns, close to sources
<br>and in remote regions, to provide improved quantification of BC effects
<br>for use in climate policy.
<br></td>
</tr>
<tr id="bib_Samset_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Samset_etal_ACP_2014a,
  author = {Samset, B. H. and Myhre, G. and Herber, A. and Kondo, Y. and Li, S.-M. and Moteki, N. and Koike, M. and Oshima, N. and Schwarz, J. P. and Balkanski, Y. and Bauer, S. E. and Bellouin, N. and Berntsen, T. K. and Bian, H. and Chin, M. and Diehl, T. and Easter, R. C. and Ghan, S. J. and Iversen, T. and Kirkev&aring;g, A. and Lamarque, J.-F. and Lin, G. and Liu, X. and Penner, J. E. and Schulz, M. and Seland, &Oslash;. and Skeie, R. B. and Stier, P. and Takemura, T. and Tsigaridis, K. and Zhang, K.},
  title = {Modelled black carbon radiative forcing and atmospheric lifetime in AeroCom Phase II constrained by aircraft observations},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2014},
  volume = {14},
  pages = {12465-12477},
  url = {http://adsabs.harvard.edu/abs/2014ACP....1412465S},
  doi = {https://doi.org/10.5194/acp-14-12465-2014}
}
</pre></td>
</tr>
<tr id="Schnell_etal_ACP_2018a" class="entry">
	<td>Schnell, J.L., Naik, V., Horowitz, L.W., Paulot, F., Mao, J., Ginoux, P., Zhao, M. and Ram, K.</td>
	<td>Exploring the relationship between surface PM_2.5 and meteorology in Northern India <p class="infolinks">[<a href="javascript:toggleInfo('Schnell_etal_ACP_2018a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Schnell_etal_ACP_2018a','bibtex')">BibTeX</a>]</p></td>
	<td>2018</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 18, pp. 10157-10175&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-18-10157-2018">DOI</a> <a href="http://adsabs.harvard.edu/abs/2018ACP....1810157S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Schnell_etal_ACP_2018a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Northern India (23-31deg N, 68-90deg E) is one of the most densely populated and polluted regions in world. Accurately modeling pollution in the region is difficult due to the extreme conditions with respect to emissions, meteorology, and topography, but it is paramount in order to understand how future changes in emissions and climate may alter the region's pollution regime. We evaluate the ability of a developmental version of the new-generation NOAA GFDL Atmospheric Model, version 4 (AM4) to simulate observed wintertime fine particulate matter (PM_2.5) and its relationship to meteorology over Northern India. We compare two simulations of GFDL-AM4 nudged to observed meteorology for the period 1980-2016 driven by pollutant emissions from two global inventories developed in support of the Coupled Model Intercomparison Project Phases 5 (CMIP5) and 6 (CMIP6), and compare results with ground-based observations from India's Central Pollution Control Board (CPCB) for the period 1 October 2015-31 March 2016. Overall, our results indicate that the simulation with CMIP6 emissions produces improved concentrations of pollutants over the region relative to the CMIP5-driven simulation.  While the particulate concentrations simulated by AM4 are biased low overall, the model generally simulates the magnitude and daily variability of observed total PM_2.5. Nitrate and organic matter are the primary components of PM_2.5 over Northern India in the model. On the basis of correlations of the individual model components with total observed PM_2.5 and correlations between the two simulations, meteorology is the primary driver of daily variability. The model correctly reproduces the shape and magnitude of the seasonal cycle of PM_2.5, but the simulated diurnal cycle misses the early evening rise and secondary maximum found in the observations. Observed PM_2.5 abundances are by far the highest within the densely populated Indo-Gangetic Plain, where they are closely related to boundary layer meteorology, specifically relative humidity, wind speed, boundary layer height, and inversion strength. The GFDL AM4 model reproduces the overall observed pollution gradient over Northern India as well as the strength of the meteorology-PM_2.5 relationship in most locations.</td>
</tr>
<tr id="bib_Schnell_etal_ACP_2018a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schnell_etal_ACP_2018a,
  author = {Schnell, J. L. and Naik, V. and Horowitz, L. W. and Paulot, F. and Mao, J. and Ginoux, P. and Zhao, M. and Ram, K.},
  title = {Exploring the relationship between surface PM_2.5 and meteorology in Northern India},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2018},
  volume = {18},
  pages = {10157-10175},
  url = {http://adsabs.harvard.edu/abs/2018ACP....1810157S},
  doi = {https://doi.org/10.5194/acp-18-10157-2018}
}
</pre></td>
</tr>
<tr id="Schulz_etal_ACP_2006a" class="entry">
	<td>Schulz, M., Textor, C., Kinne, S., Balkanski, Y., Bauer, S., Berntsen, T., Berglen, T., Boucher, O., Dentener, F., Guibert, S., Isaksen, I.S.A., Iversen, T., Koch, D., Kirkev&aring;g, A., Liu, X., Montanaro, V., Myhre, G., Penner, J.E., Pitari, G., Reddy, S., Seland, &Oslash;., Stier, P. and Takemura, T.</td>
	<td>Radiative forcing by aerosols as derived from the AeroCom present-day and pre-industrial simulations <p class="infolinks">[<a href="javascript:toggleInfo('Schulz_etal_ACP_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Schulz_etal_ACP_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 6, pp. 5225-5246&nbsp;</td>
	<td>article</td>
	<td>&nbsp;</td>
</tr>
<tr id="abs_Schulz_etal_ACP_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Nine different global models with detailed aerosol modules have
<br>independently produced instantaneous direct radiative forcing due to
<br>anthropogenic aerosols. The anthropogenic impact is derived from the
<br>difference of two model simulations with prescribed aerosol emissions,
<br>one for present-day and one for pre-industrial conditions. The
<br>difference in the solar energy budget at the top of the atmosphere (ToA)
<br>yields a new harmonized estimate for the aerosol direct radiative
<br>forcing (RF) under all-sky conditions. On a global annual basis RF is
<br>-0.22 Wm^-2, ranging from +0.04 to -0.41
<br>Wm^-2, with a standard deviation of plusmn0.16
<br>Wm^-2. Anthropogenic nitrate and dust are not included
<br>in this estimate. No model shows a significant positive all-sky RF. The
<br>corresponding clear-sky RF is -0.68 Wm^-2. The
<br>cloud-sky RF was derived based on all-sky and clear-sky RF and modelled
<br>cloud cover. It was significantly different from zero and ranged between
<br>-0.16 and +0.34 Wm^-2. A sensitivity analysis
<br>shows that the total aerosol RF is influenced by considerable diversity
<br>in simulated residence times, mass extinction coefficients and most
<br>importantly forcing efficiencies (forcing per unit optical depth). The
<br>clear-sky forcing efficiency (forcing per unit optical depth) has
<br>diversity comparable to that for the all-sky/ clear-sky forcing ratio.
<br>While the diversity in clear-sky forcing efficiency is impacted by
<br>factors such as aerosol absorption, size, and surface albedo, we can
<br>show that the all-sky/clear-sky forcing ratio is important because
<br>all-sky forcing estimates require proper representation of cloud fields
<br>and the correct relative altitude placement between absorbing aerosol
<br>and clouds. The analysis of the sulphate RF shows that long sulphate
<br>residence times are compensated by low mass extinction coefficients and
<br>vice versa. This is explained by more sulphate particle humidity growth
<br>and thus higher extinction in those models where short-lived sulphate is
<br>present at lower altitude and vice versa. Solar atmospheric forcing
<br>within the atmospheric column is estimated at +0.82plusmn0.17
<br>Wm^-2. The local annual average maxima of atmospheric
<br>forcing exceed +5 Wm^-2 confirming the regional
<br>character of aerosol impacts on climate. The annual average surface
<br>forcing is -1.02plusmn0.23 Wm^-2. With the
<br>current uncertainties in the modelling of the radiative forcing due to
<br>the direct aerosol effect we show here that an estimate from one model
<br>is not sufficient but a combination of several model estimates is
<br>necessary to provide a mean and to explore the uncertainty.
<br></td>
</tr>
<tr id="bib_Schulz_etal_ACP_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Schulz_etal_ACP_2006a,
  author = {Schulz, M. and Textor, C. and Kinne, S. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Berglen, T. and Boucher, O. and Dentener, F. and Guibert, S. and Isaksen, I. S. A. and Iversen, T. and Koch, D. and Kirkev&aring;g, A. and Liu, X. and Montanaro, V. and Myhre, G. and Penner, J. E. and Pitari, G. and Reddy, S. and Seland, &Oslash;. and Stier, P. and Takemura, T.},
  title = {Radiative forcing by aerosols as derived from the AeroCom present-day and pre-industrial simulations},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2006},
  volume = {6},
  pages = {5225-5246}
}
</pre></td>
</tr>
<tr id="Shindell_etal_ACP_2013a" class="entry">
	<td>Shindell, D.T., Lamarque, J.-F., Schulz, M., Flanner, M., Jiao, C., Chin, M., Young, P.J., Lee, Y.H., Rotstayn, L., Mahowald, N., Milly, G., Faluvegi, G., Balkanski, Y., Collins, W.J., Conley, A.J., Dalsoren, S., Easter, R., Ghan, S., Horowitz, L., Liu, X., Myhre, G., Nagashima, T., Naik, V., Rumbold, S.T., Skeie, R., Sudo, K., Szopa, S., Takemura, T., Voulgarakis, A., Yoon, J.-H. and Lo, F.</td>
	<td>Radiative forcing in the ACCMIP historical and future climate simulations <p class="infolinks">[<a href="javascript:toggleInfo('Shindell_etal_ACP_2013a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Shindell_etal_ACP_2013a','bibtex')">BibTeX</a>]</p></td>
	<td>2013</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 13, pp. 2939-2974&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-13-2939-2013">DOI</a> <a href="http://adsabs.harvard.edu/abs/2013ACP....13.2939S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Shindell_etal_ACP_2013a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The Atmospheric Chemistry and Climate Model Intercomparison Project
<br>(ACCMIP) examined the short-lived drivers of climate change in current
<br>climate models. Here we evaluate the 10 ACCMIP models that included
<br>aerosols, 8 of which also participated in the Coupled Model
<br>Intercomparison Project phase 5 (CMIP5). <BR /><BR /> The models
<br>reproduce present-day total aerosol optical depth (AOD) relatively well,
<br>though many are biased low. Contributions from individual aerosol
<br>components are quite different, however, and most models underestimate
<br>east Asian AOD. The models capture most 1980-2000 AOD trends well, but
<br>underpredict increases over the Yellow/Eastern Sea. They strongly
<br>underestimate absorbing AOD in many regions. <BR /><BR /> We examine
<br>both the direct radiative forcing (RF) and the forcing including rapid
<br>adjustments (effective radiative forcing; ERF, including direct and
<br>indirect effects). The models' all-sky 1850 to 2000 global mean annual
<br>average total aerosol RF is (mean; range) -0.26 W m^-2; -0.06
<br>to -0.49 W m^-2. Screening based on model skill in capturing
<br>observed AOD yields a best estimate of -0.42 W m^-2; -0.33 to
<br>-0.50 W m^-2, including adjustment for missing aerosol
<br>components in some models. Many ACCMIP and CMIP5 models appear to
<br>produce substantially smaller aerosol RF than this best estimate.
<br>Climate feedbacks contribute substantially (35 to -58 to modeled
<br>historical aerosol RF. The 1850 to 2000 aerosol ERF is -1.17 W
<br>m^-2; -0.71 to -1.44 W m^-2. Thus adjustments,
<br>including clouds, typically cause greater forcing than direct RF.
<br>Despite this, the multi-model spread relative to the mean is typically
<br>the same for ERF as it is for RF, or even smaller, over areas with
<br>substantial forcing. The largest 1850 to 2000 negative aerosol RF and
<br>ERF values are over and near Europe, south and east Asia and North
<br>America. ERF, however, is positive over the Sahara, the Karakoram, high
<br>Southern latitudes and especially the Arctic. <BR /><BR /> Global
<br>aerosol RF peaks in most models around 1980, declining thereafter with
<br>only weak sensitivity to the Representative Concentration Pathway (RCP).
<br>One model, however, projects approximately stable RF levels, while two
<br>show increasingly negative RF due to nitrate (not included in most
<br>models). Aerosol ERF, in contrast, becomes more negative during 1980 to
<br>2000. During this period, increased Asian emissions appear to have a
<br>larger impact on aerosol ERF than European and North American decreases
<br>due to their being upwind of the large, relatively pristine Pacific
<br>Ocean. There is no clear relationship between historical aerosol ERF and
<br>climate sensitivity in the CMIP5 subset of ACCMIP models. In the
<br>ACCMIP/CMIP5 models, historical aerosol ERF of about -0.8 to -1.5 W
<br>m^-2 is most consistent with observed historical warming.
<br>Aerosol ERF masks a large portion of greenhouse forcing during the late
<br>20th and early 21st century at the global scale. Regionally, aerosol ERF
<br>is so large that net forcing is negative over most industrialized and
<br>biomass burning regions through 1980, but remains strongly negative only
<br>over east and southeast Asia by 2000. Net forcing is strongly positive
<br>by 1980 over most deserts, the Arctic, Australia, and most tropical
<br>oceans. Both the magnitude of and area covered by positive forcing
<br>expand steadily thereafter.
<br></td>
</tr>
<tr id="bib_Shindell_etal_ACP_2013a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Shindell_etal_ACP_2013a,
  author = {Shindell, D. T. and Lamarque, J.-F. and Schulz, M. and Flanner, M. and Jiao, C. and Chin, M. and Young, P. J. and Lee, Y. H. and Rotstayn, L. and Mahowald, N. and Milly, G. and Faluvegi, G. and Balkanski, Y. and Collins, W. J. and Conley, A. J. and Dalsoren, S. and Easter, R. and Ghan, S. and Horowitz, L. and Liu, X. and Myhre, G. and Nagashima, T. and Naik, V. and Rumbold, S. T. and Skeie, R. and Sudo, K. and Szopa, S. and Takemura, T. and Voulgarakis, A. and Yoon, J.-H. and Lo, F.},
  title = {Radiative forcing in the ACCMIP historical and future climate simulations},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2013},
  volume = {13},
  pages = {2939-2974},
  url = {http://adsabs.harvard.edu/abs/2013ACP....13.2939S},
  doi = {https://doi.org/10.5194/acp-13-2939-2013}
}
</pre></td>
</tr>
<tr id="Stier_etal_ACP_2005a" class="entry">
	<td>Stier, P., Feichter, J., Kinne, S., Kloster, S., Vignati, E., Wilson, J., Ganzeveld, L., Tegen, I., Werner, M., Balkanski, Y., Schulz, M., Boucher, O., Minikin, A. and Petzold, A.</td>
	<td>The aerosol-climate model ECHAM5-HAM <p class="infolinks">[<a href="javascript:toggleInfo('Stier_etal_ACP_2005a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Stier_etal_ACP_2005a','bibtex')">BibTeX</a>]</p></td>
	<td>2005</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 5, pp. 1125-1156&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2005ACP.....5.1125S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Stier_etal_ACP_2005a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The aerosol-climate modelling system ECHAM5-HAM is introduced. It is
<br>based on a flexible microphysical approach and, as the number of
<br>externally imposed parameters is minimised, allows the application in a
<br>wide range of climate regimes. ECHAM5-HAM predicts the evolution of an
<br>ensemble of microphysically interacting internally- and externally-mixed
<br>aerosol populations as well as their size-distribution and composition.
<br>The size-distribution is represented by a superposition of log-normal
<br>modes. In the current setup, the major global aerosol compounds sulfate
<br>(SU), black carbon (BC), particulate organic matter (POM), sea salt
<br>(SS), and mineral dust (DU) are included. The simulated global annual
<br>mean aerosol burdens (lifetimes) for the year 2000 are for SU: 0.80
<br>Tg(S) (3.9 days), for BC: 0.11 Tg (5.4 days), for POM: 0.99 Tg (5.4
<br>days), for SS: 10.5 Tg (0.8 days), and for DU: 8.28 Tg (4.6 days). An
<br>extensive evaluation with in-situ and remote sensing measurements
<br>underscores that the model results are generally in good agreement with
<br>observations of the global aerosol system. The simulated global annual
<br>mean aerosol optical depth (AOD) is with 0.14 in excellent agreement
<br>with an estimate derived from AERONET measurements (0.14) and a
<br>composite derived from MODIS-MISR satellite retrievals (0.16).
<br>Regionally, the deviations are not negligible. However, the main
<br>patterns of AOD attributable to anthropogenic activity are reproduced.
<br></td>
</tr>
<tr id="bib_Stier_etal_ACP_2005a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Stier_etal_ACP_2005a,
  author = {Stier, P. and Feichter, J. and Kinne, S. and Kloster, S. and Vignati, E. and Wilson, J. and Ganzeveld, L. and Tegen, I. and Werner, M. and Balkanski, Y. and Schulz, M. and Boucher, O. and Minikin, A. and Petzold, A.},
  title = {The aerosol-climate model ECHAM5-HAM},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2005},
  volume = {5},
  pages = {1125-1156},
  url = {http://adsabs.harvard.edu/abs/2005ACP.....5.1125S}
}
</pre></td>
</tr>
<tr id="Stier_etal_ACP_2007a" class="entry">
	<td>Stier, P., Seinfeld, J.H., Kinne, S. and Boucher, O.</td>
	<td>Aerosol absorption and radiative forcing <p class="infolinks">[<a href="javascript:toggleInfo('Stier_etal_ACP_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Stier_etal_ACP_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 7, pp. 5237-5261&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2007ACP.....7.5237S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Stier_etal_ACP_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: We present a comprehensive examination of aerosol absorption with a focus on evaluating the sensitivity of the global distribution of aerosol absorption to key uncertainties in the process representation. For this purpose we extended the comprehensive aerosol-climate model ECHAM5-HAM by effective medium approximations for the calculation of aerosol effective refractive indices, updated black carbon refractive indices, new cloud radiative properties considering the effect of aerosol inclusions, as well as by modules for the calculation of long-wave aerosol radiative properties and instantaneous aerosol forcing. The evaluation of the simulated aerosol absorption optical depth with the AERONET sun-photometer network shows a good agreement in the large scale global patterns. On a regional basis it becomes evident that the update of the BC refractive indices to Bond and Bergstrom (2006) significantly improves the previous underestimation of the aerosol absorption optical depth. In the global annual-mean, absorption acts to reduce the short-wave anthropogenic aerosol top-of-atmosphere (TOA) radiative forcing clear-sky from -0.79 to -0.53 W m^-2 (33 and all-sky from -0.47 to -0.13 W m^-2 (72. Our results confirm that basic assumptions about the BC refractive index play a key role for aerosol absorption and radiative forcing. The effect of the usage of more accurate effective medium approximations is comparably small. We demonstrate that the diversity in the AeroCom land-surface albedo fields contributes to the uncertainty in the simulated anthropogenic aerosol radiative forcings: the usage of an upper versus lower bound of the AeroCom land albedos introduces a global annual-mean TOA forcing range of 0.19 W m^-2 (36 clear-sky and of 0.12 W m^-2 (92 all-sky. The consideration of black carbon inclusions on cloud radiative properties results in a small global annual-mean all-sky absorption of 0.05 W m^-2 and a positive TOA forcing perturbation of 0.02 W m^-2. The long-wave aerosol radiative effects are small for anthropogenic aerosols but become of relevance for the larger natural dust and sea-salt aerosols.</td>
</tr>
<tr id="bib_Stier_etal_ACP_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Stier_etal_ACP_2007a,
  author = {Stier, P. and Seinfeld, J. H. and Kinne, S. and Boucher, O.},
  title = {Aerosol absorption and radiative forcing},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2007},
  volume = {7},
  pages = {5237-5261},
  url = {http://adsabs.harvard.edu/abs/2007ACP.....7.5237S}
}
</pre></td>
</tr>
<tr id="Sullivan_etal_ACP_2010a" class="entry">
	<td>Sullivan, R.C., Petters, M.D., Demott, P.J., Kreidenweis, S.M., Wex, H., Niedermeier, D., Hartmann, S., Clauss, T., Stratmann, F., Reitz, P., Schneider, J. and Sierau, B.</td>
	<td>Irreversible loss of ice nucleation active sites in mineral dust particles caused by sulphuric acid condensation <p class="infolinks">[<a href="javascript:toggleInfo('Sullivan_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Sullivan_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 11471-11487&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-10-11471-2010">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ACP....1011471S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Sullivan_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: During the FROST-2 (FReezing Of duST) measurement campaign conducted at
<br>the Leipzig Aerosol Cloud Interaction Simulator (LACIS), we investigated
<br>changes in the ice nucleation properties of 300 nm Arizona Test Dust
<br>mineral particles following thermochemical processing by varying amounts
<br>and combinations of exposure to sulphuric acid vapour, ammonia gas,
<br>water vapour, and heat. The processed particles' heterogeneous ice
<br>nucleation properties were determined in both the water subsaturated and
<br>supersaturated humidity regimes at -30 degC and -25 degC
<br>using Colorado State University's continuous flow diffusion chamber. The
<br>amount of sulphuric acid coating material was estimated by an aerosol
<br>mass spectrometer and from CCN-derived hygroscopicity measurements. The
<br>condensation of sulphuric acid decreased the dust particles' ice
<br>nucleation ability in proportion to the amount of sulphuric acid added.
<br>Heating the coated particles in a thermodenuder at 250 degC -
<br>intended to evaporate the sulphuric acid coating - reduced their
<br>freezing ability even further. We attribute this behaviour to
<br>accelerated acid digestion of ice active surface sites by heat. Exposing
<br>sulphuric acid coated dust to ammonia gas produced particles with
<br>similarly poor freezing potential; however a portion of their ice
<br>nucleation ability could be restored after heating in the thermodenuder.
<br>In no case did any combination of thermochemical treatments increase the
<br>ice nucleation ability of the coated mineral dust particles compared to
<br>unprocessed dust. These first measurements of the effect of identical
<br>chemical processing of dust particles on their ice nucleation ability
<br>under both water subsaturated and mixed-phase supersaturated cloud
<br>conditions revealed that ice nucleation was more sensitive to all
<br>coating treatments in the water subsaturated regime. The results clearly
<br>indicate irreversible impairment of ice nucleation activity in both
<br>regimes after condensation of concentrated sulphuric acid. This implies
<br>that the sulphuric acid coating caused permanent chemical and/or
<br>physical modification of the ice active surface sites; the possible
<br>dissolution of the coating during droplet activation did not restore all
<br>immersion/condensation-freezing ability.
<br></td>
</tr>
<tr id="bib_Sullivan_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Sullivan_etal_ACP_2010a,
  author = {Sullivan, R. C. and Petters, M. D. and Demott, P. J. and Kreidenweis, S. M. and Wex, H. and Niedermeier, D. and Hartmann, S. and Clauss, T. and Stratmann, F. and Reitz, P. and Schneider, J. and Sierau, B.},
  title = {Irreversible loss of ice nucleation active sites in mineral dust particles caused by sulphuric acid condensation},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {11471-11487},
  url = {http://adsabs.harvard.edu/abs/2010ACP....1011471S},
  doi = {https://doi.org/10.5194/acp-10-11471-2010}
}
</pre></td>
</tr>
<tr id="Textor_etal_ACP_2006a" class="entry">
	<td>Textor, C., Schulz, M., Guibert, S., Kinne, S., Balkanski, Y., Bauer, S., Berntsen, T., Berglen, T., Boucher, O., Chin, M., Dentener, F., Diehl, T., Easter, R., Feichter, H., Fillmore, D., Ghan, S., Ginoux, P., Gong, S., Grini, A., Hendricks, J., Horowitz, L., Huang, P., Isaksen, I., Iversen, I., Kloster, S., Koch, D., Kirkev&aring;g, A., Kristjansson, J.E., Krol, M., Lauer, A., Lamarque, J.F., Liu, X., Montanaro, V., Myhre, G., Penner, J., Pitari, G., Reddy, S., Seland, &Oslash;., Stier, P., Takemura, T. and Tie, X.</td>
	<td>Analysis and quantification of the diversities of aerosol life cycles within AeroCom <p class="infolinks">[<a href="javascript:toggleInfo('Textor_etal_ACP_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Textor_etal_ACP_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 6, pp. 1777-1813&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2006ACP.....6.1777T">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Textor_etal_ACP_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Simulation results of global aerosol models have been assembled in the framework of the AeroCom intercomparison exercise. In this paper, we analyze the life cycles of dust, sea salt, sulfate, black carbon and particulate organic matter as simulated by sixteen global aerosol models. The differences among the results (model diversities) for sources and sinks, burdens, particle sizes, water uptakes, and spatial dispersals have been established. These diversities have large consequences for the calculated radiative forcing and the aerosol concentrations at the surface. Processes and parameters are identified which deserve further research. ltP style=``line-height: 20px;''gt The AeroCom all-models-average emissions are dominated by the mass of sea salt (SS), followed by dust (DU), sulfate (SO_4), particulate organic matter (POM), and finally black carbon (BC). Interactive parameterizations of the emissions and contrasting particles sizes of SS and DU lead generally to higher diversities of these species, and for total aerosol. The lower diversity of the emissions of the fine aerosols, BC, POM, and SO_4, is due to the use of similar emission inventories, and does therefore not necessarily indicate a better understanding of their sources. The diversity of SO_4-sources is mainly caused by the disagreement on depositional loss of precursor gases and on chemical production. The diversities of the emissions are passed on to the burdens, but the latter are also strongly affected by the model-specific treatments of transport and aerosol processes. The burdens of dry masses decrease from largest to smallest: DU, SS, SO_4, POM, and BC. ltP style=``line-height: 20px;''gt The all-models-average residence time is shortest for SS with about half a day, followed by SO_4 and DU with four days, and POM and BC with six and seven days, respectively. The wet deposition rate is controlled by the solubility and increases from DU, BC, POM to SO_4 and SS. It is the dominant sink for SO_4, BC, and POM, and contributes about one third to the total removal of SS and DU species. For SS and DU we find high diversities for the removal rate coefficients and deposition pathways. Models do neither agree on the split between wet and dry deposition, nor on that between sedimentation and other dry deposition processes. We diagnose an extremely high diversity for the uptake of ambient water vapor that influences the particle size and thus the sink rate coefficients. Furthermore, we find little agreement among the model results for the partitioning of wet removal into scavenging by convective and stratiform rain. ltP style=``line-height: 20px;''gt Large differences exist for aerosol dispersal both in the vertical and in the horizontal direction. In some models, a minimum of total aerosol concentration is simulated at the surface. Aerosol dispersal is most pronounced for SO_4 and BC and lowest for SS. Diversities are higher for meridional than for vertical dispersal, they are similar for the individual species and highest for SS and DU. For these two components we do not find a correlation between vertical and meridional aerosol dispersal. In addition the degree of dispersals of SS and DU is not related to their residence times. SO_4, BC, and POM, however, show increased meridional dispersal in models with larger vertical dispersal, and dispersal is larger for longer simulated residence times.</td>
</tr>
<tr id="bib_Textor_etal_ACP_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Textor_etal_ACP_2006a,
  author = {Textor, C. and Schulz, M. and Guibert, S. and Kinne, S. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Berglen, T. and Boucher, O. and Chin, M. and Dentener, F. and Diehl, T. and Easter, R. and Feichter, H. and Fillmore, D. and Ghan, S. and Ginoux, P. and Gong, S. and Grini, A. and Hendricks, J. and Horowitz, L. and Huang, P. and Isaksen, I. and Iversen, I. and Kloster, S. and Koch, D. and Kirkev&aring;g, A. and Kristjansson, J. E. and Krol, M. and Lauer, A. and Lamarque, J. F. and Liu, X. and Montanaro, V. and Myhre, G. and Penner, J. and Pitari, G. and Reddy, S. and Seland, &Oslash;. and Stier, P. and Takemura, T. and Tie, X.},
  title = {Analysis and quantification of the diversities of aerosol life cycles within AeroCom},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2006},
  volume = {6},
  pages = {1777-1813},
  url = {http://adsabs.harvard.edu/abs/2006ACP.....6.1777T}
}
</pre></td>
</tr>
<tr id="Textor_etal_ACP_2007a" class="entry">
	<td>Textor, C., Schulz, M., Guibert, S., Kinne, S., Balkanski, Y., Bauer, S., Berntsen, T., Berglen, T., Boucher, O., Chin, M., Dentener, F., Diehl, T., Feichter, J., Fillmore, D., Ginoux, P., Gong, S., Grini, A., Hendricks, J., Horowitz, L., Huang, P., Isaksen, I.S.A., Iversen, T., Kloster, S., Koch, D., Kirkev&acirc;g, A., Kristjansson, J.E., Krol, M., Lauer, A., Lamarque, J.F., Liu, X., Montanaro, V., Myhre, G., Penner, J.E., Pitari, G., Reddy, M.S., Seland, &Oslash;., Stier, P., Takemura, T. and Tie, X.</td>
	<td>The effect of harmonized emissions on aerosol properties in global models an AeroCom experiment <p class="infolinks">[<a href="javascript:toggleInfo('Textor_etal_ACP_2007a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Textor_etal_ACP_2007a','bibtex')">BibTeX</a>]</p></td>
	<td>2007</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 7, pp. 4489-4501&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2007ACP.....7.4489T">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Textor_etal_ACP_2007a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The effects of unified aerosol sources on global aerosol fields simulated by different models are examined in this paper. We compare results from two AeroCom experiments, one with different (ExpA) and one with unified emissions, injection heights, and particle sizes at the source (ExpB). Surprisingly, harmonization of aerosol sources has only a small impact on the simulated inter-model diversity of the global aerosol burden, and consequently global optical properties, as the results are largely controlled by model-specific transport, removal, chemistry (leading to the formation of secondary aerosols) and parameterizations of aerosol microphysics (e.g., the split between deposition pathways) and to a lesser extent by the spatial and temporal distributions of the (precursor) emissions.    The burdens of black carbon and especially sea salt become more coherent in ExpB only, because the large ExpA diversities for these two species were caused by a few outliers. The experiment also showed that despite prescribing emission fluxes and size distributions, ambiguities in the implementation in individual models can lead to substantial differences. These results indicate the need for a better understanding of aerosol life cycles at process level (including spatial dispersal and interaction with meteorological parameters) in order to obtain more reliable results from global aerosol simulations. This is particularly important as such model results are used to assess the consequences of specific air pollution abatement strategies.</td>
</tr>
<tr id="bib_Textor_etal_ACP_2007a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Textor_etal_ACP_2007a,
  author = {Textor, C. and Schulz, M. and Guibert, S. and Kinne, S. and Balkanski, Y. and Bauer, S. and Berntsen, T. and Berglen, T. and Boucher, O. and Chin, M. and Dentener, F. and Diehl, T. and Feichter, J. and Fillmore, D. and Ginoux, P. and Gong, S. and Grini, A. and Hendricks, J. and Horowitz, L. and Huang, P. and Isaksen, I. S. A. and Iversen, T. and Kloster, S. and Koch, D. and Kirkev&acirc;g, A. and Kristjansson, J. E. and Krol, M. and Lauer, A. and Lamarque, J. F. and Liu, X. and Montanaro, V. and Myhre, G. and Penner, J. E. and Pitari, G. and Reddy, M. S. and Seland, &Oslash;. and Stier, P. and Takemura, T. and Tie, X.},
  title = {The effect of harmonized emissions on aerosol properties in global models an AeroCom experiment},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2007},
  volume = {7},
  pages = {4489-4501},
  url = {http://adsabs.harvard.edu/abs/2007ACP.....7.4489T}
}
</pre></td>
</tr>
<tr id="Tsigaridis_etal_ACP_2014a" class="entry">
	<td>Tsigaridis, K., Daskalakis, N., Kanakidou, M., Adams, P.J., Artaxo, P., Bahadur, R., Balkanski, Y., Bauer, S.E., Bellouin, N., Benedetti, A., Bergman, T., Berntsen, T.K., Beukes, J.P., Bian, H., Carslaw, K.S., Chin, M., Curci, G., Diehl, T., Easter, R.C., Ghan, S.J., Gong, S.L., Hodzic, A., Hoyle, C.R., Iversen, T., Jathar, S., Jimenez, J.L., Kaiser, J.W., Kirkev&aring;g, A., Koch, D., Kokkola, H., Lee, Y.H., Lin, G., Liu, X., Luo, G., Ma, X., Mann, G.W., Mihalopoulos, N., Morcrette, J.-J., M&uuml;ller, J.-F., Myhre, G., Myriokefalitakis, S., Ng, N.L., O'Donnell, D., Penner, J.E., Pozzoli, L., Pringle, K.J., Russell, L.M., Schulz, M., Sciare, J., Seland, &Oslash;., Shindell, D.T., Sillman, S., Skeie, R.B., Spracklen, D., Stavrakou, T., Steenrod, S.D., Takemura, T., Tiitta, P., Tilmes, S., Tost, H., van Noije, T., van Zyl, P.G., von Salzen, K., Yu, F., Wang, Z., Wang, Z., Zaveri, R.A., Zhang, H., Zhang, K., Zhang, Q. and Zhang, X.</td>
	<td>The AeroCom evaluation and intercomparison of organic aerosol in global models <p class="infolinks">[<a href="javascript:toggleInfo('Tsigaridis_etal_ACP_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Tsigaridis_etal_ACP_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 14, pp. 10845-10895&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-14-10845-2014">DOI</a> <a href="http://adsabs.harvard.edu/abs/2014ACP....1410845T">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Tsigaridis_etal_ACP_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper evaluates the current status of global modeling of the
<br>organic aerosol (OA) in the troposphere and analyzes the differences
<br>between models as well as between models and observations. Thirty-one
<br>global chemistry transport models (CTMs) and general circulation models
<br>(GCMs) have participated in this intercomparison, in the framework of
<br>AeroCom phase II. The simulation of OA varies greatly between models in
<br>terms of the magnitude of primary emissions, secondary OA (SOA)
<br>formation, the number of OA species used (2 to 62), the complexity of OA
<br>parameterizations (gas-particle partitioning, chemical aging, multiphase
<br>chemistry, aerosol microphysics), and the OA physical, chemical and
<br>optical properties. The diversity of the global OA simulation results
<br>has increased since earlier AeroCom experiments, mainly due to the
<br>increasing complexity of the SOA parameterization in models, and the
<br>implementation of new, highly uncertain, OA sources. Diversity of over
<br>one order of magnitude exists in the modeled vertical distribution of OA
<br>concentrations that deserves a dedicated future study. Furthermore,
<br>although the OA / OC ratio depends on OA sources and atmospheric
<br>processing, and is important for model evaluation against OA and OC
<br>observations, it is resolved only by a few global models. <BR /><BR />
<br>The median global primary OA (POA) source strength is 56 Tg
<br>a^-1 (range 34-144 Tg a^-1) and the median SOA
<br>source strength (natural and anthropogenic) is 19 Tg a^-1
<br>(range 13-121 Tg a^-1). Among the models that take into
<br>account the semi-volatile SOA nature, the median source is calculated to
<br>be 51 Tg a^-1 (range 16-121 Tg a^-1), much larger
<br>than the median value of the models that calculate SOA in a more
<br>simplistic way (19 Tg a^-1; range 13-20 Tg a^-1,
<br>with one model at 37 Tg a^-1). The median atmospheric burden
<br>of OA is 1.4 Tg (24 models in the range of 0.6-2.0 Tg and 4 between 2.0
<br>and 3.8 Tg), with a median OA lifetime of 5.4 days (range 3.8-9.6 days).
<br>In models that reported both OA and sulfate burdens, the median value of
<br>the OA/sulfate burden ratio is calculated to be 0.77; 13 models
<br>calculate a ratio lower than 1, and 9 models higher than 1. For 26
<br>models that reported OA deposition fluxes, the median wet removal is 70
<br>Tg a^-1 (range 28-209 Tg a^-1), which is on average
<br>85&#37; of the total OA deposition. <BR /><BR /> Fine aerosol organic carbon
<br>(OC) and OA observations from continuous monitoring networks and
<br>individual field campaigns have been used for model evaluation. At urban
<br>locations, the model-observation comparison indicates missing knowledge
<br>on anthropogenic OA sources, both strength and seasonality. The combined
<br>model-measurements analysis suggests the existence of increased OA
<br>levels during summer due to biogenic SOA formation over large areas of
<br>the USA that can be of the same order of magnitude as the POA, even at
<br>urban locations, and contribute to the measured urban seasonal pattern.
<br><BR /><BR /> Global models are able to simulate the high secondary
<br>character of OA observed in the atmosphere as a result of SOA formation
<br>and POA aging, although the amount of OA present in the atmosphere
<br>remains largely underestimated, with a mean normalized bias (MNB) equal
<br>to -0.62 (-0.51) based on the comparison against OC (OA) urban data of
<br>all models at the surface, -0.15 (+0.51) when compared with remote
<br>measurements, and -0.30 for marine locations with OC data. The mean
<br>temporal correlations across all stations are low when compared with OC
<br>(OA) measurements: 0.47 (0.52) for urban stations, 0.39 (0.37) for
<br>remote stations, and 0.25 for marine stations with OC data. The
<br>combination of high (negative) MNB and higher correlation at urban
<br>stations when compared with the low MNB and lower correlation at remote
<br>sites suggests that knowledge about the processes that govern aerosol
<br>processing, transport and removal, on top of their sources, is important
<br>at the remote stations. There is no clear change in model skill with
<br>increasing model complexity with regard to OC or OA mass concentration.
<br>However, the complexity is needed in models in order to distinguish
<br>between anthropogenic and natural OA as needed for climate mitigation,
<br>and to calculate the impact of OA on climate accurately.
<br></td>
</tr>
<tr id="bib_Tsigaridis_etal_ACP_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Tsigaridis_etal_ACP_2014a,
  author = {Tsigaridis, K. and Daskalakis, N. and Kanakidou, M. and Adams, P. J. and Artaxo, P. and Bahadur, R. and Balkanski, Y. and Bauer, S. E. and Bellouin, N. and Benedetti, A. and Bergman, T. and Berntsen, T. K. and Beukes, J. P. and Bian, H. and Carslaw, K. S. and Chin, M. and Curci, G. and Diehl, T. and Easter, R. C. and Ghan, S. J. and Gong, S. L. and Hodzic, A. and Hoyle, C. R. and Iversen, T. and Jathar, S. and Jimenez, J. L. and Kaiser, J. W. and Kirkev&aring;g, A. and Koch, D. and Kokkola, H. and Lee, Y. H. and Lin, G. and Liu, X. and Luo, G. and Ma, X. and Mann, G. W. and Mihalopoulos, N. and Morcrette, J.-J. and M&uuml;ller, J.-F. and Myhre, G. and Myriokefalitakis, S. and Ng, N. L. and O'Donnell, D. and Penner, J. E. and Pozzoli, L. and Pringle, K. J. and Russell, L. M. and Schulz, M. and Sciare, J. and Seland, &Oslash;. and Shindell, D. T. and Sillman, S. and Skeie, R. B. and Spracklen, D. and Stavrakou, T. and Steenrod, S. D. and Takemura, T. and Tiitta, P. and Tilmes, S. and Tost, H. and van Noije, T. and van Zyl, P. G. and von Salzen, K. and Yu, F. and Wang, Z. and Wang, Z. and Zaveri, R. A. and Zhang, H. and Zhang, K. and Zhang, Q. and Zhang, X.},
  title = {The AeroCom evaluation and intercomparison of organic aerosol in global models},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2014},
  volume = {14},
  pages = {10845-10895},
  url = {http://adsabs.harvard.edu/abs/2014ACP....1410845T},
  doi = {https://doi.org/10.5194/acp-14-10845-2014}
}
</pre></td>
</tr>
<tr id="Vignati_etal_ACP_2010a" class="entry">
	<td>Vignati, E., Karl, M., Krol, M., Wilson, J., Stier, P. and Cavalli, F.</td>
	<td>Sources of uncertainties in modelling black carbon at the global scale <p class="infolinks">[<a href="javascript:toggleInfo('Vignati_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Vignati_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 2595-2611&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2010ACP....10.2595V">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Vignati_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Our understanding of the global black carbon (BC) cycle is essentially qualitative due to uncertainties in our knowledge of its properties. This work investigates two source of uncertainties in modelling black carbon: those due to the use of different schemes for BC ageing and its removal rate in the global Transport-Chemistry model TM5 and those due to the uncertainties in the definition and quantification of the observations, which propagate through to both the emission inventories, and the measurements used for the model evaluation. <BR /><BR /> The schemes for the atmospheric processing of black carbon that have been tested with the model are (i) a simple approach considering BC as bulk aerosol and a simple treatment of the removal with fixed 70&#37; of in-cloud black carbon concentrations scavenged by clouds and removed when rain is present and (ii) a more complete description of microphysical ageing within an aerosol dynamics model, where removal is coupled to the microphysical properties of the aerosol, which results in a global average of 40&#37; in-cloud black carbon that is scavenged in clouds and subsequently removed by rain, thus resulting in a longer atmospheric lifetime. This difference is reflected in comparisons between both sets of modelled results and the measurements. Close to the sources, both anthropogenic and vegetation fire source regions, the model results do not differ significantly, indicating that the emissions are the prevailing mechanism determining the concentrations and the choice of the aerosol scheme does not influence the levels. In more remote areas such as oceanic and polar regions the differences can be orders of magnitude, due to the differences between the two schemes. The more complete description reproduces the seasonal trend of the black carbon observations in those areas, although not always the magnitude of the signal, while the more simplified approach underestimates black carbon concentrations by orders of magnitude. <BR /><BR /> The sensitivity to wet scavenging has been tested by varying in-cloud and below-cloud removal. BC lifetime increases by 10&#37; when large scale and convective scale precipitation removal efficiency are reduced by 30 while the variation is very small when below-cloud scavenging is zero. <BR /><BR /> Since the emission inventories are representative of elemental carbon-like substance, the model output should be compared to elemental carbon measurements and if known, the ratio of black carbon to elemental carbon mass should be taken into account when the model is compared with black carbon observations.</td>
</tr>
<tr id="bib_Vignati_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Vignati_etal_ACP_2010a,
  author = {Vignati, E. and Karl, M. and Krol, M. and Wilson, J. and Stier, P. and Cavalli, F.},
  title = {Sources of uncertainties in modelling black carbon at the global scale},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {2595-2611},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.2595V}
}
</pre></td>
</tr>
<tr id="WagnerSilva_ACP_2008a" class="entry">
	<td>Wagner, F. and Silva, A.M.</td>
	<td>Some considerations about &Aring;ngstr&ouml;m exponent distributions <p class="infolinks">[<a href="javascript:toggleInfo('WagnerSilva_ACP_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('WagnerSilva_ACP_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 8, pp. 481-489&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2008ACP.....8..481W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_WagnerSilva_ACP_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A simulation study has been performed in order to show the influence of the aerosol optical depth (AOD) distribution together with the corresponding error distribution on the resulting &Aring;ngstr&ouml;m exponent (AE) distribution. It will be shown that the &Aring;ngstr&ouml;m exponent frequency of occurrence distribution is only normal distributed when the relative error at the two wavelengths used for estimation of the &Aring;ngstr&ouml;m exponent is the same. In all other cases a shift of the maximum of the AE-distribution will occur. It will be demonstrated that the &Aring;ngstr&ouml;m exponent (or the maximum of an AE distribution) will be systematically over- or underestimated depending on whether the relative error of the shorter wavelength is larger or smaller compared with the relative error of the longer wavelength. In such cases the AE distribution are also skewed.</td>
</tr>
<tr id="bib_WagnerSilva_ACP_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{WagnerSilva_ACP_2008a,
  author = {Wagner, F. and Silva, A. M.},
  title = {Some considerations about &Aring;ngstr&ouml;m exponent distributions},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2008},
  volume = {8},
  pages = {481-489},
  url = {http://adsabs.harvard.edu/abs/2008ACP.....8..481W}
}
</pre></td>
</tr>
<tr id="Wang_etal_ACP_2015a" class="entry">
	<td>Wang, R., Balkanski, Y., Boucher, O., Bopp, L., Chappell, A., Ciais, P., Hauglustaine, D., Pe&ntilde;uelas, J. and Tao, S.</td>
	<td>Sources, transport and deposition of iron in the global atmosphere <p class="infolinks">[<a href="javascript:toggleInfo('Wang_etal_ACP_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Wang_etal_ACP_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 15, pp. 6247-6270&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-15-6247-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACP....15.6247W">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Wang_etal_ACP_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Atmospheric deposition of iron (Fe) plays an important role in
<br>controlling oceanic primary productivity. However, the sources of Fe in
<br>the atmosphere are not well understood. In particular, the combustion
<br>sources of Fe and the subsequent deposition to the oceans have been
<br>accounted for in only few ocean biogeochemical models of the carbon
<br>cycle. Here we used a mass-balance method to estimate the emissions of
<br>Fe from the combustion of fossil fuels and biomass by accounting for the
<br>Fe contents in fuel and the partitioning of Fe during combustion. The
<br>emissions of Fe attached to aerosols from combustion sources were
<br>estimated by particle size, and their uncertainties were quantified by a
<br>Monte Carlo simulation. The emissions of Fe from mineral sources were
<br>estimated using the latest soil mineralogical database to date. As a
<br>result, the total Fe emissions from combustion averaged for 1960-2007
<br>were estimated to be 5.3 Tg yr^-1 (90&#37; confidence of 2.3 to
<br>12.1). Of these emissions, 1, 27 and 72&#37; were emitted in particles lt
<br>1 &mu;m (PM_1), 1-10 &mu;m (PM_1-10), and gt 10
<br>&mu;m (PM_&amp;gt; 10), respectively, compared to a total Fe
<br>emission from mineral dust of 41.0 Tg yr^-1 in a log-normal
<br>distribution with a mass median diameter of 2.5 &mu;m and a geometric
<br>standard deviation of 2. For combustion sources, different temporal
<br>trends were found in fine and medium-to-coarse particles, with a notable
<br>increase in Fe emissions in PM_1 since 2000 due to an increase
<br>in Fe emission from motor vehicles (from 0.008 to 0.0103 Tg
<br>yr^-1 in 2000 and 2007, respectively). These emissions have
<br>been introduced in a global 3-D transport model run at a spatial
<br>resolution of 0.94deg latitude by 1.28deg longitude to evaluate our
<br>estimation of Fe emissions. The modelled Fe concentrations as monthly
<br>means were compared with the monthly (57 sites) or daily (768 sites)
<br>measured concentrations at a total of 825 sampling stations. The
<br>deviation between modelled and observed Fe concentrations attached to
<br>aerosols at the surface was within a factor of 2 at most sampling
<br>stations, and the deviation was within a factor of 1.5 at sampling
<br>stations dominated by combustion sources. We analysed the relative
<br>contribution of combustion sources to total Fe concentrations over
<br>different regions of the world. The new mineralogical database led to a
<br>modest improvement in the simulation relative to station data even in
<br>dust-dominated regions, but could provide useful information on the
<br>chemical forms of Fe in dust for coupling with ocean biota models. We
<br>estimated a total Fe deposition sink of 8.4 Tg yr^-1 over
<br>global oceans, 7&#37; of which originated from the combustion sources. Our
<br>central estimates of Fe emissions from fossil fuel combustion (mainly
<br>from coal) are generally higher than those in previous studies, although
<br>they are within the uncertainty range of our estimates. In particular,
<br>the higher than previously estimated Fe emission from coal combustion
<br>implies a larger atmospheric anthropogenic input of soluble Fe to the
<br>northern Atlantic and northern Pacific Oceans, which is expected to
<br>enhance the biological carbon pump in those regions.
<br></td>
</tr>
<tr id="bib_Wang_etal_ACP_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Wang_etal_ACP_2015a,
  author = {Wang, R. and Balkanski, Y. and Boucher, O. and Bopp, L. and Chappell, A. and Ciais, P. and Hauglustaine, D. and Pe&ntilde;uelas, J. and Tao, S.},
  title = {Sources, transport and deposition of iron in the global atmosphere},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2015},
  volume = {15},
  pages = {6247-6270},
  url = {http://adsabs.harvard.edu/abs/2015ACP....15.6247W},
  doi = {https://doi.org/10.5194/acp-15-6247-2015}
}
</pre></td>
</tr>
<tr id="Yang_etal_ACP_2009a" class="entry">
	<td>Yang, M., Howell, S.G., Zhuang, J. and Huebert, B.J.</td>
	<td>Attribution of aerosol light absorption to black carbon, brown carbon, and dust in China - interpretations of atmospheric measurements during EAST-AIRE <p class="infolinks">[<a href="javascript:toggleInfo('Yang_etal_ACP_2009a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Yang_etal_ACP_2009a','bibtex')">BibTeX</a>]</p></td>
	<td>2009</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 9, pp. 2035-2050&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2009ACP.....9.2035Y">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Yang_etal_ACP_2009a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Black carbon, brown carbon, and mineral dust are three of the most
<br>important light absorbing aerosols. Their optical properties differ
<br>greatly and are distinctive functions of the wavelength of light. Most
<br>optical instruments that quantify light absorption, however, are unable
<br>to distinguish one type of absorbing aerosol from another. It is thus
<br>instructive to separate total absorption from these different light
<br>absorbers to gain a better understanding of the optical characteristics
<br>of each aerosol type. During the EAST-AIRE (East Asian Study of
<br>Tropospheric Aerosols: an International Regional Experiment) campaign
<br>near Beijing, we measured light scattering using a nephelometer, and
<br>light absorption using an aethalometer and a particulate soot absorption
<br>photometer. We also measured the total mass concentrations of
<br>carbonaceous (elemental and organic carbon) and inorganic particulates,
<br>as well as aerosol number and mass distributions. We were able to
<br>identify periods during the campaign that were dominated by dust,
<br>biomass burning, fresh (industrial) chimney plumes, other coal burning
<br>pollution, and relatively clean (background) air for Northern China.
<br>Each of these air masses possessed distinct intensive optical
<br>properties, including the single scatter albedo and &Aring;ngstrom
<br>exponents. Based on the wavelength-dependence and particle size
<br>distribution, we apportioned total light absorption to black carbon,
<br>brown carbon, and dust; their mass absorption efficiencies at 550 nm
<br>were estimated to be 9.5, 0.5 (a lower limit value), and 0.03
<br>m^2/g, respectively. While agreeing with the common consensus
<br>that black carbon is the most important light absorber in the
<br>mid-visible, we demonstrated that brown carbon and dust could also cause
<br>significant absorption, especially at shorter wavelengths.
<br></td>
</tr>
<tr id="bib_Yang_etal_ACP_2009a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Yang_etal_ACP_2009a,
  author = {Yang, M. and Howell, S. G. and Zhuang, J. and Huebert, B. J.},
  title = {Attribution of aerosol light absorption to black carbon, brown carbon, and dust in China - interpretations of atmospheric measurements during EAST-AIRE},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2009},
  volume = {9},
  pages = {2035-2050},
  url = {http://adsabs.harvard.edu/abs/2009ACP.....9.2035Y}
}
</pre></td>
</tr>
<tr id="Yu_etal_ACP_2006a" class="entry">
	<td>Yu, H., Kaufman, Y.J., Chin, M., Feingold, G., Remer, L.A., Anderson, T.L., Balkanski, Y., Bellouin, N., Boucher, O., Christopher, S., Decola, P., Kahn, R., Koch, D., Loeb, N., Reddy, M.S., Schulz, M., Takemura, T. and Zhou, M.</td>
	<td>A review of measurement-based assessments of the aerosol direct radiative effect and forcing <p class="infolinks">[<a href="javascript:toggleInfo('Yu_etal_ACP_2006a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Yu_etal_ACP_2006a','bibtex')">BibTeX</a>]</p></td>
	<td>2006</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 6, pp. 613-666&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2006ACP.....6..613Y">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Yu_etal_ACP_2006a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosols affect the Earth's energy budget directly by scattering and
<br>absorbing radiation and indirectly by acting as cloud condensation
<br>nuclei and, thereby, affecting cloud properties. However, large
<br>uncertainties exist in current estimates of aerosol forcing because of
<br>incomplete knowledge concerning the distribution and the physical and
<br>chemical properties of aerosols as well as aerosol-cloud interactions.
<br>In recent years, a great deal of effort has gone into improving
<br>measurements and datasets. It is thus feasible to shift the estimates of
<br>aerosol forcing from largely model-based to increasingly
<br>measurement-based. Our goal is to assess current observational
<br>capabilities and identify uncertainties in the aerosol direct forcing
<br>through comparisons of different methods with independent sources of
<br>uncertainties. Here we assess the aerosol optical depth (&tau;), direct
<br>radiative effect (DRE) by natural and anthropogenic aerosols, and direct
<br>climate forcing (DCF) by anthropogenic aerosols, focusing on satellite
<br>and ground-based measurements supplemented by global chemical transport
<br>model (CTM) simulations. The multi-spectral MODIS measures global
<br>distributions of aerosol optical depth (&tau;) on a daily scale, with a
<br>high accuracy of plusmn0.03plusmn0.05&tau; over ocean. The annual
<br>average &tau; is about 0.14 over global ocean, of which about
<br>21\plusmn7&#37; is contributed by human activities, as estimated by MODIS
<br>fine-mode fraction. The multi-angle MISR derives an annual average AOD
<br>of 0.23 over global land with an uncertainty of &tilde;20&#37; or plusmn0.05.
<br>These high-accuracy aerosol products and broadband flux measurements
<br>from CERES make it feasible to obtain observational constraints for the
<br>aerosol direct effect, especially over global the ocean. A number of
<br>measurement-based approaches estimate the clear-sky DRE (on solar
<br>radiation) at the top-of-atmosphere (TOA) to be about -5.5plusmn0.2
<br>Wm^-2 (median plusmn standard error from various methods)
<br>over the global ocean. Accounting for thin cirrus contamination of the
<br>satellite derived aerosol field will reduce the TOA DRE to -5.0
<br>Wm^-2. Because of a lack of measurements of aerosol absorption
<br>and difficulty in characterizing land surface reflection, estimates of
<br>DRE over land and at the ocean surface are currently realized through a
<br>combination of satellite retrievals, surface measurements, and model
<br>simulations, and are less constrained. Over the oceans the surface DRE
<br>is estimated to be -8.8plusmn0.7 Wm^-2. Over land, an
<br>integration of satellite retrievals and model simulations derives a DRE
<br>of -4.9plusmn0.7 Wm^-2 and -11.8plusmn1.9 Wm^-2
<br>at the TOA and surface, respectively. CTM simulations derive a wide
<br>range of DRE estimates that on average are smaller than the
<br>measurement-based DRE by about 30-40 even after accounting for thin
<br>cirrus and cloud contamination. ltP style=``line-height: 20px;''gt A
<br>number of issues remain. Current estimates of the aerosol direct effect
<br>over land are poorly constrained. Uncertainties of DRE estimates are
<br>also larger on regional scales than on a global scale and large
<br>discrepancies exist between different approaches. The characterization
<br>of aerosol absorption and vertical distribution remains challenging. The
<br>aerosol direct effect in the thermal infrared range and in cloudy
<br>conditions remains relatively unexplored and quite uncertain, because of
<br>a lack of global systematic aerosol vertical profile measurements. A
<br>coordinated research strategy needs to be developed for integration and
<br>assimilation of satellite measurements into models to constrain model
<br>simulations. Enhanced measurement capabilities in the next few years and
<br>high-level scientific cooperation will further advance our knowledge.
<br></td>
</tr>
<tr id="bib_Yu_etal_ACP_2006a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Yu_etal_ACP_2006a,
  author = {Yu, H. and Kaufman, Y. J. and Chin, M. and Feingold, G. and Remer, L. A. and Anderson, T. L. and Balkanski, Y. and Bellouin, N. and Boucher, O. and Christopher, S. and Decola, P. and Kahn, R. and Koch, D. and Loeb, N. and Reddy, M. S. and Schulz, M. and Takemura, T. and Zhou, M.},
  title = {A review of measurement-based assessments of the aerosol direct radiative effect and forcing},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2006},
  volume = {6},
  pages = {613-666},
  url = {http://adsabs.harvard.edu/abs/2006ACP.....6..613Y}
}
</pre></td>
</tr>
<tr id="Zhang_etal_ACP_2012a" class="entry">
	<td>Zhang, K., O'Donnell, D., Kazil, J., Stier, P., Kinne, S., Lohmann, U., Ferrachat, S., Croft, B., Quaas, J., Wan, H., Rast, S. and Feichter, J.</td>
	<td>The global aerosol-climate model ECHAM-HAM, version 2: sensitivity to improvements in process representations <p class="infolinks">[<a href="javascript:toggleInfo('Zhang_etal_ACP_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhang_etal_ACP_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 12, pp. 8911-8949&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-12-8911-2012">DOI</a> <a href="http://adsabs.harvard.edu/abs/2012ACP....12.8911Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhang_etal_ACP_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: This paper introduces and evaluates the second version of the global aerosol-climate model ECHAM-HAM. Major changes have been brought into the model, including new parameterizations for aerosol nucleation and water uptake, an explicit treatment of secondary organic aerosols, modified emission calculations for sea salt and mineral dust, the coupling of aerosol microphysics to a two-moment stratiform cloud microphysics scheme, and alternative wet scavenging parameterizations. These revisions extend the model's capability to represent details of the aerosol lifecycle and its interaction with climate. Nudged simulations of the year 2000 are carried out to compare the aerosol properties and global distribution in HAM1 and HAM2, and to evaluate them against various observations. Sensitivity experiments are performed to help identify the impact of each individual update in model formulation. <BR /><BR /> Results indicate that from HAM1 to HAM2 there is a marked weakening of aerosol water uptake in the lower troposphere, reducing the total aerosol water burden from 75 Tg to 51 Tg. The main reason is the newly introduced &kappa;-K&ouml;hler-theory-based water uptake scheme uses a lower value for the maximum relative humidity cutoff. Particulate organic matter loading in HAM2 is considerably higher in the upper troposphere, because the explicit treatment of secondary organic aerosols allows highly volatile oxidation products of the precursors to be vertically transported to regions of very low temperature and to form aerosols there. Sulfate, black carbon, particulate organic matter and mineral dust in HAM2 have longer lifetimes than in HAM1 because of weaker in-cloud scavenging, which is in turn related to lower autoconversion efficiency in the newly introduced two-moment cloud microphysics scheme. Modification in the sea salt emission scheme causes a significant increase in the ratio (from 1.6 to 7.7) between accumulation mode and coarse mode emission fluxes of aerosol number concentration. This leads to a general increase in the number concentration of smaller particles over the oceans in HAM2, as reflected by the higher &Aring;ngstr&ouml;m parameters. <BR /><BR /> Evaluation against observation reveals that in terms of model performance, main improvements in HAM2 include a marked decrease of the systematic negative bias in the absorption aerosol optical depth, as well as smaller biases over the oceans in &Aring;ngstr&ouml;m parameter and in the accumulation mode number concentration. The simulated geographical distribution of aerosol optical depth (AOD) is better correlated with the MODIS data, while the surface aerosol mass concentrations are very similar to those in the old version. The total aerosol water content in HAM2 is considerably closer to the multi-model average from Phase I of the AeroCom intercomparison project. Model deficiencies that require further efforts in the future include (i) positive biases in AOD over the ocean, (ii) negative biases in AOD and aerosol mass concentration in high-latitude regions, and (iii) negative biases in particle number concentration, especially that of the Aitken mode, in the lower troposphere in heavily polluted regions.</td>
</tr>
<tr id="bib_Zhang_etal_ACP_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhang_etal_ACP_2012a,
  author = {Zhang, K. and O'Donnell, D. and Kazil, J. and Stier, P. and Kinne, S. and Lohmann, U. and Ferrachat, S. and Croft, B. and Quaas, J. and Wan, H. and Rast, S. and Feichter, J.},
  title = {The global aerosol-climate model ECHAM-HAM, version 2: sensitivity to improvements in process representations},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2012},
  volume = {12},
  pages = {8911-8949},
  url = {http://adsabs.harvard.edu/abs/2012ACP....12.8911Z},
  doi = {https://doi.org/10.5194/acp-12-8911-2012}
}
</pre></td>
</tr>
<tr id="Zhao_etal_ACP_2010a" class="entry">
	<td>Zhao, C., Liu, X., Leung, L.R., Johnson, B., McFarlane, S.A., Gustafson Jr., W.I., Fast, J.D. and Easter, R.</td>
	<td>The spatial distribution of mineral dust and its shortwave radiative forcing over North Africa: modeling sensitivities to dust emissions and aerosol size treatments <p class="infolinks">[<a href="javascript:toggleInfo('Zhao_etal_ACP_2010a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhao_etal_ACP_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 10, pp. 8821-8838&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-10-8821-2010">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ACP....10.8821Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhao_etal_ACP_2010a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: A fully coupled meteorology-chemistry-aerosol model (WRF-Chem) is
<br>applied to simulate mineral dust and its shortwave (SW) radiative
<br>forcing over North Africa. Two dust emission schemes (GOCART and
<br>DUSTRAN) and two aerosol models (MADE/SORGAM and MOSAIC) are adopted in
<br>simulations to investigate the modeling sensitivities to dust emissions
<br>and aerosol size treatments. The modeled size distribution and spatial
<br>variability of mineral dust and its radiative properties are evaluated
<br>using measurements (ground-based, aircraft, and satellites) during the
<br>AMMA SOP0 campaign from 6 January to 3 February of 2006 (the SOP0
<br>period) over North Africa. Two dust emission schemes generally simulate
<br>similar spatial distributions and temporal evolutions of dust emissions.
<br>Simulations using the GOCART scheme with different initial (emitted)
<br>dust size distributions require &tilde;40&#37; difference in total emitted dust
<br>mass to produce similar SW radiative forcing of dust over the Sahel
<br>region. The modal approach of MADE/SORGAM retains 25&#37; more fine dust
<br>particles (radiuslt1.25 &mu;m) but 8&#37; less coarse dust particles
<br>(radiusgt1.25 &mu;m) than the sectional approach of MOSAIC in
<br>simulations using the same size-resolved dust emissions. Consequently,
<br>MADE/SORGAM simulates 11&#37; higher AOD, up to 13&#37; lower SW dust heating
<br>rate, and 15&#37; larger (more negative) SW dust radiative forcing at the
<br>surface than MOSAIC over the Sahel region. In the daytime of the SOP0
<br>period, the model simulations show that the mineral dust heats the lower
<br>atmosphere with an average rate of 0.8 plusmn 0.5 K
<br>day^-1 over the Niamey vicinity and 0.5 plusmn 0.2 K
<br>day^-1 over North Africa and reduces the downwelling SW
<br>radiation at the surface by up to 58 W m^-2 with an
<br>average of 22 W m^-2 over North Africa. This highlights
<br>the importance of including dust radiative impact in understanding the
<br>regional climate of North Africa. When compared to the available
<br>measurements, the WRF-Chem simulations can generally capture the
<br>measured features of mineral dust and its radiative properties over
<br>North Africa, suggesting that the model is suitable for more extensive
<br>simulations of dust impact on regional climate over North Africa.
<br></td>
</tr>
<tr id="bib_Zhao_etal_ACP_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhao_etal_ACP_2010a,
  author = {Zhao, C. and Liu, X. and Leung, L. R. and Johnson, B. and McFarlane, S. A. and Gustafson, Jr., W. I. and Fast, J. D. and Easter, R.},
  title = {The spatial distribution of mineral dust and its shortwave radiative forcing over North Africa: modeling sensitivities to dust emissions and aerosol size treatments},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2010},
  volume = {10},
  pages = {8821-8838},
  url = {http://adsabs.harvard.edu/abs/2010ACP....10.8821Z},
  doi = {https://doi.org/10.5194/acp-10-8821-2010}
}
</pre></td>
</tr>
<tr id="Zhao_etal_ACP_2015a" class="entry">
	<td>Zhao, R., Lee, A.K.Y., Huang, L., Li, X., Yang, F. and Abbatt, J.P.D.</td>
	<td>Photochemical processing of aqueous atmospheric brown carbon <p class="infolinks">[<a href="javascript:toggleInfo('Zhao_etal_ACP_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Zhao_etal_ACP_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Atmospheric Chemistry &amp; Physics<br/>Vol. 15, pp. 6087-6100&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.5194/acp-15-6087-2015">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015ACP....15.6087Z">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Zhao_etal_ACP_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Atmospheric brown carbon (BrC) is a collective term for light absorbing organic compounds in the atmosphere. While the identification of BrC and its formation mechanisms is currently a central effort in the community, little is known about the atmospheric removal processes of aerosol BrC. As a result, we report on a series of laboratory studies of photochemical processing of BrC in the aqueous phase, by direct photolysis and OH oxidation. Solutions of ammonium sulfate mixed with glyoxal (GLYAS) or methylglyoxal (MGAS) are used as surrogates for a class of secondary BrC mediated by imine intermediates. Three nitrophenol species, namely 4-nitrophenol, 5-nitroguaiacol and 4-nitrocatechol, were investigated as a class of water-soluble BrC originating from biomass burning. Photochemical processing induced significant changes in the absorptive properties of BrC. The imine-mediated BrC solutions exhibited rapid photo-bleaching with both direct photolysis and OH oxidation, with atmospheric half-lives of minutes to a few hours. The nitrophenol species exhibited photo-enhancement in the visible range during direct photolysis and the onset of OH oxidation, but rapid photo-bleaching was induced by further OH exposure on an atmospheric timescale of an hour or less. To illustrate the atmospheric relevance of this work, we also performed direct photolysis experiments on water-soluble organic carbon extracted from biofuel combustion samples and observed rapid changes in the optical properties of these samples as well. Overall, these experiments indicate that atmospheric models need to incorporate representations of atmospheric processing of BrC species to accurately model their radiative impacts.</td>
</tr>
<tr id="bib_Zhao_etal_ACP_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Zhao_etal_ACP_2015a,
  author = {Zhao, R. and Lee, A. K. Y. and Huang, L. and Li, X. and Yang, F. and Abbatt, J. P. D.},
  title = {Photochemical processing of aqueous atmospheric brown carbon},
  journal = {Atmospheric Chemistry &amp; Physics},
  year = {2015},
  volume = {15},
  pages = {6087-6100},
  url = {http://adsabs.harvard.edu/abs/2015ACP....15.6087Z},
  doi = {https://doi.org/10.5194/acp-15-6087-2015}
}
</pre></td>
</tr>
<tr id="Cwiertny_etal_ARoPC_2008a" class="entry">
	<td>Cwiertny, D.M., Young, M.A. and Grassian, V.H.</td>
	<td>Chemistry and Photochemistry of Mineral Dust Aerosol <p class="infolinks">[<a href="javascript:toggleInfo('Cwiertny_etal_ARoPC_2008a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Cwiertny_etal_ARoPC_2008a','bibtex')">BibTeX</a>]</p></td>
	<td>2008</td>
	<td>Annual Review of Physical Chemistry<br/>Vol. 59, pp. 27-51&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1146/annurev.physchem.59.032607.093630">DOI</a> <a href="http://adsabs.harvard.edu/abs/2008ARPC...59...27C">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Cwiertny_etal_ARoPC_2008a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: It has become increasingly clear that heterogeneous and multiphase
<br>chemistry of tropospheric aerosols can change the chemical balance of
<br>the atmosphere. In this review, we focus on recent laboratory studies of
<br>the heterogeneous and multiphase chemistry and photochemistry of mineral
<br>dust aerosol, a large mass fraction of the tropospheric aerosol. Mineral
<br>dust aerosol contains a mixture of oxides, clays, and carbonates.
<br>Molecular-based studies of reactions of these dust components provide
<br>insights into the chemistry of Earth's atmosphere. We discuss several
<br>different types of heterogeneous and multiphase reactions, including (a)
<br>ozone decomposition, (b) nitrogen dioxide and nitrate photochemistry,
<br>and (c) the dissolution and redox chemistry of Fe-containing dust. We
<br>also review some of the important chemical concepts that have recently
<br>emerged.
<br></td>
</tr>
<tr id="bib_Cwiertny_etal_ARoPC_2008a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Cwiertny_etal_ARoPC_2008a,
  author = {Cwiertny, D. M. and Young, M. A. and Grassian, V. H.},
  title = {Chemistry and Photochemistry of Mineral Dust Aerosol},
  journal = {Annual Review of Physical Chemistry},
  year = {2008},
  volume = {59},
  pages = {27-51},
  url = {http://adsabs.harvard.edu/abs/2008ARPC...59...27C},
  doi = {https://doi.org/10.1146/annurev.physchem.59.032607.093630}
}
</pre></td>
</tr>
<tr id="MatthewsGinoux_AJ_1974a" class="entry">
	<td>Matthews, R.D. and Ginoux, J.J.</td>
	<td>Correlation of Peak Heating in the Reattachment Region of Separated Flows <p class="infolinks">[<a href="javascript:toggleInfo('MatthewsGinoux_AJ_1974a','bibtex')">BibTeX</a>]</p></td>
	<td>1974</td>
	<td>AIAA Journal<br/>Vol. 12, pp. 397-399&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.2514/3.49249">DOI</a> <a href="http://adsabs.harvard.edu/abs/1974AIAAJ..12..397M">URL</a>&nbsp;</td>
</tr>
<tr id="bib_MatthewsGinoux_AJ_1974a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{MatthewsGinoux_AJ_1974a,
  author = {Matthews, R. D. and Ginoux, J. J.},
  title = {Correlation of Peak Heating in the Reattachment Region of Separated Flows},
  journal = {AIAA Journal},
  year = {1974},
  volume = {12},
  pages = {397-399},
  url = {http://adsabs.harvard.edu/abs/1974AIAAJ..12..397M},
  doi = {https://doi.org/10.2514/3.49249}
}
</pre></td>
</tr>
<tr id="StockGinoux_AJ_1972a" class="entry">
	<td>Stock, H.W. and Ginoux, J.J.</td>
	<td>Further Experimental Studies of Cross-Hatching <p class="infolinks">[<a href="javascript:toggleInfo('StockGinoux_AJ_1972a','bibtex')">BibTeX</a>]</p></td>
	<td>1972</td>
	<td>AIAA Journal<br/>Vol. 10, pp. 557-558&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.2514/3.50154">DOI</a> <a href="http://adsabs.harvard.edu/abs/1972AIAAJ..10..557S">URL</a>&nbsp;</td>
</tr>
<tr id="bib_StockGinoux_AJ_1972a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{StockGinoux_AJ_1972a,
  author = {Stock, H. W. and Ginoux, J. J.},
  title = {Further Experimental Studies of Cross-Hatching},
  journal = {AIAA Journal},
  year = {1972},
  volume = {10},
  pages = {557-558},
  url = {http://adsabs.harvard.edu/abs/1972AIAAJ..10..557S},
  doi = {https://doi.org/10.2514/3.50154}
}
</pre></td>
</tr>
<tr id="Ginoux_etal_ASMA_2002a" class="entry">
	<td>Ginoux, P., Dubovik, O., Chin, M. and Prospero, J.</td>
	<td>Variability of African soil absorption property derived from AERONET data and GOCART model simulations <p class="infolinks">[<a href="javascript:toggleInfo('Ginoux_etal_ASMA_2002a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Ginoux_etal_ASMA_2002a','bibtex')">BibTeX</a>]</p></td>
	<td>2002</td>
	<td>AGU Spring Meeting Abstracts, pp. A52F-10&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2002AGUSM.A52F..10G">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Ginoux_etal_ASMA_2002a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust aerosol play a significant role in climate forcing by altering the radiation balance in the atmosphere. One of the critical parameter is the absorption property of aerosol. This property has been retrieved at different locations from the AERONET data [Dubovik et al., JGR, 2002]. It was shown that there is a significant spatial and temporal variability of the retrieved absorption property for the same aerosol type. By simulating separately dust distribution from different sources, the temporal variability of dust absorption at the AERONET sites can be explained in term of dust loading from specific sources. For dust source regions with distinct contribution at the AERONET sites, the optical properties of soil can be estimated. The differentiation of optical characteristics between dust sources allow then to simulate more realistically the radiative impact of dust aerosols. To realize this analysis, the GOCART transport model has been used. This model is driven by assimilated meteorology which allows to reproduce synoptic scale variability on a daily basis [Chin et al., JGR, 2000; Ginoux et al., JGR, 2001; Chin et al., JAS, 2002]. In this presentation, we will focus our analysis with AERONET sites influenced by African dust and with 2-year simulations of dust distribution from 10 dust sources in North Africa.</td>
</tr>
<tr id="bib_Ginoux_etal_ASMA_2002a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Ginoux_etal_ASMA_2002a,
  author = {Ginoux, P. and Dubovik, O. and Chin, M. and Prospero, J.},
  title = {Variability of African soil absorption property derived from AERONET data and GOCART model simulations},
  journal = {AGU Spring Meeting Abstracts},
  year = {2002},
  pages = {A52F-10},
  url = {http://adsabs.harvard.edu/abs/2002AGUSM.A52F..10G}
}
</pre></td>
</tr>
<tr id="Dawson_etal_AFMA_2016a" class="entry">
	<td>Dawson, E., Evans, S.M. and Ginoux, P.A.</td>
	<td>Variability of the Inter-Tropical Convergence Zone Related to Changes in Inter-Hemispheric Dust Load <p class="infolinks">[<a href="javascript:toggleInfo('Dawson_etal_AFMA_2016a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dawson_etal_AFMA_2016a','bibtex')">BibTeX</a>]</p></td>
	<td>2016</td>
	<td>AGU Fall Meeting Abstracts&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2016AGUFM.A53G..03D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dawson_etal_AFMA_2016a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust is a key forcing agent in climate and has major societal impacts on health, agriculture, and transportation. Dust varies on inter-annual to millennial timescales up to a factor of 20 between glacial and interglacial periods. Over the 20th century, desert dust has doubled over much of the globe. In addition, dust has strong spatial heterogeneity producing disparate radiative forcing. Hemispheric asymmetry in dust concentrations has been observed between ice cores in Greenland and Antarctica and more recently between Australia and Africa in the 1970's. Our objective is to assess the impact of such hemispheric dust asymmetry on climate with an emphasis on the Inter-Tropical Convergence Zone (ITCZ). We perform a set of experiments with the GFDL coupled climate models (CM3), modifying dust emission in each hemisphere by 0, 1, 2, and 5 times preindustrial levels. Dust load follows the imposed emission, which reduces the net radiative flux at the surface and top of the atmosphere. When dust load is asymmetric, we find that the radiative forcing is similarly asymmetric, generating an inter-hemispheric transfer of energy through the atmosphere and ocean and an associated shift in precipitation along the ITCZ. We find a linear relationship between radiative forcing and tropical precipitation asymmetry in the Atlantic. Our results show that dust plays a significant role in determining the latitudinal position of the ITCZ. Understanding this relationship is crucial for accurately predicting dust feedbacks and the effects of dust on future climate. This relationship is also important for understanding past climate variability such as the mid-Holocene and Last Glacial Maximum.</td>
</tr>
<tr id="bib_Dawson_etal_AFMA_2016a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dawson_etal_AFMA_2016a,
  author = {Dawson, E. and Evans, S. M. and Ginoux, P. A.},
  title = {Variability of the Inter-Tropical Convergence Zone Related to Changes in Inter-Hemispheric Dust Load},
  journal = {AGU Fall Meeting Abstracts},
  year = {2016},
  url = {http://adsabs.harvard.edu/abs/2016AGUFM.A53G..03D}
}
</pre></td>
</tr>
<tr id="McGowan_etal_AFMA_2012a" class="entry">
	<td>McGowan, H.A., Marx, S., Soderholm, J. and McCarthy, N.</td>
	<td>New insights to Australian dust emissions from alpine geologic archives and LiDAR <p class="infolinks">[<a href="javascript:toggleInfo('McGowan_etal_AFMA_2012a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('McGowan_etal_AFMA_2012a','bibtex')">BibTeX</a>]</p></td>
	<td>2012</td>
	<td>AGU Fall Meeting Abstracts, pp. A41L-04&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2012AGUFM.A41L..04M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_McGowan_etal_AFMA_2012a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Australia is believed to be the largest source of atmospheric dust in the Southern Hemisphere. Estimates of annual dust emissions from numerical modelling studies and satellite image analyses are around 61 Mt yr (e.g. Ginoux et al., 2001). However, such approaches to quantification of dust emissions are fraught with difficulty, while their application to research of longer term impacts of climate variability or land use change on wind erosion is limited to available observational records. Accordingly, there is great need for long term and continuous high spatial and temporal resolution records of dust emissions and, in-situ or surface based measurement of dust plume loads to validate and calibrate satellite image analyses and modelling studies. Here we present two distinct records of Australian dust emissions that offer new insights into the Australian dust transport system and challenge conventional views. These are: 1) a 300 year record of dust deposition constructed from a peat bog and, 2) event based measurements of dust concentrations using a LiDAR ceilometer. In 2006 a sediment core was collected from an alpine ombrotrophic peat bog (1940 m asl.) in the Snowy Mountains, New South Wales near the centre of the Australian southeast dust transport pathway. This site is downwind of the Murray-Darling Basin, a large (1.06 million km2) drainage basin and Australia's main agricultural region. Results from the analysis of a continuous record of dust deposition from the top 300 years of the core show for the first time the introduction of European farming techniques increased dust deposition by between 2 to 10 times natural background levels. Modulation of ENSO by the Pacific Decadal Oscillation is shown to affect dust deposition rates at decadal scale, while the uptake of soil conservation practices in the early 1980's returned dust deposition rates to pre-European levels. Event based measurements of dust plumes by LiDAR ceilometer in the southeast dust transport pathway are presented also and show that previous estimates of dust plume loads may have been too large by gt 100 &#37; (McGowan and Soderholm, 2012). Importantly, surface based LiDAR are shown to accurately define the structure of dust plumes and allow quantification of dust loads in irregularly stratified plumes. We conclude that dust emissions from south-eastern Australia appear to have returned to levels similar to natural background rates prior to disturbance by European settlement. This result challenges recent estimates that 75&#37; of present day dust emissions from Australia are from anthropogenic sources (Ginoux et al., 2012) and, by association, reflect an enhanced dust transport system. References: Ginoux, P., et al. (2001), Sources and distributions of dust aerosols simulated with the GOCART model, J. Geophys. Res., 106, 255-273, doi:10.1029/2000JD000053. Ginoux, P., et al. (2012), Global scale attribution of anthropogenic and natural dust sources and their emission rates based on MODIS Deep Blue aerosol products, J. Geophys. Res., DOI:10.1029/. McGowan, H. A., and J. Soderholm (2012), Laser ceilometer measurements of Australian dust storm highlight need for reassessment of atmospheric dust plume loads, Geophys. Res. Lett., 39, doi:10.1029/ 2011GL050319.</td>
</tr>
<tr id="bib_McGowan_etal_AFMA_2012a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{McGowan_etal_AFMA_2012a,
  author = {McGowan, H. A. and Marx, S. and Soderholm, J. and McCarthy, N.},
  title = {New insights to Australian dust emissions from alpine geologic archives and LiDAR},
  journal = {AGU Fall Meeting Abstracts},
  year = {2012},
  pages = {A41L-04},
  url = {http://adsabs.harvard.edu/abs/2012AGUFM.A41L..04M}
}
</pre></td>
</tr>
<tr id="Miller_etal_AFMA_2014a" class="entry">
	<td>Miller, R.L., P&eacute;rez Garc\ia-Pando, C., Perlwitz, J.P. and Ginoux, P.A.</td>
	<td>Radiative Forcing and Perturbations To Climate By Anthropogenic Sources of Soil Dust Aerosols <p class="infolinks">[<a href="javascript:toggleInfo('Miller_etal_AFMA_2014a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Miller_etal_AFMA_2014a','bibtex')">BibTeX</a>]</p></td>
	<td>2014</td>
	<td>AGU Fall Meeting Abstracts, pp. A51M-06&nbsp;</td>
	<td>article</td>
	<td><a href="http://adsabs.harvard.edu/abs/2014AGUFM.A51M..06M">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Miller_etal_AFMA_2014a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The radiative forcing and climate perturbation by natural sources ofsoil dust aerosols have been calculated previously by several models.However, human activities like agriculture also createsoil dust aerosols, and the most recent estimate of this contributionto global emission is near 25 percent. Anthropogenic sources have adifferent spatial distribution compared to natural sources, resultingin radiative forcing and a climate perturbation with a unique regionalpattern. Here, we use the NASA GISS Earth System ModelE to calculatethe forcing and climate perturbation by anthropogenic dust sources identified by Ginoux (2012).We contrast the regional distribution of climate anomalies forced byanthropogenic and natural sources. We also use prescribed differencesin the particle shortwave absorption to identify the remote influenceof dust sources upon precipitation and suggest a mechanism by whichthis influence occurs.</td>
</tr>
<tr id="bib_Miller_etal_AFMA_2014a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Miller_etal_AFMA_2014a,
  author = {Miller, R. L. and P&eacute;rez Garc\ia-Pando, C. and Perlwitz, J. P. and Ginoux, P. A.},
  title = {Radiative Forcing and Perturbations To Climate By Anthropogenic Sources of Soil Dust Aerosols},
  journal = {AGU Fall Meeting Abstracts},
  year = {2014},
  pages = {A51M-06},
  url = {http://adsabs.harvard.edu/abs/2014AGUFM.A51M..06M}
}
</pre></td>
</tr>
<tr id="Nabavi_etal_AR_2017a" class="entry">
	<td>Nabavi, S.O., Haimberger, L. and Samimi, C.</td>
	<td>Sensitivity of WRF-chem predictions to dust source function specification in West Asia <p class="infolinks">[<a href="javascript:toggleInfo('Nabavi_etal_AR_2017a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Nabavi_etal_AR_2017a','bibtex')">BibTeX</a>]</p></td>
	<td>2017</td>
	<td>Aeolian Research<br/>Vol. 24, pp. 115-131&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.aeolia.2016.12.005">DOI</a> <a href="http://adsabs.harvard.edu/abs/2017AeoRe..24..115N">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Nabavi_etal_AR_2017a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Dust storms tend to form in sparsely populated areas covered by only few observations. Dust source maps, known as source functions, are used in dust models to allocate a certain potential of dust release to each place. Recent research showed that the well known Ginoux source function (GSF), currently used in Weather Research and Forecasting Model coupled with Chemistry (WRF-chem), exhibits large errors over some regions in West Asia, particularly near the IRAQ/Syrian border.  This study aims to improve the specification of this critical part of dust forecasts. A new source function based on multi-year analysis of satellite observations, called West Asia source function (WASF), is therefore proposed to raise the quality of WRF-chem predictions in the region. WASF has been implemented in three dust schemes of WRF-chem. Remotely sensed and ground-based observations have been used to verify the horizontal and vertical extent and location of simulated dust clouds. Results indicate that WRF-chem performance is significantly improved in many areas after the implementation of WASF. The modified runs (long term simulations over the summers 2008-2012, using nudging) have yielded an average increase of Spearman correlation between observed and forecast aerosol optical thickness by 12-16 percent points compared to control runs with standard source functions. They even outperform MACC and DREAM dust simulations over many dust source regions. However, the quality of the forecasts decreased with distance from sources, probably due to deficiencies in the transport and deposition characteristics of the forecast model in these areas.</td>
</tr>
<tr id="bib_Nabavi_etal_AR_2017a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Nabavi_etal_AR_2017a,
  author = {Nabavi, S. O. and Haimberger, L. and Samimi, C.},
  title = {Sensitivity of WRF-chem predictions to dust source function specification in West Asia},
  journal = {Aeolian Research},
  year = {2017},
  volume = {24},
  pages = {115-131},
  url = {http://adsabs.harvard.edu/abs/2017AeoRe..24..115N},
  doi = {https://doi.org/10.1016/j.aeolia.2016.12.005}
}
</pre></td>
</tr>
<tr id="Shao_etal_AR_2011a" class="entry">
	<td>Shao, Y., Wyrwoll, K.-H., Chappell, A., Huang, J., Lin, Z., McTainsh, G.H., Mikami, M., Tanaka, T.Y., Wang, X. and Yoon, S.</td>
	<td>Dust cycle: An emerging core theme in Earth system science <p class="infolinks">[<a href="javascript:toggleInfo('Shao_etal_AR_2011a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Shao_etal_AR_2011a','bibtex')">BibTeX</a>]</p></td>
	<td>2011</td>
	<td>Aeolian Research<br/>Vol. 2, pp. 181-204&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1016/j.aeolia.2011.02.001">DOI</a> <a href="http://adsabs.harvard.edu/abs/2011AeoRe...2..181S">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Shao_etal_AR_2011a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: The dust cycle is an integral part of the Earth system. Each year, an
<br>estimated 2000 Mt dust is emitted into the atmosphere, 75&#37; of which is
<br>deposited to the land and 25&#37; to the ocean. The emitted and deposited
<br>dust participates in a range physical, chemical and bio-geological
<br>processes that interact with the cycles of energy, carbon and water.
<br>Dust profoundly affects the energy balance of the Earth system, carries
<br>organic material, contributes directly to the carbon cycle and carries
<br>iron which is vital to ocean productivity and the ocean-atmosphere CO
<br>_2 exchange. A deciphering of dust sources, transport and
<br>deposition, requires an understanding of the geological controls and
<br>climate states - past, present and future. While our knowledge of the
<br>dust cycle, its impacts and interactions with the other global-scale
<br>bio-geochemical cycles has greatly advanced in the last 30 years, large
<br>uncertainties and knowledge gaps still exist. In this review paper, we
<br>attempt to provide a benchmark of our present understanding, identify
<br>the needs and emphasise the importance of placing the dust issue in the
<br>Earth system framework. Our review focuses on (i) the concept of the
<br>dust cycle in the context of global biogeochemical cycles; (ii) dust as
<br>a climate indicator; (iii) dust modelling; (iv) dust monitoring; and (v)
<br>dust parameters. The adoption of a quantitative and global perspective
<br>of the dust cycle, underpinned by a deeper understanding of its physical
<br>controls, will lead to the reduction of the large uncertainties which
<br>presently exist in Earth system models.
<br></td>
</tr>
<tr id="bib_Shao_etal_AR_2011a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Shao_etal_AR_2011a,
  author = {Shao, Y. and Wyrwoll, K.-H. and Chappell, A. and Huang, J. and Lin, Z. and McTainsh, G. H. and Mikami, M. and Tanaka, T. Y. and Wang, X. and Yoon, S.},
  title = {Dust cycle: An emerging core theme in Earth system science},
  journal = {Aeolian Research},
  year = {2011},
  volume = {2},
  pages = {181-204},
  url = {http://adsabs.harvard.edu/abs/2011AeoRe...2..181S},
  doi = {https://doi.org/10.1016/j.aeolia.2011.02.001}
}
</pre></td>
</tr>
<tr id="Dai_etal_AiAS_2015a" class="entry">
	<td>Dai, T., Shi, G. and Nakajima, T.</td>
	<td>Analysis and evaluation of the global aerosol optical properties simulated by an online aerosol-coupled non-hydrostatic icosahedral atmospheric model <p class="infolinks">[<a href="javascript:toggleInfo('Dai_etal_AiAS_2015a','abstract')">Abstract</a>] [<a href="javascript:toggleInfo('Dai_etal_AiAS_2015a','bibtex')">BibTeX</a>]</p></td>
	<td>2015</td>
	<td>Advances in Atmospheric Sciences<br/>Vol. 32, pp. 743-758&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1007/s00376-014-4098-z">DOI</a> <a href="http://adsabs.harvard.edu/abs/2015AdAtS..32..743D">URL</a>&nbsp;</td>
</tr>
<tr id="abs_Dai_etal_AiAS_2015a" class="abstract noshow">
	<td colspan="6"><b>Abstract</b>: Aerosol optical properties are simulated using the Spectral Radiation Transport Model for Aerosol Species (SPRINTARS) coupled with the Non-hydrostatic ICosahedral Atmospheric Model (NICAM). The 3-year global mean all-sky aerosol optical thickness (AOT) at 550 nm, the &Aring;ngstr&ouml;m Exponent (AE) based on AOTs at 440 and 870 nm, and the single scattering albedo (SSA) at 550 nm are estimated at 0.123, 0.657 and 0.944, respectively. For each aerosol species, the mean AOT is within the range of the AeroCom models. Both the modeled all-sky and clear-sky results are compared with observations from the Moderate Resolution Imaging Spectroradiometer (MODIS) and the Aerosol Robotic Network (AERONET). The simulated spatiotemporal distributions of all-sky AOTs can generally reproduce the MODIS retrievals, and the correlation and model skill can be slightly improved using the clear-sky results over most land regions. The differences between clear-sky and all-sky AOTs are larger over polluted regions. Compared with observations from AERONET, the modeled and observed all-sky AOTs and AEs are generally in reasonable agreement, whereas the SSA variation is not well captured. Although the spatiotemporal distributions of all-sky and clear-sky results are similar, the clear-sky results are generally better correlated with the observations. The clear-sky AOT and SSA are generally lower than the all-sky results, especially in those regions where the aerosol chemical composition is contributed to mostly by sulfate aerosol. The modeled clear-sky AE is larger than the all-sky AE over those regions dominated by hydrophilic aerosol, while the opposite is found over regions dominated by hydrophobic aerosol.</td>
</tr>
<tr id="bib_Dai_etal_AiAS_2015a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{Dai_etal_AiAS_2015a,
  author = {Dai, T. and Shi, G. and Nakajima, T.},
  title = {Analysis and evaluation of the global aerosol optical properties simulated by an online aerosol-coupled non-hydrostatic icosahedral atmospheric model},
  journal = {Advances in Atmospheric Sciences},
  year = {2015},
  volume = {32},
  pages = {743-758},
  url = {http://adsabs.harvard.edu/abs/2015AdAtS..32..743D},
  doi = {https://doi.org/10.1007/s00376-014-4098-z}
}
</pre></td>
</tr>
<tr id="MaxitGinoux_ASoAJ_2010a" class="entry">
	<td>Maxit, L. and Ginoux, J.-M.</td>
	<td>Prediction of the vibro-acoustic behavior of a submerged shell non periodically stiffened by internal frames <p class="infolinks">[<a href="javascript:toggleInfo('MaxitGinoux_ASoAJ_2010a','bibtex')">BibTeX</a>]</p></td>
	<td>2010</td>
	<td>Acoustical Society of America Journal<br/>Vol. 128, pp. 137&nbsp;</td>
	<td>article</td>
	<td><a href="https://doi.org/10.1121/1.3436526">DOI</a> <a href="http://adsabs.harvard.edu/abs/2010ASAJ..128..137M">URL</a>&nbsp;</td>
</tr>
<tr id="bib_MaxitGinoux_ASoAJ_2010a" class="bibtex noshow">
<td colspan="6"><b>BibTeX</b>:
<pre>
@article{MaxitGinoux_ASoAJ_2010a,
  author = {Maxit, L. and Ginoux, J.-M.},
  title = {Prediction of the vibro-acoustic behavior of a submerged shell non periodically stiffened by internal frames},
  journal = {Acoustical Society of America Journal},
  year = {2010},
  volume = {128},
  pages = {137},
  url = {http://adsabs.harvard.edu/abs/2010ASAJ..128..137M},
  doi = {https://doi.org/10.1121/1.3436526}
}
</pre></td>
</tr>
</tbody>
</table>

 <small>Created by <a href="http://jabref.sourceforge.net">JabRef</a> on 04/03/2019.</small>
<!-- file generated by JabRef -->


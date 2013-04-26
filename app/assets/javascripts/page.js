function elem(x) { return document.getElementById(x); }
function match(s, m) { return (String(s).match(m)); }
function docLoaded() { return document.readyState === 'complete'; }
function scr() { return { width: window.innerWidth, height: window.innerHeight }; }
function lastToken(str, delim) { return str.split(delim)[str.split(delim).length - 1]; }
function sleep(s) { var now = new Date(); var sleeping = true; while (sleeping) { if (new Date().getTime() - now.getTime() > (s * 1000)) sleeping = false; } }
function OnLoad() {
   loadImages();
   document.onreadystatechange = onReady;
}
function onReady() {
   if (docLoaded()) {
       var height = scr().height;
       elem('header').setAttribute('height', height * 0.3);
       elem('main').setAttribute('height', height * 0.5);
       elem('footer').setAttribute('height', height * 0.2);
       imgOnClick('home');
   }
}
function HorizontalOnLoad() {
   var str = tdResult.innerHTML;
   var vids = document.getElementsByTagName('iframe').length;
   if (vids > 0) { elem('scrollable-in').style.width = '' + (700 * vids) + 'px'; }
}
var page = '';
//***************************************************  AJAX Controllers **************************************************
function ReceiveServerData(result) {
   match(result, 'error') ?
               setContent(renderImage('notfound', '404.jpg', 'Page not found'), 'tdResult')
               : setContent(result, 'tdResult');
}
function CallbackEvent_Error(error) {
   page = '';
   document.writeln('An error has occured : ' + error);
}
function sendRequest(args) {
//    setContent('<center><img src="Images/Animated/wait.gif" /></center>', 'tdResult');
   page = args;
   CallServer(args);
}
function setContent(contentString, contentId) {
   fade(contentId);
   tdResult.innerHTML = adjustVideoSizes(contentString);
   HorizontalOnLoad();
   setScroller();
   fade(contentId);
}
function setScroller() {
   if ($("#slides")) {
       $(function () {
           $('#slides').slides({
               preload: true,
               animationStart: function (current) {
                   $('.caption').animate({
                       bottom: -35
                   }, 100);
               },
               animationComplete: function (current) {
                   $('.caption').animate({
                       bottom: 0
                   }, 200);
               },
               slidesLoaded: function () {
                   $('.caption').animate({
                       bottom: 0
                   }, 200);
               }
           });
       });
   }
}
function adjustVideoSizes(contentString) {
   var cnt = contentString;
   var h = parseInt(elem('main').height);
   var newH = (page === 'filmography') ? (h - (h % 100)) : h;
   var newW = parseInt(window.innerWidth- 100);
   if (match(cnt, 'style="height: 300px;"')) {
       cnt = cnt.replace('style="height: 300px;"', 'style="height: ' + newH + 'px;width: ' + newW + 'px;"');
   }
   if (page === 'musicvideos' || page === 'commercial') {
       cnt = cnt.replace('height="250"', 'height="' + Math.floor(h*(250/342)) + '"');
   }
   return cnt;
}
function getVidSize() {
   var h = parseInt(elem('main').height);
   var vidH = Math.floor(((h - (h % 100))));
   var vidW = Math.floor((350 / 219) * vidH);
   return { height: vidH, width: vidW };
}
function setframe(url) {
   var params = '?modestbranding=1&amp;title=&amp;autohide=1&amp;showinfo=0';
   var frameHTML = '<iframe style="width: ' + getVidSize().width + 'px;height: ' + getVidSize().height + 'px;" src="' + url + params + '" frameborder="0" allowfullscreen></iframe>';
   elem('frameDisplay').innerHTML = frameHTML;
}
//***************************************************  Image handlers **************************************************
function imgOnClick(imgId) {
   sendRequest(imgId);
}
function imgOnDown(imgId, isMouseDown) {
   imgSet(imgId, isMouseDown, '_pressed');
}

function renderImage(id, filename, altText) {
   return '<img id="' + id + '" width=240 height=240 src="Images/' + ((filename.match('.gif') != null) ? 'Animated/' : '') + fileName + '" alt="' + altText + '" />';
}
function loadButtonImages() {
   var images = ['about', 'resume', 'films', 'commercial', 'musicvideos', 'contact', 'stills'];
   var width = Math.floor(window.screen.availWidth / images.length);
   for (var i = 0; i < images.length; i++) {
       var src = 'http://www.moshemishali.com/Images/Buttons/' + images[i] + '.jpg';
       var srcPressed = src.replace(images[i], images[i] + '_pressed');
       pic = new Image(width, width / 4);
       pic.src = src;
       pic = new Image(width, width / 4);
       pic.src = srcPressed;
   }
}
function loadRegularImages() {
   var images = ['Animated/wait.gif', 'FilmPosters/privaterooms.jpg'];
   for (var i = 0; i < images.length; i++) {
       var src = 'http://www.moshemishali.com/Images/' + images[i];
       pic = new Image(100, 25);
       pic.src = src;
   }
}
function imgSet(imgId, isSet, appendix) {
   var img = elem(imgId);
   if (img) {
       var src = img.src;
       var oldImg = lastToken(src, '/');
       var newImg = (isSet) ? imgId + appendix : imgId;
       newImg += '.' + lastToken(oldImg, '.');
       img.src = src.replace(oldImg, newImg);
   }
}
function loadImages() {
   loadButtonImages();
   loadRegularImages();
}
//***************************************************  Modal Dialog ****************************************************
function openModal(modal, modalContent, content, width, height) {
   var mdlCntnt = elem(modal).getElementsByTagName('span');
   if (mdlCntnt && mdlCntnt.length > 0) {
       mdlCntnt[0].innerHTML = content;
       sm(modal, width, height);
   }
}
function openMovieDetailModal(title, details, vidlink, synopsis) {
   var pageHTML = '' +
                   '<div id="title" class="mdlTitle">' + title + '</div>' +
                   '<div id="description" class="mdlDesc">' + details + '</div>' +
                   '<table>' +
                       '<tr>' +
                           '<td id="vidout" style="vertical-align: top; text-align: justify; width: 560px; height: 315px;padding-right: 10px;">' +
                               '<iframe id="vid" width="560" height="315" src="' + vidlink + '?modestbranding=1&amp;title=&amp;autohide=1&amp;showinfo=0&amp;hd=1" frameborder="0"></iframe>' +
                           '</td>' +
                           '<td class="descCell">' + synopsis + '</td>' +
                       '</tr>' +
                   '</table>';
   var width = match(title,'Martha') ? 970 : 950;
   var height = match(title,'Martha') ? 450 : 400;
   openModal('box', 'modalContent', pageHTML, width, height);
   elem('vid') ? elem('vid').style.visibility = "visible" : '';
}
//***************************************************  Special FX  ****************************************************
function scroll(dir, spd) {
   var scrl = elem('mrq');
   if (scrl) {
       if (dir === 'up' || dir === 'down') {
           scrl.direction = dir;
           scrl.scrollAmount =  spd ? spd : 10;
       }
       else {
           scrl.scrollAmount = spd ? spd : 0;
       }
   }
}
var TimeToFade = 1000.0;
function fade(eid) {
   var element = elem(eid);
   if (element == null)
       return;

   if (element.FadeState == null) {
       if (element.style.opacity == null
       || element.style.opacity == ''
       || element.style.opacity == '1') {
           element.FadeState = 2;
       }
       else {
           element.FadeState = -2;
       }
   }

   if (element.FadeState == 1 || element.FadeState == -1) {
       element.FadeState = element.FadeState == 1 ? -1 : 1;
       element.FadeTimeLeft = TimeToFade - element.FadeTimeLeft;
   }
   else {
       element.FadeState = element.FadeState == 2 ? -1 : 1;
       element.FadeTimeLeft = TimeToFade;
       setTimeout("animateFade(" + new Date().getTime() + ",'" + eid + "')", 33);
   }
}
function animateFade(lastTick, eid) {
   var curTick = new Date().getTime();
   var elapsedTicks = curTick - lastTick;
   var element = $(eid);
   if (element && element.FadeTimeLeft && element.style) {
       if (element.FadeTimeLeft <= elapsedTicks) {
           element.style.opacity = element.FadeState == 1 ? '1' : '0';
           element.style.filter = 'alpha(opacity = ' + (element.FadeState == 1 ? '100' : '0') + ')';
           element.FadeState = element.FadeState == 1 ? 2 : -2;
           return;
       }
       element.FadeTimeLeft -= elapsedTicks;
       var newOpVal = element.FadeTimeLeft / TimeToFade;
       if (element.FadeState == 1)
           newOpVal = 1 - newOpVal;
       element.style.opacity = newOpVal;
       element.style.filter = 'alpha(opacity = ' + (newOpVal * 100) + ')';
       setTimeout("animateFade(" + curTick + ",'" + eid + "')", 33);
   }
}

alert("page.js")
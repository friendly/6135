!function(){"use strict";var e,t,i=!1;function n(e){if(i&&window.top!==window.self){var t=window;"srcdoc"===t.location.pathname&&(t=t.parent);var n,o=(n={},window._Flourish_template_id&&(n.template_id=window._Flourish_template_id),window.Flourish&&window.Flourish.app&&window.Flourish.app.loaded_template_id&&(n.template_id=window.Flourish.app.loaded_template_id),window._Flourish_visualisation_id&&(n.visualisation_id=window._Flourish_visualisation_id),window.Flourish&&window.Flourish.app&&window.Flourish.app.loaded_visualisation&&(n.visualisation_id=window.Flourish.app.loaded_visualisation.id),window.Flourish&&window.Flourish.app&&window.Flourish.app.story&&(n.story_id=window.Flourish.app.story.id,n.slide_count=window.Flourish.app.story.slides.length),window.Flourish&&window.Flourish.app&&window.Flourish.app.current_slide&&(n.slide_index=window.Flourish.app.current_slide.index+1),n),r={sender:"Flourish",method:"customerAnalytics"};for(var a in o)o.hasOwnProperty(a)&&(r[a]=o[a]);for(var a in e)e.hasOwnProperty(a)&&(r[a]=e[a]);t.parent.postMessage(JSON.stringify(r),"*")}}function o(e){if("function"!=typeof e)throw new Error("Analytics callback is not a function");window.Flourish._analytics_listeners.push(e)}function r(){i=!0;[{event_name:"click",action_name:"click",use_capture:!0},{event_name:"keydown",action_name:"key_down",use_capture:!0},{event_name:"mouseenter",action_name:"mouse_enter",use_capture:!1},{event_name:"mouseleave",action_name:"mouse_leave",use_capture:!1}].forEach((function(e){document.body.addEventListener(e.event_name,(function(){n({action:e.action_name})}),e.use_capture)}))}function a(){if(null==e){var t=function(){var e=window.location;"about:srcdoc"==e.href&&(e=window.parent.location);var t={};return function(e,i,n){for(;n=i.exec(e);)t[decodeURIComponent(n[1])]=decodeURIComponent(n[2])}(e.search.substring(1).replace(/\+/g,"%20"),/([^&=]+)=?([^&]*)/g),t}();e="referrer"in t?/^https:\/\/medium.com\//.test(t.referrer):!("auto"in t)}return e}function s(e){var t=e||window.innerWidth;return t>999?650:t>599?575:400}function l(e){if(e&&window.top!==window.self){var t=window;"srcdoc"==t.location.pathname&&(t=t.parent);var i={sender:"Flourish",method:"scrolly"};if(e)for(var n in e)i[n]=e[n];t.parent.postMessage(JSON.stringify(i),"*")}}function d(e,i){if(window.top!==window.self){var n=window;if("srcdoc"==n.location.pathname&&(n=n.parent),t)return e=parseInt(e,10),void n.parent.postMessage({sentinel:"amp",type:"embed-size",height:e},"*");var o={sender:"Flourish",context:"iframe.resize",method:"resize",height:e,src:n.location.toString()};if(i)for(var r in i)o[r]=i[r];n.parent.postMessage(JSON.stringify(o),"*")}}function u(){return(-1!==navigator.userAgent.indexOf("Safari")||-1!==navigator.userAgent.indexOf("iPhone"))&&-1==navigator.userAgent.indexOf("Chrome")}function c(e){return"string"==typeof e||e instanceof String}function h(e){return"warn"!==e.method?(console.warn("BUG: validateWarnMessage called for method"+e.method),!1):!(null!=e.message&&!c(e.message))&&!(null!=e.explanation&&!c(e.explanation))}function f(e){return"resize"!==e.method?(console.warn("BUG: validateResizeMessage called for method"+e.method),!1):!!c(e.src)&&(!!c(e.context)&&!!("number"==typeof(t=e.height)?!isNaN(t)&&t>=0:c(t)&&/\d/.test(t)&&/^[0-9]*(\.[0-9]*)?(cm|mm|Q|in|pc|pt|px|em|ex|ch|rem|lh|vw|vh|vmin|vmax|%)?$/i.test(t)));var t}function p(e){throw new Error("Validation for setSetting is not implemented yet; see issue #4328")}function m(e){return"scrolly"!==e.method?(console.warn("BUG: validateScrolly called for method"+e.method),!1):!!Array.isArray(e.slides)}function w(e){return"customerAnalytics"===e.method||(console.warn("BUG: validateCustomerAnalyticsMessage called for method"+e.method),!1)}function g(e){return"request-upload"!==e.method?(console.warn("BUG: validateResizeMessage called for method"+e.method),!1):!!c(e.name)&&!(null!=e.accept&&!c(e.accept))}function y(e,t,i){var n=function(e){for(var t={warn:h,resize:f,setSetting:p,customerAnalytics:w,"request-upload":g,scrolly:m},i={},n=0;n<e.length;n++){var o=e[n];if(!t[o])throw new Error("No validator found for method "+o);i[o]=t[o]}return i}(t);window.addEventListener("message",(function(t){var o=function(){if(t.origin==document.location.origin)return!0;if(i){const e=t.origin.toLowerCase();if(i=i.toLowerCase(),e.endsWith("//"+i))return!0;if(e.endsWith("."+i))return!0}return!!t.origin.match(/\/\/localhost:\d+$|\/\/(?:public|app)\.flourish.devlocal$|\/\/flourish-api\.com$|\.flourish\.(?:local(:\d+)?|net|rocks|studio)$|\.uri\.sh$|\/\/flourish-user-templates\.com$/)}();if(null!=t.source&&o){var r;try{r="object"==typeof t.data?t.data:JSON.parse(t.data)}catch(e){return void console.warn("Unexpected non-JSON message: "+JSON.stringify(t.data))}if("Flourish"===r.sender)if(r.method)if(Object.prototype.hasOwnProperty.call(n,r.method))if(n[r.method](r)){for(var a=document.querySelectorAll("iframe"),s=0;s<a.length;s++)if(a[s].contentWindow==t.source||a[s].contentWindow==t.source.parent)return void e(r,a[s]);console.warn("could not find frame",r)}else console.warn("Validation failed for the message",r);else console.warn("No validator implemented for message",r);else console.warn("The 'method' property was missing from message",r)}})),u()&&(window.addEventListener("resize",v),v())}function v(){for(var e=document.querySelectorAll(".flourish-embed"),t=0;t<e.length;t++){var i=e[t];if(!i.getAttribute("data-width")){var n=i.querySelector("iframe");if(n){var o=window.getComputedStyle(i),r=i.offsetWidth-parseFloat(o.paddingLeft)-parseFloat(o.paddingRight);n.style.width=r+"px"}}}}function _(e,t){var i=e.parentNode;if(i.classList.contains("fl-scrolly-wrapper"))console.warn("createScrolly is being called more than once per story. This should not happen.");else{i.classList.add("fl-scrolly-wrapper"),i.style.position="relative",i.style.paddingBottom="1px",i.style.transform="translate3d(0, 0, 0)",e.style.position="sticky";var n=i.getAttribute("data-height")||null;n||(n="80vh",e.style.height=n),e.style.top="calc(50vh - "+n+"/2)";var o=i.querySelector(".flourish-credit");o&&(o.style.position="sticky",o.style.top="calc(50vh + "+n+"/2)"),t.forEach((function(e,t){var n="string"==typeof e&&""!=e.trim(),o=document.createElement("div");o.setAttribute("data-slide",t),o.classList.add("fl-scrolly-caption"),o.style.position="relative",o.style.transform="translate3d(0,0,0)",o.style.textAlign="center",o.style.maxWidth="500px",o.style.height="auto",o.style.marginTop="0",o.style.marginBottom=n?"100vh":"50vh",o.style.marginLeft="auto",o.style.marginRight="auto";var r=document.createElement("div");r.innerHTML=e,r.style.visibility=n?"":"hidden",r.style.display="inline-block",r.style.paddingTop="1.25em",r.style.paddingRight="1.25em",r.style.paddingBottom="1.25em",r.style.paddingLeft="1.25em",r.style.background="rgba(255,255,255,0.9)",r.style.boxShadow="0px 0px 10px rgba(0,0,0,0.2)",r.style.borderRadius="10px",r.style.textAlign="center",r.style.maxWidth="100%",r.style.margin="0 20px",r.style.overflowX="hidden",o.appendChild(r),i.appendChild(o)})),function(e){for(var t=new IntersectionObserver((function(t){t.forEach((function(t){if(t.isIntersecting){var i=e.querySelector("iframe");i&&(i.src=i.src.replace(/#slide-.*/,"")+"#slide-"+t.target.getAttribute("data-slide"))}}))}),{rootMargin:"0px 0px -0% 0px"}),i=e.querySelectorAll(".fl-scrolly-caption"),n=0;n<i.length;n++)t.observe(i[n]);e.querySelectorAll(".fl-scrolly-caption img").forEach((function(e){e.style.maxWidth="100%"}))}(i)}}function F(e,t,i,n,o){var r=document.createElement("iframe");if(r.setAttribute("scrolling","no"),r.setAttribute("frameborder","0"),r.setAttribute("title","Interactive or visual content"),r.setAttribute("sandbox","allow-same-origin allow-forms allow-scripts allow-downloads allow-popups allow-popups-to-escape-sandbox allow-top-navigation-by-user-activation"),t.appendChild(r),r.offsetParent||"fixed"===getComputedStyle(r).position)x(e,t,r,i,n,o);else{var a={embed_url:e,container:t,iframe:r,width:i,height:n,play_on_load:o};if(window._flourish_poll_items?window._flourish_poll_items.push(a):window._flourish_poll_items=[a],window._flourish_poll_items.length>1)return r;var s=setInterval((function(){window._flourish_poll_items=window._flourish_poll_items.filter((function(e){return!e.iframe.offsetParent||(x(e.embed_url,e.container,e.iframe,e.width,e.height,e.play_on_load),!1)})),window._flourish_poll_items.length||clearInterval(s)}),500)}return r}function x(e,t,i,n,o,r){var a;return n&&"number"==typeof n?(a=n,n+="px"):n&&n.match(/^[ \t\r\n\f]*([+-]?\d+|\d*\.\d+(?:[eE][+-]?\d+)?)(?:\\?[Pp]|\\0{0,4}[57]0(?:\r\n|[ \t\r\n\f])?)(?:\\?[Xx]|\\0{0,4}[57]8(?:\r\n|[ \t\r\n\f])?)[ \t\r\n\f]*$/)&&(a=parseFloat(n)),o&&"number"==typeof o&&(o+="px"),n?i.style.width=n:u()?i.style.width=t.offsetWidth+"px":i.style.width="100%",!!o||(e.match(/\?/)?e+="&auto=1":e+="?auto=1",o=s(a||i.offsetWidth)+"px"),o&&("%"===o.charAt(o.length-1)&&(o=parseFloat(o)/100*t.parentNode.offsetHeight+"px"),i.style.height=o),i.setAttribute("src",e+(r?"#play-on-load":"")),i}function b(e){return!Array.isArray(e)&&"object"==typeof e&&null!=e}function A(e,t){for(var i in t)b(e[i])&&b(t[i])?A(e[i],t[i]):e[i]=t[i];return e}!function(){var e,i=window.top===window.self,c=i?null:(t="#amp=1"==window.location.hash,{createEmbedIframe:F,isFixedHeight:a,getHeightForBreakpoint:s,startEventListeners:y,notifyParentWindow:d,initScrolly:l,createScrolly:_,isSafari:u,initCustomerAnalytics:r,addAnalyticsListener:o,sendCustomerAnalyticsMessage:n}),h=!0;function f(){var t;Flourish.fixed_height||(null!=e?t=e:h&&(t=c.getHeightForBreakpoint()),t!==window.innerHeight&&c.notifyParentWindow(t))}function p(){-1!==window.location.search.indexOf("enable_customer_analytics=1")&&Flourish.enableCustomerAnalytics(),f(),window.addEventListener("resize",f)}Flourish.warn=function(e){if("string"==typeof e&&(e={message:e}),i||"editor"!==Flourish.environment)console.warn(e.message);else{var t={sender:"Flourish",method:"warn",message:e.message,explanation:e.explanation};window.parent.postMessage(JSON.stringify(t),"*")}},Flourish.uploadImage=function(e){if(i||"story_editor"!==Flourish.environment)throw"Invalid upload request";var t={sender:"Flourish",method:"request-upload",name:e.name,accept:e.accept};window.parent.postMessage(JSON.stringify(t),"*")},Flourish.setSetting=function(e,t){if("editor"===Flourish.environment||"sdk"===Flourish.environment){var i={sender:"Flourish",method:"setSetting",name:e,value:t};window.parent.postMessage(JSON.stringify(i),"*")}else if("story_editor"===Flourish.environment){var n={};n[e]=t,A(window.template.state,function(e){var t={};for(var i in e){for(var n=t,o=i.indexOf("."),r=0;o>=0;o=i.indexOf(".",r=o+1)){var a=i.substring(r,o);a in n||(n[a]={}),n=n[a]}n[i.substring(r)]=e[i]}return t}(n))}},Flourish.setHeight=function(t){Flourish.fixed_height||(e=t,h=null==t,f())},Flourish.checkHeight=function(){if(!i){var e=Flourish.__container_height;null!=e?(Flourish.fixed_height=!0,c.notifyParentWindow(e)):c.isFixedHeight()?Flourish.fixed_height=!0:(Flourish.fixed_height=!1,f())}},Flourish.fixed_height=i||c.isFixedHeight(),Flourish.enableCustomerAnalytics=function(){c&&c.initCustomerAnalytics()},"loading"===document.readyState?document.addEventListener("DOMContentLoaded",p):p()}()}();
if (window.NodeList && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = function (callback, thisArg) {
        thisArg = thisArg || window;
        for (var i = 0; i < this.length; i++) {
            callback.call(thisArg, this[i], i, this);
        }
    };
}
(function() {
    var d = document,
        sc = document.getElementsByTagName('script')[0],
        s = d.createElement('script');
    s.type = 'text/javascript';
    s.async = true;
    s.id = 'secwidgetId';
    s.src = '//cdn.finra.org/iapd-widget/addwidgetsec.js';
    sc.parentNode.insertBefore(s, sc);

    // add a title to the iframe
    const targetNode = document.getElementById('sec-root');
    const config = { childList: true, subtree: true };

    // Callback function to execute when mutations are observed
    const callback = function(mutationsList, observer) {
        // Use traditional 'for loops' for IE 11
        mutationsList.forEach(function(element, index, nodelist) {
            var mutation = element;
            if (mutation.type === 'childList') {
                // console.log('A child node has been added or removed.');
                if(targetNode.getElementsByTagName("IFRAME").length)
                {
                    var iframeItem = targetNode.getElementsByTagName("IFRAME");
                    iframeItem[0].setAttribute('title', 'Check out your investment professional');
                    observer.disconnect();
                }
            }
        });
    };

    // Create an observer instance linked to the callback function
    const observer = new MutationObserver(callback);

    // Start observing the target node for configured mutations
    observer.observe(targetNode, config);
} )();

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

_onFileProgress:function(t, n){
    var i;
    this.options.template ? e(".k-progress", t.target).width(n + "%") : (i = e(".k-upload-pct", t.target), 0 === i.length && e(".k-upload-status", t.target).prepend("<span class='k-upload-pct'></span>"), e(".k-upload-pct", t.target).text(n + "%"), e(".k-progress", t.target).width(n + "%")),
            this.trigger(E, {files: g(t).data("fileNames"), percentComplete: n})
}


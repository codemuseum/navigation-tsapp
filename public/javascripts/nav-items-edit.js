// Parses the items form correctly for a navigation editor.  
// Also requires PictureSelect to be included; and register each item with picture select

var NavigationEdit = {
  init: function() {
    TSEditor.registerOnEdit('navigation', NavigationEdit.navigationInstance);
  },
  
  navigationInstance: function(navigationEl) {
    var navObject = {
      init: function(navBox) {
        var navigationBox = $(navBox);
        var self = this;
        
        this.itemsEl = navigationBox.select('ul.items')[0];
        var creationCode = navigationBox.select('div.new_item_code')[0].remove().innerHTML;

        this.itemsEl.select('li.item').each(function(el) { self._observeItem(el); });
        navigationBox.select('.add-item')[0].observe('click', 
          function(ev) { Event.stop(ev); self._addItem(creationCode); self._makeSortable(); }
        );
        this._makeSortable();
        navigationBox.ancestors().detect(function(anc) { return anc.tagName == 'FORM' }).observe('submit', function(ev) { self._saveOrder(); });
      },
      _addItem: function(html) {
        var newEl=$(document.createElement('div'));
        newEl.update(html);
        newEl = newEl.firstDescendant().remove();
        this._addToCount(1);
        this.itemsEl.appendChild(newEl);
        this._observeItem(newEl);
        newEl.select('input')[1].focus();
      },
      _observeItem: function(item) {
        var remove = item.select('.remove')[0];
        var self = this;
        remove.observe('click', function() { item.remove(); self._addToCount(-1); });
        TS.Assets.Selector.register(item);
      },
      _makeSortable: function() {  
        var sle = this.itemsEl;
        Sortable.create(sle, { handle:'drag-handle', constraint:null });
      },
      _saveOrder: function() {
        var currentPosition = 0;
        this.itemsEl.select('div.item').each(function(item) {
          item.select('input.position-value')[0].value = currentPosition;
          currentPosition++;
        });
      },
      _addToCount: function(amount) {
        var self = this;
        var baseName = 'count-';
        this.itemsEl.classNames().each(function(className) {
          if (className.startsWith(baseName)) {
            var newCount = baseName + (parseInt(className.substring(baseName.length)) + amount);
            self.itemsEl.removeClassName(className);
            self.itemsEl.addClassName(newCount);
          }
        });
      }
    };
    navObject.init(navigationEl);
    return navObject;
  }
}
NavigationEdit.init();
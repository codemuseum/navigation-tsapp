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
        
        this.itemsEl = navigationBox.find('ul.items');
        var creationCode = navigationBox.find('div.new_item_code').remove().get(0).innerHTML;

        this.itemsEl.find('li.item').each(function(i) { self._observeItem($(this)); });
        navigationBox.find('.add-item').click(function(ev) {
          ev.preventDefault(); self._addItem(creationCode); self._makeSortable(); return false;
        });
        this._makeSortable();
        navigationBox.parents('form').bind('submit', function(ev) { self._saveOrder(); });
      },
      _addItem: function(html) {
        var newEl=$(document.createElement('div'));
        newEl.html(html);
        newEl = newEl.find("*:first").remove();
        this._addToCount(1);
        this.itemsEl.get(0).appendChild(newEl.get(0));
        this._observeItem(newEl);
        newEl.find('input')[1].focus();
      },
      _observeItem: function(item) {
        var remove = item.find('.remove a');
        var self = this;
        remove.click(function() { item.remove(); self._addToCount(-1); });
        TS.Assets.Selector.register(item);
      },
      _makeSortable: function() {  
        this.itemsEl.sortable({ items:'li.item' });
        this.itemsEl.disableSelection();
      },
      _saveOrder: function() {
        this.itemsEl.find('div.item').each(function(i) {
          $(this).find('input.position-value:first').get(0).value = i;
        });
      },
      _addToCount: function(amount) {
        var baseName = 'count-';
        var oldCount = parseInt(this.itemsEl.get(0).className.match(new RegExp('(\\s|^)count-([^\\s]*)(\\s|$)'))[2]);
        var newCount = oldCount + amount;
        this.itemsEl.removeClass(baseName + oldCount);
        this.itemsEl.addClass(baseName + newCount);
      }
    };
    navObject.init(navigationEl);
    return navObject;
  }
}
NavigationEdit.init();
if (!Object.prototype.watch) {
	Object.defineProperty(Object.prototype, "watch", {
		enumerable: false, 
        configurable: true, 
        writable: false, 
        value: function (prop, handler) {
			var oldval = this[prop], 
                newval = oldval, 
            getter = function () {
				return newval;
			}, 
            setter = function (val) {
				oldval = newval;
				return newval = handler.call(this, prop, oldval, val);
			};
			
			if (delete this[prop]) { // can't watch constants
				Object.defineProperty(this, prop, {
					  get: getter, 
                      set: setter, 
                      enumerable: true, 
                      configurable: true
				});
			}
		}
	});
}

if (!Object.prototype.unwatch) {
	Object.defineProperty(Object.prototype, "unwatch", {
		  enumerable: false, 
          configurable: true, 
          writable: false, 
          value: function (prop) {
			var val = this[prop];
			delete this[prop];
			this[prop] = val;
		}
	});
}
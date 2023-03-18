"use strict";
var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// node_modules/dequal/lite/index.js
var require_lite = __commonJS({
  "node_modules/dequal/lite/index.js"(exports) {
    var has = Object.prototype.hasOwnProperty;
    function dequal(foo, bar) {
      var ctor, len;
      if (foo === bar)
        return true;
      if (foo && bar && (ctor = foo.constructor) === bar.constructor) {
        if (ctor === Date)
          return foo.getTime() === bar.getTime();
        if (ctor === RegExp)
          return foo.toString() === bar.toString();
        if (ctor === Array) {
          if ((len = foo.length) === bar.length) {
            while (len-- && dequal(foo[len], bar[len]))
              ;
          }
          return len === -1;
        }
        if (!ctor || typeof foo === "object") {
          len = 0;
          for (ctor in foo) {
            if (has.call(foo, ctor) && ++len && !has.call(bar, ctor))
              return false;
            if (!(ctor in bar) || !dequal(foo[ctor], bar[ctor]))
              return false;
          }
          return Object.keys(bar).length === len;
        }
      }
      return foo !== foo && bar !== bar;
    }
    exports.dequal = dequal;
  }
});

// node_modules/@raycast/utils/dist/useDeepMemo.js
var require_useDeepMemo = __commonJS({
  "node_modules/@raycast/utils/dist/useDeepMemo.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useDeepMemo = void 0;
    var react_1 = require("react");
    var lite_1 = require_lite();
    function useDeepMemo(value) {
      const ref = (0, react_1.useRef)(value);
      const signalRef = (0, react_1.useRef)(0);
      if (!(0, lite_1.dequal)(value, ref.current)) {
        ref.current = value;
        signalRef.current += 1;
      }
      return (0, react_1.useMemo)(() => ref.current, [signalRef.current]);
    }
    exports.useDeepMemo = useDeepMemo;
  }
});

// node_modules/@raycast/utils/dist/useLatest.js
var require_useLatest = __commonJS({
  "node_modules/@raycast/utils/dist/useLatest.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useLatest = void 0;
    var react_1 = require("react");
    function useLatest(value) {
      const ref = (0, react_1.useRef)(value);
      ref.current = value;
      return ref;
    }
    exports.useLatest = useLatest;
  }
});

// node_modules/@raycast/utils/dist/usePromise.js
var require_usePromise = __commonJS({
  "node_modules/@raycast/utils/dist/usePromise.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.usePromise = void 0;
    var react_1 = require("react");
    var api_1 = require("@raycast/api");
    var useDeepMemo_1 = require_useDeepMemo();
    var useLatest_1 = require_useLatest();
    function usePromise(fn, args, options) {
      const lastCallId = (0, react_1.useRef)(0);
      const [state, set] = (0, react_1.useState)({ isLoading: true });
      const fnRef = (0, useLatest_1.useLatest)(fn);
      const latestAbortable = (0, useLatest_1.useLatest)(options?.abortable);
      const latestArgs = (0, useLatest_1.useLatest)(args || []);
      const latestOnError = (0, useLatest_1.useLatest)(options?.onError);
      const latestOnData = (0, useLatest_1.useLatest)(options?.onData);
      const latestOnWillExecute = (0, useLatest_1.useLatest)(options?.onWillExecute);
      const latestValue = (0, useLatest_1.useLatest)(state.data);
      const latestCallback = (0, react_1.useRef)();
      const callback = (0, react_1.useCallback)(
        (...args2) => {
          const callId = ++lastCallId.current;
          if (latestAbortable.current) {
            latestAbortable.current.current?.abort();
            latestAbortable.current.current = new AbortController();
          }
          latestOnWillExecute.current?.(args2);
          set((prevState) => ({ ...prevState, isLoading: true }));
          return fnRef.current(...args2).then((data) => {
            if (callId === lastCallId.current) {
              if (latestOnData.current) {
                latestOnData.current(data);
              }
              set({ data, isLoading: false });
            }
            return data;
          }, (error) => {
            if (error.name == "AbortError") {
              return error;
            }
            if (callId === lastCallId.current) {
              if (latestOnError.current) {
                latestOnError.current(error);
              } else {
                console.error(error);
                if (api_1.environment.launchType !== api_1.LaunchType.Background) {
                  (0, api_1.showToast)({
                    style: api_1.Toast.Style.Failure,
                    title: "Failed to fetch latest data",
                    message: error.message,
                    primaryAction: {
                      title: "Retry",
                      onAction(toast) {
                        toast.hide();
                        latestCallback.current?.(...latestArgs.current || []);
                      }
                    },
                    secondaryAction: {
                      title: "Copy Logs",
                      onAction(toast) {
                        toast.hide();
                        api_1.Clipboard.copy(error?.stack || error?.message || "");
                      }
                    }
                  });
                }
              }
              set({ error, isLoading: false });
            }
            return error;
          });
        },
        [latestAbortable, latestOnData, latestOnError, latestArgs, fnRef, set, latestCallback, latestOnWillExecute]
      );
      latestCallback.current = callback;
      const revalidate = (0, react_1.useCallback)(() => {
        return callback(...latestArgs.current || []);
      }, [callback, latestArgs]);
      const mutate = (0, react_1.useCallback)(async (asyncUpdate, options2) => {
        let dataBeforeOptimisticUpdate;
        try {
          if (options2?.optimisticUpdate) {
            if (typeof options2?.rollbackOnError !== "function" && options2?.rollbackOnError !== false) {
              dataBeforeOptimisticUpdate = structuredClone(latestValue.current?.value);
            }
            const update = options2.optimisticUpdate;
            set((prevState) => ({ ...prevState, data: update(prevState.data) }));
          }
          return await asyncUpdate;
        } catch (err) {
          if (typeof options2?.rollbackOnError === "function") {
            const update = options2.rollbackOnError;
            set((prevState) => ({ ...prevState, data: update(prevState.data) }));
          } else if (options2?.optimisticUpdate && options2?.rollbackOnError !== false) {
            set((prevState) => ({ ...prevState, data: dataBeforeOptimisticUpdate }));
          }
          throw err;
        } finally {
          if (options2?.shouldRevalidateAfter !== false) {
            if (api_1.environment.launchType === api_1.LaunchType.Background || api_1.environment.commandMode === "menu-bar") {
              await revalidate();
            } else {
              revalidate();
            }
          }
        }
      }, [revalidate, latestValue, set]);
      (0, react_1.useEffect)(() => {
        if (options?.execute !== false) {
          callback(...args || []);
        }
      }, [(0, useDeepMemo_1.useDeepMemo)([args, options?.execute, callback])]);
      (0, react_1.useEffect)(() => {
        return () => {
          if (latestAbortable.current) {
            latestAbortable.current.current?.abort();
          }
        };
      }, [latestAbortable]);
      return { ...state, revalidate, mutate };
    }
    exports.usePromise = usePromise;
  }
});

// node_modules/@raycast/utils/dist/useCachedState.js
var require_useCachedState = __commonJS({
  "node_modules/@raycast/utils/dist/useCachedState.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useCachedState = void 0;
    var react_1 = require("react");
    var api_1 = require("@raycast/api");
    var useLatest_1 = require_useLatest();
    function replacer(key, _value) {
      const value = this[key];
      if (value instanceof Date) {
        return `__raycast_cached_date__${value.toString()}`;
      }
      if (Buffer.isBuffer(value)) {
        return `__raycast_cached_buffer__${value.toString("base64")}`;
      }
      return _value;
    }
    function reviver(_key, value) {
      if (typeof value === "string" && value.startsWith("__raycast_cached_date__")) {
        return new Date(value.replace("__raycast_cached_date__", ""));
      }
      if (typeof value === "string" && value.startsWith("__raycast_cached_buffer__")) {
        return Buffer.from(value.replace("__raycast_cached_buffer__", ""), "base64");
      }
      return value;
    }
    var rootCache = Symbol("cache without namespace");
    var cacheMap = /* @__PURE__ */ new Map();
    function useCachedState(key, initialState, config) {
      const cacheKey = config?.cacheNamespace || rootCache;
      const cache = cacheMap.get(cacheKey) || cacheMap.set(cacheKey, new api_1.Cache({ namespace: config?.cacheNamespace })).get(cacheKey);
      if (!cache) {
        throw new Error("Missing cache");
      }
      const keyRef = (0, useLatest_1.useLatest)(key);
      const initialValueRef = (0, useLatest_1.useLatest)(initialState);
      const cachedState = (0, react_1.useSyncExternalStore)(cache.subscribe, () => {
        try {
          return cache.get(keyRef.current);
        } catch (error) {
          console.error("Could not get Cache data:", error);
          return void 0;
        }
      });
      const state = (0, react_1.useMemo)(() => {
        if (typeof cachedState !== "undefined") {
          if (cachedState === "undefined") {
            return void 0;
          }
          try {
            return JSON.parse(cachedState, reviver);
          } catch (err) {
            console.warn("The cached data is corrupted", err);
            return initialValueRef.current;
          }
        } else {
          return initialValueRef.current;
        }
      }, [cachedState, initialValueRef]);
      const stateRef = (0, useLatest_1.useLatest)(state);
      const setStateAndCache = (0, react_1.useCallback)((updater) => {
        const newValue = typeof updater === "function" ? updater(stateRef.current) : updater;
        if (typeof newValue === "undefined") {
          cache.set(keyRef.current, "undefined");
        } else {
          const stringifiedValue = JSON.stringify(newValue, replacer);
          cache.set(keyRef.current, stringifiedValue);
        }
        return newValue;
      }, [cache, keyRef, stateRef]);
      return [state, setStateAndCache];
    }
    exports.useCachedState = useCachedState;
  }
});

// node_modules/object-hash/index.js
var require_object_hash = __commonJS({
  "node_modules/object-hash/index.js"(exports, module2) {
    "use strict";
    var crypto = require("crypto");
    exports = module2.exports = objectHash;
    function objectHash(object, options) {
      options = applyDefaults(object, options);
      return hash(object, options);
    }
    exports.sha1 = function(object) {
      return objectHash(object);
    };
    exports.keys = function(object) {
      return objectHash(object, { excludeValues: true, algorithm: "sha1", encoding: "hex" });
    };
    exports.MD5 = function(object) {
      return objectHash(object, { algorithm: "md5", encoding: "hex" });
    };
    exports.keysMD5 = function(object) {
      return objectHash(object, { algorithm: "md5", encoding: "hex", excludeValues: true });
    };
    var hashes = crypto.getHashes ? crypto.getHashes().slice() : ["sha1", "md5"];
    hashes.push("passthrough");
    var encodings = ["buffer", "hex", "binary", "base64"];
    function applyDefaults(object, sourceOptions) {
      sourceOptions = sourceOptions || {};
      var options = {};
      options.algorithm = sourceOptions.algorithm || "sha1";
      options.encoding = sourceOptions.encoding || "hex";
      options.excludeValues = sourceOptions.excludeValues ? true : false;
      options.algorithm = options.algorithm.toLowerCase();
      options.encoding = options.encoding.toLowerCase();
      options.ignoreUnknown = sourceOptions.ignoreUnknown !== true ? false : true;
      options.respectType = sourceOptions.respectType === false ? false : true;
      options.respectFunctionNames = sourceOptions.respectFunctionNames === false ? false : true;
      options.respectFunctionProperties = sourceOptions.respectFunctionProperties === false ? false : true;
      options.unorderedArrays = sourceOptions.unorderedArrays !== true ? false : true;
      options.unorderedSets = sourceOptions.unorderedSets === false ? false : true;
      options.unorderedObjects = sourceOptions.unorderedObjects === false ? false : true;
      options.replacer = sourceOptions.replacer || void 0;
      options.excludeKeys = sourceOptions.excludeKeys || void 0;
      if (typeof object === "undefined") {
        throw new Error("Object argument required.");
      }
      for (var i = 0; i < hashes.length; ++i) {
        if (hashes[i].toLowerCase() === options.algorithm.toLowerCase()) {
          options.algorithm = hashes[i];
        }
      }
      if (hashes.indexOf(options.algorithm) === -1) {
        throw new Error('Algorithm "' + options.algorithm + '"  not supported. supported values: ' + hashes.join(", "));
      }
      if (encodings.indexOf(options.encoding) === -1 && options.algorithm !== "passthrough") {
        throw new Error('Encoding "' + options.encoding + '"  not supported. supported values: ' + encodings.join(", "));
      }
      return options;
    }
    function isNativeFunction(f) {
      if (typeof f !== "function") {
        return false;
      }
      var exp = /^function\s+\w*\s*\(\s*\)\s*{\s+\[native code\]\s+}$/i;
      return exp.exec(Function.prototype.toString.call(f)) != null;
    }
    function hash(object, options) {
      var hashingStream;
      if (options.algorithm !== "passthrough") {
        hashingStream = crypto.createHash(options.algorithm);
      } else {
        hashingStream = new PassThrough();
      }
      if (typeof hashingStream.write === "undefined") {
        hashingStream.write = hashingStream.update;
        hashingStream.end = hashingStream.update;
      }
      var hasher = typeHasher(options, hashingStream);
      hasher.dispatch(object);
      if (!hashingStream.update) {
        hashingStream.end("");
      }
      if (hashingStream.digest) {
        return hashingStream.digest(options.encoding === "buffer" ? void 0 : options.encoding);
      }
      var buf = hashingStream.read();
      if (options.encoding === "buffer") {
        return buf;
      }
      return buf.toString(options.encoding);
    }
    exports.writeToStream = function(object, options, stream) {
      if (typeof stream === "undefined") {
        stream = options;
        options = {};
      }
      options = applyDefaults(object, options);
      return typeHasher(options, stream).dispatch(object);
    };
    function typeHasher(options, writeTo, context) {
      context = context || [];
      var write = function(str) {
        if (writeTo.update) {
          return writeTo.update(str, "utf8");
        } else {
          return writeTo.write(str, "utf8");
        }
      };
      return {
        dispatch: function(value) {
          if (options.replacer) {
            value = options.replacer(value);
          }
          var type = typeof value;
          if (value === null) {
            type = "null";
          }
          return this["_" + type](value);
        },
        _object: function(object) {
          var pattern = /\[object (.*)\]/i;
          var objString = Object.prototype.toString.call(object);
          var objType = pattern.exec(objString);
          if (!objType) {
            objType = "unknown:[" + objString + "]";
          } else {
            objType = objType[1];
          }
          objType = objType.toLowerCase();
          var objectNumber = null;
          if ((objectNumber = context.indexOf(object)) >= 0) {
            return this.dispatch("[CIRCULAR:" + objectNumber + "]");
          } else {
            context.push(object);
          }
          if (typeof Buffer !== "undefined" && Buffer.isBuffer && Buffer.isBuffer(object)) {
            write("buffer:");
            return write(object);
          }
          if (objType !== "object" && objType !== "function" && objType !== "asyncfunction") {
            if (this["_" + objType]) {
              this["_" + objType](object);
            } else if (options.ignoreUnknown) {
              return write("[" + objType + "]");
            } else {
              throw new Error('Unknown object type "' + objType + '"');
            }
          } else {
            var keys = Object.keys(object);
            if (options.unorderedObjects) {
              keys = keys.sort();
            }
            if (options.respectType !== false && !isNativeFunction(object)) {
              keys.splice(0, 0, "prototype", "__proto__", "constructor");
            }
            if (options.excludeKeys) {
              keys = keys.filter(function(key) {
                return !options.excludeKeys(key);
              });
            }
            write("object:" + keys.length + ":");
            var self = this;
            return keys.forEach(function(key) {
              self.dispatch(key);
              write(":");
              if (!options.excludeValues) {
                self.dispatch(object[key]);
              }
              write(",");
            });
          }
        },
        _array: function(arr, unordered) {
          unordered = typeof unordered !== "undefined" ? unordered : options.unorderedArrays !== false;
          var self = this;
          write("array:" + arr.length + ":");
          if (!unordered || arr.length <= 1) {
            return arr.forEach(function(entry) {
              return self.dispatch(entry);
            });
          }
          var contextAdditions = [];
          var entries = arr.map(function(entry) {
            var strm = new PassThrough();
            var localContext = context.slice();
            var hasher = typeHasher(options, strm, localContext);
            hasher.dispatch(entry);
            contextAdditions = contextAdditions.concat(localContext.slice(context.length));
            return strm.read().toString();
          });
          context = context.concat(contextAdditions);
          entries.sort();
          return this._array(entries, false);
        },
        _date: function(date) {
          return write("date:" + date.toJSON());
        },
        _symbol: function(sym) {
          return write("symbol:" + sym.toString());
        },
        _error: function(err) {
          return write("error:" + err.toString());
        },
        _boolean: function(bool) {
          return write("bool:" + bool.toString());
        },
        _string: function(string) {
          write("string:" + string.length + ":");
          write(string.toString());
        },
        _function: function(fn) {
          write("fn:");
          if (isNativeFunction(fn)) {
            this.dispatch("[native]");
          } else {
            this.dispatch(fn.toString());
          }
          if (options.respectFunctionNames !== false) {
            this.dispatch("function-name:" + String(fn.name));
          }
          if (options.respectFunctionProperties) {
            this._object(fn);
          }
        },
        _number: function(number) {
          return write("number:" + number.toString());
        },
        _xml: function(xml) {
          return write("xml:" + xml.toString());
        },
        _null: function() {
          return write("Null");
        },
        _undefined: function() {
          return write("Undefined");
        },
        _regexp: function(regex) {
          return write("regex:" + regex.toString());
        },
        _uint8array: function(arr) {
          write("uint8array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _uint8clampedarray: function(arr) {
          write("uint8clampedarray:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _int8array: function(arr) {
          write("int8array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _uint16array: function(arr) {
          write("uint16array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _int16array: function(arr) {
          write("int16array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _uint32array: function(arr) {
          write("uint32array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _int32array: function(arr) {
          write("int32array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _float32array: function(arr) {
          write("float32array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _float64array: function(arr) {
          write("float64array:");
          return this.dispatch(Array.prototype.slice.call(arr));
        },
        _arraybuffer: function(arr) {
          write("arraybuffer:");
          return this.dispatch(new Uint8Array(arr));
        },
        _url: function(url) {
          return write("url:" + url.toString(), "utf8");
        },
        _map: function(map) {
          write("map:");
          var arr = Array.from(map);
          return this._array(arr, options.unorderedSets !== false);
        },
        _set: function(set) {
          write("set:");
          var arr = Array.from(set);
          return this._array(arr, options.unorderedSets !== false);
        },
        _file: function(file) {
          write("file:");
          return this.dispatch([file.name, file.size, file.type, file.lastModfied]);
        },
        _blob: function() {
          if (options.ignoreUnknown) {
            return write("[blob]");
          }
          throw Error('Hashing Blob objects is currently not supported\n(see https://github.com/puleos/object-hash/issues/26)\nUse "options.replacer" or "options.ignoreUnknown"\n');
        },
        _domwindow: function() {
          return write("domwindow");
        },
        _bigint: function(number) {
          return write("bigint:" + number.toString());
        },
        _process: function() {
          return write("process");
        },
        _timer: function() {
          return write("timer");
        },
        _pipe: function() {
          return write("pipe");
        },
        _tcp: function() {
          return write("tcp");
        },
        _udp: function() {
          return write("udp");
        },
        _tty: function() {
          return write("tty");
        },
        _statwatcher: function() {
          return write("statwatcher");
        },
        _securecontext: function() {
          return write("securecontext");
        },
        _connection: function() {
          return write("connection");
        },
        _zlib: function() {
          return write("zlib");
        },
        _context: function() {
          return write("context");
        },
        _nodescript: function() {
          return write("nodescript");
        },
        _httpparser: function() {
          return write("httpparser");
        },
        _dataview: function() {
          return write("dataview");
        },
        _signal: function() {
          return write("signal");
        },
        _fsevent: function() {
          return write("fsevent");
        },
        _tlswrap: function() {
          return write("tlswrap");
        }
      };
    }
    function PassThrough() {
      return {
        buf: "",
        write: function(b) {
          this.buf += b;
        },
        end: function(b) {
          this.buf += b;
        },
        read: function() {
          return this.buf;
        }
      };
    }
  }
});

// node_modules/@raycast/utils/dist/useCachedPromise.js
var require_useCachedPromise = __commonJS({
  "node_modules/@raycast/utils/dist/useCachedPromise.js"(exports) {
    "use strict";
    var __importDefault = exports && exports.__importDefault || function(mod) {
      return mod && mod.__esModule ? mod : { "default": mod };
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useCachedPromise = void 0;
    var react_1 = require("react");
    var object_hash_1 = __importDefault(require_object_hash());
    var useCachedState_1 = require_useCachedState();
    var usePromise_1 = require_usePromise();
    var useLatest_1 = require_useLatest();
    var emptyCache = Symbol();
    function useCachedPromise(fn, args, options) {
      const { initialData, keepPreviousData, ...usePromiseOptions } = options || {};
      const lastUpdateFrom = (0, react_1.useRef)();
      const [cachedData, mutateCache] = (0, useCachedState_1.useCachedState)((0, object_hash_1.default)(args || []), emptyCache, {
        cacheNamespace: (0, object_hash_1.default)(fn)
      });
      const laggyDataRef = (0, react_1.useRef)(cachedData !== emptyCache ? cachedData : initialData);
      const {
        mutate: _mutate,
        revalidate,
        ...state
      } = (0, usePromise_1.usePromise)(fn, args || [], {
        ...usePromiseOptions,
        onData(data2) {
          if (usePromiseOptions.onData) {
            usePromiseOptions.onData(data2);
          }
          lastUpdateFrom.current = "promise";
          laggyDataRef.current = data2;
          mutateCache(data2);
        }
      });
      const data = cachedData !== emptyCache ? cachedData : initialData;
      const returnedData = lastUpdateFrom.current === "promise" ? laggyDataRef.current : keepPreviousData ? cachedData !== emptyCache ? cachedData : laggyDataRef.current : data;
      const latestData = (0, useLatest_1.useLatest)(returnedData);
      const mutate = (0, react_1.useCallback)(async (asyncUpdate, options2) => {
        let dataBeforeOptimisticUpdate;
        try {
          if (options2?.optimisticUpdate) {
            if (typeof options2?.rollbackOnError !== "function" && options2?.rollbackOnError !== false) {
              dataBeforeOptimisticUpdate = structuredClone(latestData.current);
            }
            const data2 = options2.optimisticUpdate(latestData.current);
            lastUpdateFrom.current = "cache";
            laggyDataRef.current = data2;
            mutateCache(data2);
          }
          return await _mutate(asyncUpdate, { shouldRevalidateAfter: options2?.shouldRevalidateAfter });
        } catch (err) {
          if (typeof options2?.rollbackOnError === "function") {
            const data2 = options2.rollbackOnError(latestData.current);
            lastUpdateFrom.current = "cache";
            laggyDataRef.current = data2;
            mutateCache(data2);
          } else if (options2?.optimisticUpdate && options2?.rollbackOnError !== false) {
            lastUpdateFrom.current = "cache";
            laggyDataRef.current = dataBeforeOptimisticUpdate;
            mutateCache(dataBeforeOptimisticUpdate);
          }
          throw err;
        }
      }, [mutateCache, _mutate, latestData, laggyDataRef, lastUpdateFrom]);
      (0, react_1.useEffect)(() => {
        if (cachedData !== emptyCache) {
          lastUpdateFrom.current = "cache";
          laggyDataRef.current = cachedData;
        }
      }, [cachedData]);
      return {
        data: returnedData,
        isLoading: state.isLoading,
        error: state.error,
        mutate,
        revalidate
      };
    }
    exports.useCachedPromise = useCachedPromise;
  }
});

// node_modules/media-typer/index.js
var require_media_typer = __commonJS({
  "node_modules/media-typer/index.js"(exports) {
    "use strict";
    var SUBTYPE_NAME_REGEXP = /^[A-Za-z0-9][A-Za-z0-9!#$&^_.-]{0,126}$/;
    var TYPE_NAME_REGEXP = /^[A-Za-z0-9][A-Za-z0-9!#$&^_-]{0,126}$/;
    var TYPE_REGEXP = /^ *([A-Za-z0-9][A-Za-z0-9!#$&^_-]{0,126})\/([A-Za-z0-9][A-Za-z0-9!#$&^_.+-]{0,126}) *$/;
    exports.format = format;
    exports.parse = parse;
    exports.test = test;
    function format(obj) {
      if (!obj || typeof obj !== "object") {
        throw new TypeError("argument obj is required");
      }
      var subtype = obj.subtype;
      var suffix = obj.suffix;
      var type = obj.type;
      if (!type || !TYPE_NAME_REGEXP.test(type)) {
        throw new TypeError("invalid type");
      }
      if (!subtype || !SUBTYPE_NAME_REGEXP.test(subtype)) {
        throw new TypeError("invalid subtype");
      }
      var string = type + "/" + subtype;
      if (suffix) {
        if (!TYPE_NAME_REGEXP.test(suffix)) {
          throw new TypeError("invalid suffix");
        }
        string += "+" + suffix;
      }
      return string;
    }
    function test(string) {
      if (!string) {
        throw new TypeError("argument string is required");
      }
      if (typeof string !== "string") {
        throw new TypeError("argument string is required to be a string");
      }
      return TYPE_REGEXP.test(string.toLowerCase());
    }
    function parse(string) {
      if (!string) {
        throw new TypeError("argument string is required");
      }
      if (typeof string !== "string") {
        throw new TypeError("argument string is required to be a string");
      }
      var match = TYPE_REGEXP.exec(string.toLowerCase());
      if (!match) {
        throw new TypeError("invalid media type");
      }
      var type = match[1];
      var subtype = match[2];
      var suffix;
      var index = subtype.lastIndexOf("+");
      if (index !== -1) {
        suffix = subtype.substr(index + 1);
        subtype = subtype.substr(0, index);
      }
      return new MediaType(type, subtype, suffix);
    }
    function MediaType(type, subtype, suffix) {
      this.type = type;
      this.subtype = subtype;
      this.suffix = suffix;
    }
  }
});

// node_modules/content-type/index.js
var require_content_type = __commonJS({
  "node_modules/content-type/index.js"(exports) {
    "use strict";
    var PARAM_REGEXP = /; *([!#$%&'*+.^_`|~0-9A-Za-z-]+) *= *("(?:[\u000b\u0020\u0021\u0023-\u005b\u005d-\u007e\u0080-\u00ff]|\\[\u000b\u0020-\u00ff])*"|[!#$%&'*+.^_`|~0-9A-Za-z-]+) */g;
    var TEXT_REGEXP = /^[\u000b\u0020-\u007e\u0080-\u00ff]+$/;
    var TOKEN_REGEXP = /^[!#$%&'*+.^_`|~0-9A-Za-z-]+$/;
    var QESC_REGEXP = /\\([\u000b\u0020-\u00ff])/g;
    var QUOTE_REGEXP = /([\\"])/g;
    var TYPE_REGEXP = /^[!#$%&'*+.^_`|~0-9A-Za-z-]+\/[!#$%&'*+.^_`|~0-9A-Za-z-]+$/;
    exports.format = format;
    exports.parse = parse;
    function format(obj) {
      if (!obj || typeof obj !== "object") {
        throw new TypeError("argument obj is required");
      }
      var parameters = obj.parameters;
      var type = obj.type;
      if (!type || !TYPE_REGEXP.test(type)) {
        throw new TypeError("invalid type");
      }
      var string = type;
      if (parameters && typeof parameters === "object") {
        var param;
        var params = Object.keys(parameters).sort();
        for (var i = 0; i < params.length; i++) {
          param = params[i];
          if (!TOKEN_REGEXP.test(param)) {
            throw new TypeError("invalid parameter name");
          }
          string += "; " + param + "=" + qstring(parameters[param]);
        }
      }
      return string;
    }
    function parse(string) {
      if (!string) {
        throw new TypeError("argument string is required");
      }
      var header = typeof string === "object" ? getcontenttype(string) : string;
      if (typeof header !== "string") {
        throw new TypeError("argument string is required to be a string");
      }
      var index = header.indexOf(";");
      var type = index !== -1 ? header.slice(0, index).trim() : header.trim();
      if (!TYPE_REGEXP.test(type)) {
        throw new TypeError("invalid media type");
      }
      var obj = new ContentType(type.toLowerCase());
      if (index !== -1) {
        var key;
        var match;
        var value;
        PARAM_REGEXP.lastIndex = index;
        while (match = PARAM_REGEXP.exec(header)) {
          if (match.index !== index) {
            throw new TypeError("invalid parameter format");
          }
          index += match[0].length;
          key = match[1].toLowerCase();
          value = match[2];
          if (value.charCodeAt(0) === 34) {
            value = value.slice(1, -1);
            if (value.indexOf("\\") !== -1) {
              value = value.replace(QESC_REGEXP, "$1");
            }
          }
          obj.parameters[key] = value;
        }
        if (index !== header.length) {
          throw new TypeError("invalid parameter format");
        }
      }
      return obj;
    }
    function getcontenttype(obj) {
      var header;
      if (typeof obj.getHeader === "function") {
        header = obj.getHeader("content-type");
      } else if (typeof obj.headers === "object") {
        header = obj.headers && obj.headers["content-type"];
      }
      if (typeof header !== "string") {
        throw new TypeError("content-type header is missing from object");
      }
      return header;
    }
    function qstring(val) {
      var str = String(val);
      if (TOKEN_REGEXP.test(str)) {
        return str;
      }
      if (str.length > 0 && !TEXT_REGEXP.test(str)) {
        throw new TypeError("invalid parameter value");
      }
      return '"' + str.replace(QUOTE_REGEXP, "\\$1") + '"';
    }
    function ContentType(type) {
      this.parameters = /* @__PURE__ */ Object.create(null);
      this.type = type;
    }
  }
});

// node_modules/webidl-conversions/lib/index.js
var require_lib = __commonJS({
  "node_modules/webidl-conversions/lib/index.js"(exports, module2) {
    "use strict";
    var conversions = {};
    module2.exports = conversions;
    function sign(x) {
      return x < 0 ? -1 : 1;
    }
    function evenRound(x) {
      if (x % 1 === 0.5 && (x & 1) === 0) {
        return Math.floor(x);
      } else {
        return Math.round(x);
      }
    }
    function createNumberConversion(bitLength, typeOpts) {
      if (!typeOpts.unsigned) {
        --bitLength;
      }
      const lowerBound = typeOpts.unsigned ? 0 : -Math.pow(2, bitLength);
      const upperBound = Math.pow(2, bitLength) - 1;
      const moduloVal = typeOpts.moduloBitLength ? Math.pow(2, typeOpts.moduloBitLength) : Math.pow(2, bitLength);
      const moduloBound = typeOpts.moduloBitLength ? Math.pow(2, typeOpts.moduloBitLength - 1) : Math.pow(2, bitLength - 1);
      return function(V, opts) {
        if (!opts)
          opts = {};
        let x = +V;
        if (opts.enforceRange) {
          if (!Number.isFinite(x)) {
            throw new TypeError("Argument is not a finite number");
          }
          x = sign(x) * Math.floor(Math.abs(x));
          if (x < lowerBound || x > upperBound) {
            throw new TypeError("Argument is not in byte range");
          }
          return x;
        }
        if (!isNaN(x) && opts.clamp) {
          x = evenRound(x);
          if (x < lowerBound)
            x = lowerBound;
          if (x > upperBound)
            x = upperBound;
          return x;
        }
        if (!Number.isFinite(x) || x === 0) {
          return 0;
        }
        x = sign(x) * Math.floor(Math.abs(x));
        x = x % moduloVal;
        if (!typeOpts.unsigned && x >= moduloBound) {
          return x - moduloVal;
        } else if (typeOpts.unsigned) {
          if (x < 0) {
            x += moduloVal;
          } else if (x === -0) {
            return 0;
          }
        }
        return x;
      };
    }
    conversions["void"] = function() {
      return void 0;
    };
    conversions["boolean"] = function(val) {
      return !!val;
    };
    conversions["byte"] = createNumberConversion(8, { unsigned: false });
    conversions["octet"] = createNumberConversion(8, { unsigned: true });
    conversions["short"] = createNumberConversion(16, { unsigned: false });
    conversions["unsigned short"] = createNumberConversion(16, { unsigned: true });
    conversions["long"] = createNumberConversion(32, { unsigned: false });
    conversions["unsigned long"] = createNumberConversion(32, { unsigned: true });
    conversions["long long"] = createNumberConversion(32, { unsigned: false, moduloBitLength: 64 });
    conversions["unsigned long long"] = createNumberConversion(32, { unsigned: true, moduloBitLength: 64 });
    conversions["double"] = function(V) {
      const x = +V;
      if (!Number.isFinite(x)) {
        throw new TypeError("Argument is not a finite floating-point value");
      }
      return x;
    };
    conversions["unrestricted double"] = function(V) {
      const x = +V;
      if (isNaN(x)) {
        throw new TypeError("Argument is NaN");
      }
      return x;
    };
    conversions["float"] = conversions["double"];
    conversions["unrestricted float"] = conversions["unrestricted double"];
    conversions["DOMString"] = function(V, opts) {
      if (!opts)
        opts = {};
      if (opts.treatNullAsEmptyString && V === null) {
        return "";
      }
      return String(V);
    };
    conversions["ByteString"] = function(V, opts) {
      const x = String(V);
      let c = void 0;
      for (let i = 0; (c = x.codePointAt(i)) !== void 0; ++i) {
        if (c > 255) {
          throw new TypeError("Argument is not a valid bytestring");
        }
      }
      return x;
    };
    conversions["USVString"] = function(V) {
      const S = String(V);
      const n = S.length;
      const U = [];
      for (let i = 0; i < n; ++i) {
        const c = S.charCodeAt(i);
        if (c < 55296 || c > 57343) {
          U.push(String.fromCodePoint(c));
        } else if (56320 <= c && c <= 57343) {
          U.push(String.fromCodePoint(65533));
        } else {
          if (i === n - 1) {
            U.push(String.fromCodePoint(65533));
          } else {
            const d = S.charCodeAt(i + 1);
            if (56320 <= d && d <= 57343) {
              const a = c & 1023;
              const b = d & 1023;
              U.push(String.fromCodePoint((2 << 15) + (2 << 9) * a + b));
              ++i;
            } else {
              U.push(String.fromCodePoint(65533));
            }
          }
        }
      }
      return U.join("");
    };
    conversions["Date"] = function(V, opts) {
      if (!(V instanceof Date)) {
        throw new TypeError("Argument is not a Date object");
      }
      if (isNaN(V)) {
        return void 0;
      }
      return V;
    };
    conversions["RegExp"] = function(V, opts) {
      if (!(V instanceof RegExp)) {
        V = new RegExp(V);
      }
      return V;
    };
  }
});

// node_modules/whatwg-url/lib/utils.js
var require_utils = __commonJS({
  "node_modules/whatwg-url/lib/utils.js"(exports, module2) {
    "use strict";
    module2.exports.mixin = function mixin(target, source) {
      const keys = Object.getOwnPropertyNames(source);
      for (let i = 0; i < keys.length; ++i) {
        Object.defineProperty(target, keys[i], Object.getOwnPropertyDescriptor(source, keys[i]));
      }
    };
    module2.exports.wrapperSymbol = Symbol("wrapper");
    module2.exports.implSymbol = Symbol("impl");
    module2.exports.wrapperForImpl = function(impl) {
      return impl[module2.exports.wrapperSymbol];
    };
    module2.exports.implForWrapper = function(wrapper) {
      return wrapper[module2.exports.implSymbol];
    };
  }
});

// node_modules/tr46/lib/mappingTable.json
var require_mappingTable = __commonJS({
  "node_modules/tr46/lib/mappingTable.json"(exports, module2) {
    module2.exports = [[[0, 44], "disallowed_STD3_valid"], [[45, 46], "valid"], [[47, 47], "disallowed_STD3_valid"], [[48, 57], "valid"], [[58, 64], "disallowed_STD3_valid"], [[65, 65], "mapped", [97]], [[66, 66], "mapped", [98]], [[67, 67], "mapped", [99]], [[68, 68], "mapped", [100]], [[69, 69], "mapped", [101]], [[70, 70], "mapped", [102]], [[71, 71], "mapped", [103]], [[72, 72], "mapped", [104]], [[73, 73], "mapped", [105]], [[74, 74], "mapped", [106]], [[75, 75], "mapped", [107]], [[76, 76], "mapped", [108]], [[77, 77], "mapped", [109]], [[78, 78], "mapped", [110]], [[79, 79], "mapped", [111]], [[80, 80], "mapped", [112]], [[81, 81], "mapped", [113]], [[82, 82], "mapped", [114]], [[83, 83], "mapped", [115]], [[84, 84], "mapped", [116]], [[85, 85], "mapped", [117]], [[86, 86], "mapped", [118]], [[87, 87], "mapped", [119]], [[88, 88], "mapped", [120]], [[89, 89], "mapped", [121]], [[90, 90], "mapped", [122]], [[91, 96], "disallowed_STD3_valid"], [[97, 122], "valid"], [[123, 127], "disallowed_STD3_valid"], [[128, 159], "disallowed"], [[160, 160], "disallowed_STD3_mapped", [32]], [[161, 167], "valid", [], "NV8"], [[168, 168], "disallowed_STD3_mapped", [32, 776]], [[169, 169], "valid", [], "NV8"], [[170, 170], "mapped", [97]], [[171, 172], "valid", [], "NV8"], [[173, 173], "ignored"], [[174, 174], "valid", [], "NV8"], [[175, 175], "disallowed_STD3_mapped", [32, 772]], [[176, 177], "valid", [], "NV8"], [[178, 178], "mapped", [50]], [[179, 179], "mapped", [51]], [[180, 180], "disallowed_STD3_mapped", [32, 769]], [[181, 181], "mapped", [956]], [[182, 182], "valid", [], "NV8"], [[183, 183], "valid"], [[184, 184], "disallowed_STD3_mapped", [32, 807]], [[185, 185], "mapped", [49]], [[186, 186], "mapped", [111]], [[187, 187], "valid", [], "NV8"], [[188, 188], "mapped", [49, 8260, 52]], [[189, 189], "mapped", [49, 8260, 50]], [[190, 190], "mapped", [51, 8260, 52]], [[191, 191], "valid", [], "NV8"], [[192, 192], "mapped", [224]], [[193, 193], "mapped", [225]], [[194, 194], "mapped", [226]], [[195, 195], "mapped", [227]], [[196, 196], "mapped", [228]], [[197, 197], "mapped", [229]], [[198, 198], "mapped", [230]], [[199, 199], "mapped", [231]], [[200, 200], "mapped", [232]], [[201, 201], "mapped", [233]], [[202, 202], "mapped", [234]], [[203, 203], "mapped", [235]], [[204, 204], "mapped", [236]], [[205, 205], "mapped", [237]], [[206, 206], "mapped", [238]], [[207, 207], "mapped", [239]], [[208, 208], "mapped", [240]], [[209, 209], "mapped", [241]], [[210, 210], "mapped", [242]], [[211, 211], "mapped", [243]], [[212, 212], "mapped", [244]], [[213, 213], "mapped", [245]], [[214, 214], "mapped", [246]], [[215, 215], "valid", [], "NV8"], [[216, 216], "mapped", [248]], [[217, 217], "mapped", [249]], [[218, 218], "mapped", [250]], [[219, 219], "mapped", [251]], [[220, 220], "mapped", [252]], [[221, 221], "mapped", [253]], [[222, 222], "mapped", [254]], [[223, 223], "deviation", [115, 115]], [[224, 246], "valid"], [[247, 247], "valid", [], "NV8"], [[248, 255], "valid"], [[256, 256], "mapped", [257]], [[257, 257], "valid"], [[258, 258], "mapped", [259]], [[259, 259], "valid"], [[260, 260], "mapped", [261]], [[261, 261], "valid"], [[262, 262], "mapped", [263]], [[263, 263], "valid"], [[264, 264], "mapped", [265]], [[265, 265], "valid"], [[266, 266], "mapped", [267]], [[267, 267], "valid"], [[268, 268], "mapped", [269]], [[269, 269], "valid"], [[270, 270], "mapped", [271]], [[271, 271], "valid"], [[272, 272], "mapped", [273]], [[273, 273], "valid"], [[274, 274], "mapped", [275]], [[275, 275], "valid"], [[276, 276], "mapped", [277]], [[277, 277], "valid"], [[278, 278], "mapped", [279]], [[279, 279], "valid"], [[280, 280], "mapped", [281]], [[281, 281], "valid"], [[282, 282], "mapped", [283]], [[283, 283], "valid"], [[284, 284], "mapped", [285]], [[285, 285], "valid"], [[286, 286], "mapped", [287]], [[287, 287], "valid"], [[288, 288], "mapped", [289]], [[289, 289], "valid"], [[290, 290], "mapped", [291]], [[291, 291], "valid"], [[292, 292], "mapped", [293]], [[293, 293], "valid"], [[294, 294], "mapped", [295]], [[295, 295], "valid"], [[296, 296], "mapped", [297]], [[297, 297], "valid"], [[298, 298], "mapped", [299]], [[299, 299], "valid"], [[300, 300], "mapped", [301]], [[301, 301], "valid"], [[302, 302], "mapped", [303]], [[303, 303], "valid"], [[304, 304], "mapped", [105, 775]], [[305, 305], "valid"], [[306, 307], "mapped", [105, 106]], [[308, 308], "mapped", [309]], [[309, 309], "valid"], [[310, 310], "mapped", [311]], [[311, 312], "valid"], [[313, 313], "mapped", [314]], [[314, 314], "valid"], [[315, 315], "mapped", [316]], [[316, 316], "valid"], [[317, 317], "mapped", [318]], [[318, 318], "valid"], [[319, 320], "mapped", [108, 183]], [[321, 321], "mapped", [322]], [[322, 322], "valid"], [[323, 323], "mapped", [324]], [[324, 324], "valid"], [[325, 325], "mapped", [326]], [[326, 326], "valid"], [[327, 327], "mapped", [328]], [[328, 328], "valid"], [[329, 329], "mapped", [700, 110]], [[330, 330], "mapped", [331]], [[331, 331], "valid"], [[332, 332], "mapped", [333]], [[333, 333], "valid"], [[334, 334], "mapped", [335]], [[335, 335], "valid"], [[336, 336], "mapped", [337]], [[337, 337], "valid"], [[338, 338], "mapped", [339]], [[339, 339], "valid"], [[340, 340], "mapped", [341]], [[341, 341], "valid"], [[342, 342], "mapped", [343]], [[343, 343], "valid"], [[344, 344], "mapped", [345]], [[345, 345], "valid"], [[346, 346], "mapped", [347]], [[347, 347], "valid"], [[348, 348], "mapped", [349]], [[349, 349], "valid"], [[350, 350], "mapped", [351]], [[351, 351], "valid"], [[352, 352], "mapped", [353]], [[353, 353], "valid"], [[354, 354], "mapped", [355]], [[355, 355], "valid"], [[356, 356], "mapped", [357]], [[357, 357], "valid"], [[358, 358], "mapped", [359]], [[359, 359], "valid"], [[360, 360], "mapped", [361]], [[361, 361], "valid"], [[362, 362], "mapped", [363]], [[363, 363], "valid"], [[364, 364], "mapped", [365]], [[365, 365], "valid"], [[366, 366], "mapped", [367]], [[367, 367], "valid"], [[368, 368], "mapped", [369]], [[369, 369], "valid"], [[370, 370], "mapped", [371]], [[371, 371], "valid"], [[372, 372], "mapped", [373]], [[373, 373], "valid"], [[374, 374], "mapped", [375]], [[375, 375], "valid"], [[376, 376], "mapped", [255]], [[377, 377], "mapped", [378]], [[378, 378], "valid"], [[379, 379], "mapped", [380]], [[380, 380], "valid"], [[381, 381], "mapped", [382]], [[382, 382], "valid"], [[383, 383], "mapped", [115]], [[384, 384], "valid"], [[385, 385], "mapped", [595]], [[386, 386], "mapped", [387]], [[387, 387], "valid"], [[388, 388], "mapped", [389]], [[389, 389], "valid"], [[390, 390], "mapped", [596]], [[391, 391], "mapped", [392]], [[392, 392], "valid"], [[393, 393], "mapped", [598]], [[394, 394], "mapped", [599]], [[395, 395], "mapped", [396]], [[396, 397], "valid"], [[398, 398], "mapped", [477]], [[399, 399], "mapped", [601]], [[400, 400], "mapped", [603]], [[401, 401], "mapped", [402]], [[402, 402], "valid"], [[403, 403], "mapped", [608]], [[404, 404], "mapped", [611]], [[405, 405], "valid"], [[406, 406], "mapped", [617]], [[407, 407], "mapped", [616]], [[408, 408], "mapped", [409]], [[409, 411], "valid"], [[412, 412], "mapped", [623]], [[413, 413], "mapped", [626]], [[414, 414], "valid"], [[415, 415], "mapped", [629]], [[416, 416], "mapped", [417]], [[417, 417], "valid"], [[418, 418], "mapped", [419]], [[419, 419], "valid"], [[420, 420], "mapped", [421]], [[421, 421], "valid"], [[422, 422], "mapped", [640]], [[423, 423], "mapped", [424]], [[424, 424], "valid"], [[425, 425], "mapped", [643]], [[426, 427], "valid"], [[428, 428], "mapped", [429]], [[429, 429], "valid"], [[430, 430], "mapped", [648]], [[431, 431], "mapped", [432]], [[432, 432], "valid"], [[433, 433], "mapped", [650]], [[434, 434], "mapped", [651]], [[435, 435], "mapped", [436]], [[436, 436], "valid"], [[437, 437], "mapped", [438]], [[438, 438], "valid"], [[439, 439], "mapped", [658]], [[440, 440], "mapped", [441]], [[441, 443], "valid"], [[444, 444], "mapped", [445]], [[445, 451], "valid"], [[452, 454], "mapped", [100, 382]], [[455, 457], "mapped", [108, 106]], [[458, 460], "mapped", [110, 106]], [[461, 461], "mapped", [462]], [[462, 462], "valid"], [[463, 463], "mapped", [464]], [[464, 464], "valid"], [[465, 465], "mapped", [466]], [[466, 466], "valid"], [[467, 467], "mapped", [468]], [[468, 468], "valid"], [[469, 469], "mapped", [470]], [[470, 470], "valid"], [[471, 471], "mapped", [472]], [[472, 472], "valid"], [[473, 473], "mapped", [474]], [[474, 474], "valid"], [[475, 475], "mapped", [476]], [[476, 477], "valid"], [[478, 478], "mapped", [479]], [[479, 479], "valid"], [[480, 480], "mapped", [481]], [[481, 481], "valid"], [[482, 482], "mapped", [483]], [[483, 483], "valid"], [[484, 484], "mapped", [485]], [[485, 485], "valid"], [[486, 486], "mapped", [487]], [[487, 487], "valid"], [[488, 488], "mapped", [489]], [[489, 489], "valid"], [[490, 490], "mapped", [491]], [[491, 491], "valid"], [[492, 492], "mapped", [493]], [[493, 493], "valid"], [[494, 494], "mapped", [495]], [[495, 496], "valid"], [[497, 499], "mapped", [100, 122]], [[500, 500], "mapped", [501]], [[501, 501], "valid"], [[502, 502], "mapped", [405]], [[503, 503], "mapped", [447]], [[504, 504], "mapped", [505]], [[505, 505], "valid"], [[506, 506], "mapped", [507]], [[507, 507], "valid"], [[508, 508], "mapped", [509]], [[509, 509], "valid"], [[510, 510], "mapped", [511]], [[511, 511], "valid"], [[512, 512], "mapped", [513]], [[513, 513], "valid"], [[514, 514], "mapped", [515]], [[515, 515], "valid"], [[516, 516], "mapped", [517]], [[517, 517], "valid"], [[518, 518], "mapped", [519]], [[519, 519], "valid"], [[520, 520], "mapped", [521]], [[521, 521], "valid"], [[522, 522], "mapped", [523]], [[523, 523], "valid"], [[524, 524], "mapped", [525]], [[525, 525], "valid"], [[526, 526], "mapped", [527]], [[527, 527], "valid"], [[528, 528], "mapped", [529]], [[529, 529], "valid"], [[530, 530], "mapped", [531]], [[531, 531], "valid"], [[532, 532], "mapped", [533]], [[533, 533], "valid"], [[534, 534], "mapped", [535]], [[535, 535], "valid"], [[536, 536], "mapped", [537]], [[537, 537], "valid"], [[538, 538], "mapped", [539]], [[539, 539], "valid"], [[540, 540], "mapped", [541]], [[541, 541], "valid"], [[542, 542], "mapped", [543]], [[543, 543], "valid"], [[544, 544], "mapped", [414]], [[545, 545], "valid"], [[546, 546], "mapped", [547]], [[547, 547], "valid"], [[548, 548], "mapped", [549]], [[549, 549], "valid"], [[550, 550], "mapped", [551]], [[551, 551], "valid"], [[552, 552], "mapped", [553]], [[553, 553], "valid"], [[554, 554], "mapped", [555]], [[555, 555], "valid"], [[556, 556], "mapped", [557]], [[557, 557], "valid"], [[558, 558], "mapped", [559]], [[559, 559], "valid"], [[560, 560], "mapped", [561]], [[561, 561], "valid"], [[562, 562], "mapped", [563]], [[563, 563], "valid"], [[564, 566], "valid"], [[567, 569], "valid"], [[570, 570], "mapped", [11365]], [[571, 571], "mapped", [572]], [[572, 572], "valid"], [[573, 573], "mapped", [410]], [[574, 574], "mapped", [11366]], [[575, 576], "valid"], [[577, 577], "mapped", [578]], [[578, 578], "valid"], [[579, 579], "mapped", [384]], [[580, 580], "mapped", [649]], [[581, 581], "mapped", [652]], [[582, 582], "mapped", [583]], [[583, 583], "valid"], [[584, 584], "mapped", [585]], [[585, 585], "valid"], [[586, 586], "mapped", [587]], [[587, 587], "valid"], [[588, 588], "mapped", [589]], [[589, 589], "valid"], [[590, 590], "mapped", [591]], [[591, 591], "valid"], [[592, 680], "valid"], [[681, 685], "valid"], [[686, 687], "valid"], [[688, 688], "mapped", [104]], [[689, 689], "mapped", [614]], [[690, 690], "mapped", [106]], [[691, 691], "mapped", [114]], [[692, 692], "mapped", [633]], [[693, 693], "mapped", [635]], [[694, 694], "mapped", [641]], [[695, 695], "mapped", [119]], [[696, 696], "mapped", [121]], [[697, 705], "valid"], [[706, 709], "valid", [], "NV8"], [[710, 721], "valid"], [[722, 727], "valid", [], "NV8"], [[728, 728], "disallowed_STD3_mapped", [32, 774]], [[729, 729], "disallowed_STD3_mapped", [32, 775]], [[730, 730], "disallowed_STD3_mapped", [32, 778]], [[731, 731], "disallowed_STD3_mapped", [32, 808]], [[732, 732], "disallowed_STD3_mapped", [32, 771]], [[733, 733], "disallowed_STD3_mapped", [32, 779]], [[734, 734], "valid", [], "NV8"], [[735, 735], "valid", [], "NV8"], [[736, 736], "mapped", [611]], [[737, 737], "mapped", [108]], [[738, 738], "mapped", [115]], [[739, 739], "mapped", [120]], [[740, 740], "mapped", [661]], [[741, 745], "valid", [], "NV8"], [[746, 747], "valid", [], "NV8"], [[748, 748], "valid"], [[749, 749], "valid", [], "NV8"], [[750, 750], "valid"], [[751, 767], "valid", [], "NV8"], [[768, 831], "valid"], [[832, 832], "mapped", [768]], [[833, 833], "mapped", [769]], [[834, 834], "valid"], [[835, 835], "mapped", [787]], [[836, 836], "mapped", [776, 769]], [[837, 837], "mapped", [953]], [[838, 846], "valid"], [[847, 847], "ignored"], [[848, 855], "valid"], [[856, 860], "valid"], [[861, 863], "valid"], [[864, 865], "valid"], [[866, 866], "valid"], [[867, 879], "valid"], [[880, 880], "mapped", [881]], [[881, 881], "valid"], [[882, 882], "mapped", [883]], [[883, 883], "valid"], [[884, 884], "mapped", [697]], [[885, 885], "valid"], [[886, 886], "mapped", [887]], [[887, 887], "valid"], [[888, 889], "disallowed"], [[890, 890], "disallowed_STD3_mapped", [32, 953]], [[891, 893], "valid"], [[894, 894], "disallowed_STD3_mapped", [59]], [[895, 895], "mapped", [1011]], [[896, 899], "disallowed"], [[900, 900], "disallowed_STD3_mapped", [32, 769]], [[901, 901], "disallowed_STD3_mapped", [32, 776, 769]], [[902, 902], "mapped", [940]], [[903, 903], "mapped", [183]], [[904, 904], "mapped", [941]], [[905, 905], "mapped", [942]], [[906, 906], "mapped", [943]], [[907, 907], "disallowed"], [[908, 908], "mapped", [972]], [[909, 909], "disallowed"], [[910, 910], "mapped", [973]], [[911, 911], "mapped", [974]], [[912, 912], "valid"], [[913, 913], "mapped", [945]], [[914, 914], "mapped", [946]], [[915, 915], "mapped", [947]], [[916, 916], "mapped", [948]], [[917, 917], "mapped", [949]], [[918, 918], "mapped", [950]], [[919, 919], "mapped", [951]], [[920, 920], "mapped", [952]], [[921, 921], "mapped", [953]], [[922, 922], "mapped", [954]], [[923, 923], "mapped", [955]], [[924, 924], "mapped", [956]], [[925, 925], "mapped", [957]], [[926, 926], "mapped", [958]], [[927, 927], "mapped", [959]], [[928, 928], "mapped", [960]], [[929, 929], "mapped", [961]], [[930, 930], "disallowed"], [[931, 931], "mapped", [963]], [[932, 932], "mapped", [964]], [[933, 933], "mapped", [965]], [[934, 934], "mapped", [966]], [[935, 935], "mapped", [967]], [[936, 936], "mapped", [968]], [[937, 937], "mapped", [969]], [[938, 938], "mapped", [970]], [[939, 939], "mapped", [971]], [[940, 961], "valid"], [[962, 962], "deviation", [963]], [[963, 974], "valid"], [[975, 975], "mapped", [983]], [[976, 976], "mapped", [946]], [[977, 977], "mapped", [952]], [[978, 978], "mapped", [965]], [[979, 979], "mapped", [973]], [[980, 980], "mapped", [971]], [[981, 981], "mapped", [966]], [[982, 982], "mapped", [960]], [[983, 983], "valid"], [[984, 984], "mapped", [985]], [[985, 985], "valid"], [[986, 986], "mapped", [987]], [[987, 987], "valid"], [[988, 988], "mapped", [989]], [[989, 989], "valid"], [[990, 990], "mapped", [991]], [[991, 991], "valid"], [[992, 992], "mapped", [993]], [[993, 993], "valid"], [[994, 994], "mapped", [995]], [[995, 995], "valid"], [[996, 996], "mapped", [997]], [[997, 997], "valid"], [[998, 998], "mapped", [999]], [[999, 999], "valid"], [[1e3, 1e3], "mapped", [1001]], [[1001, 1001], "valid"], [[1002, 1002], "mapped", [1003]], [[1003, 1003], "valid"], [[1004, 1004], "mapped", [1005]], [[1005, 1005], "valid"], [[1006, 1006], "mapped", [1007]], [[1007, 1007], "valid"], [[1008, 1008], "mapped", [954]], [[1009, 1009], "mapped", [961]], [[1010, 1010], "mapped", [963]], [[1011, 1011], "valid"], [[1012, 1012], "mapped", [952]], [[1013, 1013], "mapped", [949]], [[1014, 1014], "valid", [], "NV8"], [[1015, 1015], "mapped", [1016]], [[1016, 1016], "valid"], [[1017, 1017], "mapped", [963]], [[1018, 1018], "mapped", [1019]], [[1019, 1019], "valid"], [[1020, 1020], "valid"], [[1021, 1021], "mapped", [891]], [[1022, 1022], "mapped", [892]], [[1023, 1023], "mapped", [893]], [[1024, 1024], "mapped", [1104]], [[1025, 1025], "mapped", [1105]], [[1026, 1026], "mapped", [1106]], [[1027, 1027], "mapped", [1107]], [[1028, 1028], "mapped", [1108]], [[1029, 1029], "mapped", [1109]], [[1030, 1030], "mapped", [1110]], [[1031, 1031], "mapped", [1111]], [[1032, 1032], "mapped", [1112]], [[1033, 1033], "mapped", [1113]], [[1034, 1034], "mapped", [1114]], [[1035, 1035], "mapped", [1115]], [[1036, 1036], "mapped", [1116]], [[1037, 1037], "mapped", [1117]], [[1038, 1038], "mapped", [1118]], [[1039, 1039], "mapped", [1119]], [[1040, 1040], "mapped", [1072]], [[1041, 1041], "mapped", [1073]], [[1042, 1042], "mapped", [1074]], [[1043, 1043], "mapped", [1075]], [[1044, 1044], "mapped", [1076]], [[1045, 1045], "mapped", [1077]], [[1046, 1046], "mapped", [1078]], [[1047, 1047], "mapped", [1079]], [[1048, 1048], "mapped", [1080]], [[1049, 1049], "mapped", [1081]], [[1050, 1050], "mapped", [1082]], [[1051, 1051], "mapped", [1083]], [[1052, 1052], "mapped", [1084]], [[1053, 1053], "mapped", [1085]], [[1054, 1054], "mapped", [1086]], [[1055, 1055], "mapped", [1087]], [[1056, 1056], "mapped", [1088]], [[1057, 1057], "mapped", [1089]], [[1058, 1058], "mapped", [1090]], [[1059, 1059], "mapped", [1091]], [[1060, 1060], "mapped", [1092]], [[1061, 1061], "mapped", [1093]], [[1062, 1062], "mapped", [1094]], [[1063, 1063], "mapped", [1095]], [[1064, 1064], "mapped", [1096]], [[1065, 1065], "mapped", [1097]], [[1066, 1066], "mapped", [1098]], [[1067, 1067], "mapped", [1099]], [[1068, 1068], "mapped", [1100]], [[1069, 1069], "mapped", [1101]], [[1070, 1070], "mapped", [1102]], [[1071, 1071], "mapped", [1103]], [[1072, 1103], "valid"], [[1104, 1104], "valid"], [[1105, 1116], "valid"], [[1117, 1117], "valid"], [[1118, 1119], "valid"], [[1120, 1120], "mapped", [1121]], [[1121, 1121], "valid"], [[1122, 1122], "mapped", [1123]], [[1123, 1123], "valid"], [[1124, 1124], "mapped", [1125]], [[1125, 1125], "valid"], [[1126, 1126], "mapped", [1127]], [[1127, 1127], "valid"], [[1128, 1128], "mapped", [1129]], [[1129, 1129], "valid"], [[1130, 1130], "mapped", [1131]], [[1131, 1131], "valid"], [[1132, 1132], "mapped", [1133]], [[1133, 1133], "valid"], [[1134, 1134], "mapped", [1135]], [[1135, 1135], "valid"], [[1136, 1136], "mapped", [1137]], [[1137, 1137], "valid"], [[1138, 1138], "mapped", [1139]], [[1139, 1139], "valid"], [[1140, 1140], "mapped", [1141]], [[1141, 1141], "valid"], [[1142, 1142], "mapped", [1143]], [[1143, 1143], "valid"], [[1144, 1144], "mapped", [1145]], [[1145, 1145], "valid"], [[1146, 1146], "mapped", [1147]], [[1147, 1147], "valid"], [[1148, 1148], "mapped", [1149]], [[1149, 1149], "valid"], [[1150, 1150], "mapped", [1151]], [[1151, 1151], "valid"], [[1152, 1152], "mapped", [1153]], [[1153, 1153], "valid"], [[1154, 1154], "valid", [], "NV8"], [[1155, 1158], "valid"], [[1159, 1159], "valid"], [[1160, 1161], "valid", [], "NV8"], [[1162, 1162], "mapped", [1163]], [[1163, 1163], "valid"], [[1164, 1164], "mapped", [1165]], [[1165, 1165], "valid"], [[1166, 1166], "mapped", [1167]], [[1167, 1167], "valid"], [[1168, 1168], "mapped", [1169]], [[1169, 1169], "valid"], [[1170, 1170], "mapped", [1171]], [[1171, 1171], "valid"], [[1172, 1172], "mapped", [1173]], [[1173, 1173], "valid"], [[1174, 1174], "mapped", [1175]], [[1175, 1175], "valid"], [[1176, 1176], "mapped", [1177]], [[1177, 1177], "valid"], [[1178, 1178], "mapped", [1179]], [[1179, 1179], "valid"], [[1180, 1180], "mapped", [1181]], [[1181, 1181], "valid"], [[1182, 1182], "mapped", [1183]], [[1183, 1183], "valid"], [[1184, 1184], "mapped", [1185]], [[1185, 1185], "valid"], [[1186, 1186], "mapped", [1187]], [[1187, 1187], "valid"], [[1188, 1188], "mapped", [1189]], [[1189, 1189], "valid"], [[1190, 1190], "mapped", [1191]], [[1191, 1191], "valid"], [[1192, 1192], "mapped", [1193]], [[1193, 1193], "valid"], [[1194, 1194], "mapped", [1195]], [[1195, 1195], "valid"], [[1196, 1196], "mapped", [1197]], [[1197, 1197], "valid"], [[1198, 1198], "mapped", [1199]], [[1199, 1199], "valid"], [[1200, 1200], "mapped", [1201]], [[1201, 1201], "valid"], [[1202, 1202], "mapped", [1203]], [[1203, 1203], "valid"], [[1204, 1204], "mapped", [1205]], [[1205, 1205], "valid"], [[1206, 1206], "mapped", [1207]], [[1207, 1207], "valid"], [[1208, 1208], "mapped", [1209]], [[1209, 1209], "valid"], [[1210, 1210], "mapped", [1211]], [[1211, 1211], "valid"], [[1212, 1212], "mapped", [1213]], [[1213, 1213], "valid"], [[1214, 1214], "mapped", [1215]], [[1215, 1215], "valid"], [[1216, 1216], "disallowed"], [[1217, 1217], "mapped", [1218]], [[1218, 1218], "valid"], [[1219, 1219], "mapped", [1220]], [[1220, 1220], "valid"], [[1221, 1221], "mapped", [1222]], [[1222, 1222], "valid"], [[1223, 1223], "mapped", [1224]], [[1224, 1224], "valid"], [[1225, 1225], "mapped", [1226]], [[1226, 1226], "valid"], [[1227, 1227], "mapped", [1228]], [[1228, 1228], "valid"], [[1229, 1229], "mapped", [1230]], [[1230, 1230], "valid"], [[1231, 1231], "valid"], [[1232, 1232], "mapped", [1233]], [[1233, 1233], "valid"], [[1234, 1234], "mapped", [1235]], [[1235, 1235], "valid"], [[1236, 1236], "mapped", [1237]], [[1237, 1237], "valid"], [[1238, 1238], "mapped", [1239]], [[1239, 1239], "valid"], [[1240, 1240], "mapped", [1241]], [[1241, 1241], "valid"], [[1242, 1242], "mapped", [1243]], [[1243, 1243], "valid"], [[1244, 1244], "mapped", [1245]], [[1245, 1245], "valid"], [[1246, 1246], "mapped", [1247]], [[1247, 1247], "valid"], [[1248, 1248], "mapped", [1249]], [[1249, 1249], "valid"], [[1250, 1250], "mapped", [1251]], [[1251, 1251], "valid"], [[1252, 1252], "mapped", [1253]], [[1253, 1253], "valid"], [[1254, 1254], "mapped", [1255]], [[1255, 1255], "valid"], [[1256, 1256], "mapped", [1257]], [[1257, 1257], "valid"], [[1258, 1258], "mapped", [1259]], [[1259, 1259], "valid"], [[1260, 1260], "mapped", [1261]], [[1261, 1261], "valid"], [[1262, 1262], "mapped", [1263]], [[1263, 1263], "valid"], [[1264, 1264], "mapped", [1265]], [[1265, 1265], "valid"], [[1266, 1266], "mapped", [1267]], [[1267, 1267], "valid"], [[1268, 1268], "mapped", [1269]], [[1269, 1269], "valid"], [[1270, 1270], "mapped", [1271]], [[1271, 1271], "valid"], [[1272, 1272], "mapped", [1273]], [[1273, 1273], "valid"], [[1274, 1274], "mapped", [1275]], [[1275, 1275], "valid"], [[1276, 1276], "mapped", [1277]], [[1277, 1277], "valid"], [[1278, 1278], "mapped", [1279]], [[1279, 1279], "valid"], [[1280, 1280], "mapped", [1281]], [[1281, 1281], "valid"], [[1282, 1282], "mapped", [1283]], [[1283, 1283], "valid"], [[1284, 1284], "mapped", [1285]], [[1285, 1285], "valid"], [[1286, 1286], "mapped", [1287]], [[1287, 1287], "valid"], [[1288, 1288], "mapped", [1289]], [[1289, 1289], "valid"], [[1290, 1290], "mapped", [1291]], [[1291, 1291], "valid"], [[1292, 1292], "mapped", [1293]], [[1293, 1293], "valid"], [[1294, 1294], "mapped", [1295]], [[1295, 1295], "valid"], [[1296, 1296], "mapped", [1297]], [[1297, 1297], "valid"], [[1298, 1298], "mapped", [1299]], [[1299, 1299], "valid"], [[1300, 1300], "mapped", [1301]], [[1301, 1301], "valid"], [[1302, 1302], "mapped", [1303]], [[1303, 1303], "valid"], [[1304, 1304], "mapped", [1305]], [[1305, 1305], "valid"], [[1306, 1306], "mapped", [1307]], [[1307, 1307], "valid"], [[1308, 1308], "mapped", [1309]], [[1309, 1309], "valid"], [[1310, 1310], "mapped", [1311]], [[1311, 1311], "valid"], [[1312, 1312], "mapped", [1313]], [[1313, 1313], "valid"], [[1314, 1314], "mapped", [1315]], [[1315, 1315], "valid"], [[1316, 1316], "mapped", [1317]], [[1317, 1317], "valid"], [[1318, 1318], "mapped", [1319]], [[1319, 1319], "valid"], [[1320, 1320], "mapped", [1321]], [[1321, 1321], "valid"], [[1322, 1322], "mapped", [1323]], [[1323, 1323], "valid"], [[1324, 1324], "mapped", [1325]], [[1325, 1325], "valid"], [[1326, 1326], "mapped", [1327]], [[1327, 1327], "valid"], [[1328, 1328], "disallowed"], [[1329, 1329], "mapped", [1377]], [[1330, 1330], "mapped", [1378]], [[1331, 1331], "mapped", [1379]], [[1332, 1332], "mapped", [1380]], [[1333, 1333], "mapped", [1381]], [[1334, 1334], "mapped", [1382]], [[1335, 1335], "mapped", [1383]], [[1336, 1336], "mapped", [1384]], [[1337, 1337], "mapped", [1385]], [[1338, 1338], "mapped", [1386]], [[1339, 1339], "mapped", [1387]], [[1340, 1340], "mapped", [1388]], [[1341, 1341], "mapped", [1389]], [[1342, 1342], "mapped", [1390]], [[1343, 1343], "mapped", [1391]], [[1344, 1344], "mapped", [1392]], [[1345, 1345], "mapped", [1393]], [[1346, 1346], "mapped", [1394]], [[1347, 1347], "mapped", [1395]], [[1348, 1348], "mapped", [1396]], [[1349, 1349], "mapped", [1397]], [[1350, 1350], "mapped", [1398]], [[1351, 1351], "mapped", [1399]], [[1352, 1352], "mapped", [1400]], [[1353, 1353], "mapped", [1401]], [[1354, 1354], "mapped", [1402]], [[1355, 1355], "mapped", [1403]], [[1356, 1356], "mapped", [1404]], [[1357, 1357], "mapped", [1405]], [[1358, 1358], "mapped", [1406]], [[1359, 1359], "mapped", [1407]], [[1360, 1360], "mapped", [1408]], [[1361, 1361], "mapped", [1409]], [[1362, 1362], "mapped", [1410]], [[1363, 1363], "mapped", [1411]], [[1364, 1364], "mapped", [1412]], [[1365, 1365], "mapped", [1413]], [[1366, 1366], "mapped", [1414]], [[1367, 1368], "disallowed"], [[1369, 1369], "valid"], [[1370, 1375], "valid", [], "NV8"], [[1376, 1376], "disallowed"], [[1377, 1414], "valid"], [[1415, 1415], "mapped", [1381, 1410]], [[1416, 1416], "disallowed"], [[1417, 1417], "valid", [], "NV8"], [[1418, 1418], "valid", [], "NV8"], [[1419, 1420], "disallowed"], [[1421, 1422], "valid", [], "NV8"], [[1423, 1423], "valid", [], "NV8"], [[1424, 1424], "disallowed"], [[1425, 1441], "valid"], [[1442, 1442], "valid"], [[1443, 1455], "valid"], [[1456, 1465], "valid"], [[1466, 1466], "valid"], [[1467, 1469], "valid"], [[1470, 1470], "valid", [], "NV8"], [[1471, 1471], "valid"], [[1472, 1472], "valid", [], "NV8"], [[1473, 1474], "valid"], [[1475, 1475], "valid", [], "NV8"], [[1476, 1476], "valid"], [[1477, 1477], "valid"], [[1478, 1478], "valid", [], "NV8"], [[1479, 1479], "valid"], [[1480, 1487], "disallowed"], [[1488, 1514], "valid"], [[1515, 1519], "disallowed"], [[1520, 1524], "valid"], [[1525, 1535], "disallowed"], [[1536, 1539], "disallowed"], [[1540, 1540], "disallowed"], [[1541, 1541], "disallowed"], [[1542, 1546], "valid", [], "NV8"], [[1547, 1547], "valid", [], "NV8"], [[1548, 1548], "valid", [], "NV8"], [[1549, 1551], "valid", [], "NV8"], [[1552, 1557], "valid"], [[1558, 1562], "valid"], [[1563, 1563], "valid", [], "NV8"], [[1564, 1564], "disallowed"], [[1565, 1565], "disallowed"], [[1566, 1566], "valid", [], "NV8"], [[1567, 1567], "valid", [], "NV8"], [[1568, 1568], "valid"], [[1569, 1594], "valid"], [[1595, 1599], "valid"], [[1600, 1600], "valid", [], "NV8"], [[1601, 1618], "valid"], [[1619, 1621], "valid"], [[1622, 1624], "valid"], [[1625, 1630], "valid"], [[1631, 1631], "valid"], [[1632, 1641], "valid"], [[1642, 1645], "valid", [], "NV8"], [[1646, 1647], "valid"], [[1648, 1652], "valid"], [[1653, 1653], "mapped", [1575, 1652]], [[1654, 1654], "mapped", [1608, 1652]], [[1655, 1655], "mapped", [1735, 1652]], [[1656, 1656], "mapped", [1610, 1652]], [[1657, 1719], "valid"], [[1720, 1721], "valid"], [[1722, 1726], "valid"], [[1727, 1727], "valid"], [[1728, 1742], "valid"], [[1743, 1743], "valid"], [[1744, 1747], "valid"], [[1748, 1748], "valid", [], "NV8"], [[1749, 1756], "valid"], [[1757, 1757], "disallowed"], [[1758, 1758], "valid", [], "NV8"], [[1759, 1768], "valid"], [[1769, 1769], "valid", [], "NV8"], [[1770, 1773], "valid"], [[1774, 1775], "valid"], [[1776, 1785], "valid"], [[1786, 1790], "valid"], [[1791, 1791], "valid"], [[1792, 1805], "valid", [], "NV8"], [[1806, 1806], "disallowed"], [[1807, 1807], "disallowed"], [[1808, 1836], "valid"], [[1837, 1839], "valid"], [[1840, 1866], "valid"], [[1867, 1868], "disallowed"], [[1869, 1871], "valid"], [[1872, 1901], "valid"], [[1902, 1919], "valid"], [[1920, 1968], "valid"], [[1969, 1969], "valid"], [[1970, 1983], "disallowed"], [[1984, 2037], "valid"], [[2038, 2042], "valid", [], "NV8"], [[2043, 2047], "disallowed"], [[2048, 2093], "valid"], [[2094, 2095], "disallowed"], [[2096, 2110], "valid", [], "NV8"], [[2111, 2111], "disallowed"], [[2112, 2139], "valid"], [[2140, 2141], "disallowed"], [[2142, 2142], "valid", [], "NV8"], [[2143, 2207], "disallowed"], [[2208, 2208], "valid"], [[2209, 2209], "valid"], [[2210, 2220], "valid"], [[2221, 2226], "valid"], [[2227, 2228], "valid"], [[2229, 2274], "disallowed"], [[2275, 2275], "valid"], [[2276, 2302], "valid"], [[2303, 2303], "valid"], [[2304, 2304], "valid"], [[2305, 2307], "valid"], [[2308, 2308], "valid"], [[2309, 2361], "valid"], [[2362, 2363], "valid"], [[2364, 2381], "valid"], [[2382, 2382], "valid"], [[2383, 2383], "valid"], [[2384, 2388], "valid"], [[2389, 2389], "valid"], [[2390, 2391], "valid"], [[2392, 2392], "mapped", [2325, 2364]], [[2393, 2393], "mapped", [2326, 2364]], [[2394, 2394], "mapped", [2327, 2364]], [[2395, 2395], "mapped", [2332, 2364]], [[2396, 2396], "mapped", [2337, 2364]], [[2397, 2397], "mapped", [2338, 2364]], [[2398, 2398], "mapped", [2347, 2364]], [[2399, 2399], "mapped", [2351, 2364]], [[2400, 2403], "valid"], [[2404, 2405], "valid", [], "NV8"], [[2406, 2415], "valid"], [[2416, 2416], "valid", [], "NV8"], [[2417, 2418], "valid"], [[2419, 2423], "valid"], [[2424, 2424], "valid"], [[2425, 2426], "valid"], [[2427, 2428], "valid"], [[2429, 2429], "valid"], [[2430, 2431], "valid"], [[2432, 2432], "valid"], [[2433, 2435], "valid"], [[2436, 2436], "disallowed"], [[2437, 2444], "valid"], [[2445, 2446], "disallowed"], [[2447, 2448], "valid"], [[2449, 2450], "disallowed"], [[2451, 2472], "valid"], [[2473, 2473], "disallowed"], [[2474, 2480], "valid"], [[2481, 2481], "disallowed"], [[2482, 2482], "valid"], [[2483, 2485], "disallowed"], [[2486, 2489], "valid"], [[2490, 2491], "disallowed"], [[2492, 2492], "valid"], [[2493, 2493], "valid"], [[2494, 2500], "valid"], [[2501, 2502], "disallowed"], [[2503, 2504], "valid"], [[2505, 2506], "disallowed"], [[2507, 2509], "valid"], [[2510, 2510], "valid"], [[2511, 2518], "disallowed"], [[2519, 2519], "valid"], [[2520, 2523], "disallowed"], [[2524, 2524], "mapped", [2465, 2492]], [[2525, 2525], "mapped", [2466, 2492]], [[2526, 2526], "disallowed"], [[2527, 2527], "mapped", [2479, 2492]], [[2528, 2531], "valid"], [[2532, 2533], "disallowed"], [[2534, 2545], "valid"], [[2546, 2554], "valid", [], "NV8"], [[2555, 2555], "valid", [], "NV8"], [[2556, 2560], "disallowed"], [[2561, 2561], "valid"], [[2562, 2562], "valid"], [[2563, 2563], "valid"], [[2564, 2564], "disallowed"], [[2565, 2570], "valid"], [[2571, 2574], "disallowed"], [[2575, 2576], "valid"], [[2577, 2578], "disallowed"], [[2579, 2600], "valid"], [[2601, 2601], "disallowed"], [[2602, 2608], "valid"], [[2609, 2609], "disallowed"], [[2610, 2610], "valid"], [[2611, 2611], "mapped", [2610, 2620]], [[2612, 2612], "disallowed"], [[2613, 2613], "valid"], [[2614, 2614], "mapped", [2616, 2620]], [[2615, 2615], "disallowed"], [[2616, 2617], "valid"], [[2618, 2619], "disallowed"], [[2620, 2620], "valid"], [[2621, 2621], "disallowed"], [[2622, 2626], "valid"], [[2627, 2630], "disallowed"], [[2631, 2632], "valid"], [[2633, 2634], "disallowed"], [[2635, 2637], "valid"], [[2638, 2640], "disallowed"], [[2641, 2641], "valid"], [[2642, 2648], "disallowed"], [[2649, 2649], "mapped", [2582, 2620]], [[2650, 2650], "mapped", [2583, 2620]], [[2651, 2651], "mapped", [2588, 2620]], [[2652, 2652], "valid"], [[2653, 2653], "disallowed"], [[2654, 2654], "mapped", [2603, 2620]], [[2655, 2661], "disallowed"], [[2662, 2676], "valid"], [[2677, 2677], "valid"], [[2678, 2688], "disallowed"], [[2689, 2691], "valid"], [[2692, 2692], "disallowed"], [[2693, 2699], "valid"], [[2700, 2700], "valid"], [[2701, 2701], "valid"], [[2702, 2702], "disallowed"], [[2703, 2705], "valid"], [[2706, 2706], "disallowed"], [[2707, 2728], "valid"], [[2729, 2729], "disallowed"], [[2730, 2736], "valid"], [[2737, 2737], "disallowed"], [[2738, 2739], "valid"], [[2740, 2740], "disallowed"], [[2741, 2745], "valid"], [[2746, 2747], "disallowed"], [[2748, 2757], "valid"], [[2758, 2758], "disallowed"], [[2759, 2761], "valid"], [[2762, 2762], "disallowed"], [[2763, 2765], "valid"], [[2766, 2767], "disallowed"], [[2768, 2768], "valid"], [[2769, 2783], "disallowed"], [[2784, 2784], "valid"], [[2785, 2787], "valid"], [[2788, 2789], "disallowed"], [[2790, 2799], "valid"], [[2800, 2800], "valid", [], "NV8"], [[2801, 2801], "valid", [], "NV8"], [[2802, 2808], "disallowed"], [[2809, 2809], "valid"], [[2810, 2816], "disallowed"], [[2817, 2819], "valid"], [[2820, 2820], "disallowed"], [[2821, 2828], "valid"], [[2829, 2830], "disallowed"], [[2831, 2832], "valid"], [[2833, 2834], "disallowed"], [[2835, 2856], "valid"], [[2857, 2857], "disallowed"], [[2858, 2864], "valid"], [[2865, 2865], "disallowed"], [[2866, 2867], "valid"], [[2868, 2868], "disallowed"], [[2869, 2869], "valid"], [[2870, 2873], "valid"], [[2874, 2875], "disallowed"], [[2876, 2883], "valid"], [[2884, 2884], "valid"], [[2885, 2886], "disallowed"], [[2887, 2888], "valid"], [[2889, 2890], "disallowed"], [[2891, 2893], "valid"], [[2894, 2901], "disallowed"], [[2902, 2903], "valid"], [[2904, 2907], "disallowed"], [[2908, 2908], "mapped", [2849, 2876]], [[2909, 2909], "mapped", [2850, 2876]], [[2910, 2910], "disallowed"], [[2911, 2913], "valid"], [[2914, 2915], "valid"], [[2916, 2917], "disallowed"], [[2918, 2927], "valid"], [[2928, 2928], "valid", [], "NV8"], [[2929, 2929], "valid"], [[2930, 2935], "valid", [], "NV8"], [[2936, 2945], "disallowed"], [[2946, 2947], "valid"], [[2948, 2948], "disallowed"], [[2949, 2954], "valid"], [[2955, 2957], "disallowed"], [[2958, 2960], "valid"], [[2961, 2961], "disallowed"], [[2962, 2965], "valid"], [[2966, 2968], "disallowed"], [[2969, 2970], "valid"], [[2971, 2971], "disallowed"], [[2972, 2972], "valid"], [[2973, 2973], "disallowed"], [[2974, 2975], "valid"], [[2976, 2978], "disallowed"], [[2979, 2980], "valid"], [[2981, 2983], "disallowed"], [[2984, 2986], "valid"], [[2987, 2989], "disallowed"], [[2990, 2997], "valid"], [[2998, 2998], "valid"], [[2999, 3001], "valid"], [[3002, 3005], "disallowed"], [[3006, 3010], "valid"], [[3011, 3013], "disallowed"], [[3014, 3016], "valid"], [[3017, 3017], "disallowed"], [[3018, 3021], "valid"], [[3022, 3023], "disallowed"], [[3024, 3024], "valid"], [[3025, 3030], "disallowed"], [[3031, 3031], "valid"], [[3032, 3045], "disallowed"], [[3046, 3046], "valid"], [[3047, 3055], "valid"], [[3056, 3058], "valid", [], "NV8"], [[3059, 3066], "valid", [], "NV8"], [[3067, 3071], "disallowed"], [[3072, 3072], "valid"], [[3073, 3075], "valid"], [[3076, 3076], "disallowed"], [[3077, 3084], "valid"], [[3085, 3085], "disallowed"], [[3086, 3088], "valid"], [[3089, 3089], "disallowed"], [[3090, 3112], "valid"], [[3113, 3113], "disallowed"], [[3114, 3123], "valid"], [[3124, 3124], "valid"], [[3125, 3129], "valid"], [[3130, 3132], "disallowed"], [[3133, 3133], "valid"], [[3134, 3140], "valid"], [[3141, 3141], "disallowed"], [[3142, 3144], "valid"], [[3145, 3145], "disallowed"], [[3146, 3149], "valid"], [[3150, 3156], "disallowed"], [[3157, 3158], "valid"], [[3159, 3159], "disallowed"], [[3160, 3161], "valid"], [[3162, 3162], "valid"], [[3163, 3167], "disallowed"], [[3168, 3169], "valid"], [[3170, 3171], "valid"], [[3172, 3173], "disallowed"], [[3174, 3183], "valid"], [[3184, 3191], "disallowed"], [[3192, 3199], "valid", [], "NV8"], [[3200, 3200], "disallowed"], [[3201, 3201], "valid"], [[3202, 3203], "valid"], [[3204, 3204], "disallowed"], [[3205, 3212], "valid"], [[3213, 3213], "disallowed"], [[3214, 3216], "valid"], [[3217, 3217], "disallowed"], [[3218, 3240], "valid"], [[3241, 3241], "disallowed"], [[3242, 3251], "valid"], [[3252, 3252], "disallowed"], [[3253, 3257], "valid"], [[3258, 3259], "disallowed"], [[3260, 3261], "valid"], [[3262, 3268], "valid"], [[3269, 3269], "disallowed"], [[3270, 3272], "valid"], [[3273, 3273], "disallowed"], [[3274, 3277], "valid"], [[3278, 3284], "disallowed"], [[3285, 3286], "valid"], [[3287, 3293], "disallowed"], [[3294, 3294], "valid"], [[3295, 3295], "disallowed"], [[3296, 3297], "valid"], [[3298, 3299], "valid"], [[3300, 3301], "disallowed"], [[3302, 3311], "valid"], [[3312, 3312], "disallowed"], [[3313, 3314], "valid"], [[3315, 3328], "disallowed"], [[3329, 3329], "valid"], [[3330, 3331], "valid"], [[3332, 3332], "disallowed"], [[3333, 3340], "valid"], [[3341, 3341], "disallowed"], [[3342, 3344], "valid"], [[3345, 3345], "disallowed"], [[3346, 3368], "valid"], [[3369, 3369], "valid"], [[3370, 3385], "valid"], [[3386, 3386], "valid"], [[3387, 3388], "disallowed"], [[3389, 3389], "valid"], [[3390, 3395], "valid"], [[3396, 3396], "valid"], [[3397, 3397], "disallowed"], [[3398, 3400], "valid"], [[3401, 3401], "disallowed"], [[3402, 3405], "valid"], [[3406, 3406], "valid"], [[3407, 3414], "disallowed"], [[3415, 3415], "valid"], [[3416, 3422], "disallowed"], [[3423, 3423], "valid"], [[3424, 3425], "valid"], [[3426, 3427], "valid"], [[3428, 3429], "disallowed"], [[3430, 3439], "valid"], [[3440, 3445], "valid", [], "NV8"], [[3446, 3448], "disallowed"], [[3449, 3449], "valid", [], "NV8"], [[3450, 3455], "valid"], [[3456, 3457], "disallowed"], [[3458, 3459], "valid"], [[3460, 3460], "disallowed"], [[3461, 3478], "valid"], [[3479, 3481], "disallowed"], [[3482, 3505], "valid"], [[3506, 3506], "disallowed"], [[3507, 3515], "valid"], [[3516, 3516], "disallowed"], [[3517, 3517], "valid"], [[3518, 3519], "disallowed"], [[3520, 3526], "valid"], [[3527, 3529], "disallowed"], [[3530, 3530], "valid"], [[3531, 3534], "disallowed"], [[3535, 3540], "valid"], [[3541, 3541], "disallowed"], [[3542, 3542], "valid"], [[3543, 3543], "disallowed"], [[3544, 3551], "valid"], [[3552, 3557], "disallowed"], [[3558, 3567], "valid"], [[3568, 3569], "disallowed"], [[3570, 3571], "valid"], [[3572, 3572], "valid", [], "NV8"], [[3573, 3584], "disallowed"], [[3585, 3634], "valid"], [[3635, 3635], "mapped", [3661, 3634]], [[3636, 3642], "valid"], [[3643, 3646], "disallowed"], [[3647, 3647], "valid", [], "NV8"], [[3648, 3662], "valid"], [[3663, 3663], "valid", [], "NV8"], [[3664, 3673], "valid"], [[3674, 3675], "valid", [], "NV8"], [[3676, 3712], "disallowed"], [[3713, 3714], "valid"], [[3715, 3715], "disallowed"], [[3716, 3716], "valid"], [[3717, 3718], "disallowed"], [[3719, 3720], "valid"], [[3721, 3721], "disallowed"], [[3722, 3722], "valid"], [[3723, 3724], "disallowed"], [[3725, 3725], "valid"], [[3726, 3731], "disallowed"], [[3732, 3735], "valid"], [[3736, 3736], "disallowed"], [[3737, 3743], "valid"], [[3744, 3744], "disallowed"], [[3745, 3747], "valid"], [[3748, 3748], "disallowed"], [[3749, 3749], "valid"], [[3750, 3750], "disallowed"], [[3751, 3751], "valid"], [[3752, 3753], "disallowed"], [[3754, 3755], "valid"], [[3756, 3756], "disallowed"], [[3757, 3762], "valid"], [[3763, 3763], "mapped", [3789, 3762]], [[3764, 3769], "valid"], [[3770, 3770], "disallowed"], [[3771, 3773], "valid"], [[3774, 3775], "disallowed"], [[3776, 3780], "valid"], [[3781, 3781], "disallowed"], [[3782, 3782], "valid"], [[3783, 3783], "disallowed"], [[3784, 3789], "valid"], [[3790, 3791], "disallowed"], [[3792, 3801], "valid"], [[3802, 3803], "disallowed"], [[3804, 3804], "mapped", [3755, 3737]], [[3805, 3805], "mapped", [3755, 3745]], [[3806, 3807], "valid"], [[3808, 3839], "disallowed"], [[3840, 3840], "valid"], [[3841, 3850], "valid", [], "NV8"], [[3851, 3851], "valid"], [[3852, 3852], "mapped", [3851]], [[3853, 3863], "valid", [], "NV8"], [[3864, 3865], "valid"], [[3866, 3871], "valid", [], "NV8"], [[3872, 3881], "valid"], [[3882, 3892], "valid", [], "NV8"], [[3893, 3893], "valid"], [[3894, 3894], "valid", [], "NV8"], [[3895, 3895], "valid"], [[3896, 3896], "valid", [], "NV8"], [[3897, 3897], "valid"], [[3898, 3901], "valid", [], "NV8"], [[3902, 3906], "valid"], [[3907, 3907], "mapped", [3906, 4023]], [[3908, 3911], "valid"], [[3912, 3912], "disallowed"], [[3913, 3916], "valid"], [[3917, 3917], "mapped", [3916, 4023]], [[3918, 3921], "valid"], [[3922, 3922], "mapped", [3921, 4023]], [[3923, 3926], "valid"], [[3927, 3927], "mapped", [3926, 4023]], [[3928, 3931], "valid"], [[3932, 3932], "mapped", [3931, 4023]], [[3933, 3944], "valid"], [[3945, 3945], "mapped", [3904, 4021]], [[3946, 3946], "valid"], [[3947, 3948], "valid"], [[3949, 3952], "disallowed"], [[3953, 3954], "valid"], [[3955, 3955], "mapped", [3953, 3954]], [[3956, 3956], "valid"], [[3957, 3957], "mapped", [3953, 3956]], [[3958, 3958], "mapped", [4018, 3968]], [[3959, 3959], "mapped", [4018, 3953, 3968]], [[3960, 3960], "mapped", [4019, 3968]], [[3961, 3961], "mapped", [4019, 3953, 3968]], [[3962, 3968], "valid"], [[3969, 3969], "mapped", [3953, 3968]], [[3970, 3972], "valid"], [[3973, 3973], "valid", [], "NV8"], [[3974, 3979], "valid"], [[3980, 3983], "valid"], [[3984, 3986], "valid"], [[3987, 3987], "mapped", [3986, 4023]], [[3988, 3989], "valid"], [[3990, 3990], "valid"], [[3991, 3991], "valid"], [[3992, 3992], "disallowed"], [[3993, 3996], "valid"], [[3997, 3997], "mapped", [3996, 4023]], [[3998, 4001], "valid"], [[4002, 4002], "mapped", [4001, 4023]], [[4003, 4006], "valid"], [[4007, 4007], "mapped", [4006, 4023]], [[4008, 4011], "valid"], [[4012, 4012], "mapped", [4011, 4023]], [[4013, 4013], "valid"], [[4014, 4016], "valid"], [[4017, 4023], "valid"], [[4024, 4024], "valid"], [[4025, 4025], "mapped", [3984, 4021]], [[4026, 4028], "valid"], [[4029, 4029], "disallowed"], [[4030, 4037], "valid", [], "NV8"], [[4038, 4038], "valid"], [[4039, 4044], "valid", [], "NV8"], [[4045, 4045], "disallowed"], [[4046, 4046], "valid", [], "NV8"], [[4047, 4047], "valid", [], "NV8"], [[4048, 4049], "valid", [], "NV8"], [[4050, 4052], "valid", [], "NV8"], [[4053, 4056], "valid", [], "NV8"], [[4057, 4058], "valid", [], "NV8"], [[4059, 4095], "disallowed"], [[4096, 4129], "valid"], [[4130, 4130], "valid"], [[4131, 4135], "valid"], [[4136, 4136], "valid"], [[4137, 4138], "valid"], [[4139, 4139], "valid"], [[4140, 4146], "valid"], [[4147, 4149], "valid"], [[4150, 4153], "valid"], [[4154, 4159], "valid"], [[4160, 4169], "valid"], [[4170, 4175], "valid", [], "NV8"], [[4176, 4185], "valid"], [[4186, 4249], "valid"], [[4250, 4253], "valid"], [[4254, 4255], "valid", [], "NV8"], [[4256, 4293], "disallowed"], [[4294, 4294], "disallowed"], [[4295, 4295], "mapped", [11559]], [[4296, 4300], "disallowed"], [[4301, 4301], "mapped", [11565]], [[4302, 4303], "disallowed"], [[4304, 4342], "valid"], [[4343, 4344], "valid"], [[4345, 4346], "valid"], [[4347, 4347], "valid", [], "NV8"], [[4348, 4348], "mapped", [4316]], [[4349, 4351], "valid"], [[4352, 4441], "valid", [], "NV8"], [[4442, 4446], "valid", [], "NV8"], [[4447, 4448], "disallowed"], [[4449, 4514], "valid", [], "NV8"], [[4515, 4519], "valid", [], "NV8"], [[4520, 4601], "valid", [], "NV8"], [[4602, 4607], "valid", [], "NV8"], [[4608, 4614], "valid"], [[4615, 4615], "valid"], [[4616, 4678], "valid"], [[4679, 4679], "valid"], [[4680, 4680], "valid"], [[4681, 4681], "disallowed"], [[4682, 4685], "valid"], [[4686, 4687], "disallowed"], [[4688, 4694], "valid"], [[4695, 4695], "disallowed"], [[4696, 4696], "valid"], [[4697, 4697], "disallowed"], [[4698, 4701], "valid"], [[4702, 4703], "disallowed"], [[4704, 4742], "valid"], [[4743, 4743], "valid"], [[4744, 4744], "valid"], [[4745, 4745], "disallowed"], [[4746, 4749], "valid"], [[4750, 4751], "disallowed"], [[4752, 4782], "valid"], [[4783, 4783], "valid"], [[4784, 4784], "valid"], [[4785, 4785], "disallowed"], [[4786, 4789], "valid"], [[4790, 4791], "disallowed"], [[4792, 4798], "valid"], [[4799, 4799], "disallowed"], [[4800, 4800], "valid"], [[4801, 4801], "disallowed"], [[4802, 4805], "valid"], [[4806, 4807], "disallowed"], [[4808, 4814], "valid"], [[4815, 4815], "valid"], [[4816, 4822], "valid"], [[4823, 4823], "disallowed"], [[4824, 4846], "valid"], [[4847, 4847], "valid"], [[4848, 4878], "valid"], [[4879, 4879], "valid"], [[4880, 4880], "valid"], [[4881, 4881], "disallowed"], [[4882, 4885], "valid"], [[4886, 4887], "disallowed"], [[4888, 4894], "valid"], [[4895, 4895], "valid"], [[4896, 4934], "valid"], [[4935, 4935], "valid"], [[4936, 4954], "valid"], [[4955, 4956], "disallowed"], [[4957, 4958], "valid"], [[4959, 4959], "valid"], [[4960, 4960], "valid", [], "NV8"], [[4961, 4988], "valid", [], "NV8"], [[4989, 4991], "disallowed"], [[4992, 5007], "valid"], [[5008, 5017], "valid", [], "NV8"], [[5018, 5023], "disallowed"], [[5024, 5108], "valid"], [[5109, 5109], "valid"], [[5110, 5111], "disallowed"], [[5112, 5112], "mapped", [5104]], [[5113, 5113], "mapped", [5105]], [[5114, 5114], "mapped", [5106]], [[5115, 5115], "mapped", [5107]], [[5116, 5116], "mapped", [5108]], [[5117, 5117], "mapped", [5109]], [[5118, 5119], "disallowed"], [[5120, 5120], "valid", [], "NV8"], [[5121, 5740], "valid"], [[5741, 5742], "valid", [], "NV8"], [[5743, 5750], "valid"], [[5751, 5759], "valid"], [[5760, 5760], "disallowed"], [[5761, 5786], "valid"], [[5787, 5788], "valid", [], "NV8"], [[5789, 5791], "disallowed"], [[5792, 5866], "valid"], [[5867, 5872], "valid", [], "NV8"], [[5873, 5880], "valid"], [[5881, 5887], "disallowed"], [[5888, 5900], "valid"], [[5901, 5901], "disallowed"], [[5902, 5908], "valid"], [[5909, 5919], "disallowed"], [[5920, 5940], "valid"], [[5941, 5942], "valid", [], "NV8"], [[5943, 5951], "disallowed"], [[5952, 5971], "valid"], [[5972, 5983], "disallowed"], [[5984, 5996], "valid"], [[5997, 5997], "disallowed"], [[5998, 6e3], "valid"], [[6001, 6001], "disallowed"], [[6002, 6003], "valid"], [[6004, 6015], "disallowed"], [[6016, 6067], "valid"], [[6068, 6069], "disallowed"], [[6070, 6099], "valid"], [[6100, 6102], "valid", [], "NV8"], [[6103, 6103], "valid"], [[6104, 6107], "valid", [], "NV8"], [[6108, 6108], "valid"], [[6109, 6109], "valid"], [[6110, 6111], "disallowed"], [[6112, 6121], "valid"], [[6122, 6127], "disallowed"], [[6128, 6137], "valid", [], "NV8"], [[6138, 6143], "disallowed"], [[6144, 6149], "valid", [], "NV8"], [[6150, 6150], "disallowed"], [[6151, 6154], "valid", [], "NV8"], [[6155, 6157], "ignored"], [[6158, 6158], "disallowed"], [[6159, 6159], "disallowed"], [[6160, 6169], "valid"], [[6170, 6175], "disallowed"], [[6176, 6263], "valid"], [[6264, 6271], "disallowed"], [[6272, 6313], "valid"], [[6314, 6314], "valid"], [[6315, 6319], "disallowed"], [[6320, 6389], "valid"], [[6390, 6399], "disallowed"], [[6400, 6428], "valid"], [[6429, 6430], "valid"], [[6431, 6431], "disallowed"], [[6432, 6443], "valid"], [[6444, 6447], "disallowed"], [[6448, 6459], "valid"], [[6460, 6463], "disallowed"], [[6464, 6464], "valid", [], "NV8"], [[6465, 6467], "disallowed"], [[6468, 6469], "valid", [], "NV8"], [[6470, 6509], "valid"], [[6510, 6511], "disallowed"], [[6512, 6516], "valid"], [[6517, 6527], "disallowed"], [[6528, 6569], "valid"], [[6570, 6571], "valid"], [[6572, 6575], "disallowed"], [[6576, 6601], "valid"], [[6602, 6607], "disallowed"], [[6608, 6617], "valid"], [[6618, 6618], "valid", [], "XV8"], [[6619, 6621], "disallowed"], [[6622, 6623], "valid", [], "NV8"], [[6624, 6655], "valid", [], "NV8"], [[6656, 6683], "valid"], [[6684, 6685], "disallowed"], [[6686, 6687], "valid", [], "NV8"], [[6688, 6750], "valid"], [[6751, 6751], "disallowed"], [[6752, 6780], "valid"], [[6781, 6782], "disallowed"], [[6783, 6793], "valid"], [[6794, 6799], "disallowed"], [[6800, 6809], "valid"], [[6810, 6815], "disallowed"], [[6816, 6822], "valid", [], "NV8"], [[6823, 6823], "valid"], [[6824, 6829], "valid", [], "NV8"], [[6830, 6831], "disallowed"], [[6832, 6845], "valid"], [[6846, 6846], "valid", [], "NV8"], [[6847, 6911], "disallowed"], [[6912, 6987], "valid"], [[6988, 6991], "disallowed"], [[6992, 7001], "valid"], [[7002, 7018], "valid", [], "NV8"], [[7019, 7027], "valid"], [[7028, 7036], "valid", [], "NV8"], [[7037, 7039], "disallowed"], [[7040, 7082], "valid"], [[7083, 7085], "valid"], [[7086, 7097], "valid"], [[7098, 7103], "valid"], [[7104, 7155], "valid"], [[7156, 7163], "disallowed"], [[7164, 7167], "valid", [], "NV8"], [[7168, 7223], "valid"], [[7224, 7226], "disallowed"], [[7227, 7231], "valid", [], "NV8"], [[7232, 7241], "valid"], [[7242, 7244], "disallowed"], [[7245, 7293], "valid"], [[7294, 7295], "valid", [], "NV8"], [[7296, 7359], "disallowed"], [[7360, 7367], "valid", [], "NV8"], [[7368, 7375], "disallowed"], [[7376, 7378], "valid"], [[7379, 7379], "valid", [], "NV8"], [[7380, 7410], "valid"], [[7411, 7414], "valid"], [[7415, 7415], "disallowed"], [[7416, 7417], "valid"], [[7418, 7423], "disallowed"], [[7424, 7467], "valid"], [[7468, 7468], "mapped", [97]], [[7469, 7469], "mapped", [230]], [[7470, 7470], "mapped", [98]], [[7471, 7471], "valid"], [[7472, 7472], "mapped", [100]], [[7473, 7473], "mapped", [101]], [[7474, 7474], "mapped", [477]], [[7475, 7475], "mapped", [103]], [[7476, 7476], "mapped", [104]], [[7477, 7477], "mapped", [105]], [[7478, 7478], "mapped", [106]], [[7479, 7479], "mapped", [107]], [[7480, 7480], "mapped", [108]], [[7481, 7481], "mapped", [109]], [[7482, 7482], "mapped", [110]], [[7483, 7483], "valid"], [[7484, 7484], "mapped", [111]], [[7485, 7485], "mapped", [547]], [[7486, 7486], "mapped", [112]], [[7487, 7487], "mapped", [114]], [[7488, 7488], "mapped", [116]], [[7489, 7489], "mapped", [117]], [[7490, 7490], "mapped", [119]], [[7491, 7491], "mapped", [97]], [[7492, 7492], "mapped", [592]], [[7493, 7493], "mapped", [593]], [[7494, 7494], "mapped", [7426]], [[7495, 7495], "mapped", [98]], [[7496, 7496], "mapped", [100]], [[7497, 7497], "mapped", [101]], [[7498, 7498], "mapped", [601]], [[7499, 7499], "mapped", [603]], [[7500, 7500], "mapped", [604]], [[7501, 7501], "mapped", [103]], [[7502, 7502], "valid"], [[7503, 7503], "mapped", [107]], [[7504, 7504], "mapped", [109]], [[7505, 7505], "mapped", [331]], [[7506, 7506], "mapped", [111]], [[7507, 7507], "mapped", [596]], [[7508, 7508], "mapped", [7446]], [[7509, 7509], "mapped", [7447]], [[7510, 7510], "mapped", [112]], [[7511, 7511], "mapped", [116]], [[7512, 7512], "mapped", [117]], [[7513, 7513], "mapped", [7453]], [[7514, 7514], "mapped", [623]], [[7515, 7515], "mapped", [118]], [[7516, 7516], "mapped", [7461]], [[7517, 7517], "mapped", [946]], [[7518, 7518], "mapped", [947]], [[7519, 7519], "mapped", [948]], [[7520, 7520], "mapped", [966]], [[7521, 7521], "mapped", [967]], [[7522, 7522], "mapped", [105]], [[7523, 7523], "mapped", [114]], [[7524, 7524], "mapped", [117]], [[7525, 7525], "mapped", [118]], [[7526, 7526], "mapped", [946]], [[7527, 7527], "mapped", [947]], [[7528, 7528], "mapped", [961]], [[7529, 7529], "mapped", [966]], [[7530, 7530], "mapped", [967]], [[7531, 7531], "valid"], [[7532, 7543], "valid"], [[7544, 7544], "mapped", [1085]], [[7545, 7578], "valid"], [[7579, 7579], "mapped", [594]], [[7580, 7580], "mapped", [99]], [[7581, 7581], "mapped", [597]], [[7582, 7582], "mapped", [240]], [[7583, 7583], "mapped", [604]], [[7584, 7584], "mapped", [102]], [[7585, 7585], "mapped", [607]], [[7586, 7586], "mapped", [609]], [[7587, 7587], "mapped", [613]], [[7588, 7588], "mapped", [616]], [[7589, 7589], "mapped", [617]], [[7590, 7590], "mapped", [618]], [[7591, 7591], "mapped", [7547]], [[7592, 7592], "mapped", [669]], [[7593, 7593], "mapped", [621]], [[7594, 7594], "mapped", [7557]], [[7595, 7595], "mapped", [671]], [[7596, 7596], "mapped", [625]], [[7597, 7597], "mapped", [624]], [[7598, 7598], "mapped", [626]], [[7599, 7599], "mapped", [627]], [[7600, 7600], "mapped", [628]], [[7601, 7601], "mapped", [629]], [[7602, 7602], "mapped", [632]], [[7603, 7603], "mapped", [642]], [[7604, 7604], "mapped", [643]], [[7605, 7605], "mapped", [427]], [[7606, 7606], "mapped", [649]], [[7607, 7607], "mapped", [650]], [[7608, 7608], "mapped", [7452]], [[7609, 7609], "mapped", [651]], [[7610, 7610], "mapped", [652]], [[7611, 7611], "mapped", [122]], [[7612, 7612], "mapped", [656]], [[7613, 7613], "mapped", [657]], [[7614, 7614], "mapped", [658]], [[7615, 7615], "mapped", [952]], [[7616, 7619], "valid"], [[7620, 7626], "valid"], [[7627, 7654], "valid"], [[7655, 7669], "valid"], [[7670, 7675], "disallowed"], [[7676, 7676], "valid"], [[7677, 7677], "valid"], [[7678, 7679], "valid"], [[7680, 7680], "mapped", [7681]], [[7681, 7681], "valid"], [[7682, 7682], "mapped", [7683]], [[7683, 7683], "valid"], [[7684, 7684], "mapped", [7685]], [[7685, 7685], "valid"], [[7686, 7686], "mapped", [7687]], [[7687, 7687], "valid"], [[7688, 7688], "mapped", [7689]], [[7689, 7689], "valid"], [[7690, 7690], "mapped", [7691]], [[7691, 7691], "valid"], [[7692, 7692], "mapped", [7693]], [[7693, 7693], "valid"], [[7694, 7694], "mapped", [7695]], [[7695, 7695], "valid"], [[7696, 7696], "mapped", [7697]], [[7697, 7697], "valid"], [[7698, 7698], "mapped", [7699]], [[7699, 7699], "valid"], [[7700, 7700], "mapped", [7701]], [[7701, 7701], "valid"], [[7702, 7702], "mapped", [7703]], [[7703, 7703], "valid"], [[7704, 7704], "mapped", [7705]], [[7705, 7705], "valid"], [[7706, 7706], "mapped", [7707]], [[7707, 7707], "valid"], [[7708, 7708], "mapped", [7709]], [[7709, 7709], "valid"], [[7710, 7710], "mapped", [7711]], [[7711, 7711], "valid"], [[7712, 7712], "mapped", [7713]], [[7713, 7713], "valid"], [[7714, 7714], "mapped", [7715]], [[7715, 7715], "valid"], [[7716, 7716], "mapped", [7717]], [[7717, 7717], "valid"], [[7718, 7718], "mapped", [7719]], [[7719, 7719], "valid"], [[7720, 7720], "mapped", [7721]], [[7721, 7721], "valid"], [[7722, 7722], "mapped", [7723]], [[7723, 7723], "valid"], [[7724, 7724], "mapped", [7725]], [[7725, 7725], "valid"], [[7726, 7726], "mapped", [7727]], [[7727, 7727], "valid"], [[7728, 7728], "mapped", [7729]], [[7729, 7729], "valid"], [[7730, 7730], "mapped", [7731]], [[7731, 7731], "valid"], [[7732, 7732], "mapped", [7733]], [[7733, 7733], "valid"], [[7734, 7734], "mapped", [7735]], [[7735, 7735], "valid"], [[7736, 7736], "mapped", [7737]], [[7737, 7737], "valid"], [[7738, 7738], "mapped", [7739]], [[7739, 7739], "valid"], [[7740, 7740], "mapped", [7741]], [[7741, 7741], "valid"], [[7742, 7742], "mapped", [7743]], [[7743, 7743], "valid"], [[7744, 7744], "mapped", [7745]], [[7745, 7745], "valid"], [[7746, 7746], "mapped", [7747]], [[7747, 7747], "valid"], [[7748, 7748], "mapped", [7749]], [[7749, 7749], "valid"], [[7750, 7750], "mapped", [7751]], [[7751, 7751], "valid"], [[7752, 7752], "mapped", [7753]], [[7753, 7753], "valid"], [[7754, 7754], "mapped", [7755]], [[7755, 7755], "valid"], [[7756, 7756], "mapped", [7757]], [[7757, 7757], "valid"], [[7758, 7758], "mapped", [7759]], [[7759, 7759], "valid"], [[7760, 7760], "mapped", [7761]], [[7761, 7761], "valid"], [[7762, 7762], "mapped", [7763]], [[7763, 7763], "valid"], [[7764, 7764], "mapped", [7765]], [[7765, 7765], "valid"], [[7766, 7766], "mapped", [7767]], [[7767, 7767], "valid"], [[7768, 7768], "mapped", [7769]], [[7769, 7769], "valid"], [[7770, 7770], "mapped", [7771]], [[7771, 7771], "valid"], [[7772, 7772], "mapped", [7773]], [[7773, 7773], "valid"], [[7774, 7774], "mapped", [7775]], [[7775, 7775], "valid"], [[7776, 7776], "mapped", [7777]], [[7777, 7777], "valid"], [[7778, 7778], "mapped", [7779]], [[7779, 7779], "valid"], [[7780, 7780], "mapped", [7781]], [[7781, 7781], "valid"], [[7782, 7782], "mapped", [7783]], [[7783, 7783], "valid"], [[7784, 7784], "mapped", [7785]], [[7785, 7785], "valid"], [[7786, 7786], "mapped", [7787]], [[7787, 7787], "valid"], [[7788, 7788], "mapped", [7789]], [[7789, 7789], "valid"], [[7790, 7790], "mapped", [7791]], [[7791, 7791], "valid"], [[7792, 7792], "mapped", [7793]], [[7793, 7793], "valid"], [[7794, 7794], "mapped", [7795]], [[7795, 7795], "valid"], [[7796, 7796], "mapped", [7797]], [[7797, 7797], "valid"], [[7798, 7798], "mapped", [7799]], [[7799, 7799], "valid"], [[7800, 7800], "mapped", [7801]], [[7801, 7801], "valid"], [[7802, 7802], "mapped", [7803]], [[7803, 7803], "valid"], [[7804, 7804], "mapped", [7805]], [[7805, 7805], "valid"], [[7806, 7806], "mapped", [7807]], [[7807, 7807], "valid"], [[7808, 7808], "mapped", [7809]], [[7809, 7809], "valid"], [[7810, 7810], "mapped", [7811]], [[7811, 7811], "valid"], [[7812, 7812], "mapped", [7813]], [[7813, 7813], "valid"], [[7814, 7814], "mapped", [7815]], [[7815, 7815], "valid"], [[7816, 7816], "mapped", [7817]], [[7817, 7817], "valid"], [[7818, 7818], "mapped", [7819]], [[7819, 7819], "valid"], [[7820, 7820], "mapped", [7821]], [[7821, 7821], "valid"], [[7822, 7822], "mapped", [7823]], [[7823, 7823], "valid"], [[7824, 7824], "mapped", [7825]], [[7825, 7825], "valid"], [[7826, 7826], "mapped", [7827]], [[7827, 7827], "valid"], [[7828, 7828], "mapped", [7829]], [[7829, 7833], "valid"], [[7834, 7834], "mapped", [97, 702]], [[7835, 7835], "mapped", [7777]], [[7836, 7837], "valid"], [[7838, 7838], "mapped", [115, 115]], [[7839, 7839], "valid"], [[7840, 7840], "mapped", [7841]], [[7841, 7841], "valid"], [[7842, 7842], "mapped", [7843]], [[7843, 7843], "valid"], [[7844, 7844], "mapped", [7845]], [[7845, 7845], "valid"], [[7846, 7846], "mapped", [7847]], [[7847, 7847], "valid"], [[7848, 7848], "mapped", [7849]], [[7849, 7849], "valid"], [[7850, 7850], "mapped", [7851]], [[7851, 7851], "valid"], [[7852, 7852], "mapped", [7853]], [[7853, 7853], "valid"], [[7854, 7854], "mapped", [7855]], [[7855, 7855], "valid"], [[7856, 7856], "mapped", [7857]], [[7857, 7857], "valid"], [[7858, 7858], "mapped", [7859]], [[7859, 7859], "valid"], [[7860, 7860], "mapped", [7861]], [[7861, 7861], "valid"], [[7862, 7862], "mapped", [7863]], [[7863, 7863], "valid"], [[7864, 7864], "mapped", [7865]], [[7865, 7865], "valid"], [[7866, 7866], "mapped", [7867]], [[7867, 7867], "valid"], [[7868, 7868], "mapped", [7869]], [[7869, 7869], "valid"], [[7870, 7870], "mapped", [7871]], [[7871, 7871], "valid"], [[7872, 7872], "mapped", [7873]], [[7873, 7873], "valid"], [[7874, 7874], "mapped", [7875]], [[7875, 7875], "valid"], [[7876, 7876], "mapped", [7877]], [[7877, 7877], "valid"], [[7878, 7878], "mapped", [7879]], [[7879, 7879], "valid"], [[7880, 7880], "mapped", [7881]], [[7881, 7881], "valid"], [[7882, 7882], "mapped", [7883]], [[7883, 7883], "valid"], [[7884, 7884], "mapped", [7885]], [[7885, 7885], "valid"], [[7886, 7886], "mapped", [7887]], [[7887, 7887], "valid"], [[7888, 7888], "mapped", [7889]], [[7889, 7889], "valid"], [[7890, 7890], "mapped", [7891]], [[7891, 7891], "valid"], [[7892, 7892], "mapped", [7893]], [[7893, 7893], "valid"], [[7894, 7894], "mapped", [7895]], [[7895, 7895], "valid"], [[7896, 7896], "mapped", [7897]], [[7897, 7897], "valid"], [[7898, 7898], "mapped", [7899]], [[7899, 7899], "valid"], [[7900, 7900], "mapped", [7901]], [[7901, 7901], "valid"], [[7902, 7902], "mapped", [7903]], [[7903, 7903], "valid"], [[7904, 7904], "mapped", [7905]], [[7905, 7905], "valid"], [[7906, 7906], "mapped", [7907]], [[7907, 7907], "valid"], [[7908, 7908], "mapped", [7909]], [[7909, 7909], "valid"], [[7910, 7910], "mapped", [7911]], [[7911, 7911], "valid"], [[7912, 7912], "mapped", [7913]], [[7913, 7913], "valid"], [[7914, 7914], "mapped", [7915]], [[7915, 7915], "valid"], [[7916, 7916], "mapped", [7917]], [[7917, 7917], "valid"], [[7918, 7918], "mapped", [7919]], [[7919, 7919], "valid"], [[7920, 7920], "mapped", [7921]], [[7921, 7921], "valid"], [[7922, 7922], "mapped", [7923]], [[7923, 7923], "valid"], [[7924, 7924], "mapped", [7925]], [[7925, 7925], "valid"], [[7926, 7926], "mapped", [7927]], [[7927, 7927], "valid"], [[7928, 7928], "mapped", [7929]], [[7929, 7929], "valid"], [[7930, 7930], "mapped", [7931]], [[7931, 7931], "valid"], [[7932, 7932], "mapped", [7933]], [[7933, 7933], "valid"], [[7934, 7934], "mapped", [7935]], [[7935, 7935], "valid"], [[7936, 7943], "valid"], [[7944, 7944], "mapped", [7936]], [[7945, 7945], "mapped", [7937]], [[7946, 7946], "mapped", [7938]], [[7947, 7947], "mapped", [7939]], [[7948, 7948], "mapped", [7940]], [[7949, 7949], "mapped", [7941]], [[7950, 7950], "mapped", [7942]], [[7951, 7951], "mapped", [7943]], [[7952, 7957], "valid"], [[7958, 7959], "disallowed"], [[7960, 7960], "mapped", [7952]], [[7961, 7961], "mapped", [7953]], [[7962, 7962], "mapped", [7954]], [[7963, 7963], "mapped", [7955]], [[7964, 7964], "mapped", [7956]], [[7965, 7965], "mapped", [7957]], [[7966, 7967], "disallowed"], [[7968, 7975], "valid"], [[7976, 7976], "mapped", [7968]], [[7977, 7977], "mapped", [7969]], [[7978, 7978], "mapped", [7970]], [[7979, 7979], "mapped", [7971]], [[7980, 7980], "mapped", [7972]], [[7981, 7981], "mapped", [7973]], [[7982, 7982], "mapped", [7974]], [[7983, 7983], "mapped", [7975]], [[7984, 7991], "valid"], [[7992, 7992], "mapped", [7984]], [[7993, 7993], "mapped", [7985]], [[7994, 7994], "mapped", [7986]], [[7995, 7995], "mapped", [7987]], [[7996, 7996], "mapped", [7988]], [[7997, 7997], "mapped", [7989]], [[7998, 7998], "mapped", [7990]], [[7999, 7999], "mapped", [7991]], [[8e3, 8005], "valid"], [[8006, 8007], "disallowed"], [[8008, 8008], "mapped", [8e3]], [[8009, 8009], "mapped", [8001]], [[8010, 8010], "mapped", [8002]], [[8011, 8011], "mapped", [8003]], [[8012, 8012], "mapped", [8004]], [[8013, 8013], "mapped", [8005]], [[8014, 8015], "disallowed"], [[8016, 8023], "valid"], [[8024, 8024], "disallowed"], [[8025, 8025], "mapped", [8017]], [[8026, 8026], "disallowed"], [[8027, 8027], "mapped", [8019]], [[8028, 8028], "disallowed"], [[8029, 8029], "mapped", [8021]], [[8030, 8030], "disallowed"], [[8031, 8031], "mapped", [8023]], [[8032, 8039], "valid"], [[8040, 8040], "mapped", [8032]], [[8041, 8041], "mapped", [8033]], [[8042, 8042], "mapped", [8034]], [[8043, 8043], "mapped", [8035]], [[8044, 8044], "mapped", [8036]], [[8045, 8045], "mapped", [8037]], [[8046, 8046], "mapped", [8038]], [[8047, 8047], "mapped", [8039]], [[8048, 8048], "valid"], [[8049, 8049], "mapped", [940]], [[8050, 8050], "valid"], [[8051, 8051], "mapped", [941]], [[8052, 8052], "valid"], [[8053, 8053], "mapped", [942]], [[8054, 8054], "valid"], [[8055, 8055], "mapped", [943]], [[8056, 8056], "valid"], [[8057, 8057], "mapped", [972]], [[8058, 8058], "valid"], [[8059, 8059], "mapped", [973]], [[8060, 8060], "valid"], [[8061, 8061], "mapped", [974]], [[8062, 8063], "disallowed"], [[8064, 8064], "mapped", [7936, 953]], [[8065, 8065], "mapped", [7937, 953]], [[8066, 8066], "mapped", [7938, 953]], [[8067, 8067], "mapped", [7939, 953]], [[8068, 8068], "mapped", [7940, 953]], [[8069, 8069], "mapped", [7941, 953]], [[8070, 8070], "mapped", [7942, 953]], [[8071, 8071], "mapped", [7943, 953]], [[8072, 8072], "mapped", [7936, 953]], [[8073, 8073], "mapped", [7937, 953]], [[8074, 8074], "mapped", [7938, 953]], [[8075, 8075], "mapped", [7939, 953]], [[8076, 8076], "mapped", [7940, 953]], [[8077, 8077], "mapped", [7941, 953]], [[8078, 8078], "mapped", [7942, 953]], [[8079, 8079], "mapped", [7943, 953]], [[8080, 8080], "mapped", [7968, 953]], [[8081, 8081], "mapped", [7969, 953]], [[8082, 8082], "mapped", [7970, 953]], [[8083, 8083], "mapped", [7971, 953]], [[8084, 8084], "mapped", [7972, 953]], [[8085, 8085], "mapped", [7973, 953]], [[8086, 8086], "mapped", [7974, 953]], [[8087, 8087], "mapped", [7975, 953]], [[8088, 8088], "mapped", [7968, 953]], [[8089, 8089], "mapped", [7969, 953]], [[8090, 8090], "mapped", [7970, 953]], [[8091, 8091], "mapped", [7971, 953]], [[8092, 8092], "mapped", [7972, 953]], [[8093, 8093], "mapped", [7973, 953]], [[8094, 8094], "mapped", [7974, 953]], [[8095, 8095], "mapped", [7975, 953]], [[8096, 8096], "mapped", [8032, 953]], [[8097, 8097], "mapped", [8033, 953]], [[8098, 8098], "mapped", [8034, 953]], [[8099, 8099], "mapped", [8035, 953]], [[8100, 8100], "mapped", [8036, 953]], [[8101, 8101], "mapped", [8037, 953]], [[8102, 8102], "mapped", [8038, 953]], [[8103, 8103], "mapped", [8039, 953]], [[8104, 8104], "mapped", [8032, 953]], [[8105, 8105], "mapped", [8033, 953]], [[8106, 8106], "mapped", [8034, 953]], [[8107, 8107], "mapped", [8035, 953]], [[8108, 8108], "mapped", [8036, 953]], [[8109, 8109], "mapped", [8037, 953]], [[8110, 8110], "mapped", [8038, 953]], [[8111, 8111], "mapped", [8039, 953]], [[8112, 8113], "valid"], [[8114, 8114], "mapped", [8048, 953]], [[8115, 8115], "mapped", [945, 953]], [[8116, 8116], "mapped", [940, 953]], [[8117, 8117], "disallowed"], [[8118, 8118], "valid"], [[8119, 8119], "mapped", [8118, 953]], [[8120, 8120], "mapped", [8112]], [[8121, 8121], "mapped", [8113]], [[8122, 8122], "mapped", [8048]], [[8123, 8123], "mapped", [940]], [[8124, 8124], "mapped", [945, 953]], [[8125, 8125], "disallowed_STD3_mapped", [32, 787]], [[8126, 8126], "mapped", [953]], [[8127, 8127], "disallowed_STD3_mapped", [32, 787]], [[8128, 8128], "disallowed_STD3_mapped", [32, 834]], [[8129, 8129], "disallowed_STD3_mapped", [32, 776, 834]], [[8130, 8130], "mapped", [8052, 953]], [[8131, 8131], "mapped", [951, 953]], [[8132, 8132], "mapped", [942, 953]], [[8133, 8133], "disallowed"], [[8134, 8134], "valid"], [[8135, 8135], "mapped", [8134, 953]], [[8136, 8136], "mapped", [8050]], [[8137, 8137], "mapped", [941]], [[8138, 8138], "mapped", [8052]], [[8139, 8139], "mapped", [942]], [[8140, 8140], "mapped", [951, 953]], [[8141, 8141], "disallowed_STD3_mapped", [32, 787, 768]], [[8142, 8142], "disallowed_STD3_mapped", [32, 787, 769]], [[8143, 8143], "disallowed_STD3_mapped", [32, 787, 834]], [[8144, 8146], "valid"], [[8147, 8147], "mapped", [912]], [[8148, 8149], "disallowed"], [[8150, 8151], "valid"], [[8152, 8152], "mapped", [8144]], [[8153, 8153], "mapped", [8145]], [[8154, 8154], "mapped", [8054]], [[8155, 8155], "mapped", [943]], [[8156, 8156], "disallowed"], [[8157, 8157], "disallowed_STD3_mapped", [32, 788, 768]], [[8158, 8158], "disallowed_STD3_mapped", [32, 788, 769]], [[8159, 8159], "disallowed_STD3_mapped", [32, 788, 834]], [[8160, 8162], "valid"], [[8163, 8163], "mapped", [944]], [[8164, 8167], "valid"], [[8168, 8168], "mapped", [8160]], [[8169, 8169], "mapped", [8161]], [[8170, 8170], "mapped", [8058]], [[8171, 8171], "mapped", [973]], [[8172, 8172], "mapped", [8165]], [[8173, 8173], "disallowed_STD3_mapped", [32, 776, 768]], [[8174, 8174], "disallowed_STD3_mapped", [32, 776, 769]], [[8175, 8175], "disallowed_STD3_mapped", [96]], [[8176, 8177], "disallowed"], [[8178, 8178], "mapped", [8060, 953]], [[8179, 8179], "mapped", [969, 953]], [[8180, 8180], "mapped", [974, 953]], [[8181, 8181], "disallowed"], [[8182, 8182], "valid"], [[8183, 8183], "mapped", [8182, 953]], [[8184, 8184], "mapped", [8056]], [[8185, 8185], "mapped", [972]], [[8186, 8186], "mapped", [8060]], [[8187, 8187], "mapped", [974]], [[8188, 8188], "mapped", [969, 953]], [[8189, 8189], "disallowed_STD3_mapped", [32, 769]], [[8190, 8190], "disallowed_STD3_mapped", [32, 788]], [[8191, 8191], "disallowed"], [[8192, 8202], "disallowed_STD3_mapped", [32]], [[8203, 8203], "ignored"], [[8204, 8205], "deviation", []], [[8206, 8207], "disallowed"], [[8208, 8208], "valid", [], "NV8"], [[8209, 8209], "mapped", [8208]], [[8210, 8214], "valid", [], "NV8"], [[8215, 8215], "disallowed_STD3_mapped", [32, 819]], [[8216, 8227], "valid", [], "NV8"], [[8228, 8230], "disallowed"], [[8231, 8231], "valid", [], "NV8"], [[8232, 8238], "disallowed"], [[8239, 8239], "disallowed_STD3_mapped", [32]], [[8240, 8242], "valid", [], "NV8"], [[8243, 8243], "mapped", [8242, 8242]], [[8244, 8244], "mapped", [8242, 8242, 8242]], [[8245, 8245], "valid", [], "NV8"], [[8246, 8246], "mapped", [8245, 8245]], [[8247, 8247], "mapped", [8245, 8245, 8245]], [[8248, 8251], "valid", [], "NV8"], [[8252, 8252], "disallowed_STD3_mapped", [33, 33]], [[8253, 8253], "valid", [], "NV8"], [[8254, 8254], "disallowed_STD3_mapped", [32, 773]], [[8255, 8262], "valid", [], "NV8"], [[8263, 8263], "disallowed_STD3_mapped", [63, 63]], [[8264, 8264], "disallowed_STD3_mapped", [63, 33]], [[8265, 8265], "disallowed_STD3_mapped", [33, 63]], [[8266, 8269], "valid", [], "NV8"], [[8270, 8274], "valid", [], "NV8"], [[8275, 8276], "valid", [], "NV8"], [[8277, 8278], "valid", [], "NV8"], [[8279, 8279], "mapped", [8242, 8242, 8242, 8242]], [[8280, 8286], "valid", [], "NV8"], [[8287, 8287], "disallowed_STD3_mapped", [32]], [[8288, 8288], "ignored"], [[8289, 8291], "disallowed"], [[8292, 8292], "ignored"], [[8293, 8293], "disallowed"], [[8294, 8297], "disallowed"], [[8298, 8303], "disallowed"], [[8304, 8304], "mapped", [48]], [[8305, 8305], "mapped", [105]], [[8306, 8307], "disallowed"], [[8308, 8308], "mapped", [52]], [[8309, 8309], "mapped", [53]], [[8310, 8310], "mapped", [54]], [[8311, 8311], "mapped", [55]], [[8312, 8312], "mapped", [56]], [[8313, 8313], "mapped", [57]], [[8314, 8314], "disallowed_STD3_mapped", [43]], [[8315, 8315], "mapped", [8722]], [[8316, 8316], "disallowed_STD3_mapped", [61]], [[8317, 8317], "disallowed_STD3_mapped", [40]], [[8318, 8318], "disallowed_STD3_mapped", [41]], [[8319, 8319], "mapped", [110]], [[8320, 8320], "mapped", [48]], [[8321, 8321], "mapped", [49]], [[8322, 8322], "mapped", [50]], [[8323, 8323], "mapped", [51]], [[8324, 8324], "mapped", [52]], [[8325, 8325], "mapped", [53]], [[8326, 8326], "mapped", [54]], [[8327, 8327], "mapped", [55]], [[8328, 8328], "mapped", [56]], [[8329, 8329], "mapped", [57]], [[8330, 8330], "disallowed_STD3_mapped", [43]], [[8331, 8331], "mapped", [8722]], [[8332, 8332], "disallowed_STD3_mapped", [61]], [[8333, 8333], "disallowed_STD3_mapped", [40]], [[8334, 8334], "disallowed_STD3_mapped", [41]], [[8335, 8335], "disallowed"], [[8336, 8336], "mapped", [97]], [[8337, 8337], "mapped", [101]], [[8338, 8338], "mapped", [111]], [[8339, 8339], "mapped", [120]], [[8340, 8340], "mapped", [601]], [[8341, 8341], "mapped", [104]], [[8342, 8342], "mapped", [107]], [[8343, 8343], "mapped", [108]], [[8344, 8344], "mapped", [109]], [[8345, 8345], "mapped", [110]], [[8346, 8346], "mapped", [112]], [[8347, 8347], "mapped", [115]], [[8348, 8348], "mapped", [116]], [[8349, 8351], "disallowed"], [[8352, 8359], "valid", [], "NV8"], [[8360, 8360], "mapped", [114, 115]], [[8361, 8362], "valid", [], "NV8"], [[8363, 8363], "valid", [], "NV8"], [[8364, 8364], "valid", [], "NV8"], [[8365, 8367], "valid", [], "NV8"], [[8368, 8369], "valid", [], "NV8"], [[8370, 8373], "valid", [], "NV8"], [[8374, 8376], "valid", [], "NV8"], [[8377, 8377], "valid", [], "NV8"], [[8378, 8378], "valid", [], "NV8"], [[8379, 8381], "valid", [], "NV8"], [[8382, 8382], "valid", [], "NV8"], [[8383, 8399], "disallowed"], [[8400, 8417], "valid", [], "NV8"], [[8418, 8419], "valid", [], "NV8"], [[8420, 8426], "valid", [], "NV8"], [[8427, 8427], "valid", [], "NV8"], [[8428, 8431], "valid", [], "NV8"], [[8432, 8432], "valid", [], "NV8"], [[8433, 8447], "disallowed"], [[8448, 8448], "disallowed_STD3_mapped", [97, 47, 99]], [[8449, 8449], "disallowed_STD3_mapped", [97, 47, 115]], [[8450, 8450], "mapped", [99]], [[8451, 8451], "mapped", [176, 99]], [[8452, 8452], "valid", [], "NV8"], [[8453, 8453], "disallowed_STD3_mapped", [99, 47, 111]], [[8454, 8454], "disallowed_STD3_mapped", [99, 47, 117]], [[8455, 8455], "mapped", [603]], [[8456, 8456], "valid", [], "NV8"], [[8457, 8457], "mapped", [176, 102]], [[8458, 8458], "mapped", [103]], [[8459, 8462], "mapped", [104]], [[8463, 8463], "mapped", [295]], [[8464, 8465], "mapped", [105]], [[8466, 8467], "mapped", [108]], [[8468, 8468], "valid", [], "NV8"], [[8469, 8469], "mapped", [110]], [[8470, 8470], "mapped", [110, 111]], [[8471, 8472], "valid", [], "NV8"], [[8473, 8473], "mapped", [112]], [[8474, 8474], "mapped", [113]], [[8475, 8477], "mapped", [114]], [[8478, 8479], "valid", [], "NV8"], [[8480, 8480], "mapped", [115, 109]], [[8481, 8481], "mapped", [116, 101, 108]], [[8482, 8482], "mapped", [116, 109]], [[8483, 8483], "valid", [], "NV8"], [[8484, 8484], "mapped", [122]], [[8485, 8485], "valid", [], "NV8"], [[8486, 8486], "mapped", [969]], [[8487, 8487], "valid", [], "NV8"], [[8488, 8488], "mapped", [122]], [[8489, 8489], "valid", [], "NV8"], [[8490, 8490], "mapped", [107]], [[8491, 8491], "mapped", [229]], [[8492, 8492], "mapped", [98]], [[8493, 8493], "mapped", [99]], [[8494, 8494], "valid", [], "NV8"], [[8495, 8496], "mapped", [101]], [[8497, 8497], "mapped", [102]], [[8498, 8498], "disallowed"], [[8499, 8499], "mapped", [109]], [[8500, 8500], "mapped", [111]], [[8501, 8501], "mapped", [1488]], [[8502, 8502], "mapped", [1489]], [[8503, 8503], "mapped", [1490]], [[8504, 8504], "mapped", [1491]], [[8505, 8505], "mapped", [105]], [[8506, 8506], "valid", [], "NV8"], [[8507, 8507], "mapped", [102, 97, 120]], [[8508, 8508], "mapped", [960]], [[8509, 8510], "mapped", [947]], [[8511, 8511], "mapped", [960]], [[8512, 8512], "mapped", [8721]], [[8513, 8516], "valid", [], "NV8"], [[8517, 8518], "mapped", [100]], [[8519, 8519], "mapped", [101]], [[8520, 8520], "mapped", [105]], [[8521, 8521], "mapped", [106]], [[8522, 8523], "valid", [], "NV8"], [[8524, 8524], "valid", [], "NV8"], [[8525, 8525], "valid", [], "NV8"], [[8526, 8526], "valid"], [[8527, 8527], "valid", [], "NV8"], [[8528, 8528], "mapped", [49, 8260, 55]], [[8529, 8529], "mapped", [49, 8260, 57]], [[8530, 8530], "mapped", [49, 8260, 49, 48]], [[8531, 8531], "mapped", [49, 8260, 51]], [[8532, 8532], "mapped", [50, 8260, 51]], [[8533, 8533], "mapped", [49, 8260, 53]], [[8534, 8534], "mapped", [50, 8260, 53]], [[8535, 8535], "mapped", [51, 8260, 53]], [[8536, 8536], "mapped", [52, 8260, 53]], [[8537, 8537], "mapped", [49, 8260, 54]], [[8538, 8538], "mapped", [53, 8260, 54]], [[8539, 8539], "mapped", [49, 8260, 56]], [[8540, 8540], "mapped", [51, 8260, 56]], [[8541, 8541], "mapped", [53, 8260, 56]], [[8542, 8542], "mapped", [55, 8260, 56]], [[8543, 8543], "mapped", [49, 8260]], [[8544, 8544], "mapped", [105]], [[8545, 8545], "mapped", [105, 105]], [[8546, 8546], "mapped", [105, 105, 105]], [[8547, 8547], "mapped", [105, 118]], [[8548, 8548], "mapped", [118]], [[8549, 8549], "mapped", [118, 105]], [[8550, 8550], "mapped", [118, 105, 105]], [[8551, 8551], "mapped", [118, 105, 105, 105]], [[8552, 8552], "mapped", [105, 120]], [[8553, 8553], "mapped", [120]], [[8554, 8554], "mapped", [120, 105]], [[8555, 8555], "mapped", [120, 105, 105]], [[8556, 8556], "mapped", [108]], [[8557, 8557], "mapped", [99]], [[8558, 8558], "mapped", [100]], [[8559, 8559], "mapped", [109]], [[8560, 8560], "mapped", [105]], [[8561, 8561], "mapped", [105, 105]], [[8562, 8562], "mapped", [105, 105, 105]], [[8563, 8563], "mapped", [105, 118]], [[8564, 8564], "mapped", [118]], [[8565, 8565], "mapped", [118, 105]], [[8566, 8566], "mapped", [118, 105, 105]], [[8567, 8567], "mapped", [118, 105, 105, 105]], [[8568, 8568], "mapped", [105, 120]], [[8569, 8569], "mapped", [120]], [[8570, 8570], "mapped", [120, 105]], [[8571, 8571], "mapped", [120, 105, 105]], [[8572, 8572], "mapped", [108]], [[8573, 8573], "mapped", [99]], [[8574, 8574], "mapped", [100]], [[8575, 8575], "mapped", [109]], [[8576, 8578], "valid", [], "NV8"], [[8579, 8579], "disallowed"], [[8580, 8580], "valid"], [[8581, 8584], "valid", [], "NV8"], [[8585, 8585], "mapped", [48, 8260, 51]], [[8586, 8587], "valid", [], "NV8"], [[8588, 8591], "disallowed"], [[8592, 8682], "valid", [], "NV8"], [[8683, 8691], "valid", [], "NV8"], [[8692, 8703], "valid", [], "NV8"], [[8704, 8747], "valid", [], "NV8"], [[8748, 8748], "mapped", [8747, 8747]], [[8749, 8749], "mapped", [8747, 8747, 8747]], [[8750, 8750], "valid", [], "NV8"], [[8751, 8751], "mapped", [8750, 8750]], [[8752, 8752], "mapped", [8750, 8750, 8750]], [[8753, 8799], "valid", [], "NV8"], [[8800, 8800], "disallowed_STD3_valid"], [[8801, 8813], "valid", [], "NV8"], [[8814, 8815], "disallowed_STD3_valid"], [[8816, 8945], "valid", [], "NV8"], [[8946, 8959], "valid", [], "NV8"], [[8960, 8960], "valid", [], "NV8"], [[8961, 8961], "valid", [], "NV8"], [[8962, 9e3], "valid", [], "NV8"], [[9001, 9001], "mapped", [12296]], [[9002, 9002], "mapped", [12297]], [[9003, 9082], "valid", [], "NV8"], [[9083, 9083], "valid", [], "NV8"], [[9084, 9084], "valid", [], "NV8"], [[9085, 9114], "valid", [], "NV8"], [[9115, 9166], "valid", [], "NV8"], [[9167, 9168], "valid", [], "NV8"], [[9169, 9179], "valid", [], "NV8"], [[9180, 9191], "valid", [], "NV8"], [[9192, 9192], "valid", [], "NV8"], [[9193, 9203], "valid", [], "NV8"], [[9204, 9210], "valid", [], "NV8"], [[9211, 9215], "disallowed"], [[9216, 9252], "valid", [], "NV8"], [[9253, 9254], "valid", [], "NV8"], [[9255, 9279], "disallowed"], [[9280, 9290], "valid", [], "NV8"], [[9291, 9311], "disallowed"], [[9312, 9312], "mapped", [49]], [[9313, 9313], "mapped", [50]], [[9314, 9314], "mapped", [51]], [[9315, 9315], "mapped", [52]], [[9316, 9316], "mapped", [53]], [[9317, 9317], "mapped", [54]], [[9318, 9318], "mapped", [55]], [[9319, 9319], "mapped", [56]], [[9320, 9320], "mapped", [57]], [[9321, 9321], "mapped", [49, 48]], [[9322, 9322], "mapped", [49, 49]], [[9323, 9323], "mapped", [49, 50]], [[9324, 9324], "mapped", [49, 51]], [[9325, 9325], "mapped", [49, 52]], [[9326, 9326], "mapped", [49, 53]], [[9327, 9327], "mapped", [49, 54]], [[9328, 9328], "mapped", [49, 55]], [[9329, 9329], "mapped", [49, 56]], [[9330, 9330], "mapped", [49, 57]], [[9331, 9331], "mapped", [50, 48]], [[9332, 9332], "disallowed_STD3_mapped", [40, 49, 41]], [[9333, 9333], "disallowed_STD3_mapped", [40, 50, 41]], [[9334, 9334], "disallowed_STD3_mapped", [40, 51, 41]], [[9335, 9335], "disallowed_STD3_mapped", [40, 52, 41]], [[9336, 9336], "disallowed_STD3_mapped", [40, 53, 41]], [[9337, 9337], "disallowed_STD3_mapped", [40, 54, 41]], [[9338, 9338], "disallowed_STD3_mapped", [40, 55, 41]], [[9339, 9339], "disallowed_STD3_mapped", [40, 56, 41]], [[9340, 9340], "disallowed_STD3_mapped", [40, 57, 41]], [[9341, 9341], "disallowed_STD3_mapped", [40, 49, 48, 41]], [[9342, 9342], "disallowed_STD3_mapped", [40, 49, 49, 41]], [[9343, 9343], "disallowed_STD3_mapped", [40, 49, 50, 41]], [[9344, 9344], "disallowed_STD3_mapped", [40, 49, 51, 41]], [[9345, 9345], "disallowed_STD3_mapped", [40, 49, 52, 41]], [[9346, 9346], "disallowed_STD3_mapped", [40, 49, 53, 41]], [[9347, 9347], "disallowed_STD3_mapped", [40, 49, 54, 41]], [[9348, 9348], "disallowed_STD3_mapped", [40, 49, 55, 41]], [[9349, 9349], "disallowed_STD3_mapped", [40, 49, 56, 41]], [[9350, 9350], "disallowed_STD3_mapped", [40, 49, 57, 41]], [[9351, 9351], "disallowed_STD3_mapped", [40, 50, 48, 41]], [[9352, 9371], "disallowed"], [[9372, 9372], "disallowed_STD3_mapped", [40, 97, 41]], [[9373, 9373], "disallowed_STD3_mapped", [40, 98, 41]], [[9374, 9374], "disallowed_STD3_mapped", [40, 99, 41]], [[9375, 9375], "disallowed_STD3_mapped", [40, 100, 41]], [[9376, 9376], "disallowed_STD3_mapped", [40, 101, 41]], [[9377, 9377], "disallowed_STD3_mapped", [40, 102, 41]], [[9378, 9378], "disallowed_STD3_mapped", [40, 103, 41]], [[9379, 9379], "disallowed_STD3_mapped", [40, 104, 41]], [[9380, 9380], "disallowed_STD3_mapped", [40, 105, 41]], [[9381, 9381], "disallowed_STD3_mapped", [40, 106, 41]], [[9382, 9382], "disallowed_STD3_mapped", [40, 107, 41]], [[9383, 9383], "disallowed_STD3_mapped", [40, 108, 41]], [[9384, 9384], "disallowed_STD3_mapped", [40, 109, 41]], [[9385, 9385], "disallowed_STD3_mapped", [40, 110, 41]], [[9386, 9386], "disallowed_STD3_mapped", [40, 111, 41]], [[9387, 9387], "disallowed_STD3_mapped", [40, 112, 41]], [[9388, 9388], "disallowed_STD3_mapped", [40, 113, 41]], [[9389, 9389], "disallowed_STD3_mapped", [40, 114, 41]], [[9390, 9390], "disallowed_STD3_mapped", [40, 115, 41]], [[9391, 9391], "disallowed_STD3_mapped", [40, 116, 41]], [[9392, 9392], "disallowed_STD3_mapped", [40, 117, 41]], [[9393, 9393], "disallowed_STD3_mapped", [40, 118, 41]], [[9394, 9394], "disallowed_STD3_mapped", [40, 119, 41]], [[9395, 9395], "disallowed_STD3_mapped", [40, 120, 41]], [[9396, 9396], "disallowed_STD3_mapped", [40, 121, 41]], [[9397, 9397], "disallowed_STD3_mapped", [40, 122, 41]], [[9398, 9398], "mapped", [97]], [[9399, 9399], "mapped", [98]], [[9400, 9400], "mapped", [99]], [[9401, 9401], "mapped", [100]], [[9402, 9402], "mapped", [101]], [[9403, 9403], "mapped", [102]], [[9404, 9404], "mapped", [103]], [[9405, 9405], "mapped", [104]], [[9406, 9406], "mapped", [105]], [[9407, 9407], "mapped", [106]], [[9408, 9408], "mapped", [107]], [[9409, 9409], "mapped", [108]], [[9410, 9410], "mapped", [109]], [[9411, 9411], "mapped", [110]], [[9412, 9412], "mapped", [111]], [[9413, 9413], "mapped", [112]], [[9414, 9414], "mapped", [113]], [[9415, 9415], "mapped", [114]], [[9416, 9416], "mapped", [115]], [[9417, 9417], "mapped", [116]], [[9418, 9418], "mapped", [117]], [[9419, 9419], "mapped", [118]], [[9420, 9420], "mapped", [119]], [[9421, 9421], "mapped", [120]], [[9422, 9422], "mapped", [121]], [[9423, 9423], "mapped", [122]], [[9424, 9424], "mapped", [97]], [[9425, 9425], "mapped", [98]], [[9426, 9426], "mapped", [99]], [[9427, 9427], "mapped", [100]], [[9428, 9428], "mapped", [101]], [[9429, 9429], "mapped", [102]], [[9430, 9430], "mapped", [103]], [[9431, 9431], "mapped", [104]], [[9432, 9432], "mapped", [105]], [[9433, 9433], "mapped", [106]], [[9434, 9434], "mapped", [107]], [[9435, 9435], "mapped", [108]], [[9436, 9436], "mapped", [109]], [[9437, 9437], "mapped", [110]], [[9438, 9438], "mapped", [111]], [[9439, 9439], "mapped", [112]], [[9440, 9440], "mapped", [113]], [[9441, 9441], "mapped", [114]], [[9442, 9442], "mapped", [115]], [[9443, 9443], "mapped", [116]], [[9444, 9444], "mapped", [117]], [[9445, 9445], "mapped", [118]], [[9446, 9446], "mapped", [119]], [[9447, 9447], "mapped", [120]], [[9448, 9448], "mapped", [121]], [[9449, 9449], "mapped", [122]], [[9450, 9450], "mapped", [48]], [[9451, 9470], "valid", [], "NV8"], [[9471, 9471], "valid", [], "NV8"], [[9472, 9621], "valid", [], "NV8"], [[9622, 9631], "valid", [], "NV8"], [[9632, 9711], "valid", [], "NV8"], [[9712, 9719], "valid", [], "NV8"], [[9720, 9727], "valid", [], "NV8"], [[9728, 9747], "valid", [], "NV8"], [[9748, 9749], "valid", [], "NV8"], [[9750, 9751], "valid", [], "NV8"], [[9752, 9752], "valid", [], "NV8"], [[9753, 9753], "valid", [], "NV8"], [[9754, 9839], "valid", [], "NV8"], [[9840, 9841], "valid", [], "NV8"], [[9842, 9853], "valid", [], "NV8"], [[9854, 9855], "valid", [], "NV8"], [[9856, 9865], "valid", [], "NV8"], [[9866, 9873], "valid", [], "NV8"], [[9874, 9884], "valid", [], "NV8"], [[9885, 9885], "valid", [], "NV8"], [[9886, 9887], "valid", [], "NV8"], [[9888, 9889], "valid", [], "NV8"], [[9890, 9905], "valid", [], "NV8"], [[9906, 9906], "valid", [], "NV8"], [[9907, 9916], "valid", [], "NV8"], [[9917, 9919], "valid", [], "NV8"], [[9920, 9923], "valid", [], "NV8"], [[9924, 9933], "valid", [], "NV8"], [[9934, 9934], "valid", [], "NV8"], [[9935, 9953], "valid", [], "NV8"], [[9954, 9954], "valid", [], "NV8"], [[9955, 9955], "valid", [], "NV8"], [[9956, 9959], "valid", [], "NV8"], [[9960, 9983], "valid", [], "NV8"], [[9984, 9984], "valid", [], "NV8"], [[9985, 9988], "valid", [], "NV8"], [[9989, 9989], "valid", [], "NV8"], [[9990, 9993], "valid", [], "NV8"], [[9994, 9995], "valid", [], "NV8"], [[9996, 10023], "valid", [], "NV8"], [[10024, 10024], "valid", [], "NV8"], [[10025, 10059], "valid", [], "NV8"], [[10060, 10060], "valid", [], "NV8"], [[10061, 10061], "valid", [], "NV8"], [[10062, 10062], "valid", [], "NV8"], [[10063, 10066], "valid", [], "NV8"], [[10067, 10069], "valid", [], "NV8"], [[10070, 10070], "valid", [], "NV8"], [[10071, 10071], "valid", [], "NV8"], [[10072, 10078], "valid", [], "NV8"], [[10079, 10080], "valid", [], "NV8"], [[10081, 10087], "valid", [], "NV8"], [[10088, 10101], "valid", [], "NV8"], [[10102, 10132], "valid", [], "NV8"], [[10133, 10135], "valid", [], "NV8"], [[10136, 10159], "valid", [], "NV8"], [[10160, 10160], "valid", [], "NV8"], [[10161, 10174], "valid", [], "NV8"], [[10175, 10175], "valid", [], "NV8"], [[10176, 10182], "valid", [], "NV8"], [[10183, 10186], "valid", [], "NV8"], [[10187, 10187], "valid", [], "NV8"], [[10188, 10188], "valid", [], "NV8"], [[10189, 10189], "valid", [], "NV8"], [[10190, 10191], "valid", [], "NV8"], [[10192, 10219], "valid", [], "NV8"], [[10220, 10223], "valid", [], "NV8"], [[10224, 10239], "valid", [], "NV8"], [[10240, 10495], "valid", [], "NV8"], [[10496, 10763], "valid", [], "NV8"], [[10764, 10764], "mapped", [8747, 8747, 8747, 8747]], [[10765, 10867], "valid", [], "NV8"], [[10868, 10868], "disallowed_STD3_mapped", [58, 58, 61]], [[10869, 10869], "disallowed_STD3_mapped", [61, 61]], [[10870, 10870], "disallowed_STD3_mapped", [61, 61, 61]], [[10871, 10971], "valid", [], "NV8"], [[10972, 10972], "mapped", [10973, 824]], [[10973, 11007], "valid", [], "NV8"], [[11008, 11021], "valid", [], "NV8"], [[11022, 11027], "valid", [], "NV8"], [[11028, 11034], "valid", [], "NV8"], [[11035, 11039], "valid", [], "NV8"], [[11040, 11043], "valid", [], "NV8"], [[11044, 11084], "valid", [], "NV8"], [[11085, 11087], "valid", [], "NV8"], [[11088, 11092], "valid", [], "NV8"], [[11093, 11097], "valid", [], "NV8"], [[11098, 11123], "valid", [], "NV8"], [[11124, 11125], "disallowed"], [[11126, 11157], "valid", [], "NV8"], [[11158, 11159], "disallowed"], [[11160, 11193], "valid", [], "NV8"], [[11194, 11196], "disallowed"], [[11197, 11208], "valid", [], "NV8"], [[11209, 11209], "disallowed"], [[11210, 11217], "valid", [], "NV8"], [[11218, 11243], "disallowed"], [[11244, 11247], "valid", [], "NV8"], [[11248, 11263], "disallowed"], [[11264, 11264], "mapped", [11312]], [[11265, 11265], "mapped", [11313]], [[11266, 11266], "mapped", [11314]], [[11267, 11267], "mapped", [11315]], [[11268, 11268], "mapped", [11316]], [[11269, 11269], "mapped", [11317]], [[11270, 11270], "mapped", [11318]], [[11271, 11271], "mapped", [11319]], [[11272, 11272], "mapped", [11320]], [[11273, 11273], "mapped", [11321]], [[11274, 11274], "mapped", [11322]], [[11275, 11275], "mapped", [11323]], [[11276, 11276], "mapped", [11324]], [[11277, 11277], "mapped", [11325]], [[11278, 11278], "mapped", [11326]], [[11279, 11279], "mapped", [11327]], [[11280, 11280], "mapped", [11328]], [[11281, 11281], "mapped", [11329]], [[11282, 11282], "mapped", [11330]], [[11283, 11283], "mapped", [11331]], [[11284, 11284], "mapped", [11332]], [[11285, 11285], "mapped", [11333]], [[11286, 11286], "mapped", [11334]], [[11287, 11287], "mapped", [11335]], [[11288, 11288], "mapped", [11336]], [[11289, 11289], "mapped", [11337]], [[11290, 11290], "mapped", [11338]], [[11291, 11291], "mapped", [11339]], [[11292, 11292], "mapped", [11340]], [[11293, 11293], "mapped", [11341]], [[11294, 11294], "mapped", [11342]], [[11295, 11295], "mapped", [11343]], [[11296, 11296], "mapped", [11344]], [[11297, 11297], "mapped", [11345]], [[11298, 11298], "mapped", [11346]], [[11299, 11299], "mapped", [11347]], [[11300, 11300], "mapped", [11348]], [[11301, 11301], "mapped", [11349]], [[11302, 11302], "mapped", [11350]], [[11303, 11303], "mapped", [11351]], [[11304, 11304], "mapped", [11352]], [[11305, 11305], "mapped", [11353]], [[11306, 11306], "mapped", [11354]], [[11307, 11307], "mapped", [11355]], [[11308, 11308], "mapped", [11356]], [[11309, 11309], "mapped", [11357]], [[11310, 11310], "mapped", [11358]], [[11311, 11311], "disallowed"], [[11312, 11358], "valid"], [[11359, 11359], "disallowed"], [[11360, 11360], "mapped", [11361]], [[11361, 11361], "valid"], [[11362, 11362], "mapped", [619]], [[11363, 11363], "mapped", [7549]], [[11364, 11364], "mapped", [637]], [[11365, 11366], "valid"], [[11367, 11367], "mapped", [11368]], [[11368, 11368], "valid"], [[11369, 11369], "mapped", [11370]], [[11370, 11370], "valid"], [[11371, 11371], "mapped", [11372]], [[11372, 11372], "valid"], [[11373, 11373], "mapped", [593]], [[11374, 11374], "mapped", [625]], [[11375, 11375], "mapped", [592]], [[11376, 11376], "mapped", [594]], [[11377, 11377], "valid"], [[11378, 11378], "mapped", [11379]], [[11379, 11379], "valid"], [[11380, 11380], "valid"], [[11381, 11381], "mapped", [11382]], [[11382, 11383], "valid"], [[11384, 11387], "valid"], [[11388, 11388], "mapped", [106]], [[11389, 11389], "mapped", [118]], [[11390, 11390], "mapped", [575]], [[11391, 11391], "mapped", [576]], [[11392, 11392], "mapped", [11393]], [[11393, 11393], "valid"], [[11394, 11394], "mapped", [11395]], [[11395, 11395], "valid"], [[11396, 11396], "mapped", [11397]], [[11397, 11397], "valid"], [[11398, 11398], "mapped", [11399]], [[11399, 11399], "valid"], [[11400, 11400], "mapped", [11401]], [[11401, 11401], "valid"], [[11402, 11402], "mapped", [11403]], [[11403, 11403], "valid"], [[11404, 11404], "mapped", [11405]], [[11405, 11405], "valid"], [[11406, 11406], "mapped", [11407]], [[11407, 11407], "valid"], [[11408, 11408], "mapped", [11409]], [[11409, 11409], "valid"], [[11410, 11410], "mapped", [11411]], [[11411, 11411], "valid"], [[11412, 11412], "mapped", [11413]], [[11413, 11413], "valid"], [[11414, 11414], "mapped", [11415]], [[11415, 11415], "valid"], [[11416, 11416], "mapped", [11417]], [[11417, 11417], "valid"], [[11418, 11418], "mapped", [11419]], [[11419, 11419], "valid"], [[11420, 11420], "mapped", [11421]], [[11421, 11421], "valid"], [[11422, 11422], "mapped", [11423]], [[11423, 11423], "valid"], [[11424, 11424], "mapped", [11425]], [[11425, 11425], "valid"], [[11426, 11426], "mapped", [11427]], [[11427, 11427], "valid"], [[11428, 11428], "mapped", [11429]], [[11429, 11429], "valid"], [[11430, 11430], "mapped", [11431]], [[11431, 11431], "valid"], [[11432, 11432], "mapped", [11433]], [[11433, 11433], "valid"], [[11434, 11434], "mapped", [11435]], [[11435, 11435], "valid"], [[11436, 11436], "mapped", [11437]], [[11437, 11437], "valid"], [[11438, 11438], "mapped", [11439]], [[11439, 11439], "valid"], [[11440, 11440], "mapped", [11441]], [[11441, 11441], "valid"], [[11442, 11442], "mapped", [11443]], [[11443, 11443], "valid"], [[11444, 11444], "mapped", [11445]], [[11445, 11445], "valid"], [[11446, 11446], "mapped", [11447]], [[11447, 11447], "valid"], [[11448, 11448], "mapped", [11449]], [[11449, 11449], "valid"], [[11450, 11450], "mapped", [11451]], [[11451, 11451], "valid"], [[11452, 11452], "mapped", [11453]], [[11453, 11453], "valid"], [[11454, 11454], "mapped", [11455]], [[11455, 11455], "valid"], [[11456, 11456], "mapped", [11457]], [[11457, 11457], "valid"], [[11458, 11458], "mapped", [11459]], [[11459, 11459], "valid"], [[11460, 11460], "mapped", [11461]], [[11461, 11461], "valid"], [[11462, 11462], "mapped", [11463]], [[11463, 11463], "valid"], [[11464, 11464], "mapped", [11465]], [[11465, 11465], "valid"], [[11466, 11466], "mapped", [11467]], [[11467, 11467], "valid"], [[11468, 11468], "mapped", [11469]], [[11469, 11469], "valid"], [[11470, 11470], "mapped", [11471]], [[11471, 11471], "valid"], [[11472, 11472], "mapped", [11473]], [[11473, 11473], "valid"], [[11474, 11474], "mapped", [11475]], [[11475, 11475], "valid"], [[11476, 11476], "mapped", [11477]], [[11477, 11477], "valid"], [[11478, 11478], "mapped", [11479]], [[11479, 11479], "valid"], [[11480, 11480], "mapped", [11481]], [[11481, 11481], "valid"], [[11482, 11482], "mapped", [11483]], [[11483, 11483], "valid"], [[11484, 11484], "mapped", [11485]], [[11485, 11485], "valid"], [[11486, 11486], "mapped", [11487]], [[11487, 11487], "valid"], [[11488, 11488], "mapped", [11489]], [[11489, 11489], "valid"], [[11490, 11490], "mapped", [11491]], [[11491, 11492], "valid"], [[11493, 11498], "valid", [], "NV8"], [[11499, 11499], "mapped", [11500]], [[11500, 11500], "valid"], [[11501, 11501], "mapped", [11502]], [[11502, 11505], "valid"], [[11506, 11506], "mapped", [11507]], [[11507, 11507], "valid"], [[11508, 11512], "disallowed"], [[11513, 11519], "valid", [], "NV8"], [[11520, 11557], "valid"], [[11558, 11558], "disallowed"], [[11559, 11559], "valid"], [[11560, 11564], "disallowed"], [[11565, 11565], "valid"], [[11566, 11567], "disallowed"], [[11568, 11621], "valid"], [[11622, 11623], "valid"], [[11624, 11630], "disallowed"], [[11631, 11631], "mapped", [11617]], [[11632, 11632], "valid", [], "NV8"], [[11633, 11646], "disallowed"], [[11647, 11647], "valid"], [[11648, 11670], "valid"], [[11671, 11679], "disallowed"], [[11680, 11686], "valid"], [[11687, 11687], "disallowed"], [[11688, 11694], "valid"], [[11695, 11695], "disallowed"], [[11696, 11702], "valid"], [[11703, 11703], "disallowed"], [[11704, 11710], "valid"], [[11711, 11711], "disallowed"], [[11712, 11718], "valid"], [[11719, 11719], "disallowed"], [[11720, 11726], "valid"], [[11727, 11727], "disallowed"], [[11728, 11734], "valid"], [[11735, 11735], "disallowed"], [[11736, 11742], "valid"], [[11743, 11743], "disallowed"], [[11744, 11775], "valid"], [[11776, 11799], "valid", [], "NV8"], [[11800, 11803], "valid", [], "NV8"], [[11804, 11805], "valid", [], "NV8"], [[11806, 11822], "valid", [], "NV8"], [[11823, 11823], "valid"], [[11824, 11824], "valid", [], "NV8"], [[11825, 11825], "valid", [], "NV8"], [[11826, 11835], "valid", [], "NV8"], [[11836, 11842], "valid", [], "NV8"], [[11843, 11903], "disallowed"], [[11904, 11929], "valid", [], "NV8"], [[11930, 11930], "disallowed"], [[11931, 11934], "valid", [], "NV8"], [[11935, 11935], "mapped", [27597]], [[11936, 12018], "valid", [], "NV8"], [[12019, 12019], "mapped", [40863]], [[12020, 12031], "disallowed"], [[12032, 12032], "mapped", [19968]], [[12033, 12033], "mapped", [20008]], [[12034, 12034], "mapped", [20022]], [[12035, 12035], "mapped", [20031]], [[12036, 12036], "mapped", [20057]], [[12037, 12037], "mapped", [20101]], [[12038, 12038], "mapped", [20108]], [[12039, 12039], "mapped", [20128]], [[12040, 12040], "mapped", [20154]], [[12041, 12041], "mapped", [20799]], [[12042, 12042], "mapped", [20837]], [[12043, 12043], "mapped", [20843]], [[12044, 12044], "mapped", [20866]], [[12045, 12045], "mapped", [20886]], [[12046, 12046], "mapped", [20907]], [[12047, 12047], "mapped", [20960]], [[12048, 12048], "mapped", [20981]], [[12049, 12049], "mapped", [20992]], [[12050, 12050], "mapped", [21147]], [[12051, 12051], "mapped", [21241]], [[12052, 12052], "mapped", [21269]], [[12053, 12053], "mapped", [21274]], [[12054, 12054], "mapped", [21304]], [[12055, 12055], "mapped", [21313]], [[12056, 12056], "mapped", [21340]], [[12057, 12057], "mapped", [21353]], [[12058, 12058], "mapped", [21378]], [[12059, 12059], "mapped", [21430]], [[12060, 12060], "mapped", [21448]], [[12061, 12061], "mapped", [21475]], [[12062, 12062], "mapped", [22231]], [[12063, 12063], "mapped", [22303]], [[12064, 12064], "mapped", [22763]], [[12065, 12065], "mapped", [22786]], [[12066, 12066], "mapped", [22794]], [[12067, 12067], "mapped", [22805]], [[12068, 12068], "mapped", [22823]], [[12069, 12069], "mapped", [22899]], [[12070, 12070], "mapped", [23376]], [[12071, 12071], "mapped", [23424]], [[12072, 12072], "mapped", [23544]], [[12073, 12073], "mapped", [23567]], [[12074, 12074], "mapped", [23586]], [[12075, 12075], "mapped", [23608]], [[12076, 12076], "mapped", [23662]], [[12077, 12077], "mapped", [23665]], [[12078, 12078], "mapped", [24027]], [[12079, 12079], "mapped", [24037]], [[12080, 12080], "mapped", [24049]], [[12081, 12081], "mapped", [24062]], [[12082, 12082], "mapped", [24178]], [[12083, 12083], "mapped", [24186]], [[12084, 12084], "mapped", [24191]], [[12085, 12085], "mapped", [24308]], [[12086, 12086], "mapped", [24318]], [[12087, 12087], "mapped", [24331]], [[12088, 12088], "mapped", [24339]], [[12089, 12089], "mapped", [24400]], [[12090, 12090], "mapped", [24417]], [[12091, 12091], "mapped", [24435]], [[12092, 12092], "mapped", [24515]], [[12093, 12093], "mapped", [25096]], [[12094, 12094], "mapped", [25142]], [[12095, 12095], "mapped", [25163]], [[12096, 12096], "mapped", [25903]], [[12097, 12097], "mapped", [25908]], [[12098, 12098], "mapped", [25991]], [[12099, 12099], "mapped", [26007]], [[12100, 12100], "mapped", [26020]], [[12101, 12101], "mapped", [26041]], [[12102, 12102], "mapped", [26080]], [[12103, 12103], "mapped", [26085]], [[12104, 12104], "mapped", [26352]], [[12105, 12105], "mapped", [26376]], [[12106, 12106], "mapped", [26408]], [[12107, 12107], "mapped", [27424]], [[12108, 12108], "mapped", [27490]], [[12109, 12109], "mapped", [27513]], [[12110, 12110], "mapped", [27571]], [[12111, 12111], "mapped", [27595]], [[12112, 12112], "mapped", [27604]], [[12113, 12113], "mapped", [27611]], [[12114, 12114], "mapped", [27663]], [[12115, 12115], "mapped", [27668]], [[12116, 12116], "mapped", [27700]], [[12117, 12117], "mapped", [28779]], [[12118, 12118], "mapped", [29226]], [[12119, 12119], "mapped", [29238]], [[12120, 12120], "mapped", [29243]], [[12121, 12121], "mapped", [29247]], [[12122, 12122], "mapped", [29255]], [[12123, 12123], "mapped", [29273]], [[12124, 12124], "mapped", [29275]], [[12125, 12125], "mapped", [29356]], [[12126, 12126], "mapped", [29572]], [[12127, 12127], "mapped", [29577]], [[12128, 12128], "mapped", [29916]], [[12129, 12129], "mapped", [29926]], [[12130, 12130], "mapped", [29976]], [[12131, 12131], "mapped", [29983]], [[12132, 12132], "mapped", [29992]], [[12133, 12133], "mapped", [3e4]], [[12134, 12134], "mapped", [30091]], [[12135, 12135], "mapped", [30098]], [[12136, 12136], "mapped", [30326]], [[12137, 12137], "mapped", [30333]], [[12138, 12138], "mapped", [30382]], [[12139, 12139], "mapped", [30399]], [[12140, 12140], "mapped", [30446]], [[12141, 12141], "mapped", [30683]], [[12142, 12142], "mapped", [30690]], [[12143, 12143], "mapped", [30707]], [[12144, 12144], "mapped", [31034]], [[12145, 12145], "mapped", [31160]], [[12146, 12146], "mapped", [31166]], [[12147, 12147], "mapped", [31348]], [[12148, 12148], "mapped", [31435]], [[12149, 12149], "mapped", [31481]], [[12150, 12150], "mapped", [31859]], [[12151, 12151], "mapped", [31992]], [[12152, 12152], "mapped", [32566]], [[12153, 12153], "mapped", [32593]], [[12154, 12154], "mapped", [32650]], [[12155, 12155], "mapped", [32701]], [[12156, 12156], "mapped", [32769]], [[12157, 12157], "mapped", [32780]], [[12158, 12158], "mapped", [32786]], [[12159, 12159], "mapped", [32819]], [[12160, 12160], "mapped", [32895]], [[12161, 12161], "mapped", [32905]], [[12162, 12162], "mapped", [33251]], [[12163, 12163], "mapped", [33258]], [[12164, 12164], "mapped", [33267]], [[12165, 12165], "mapped", [33276]], [[12166, 12166], "mapped", [33292]], [[12167, 12167], "mapped", [33307]], [[12168, 12168], "mapped", [33311]], [[12169, 12169], "mapped", [33390]], [[12170, 12170], "mapped", [33394]], [[12171, 12171], "mapped", [33400]], [[12172, 12172], "mapped", [34381]], [[12173, 12173], "mapped", [34411]], [[12174, 12174], "mapped", [34880]], [[12175, 12175], "mapped", [34892]], [[12176, 12176], "mapped", [34915]], [[12177, 12177], "mapped", [35198]], [[12178, 12178], "mapped", [35211]], [[12179, 12179], "mapped", [35282]], [[12180, 12180], "mapped", [35328]], [[12181, 12181], "mapped", [35895]], [[12182, 12182], "mapped", [35910]], [[12183, 12183], "mapped", [35925]], [[12184, 12184], "mapped", [35960]], [[12185, 12185], "mapped", [35997]], [[12186, 12186], "mapped", [36196]], [[12187, 12187], "mapped", [36208]], [[12188, 12188], "mapped", [36275]], [[12189, 12189], "mapped", [36523]], [[12190, 12190], "mapped", [36554]], [[12191, 12191], "mapped", [36763]], [[12192, 12192], "mapped", [36784]], [[12193, 12193], "mapped", [36789]], [[12194, 12194], "mapped", [37009]], [[12195, 12195], "mapped", [37193]], [[12196, 12196], "mapped", [37318]], [[12197, 12197], "mapped", [37324]], [[12198, 12198], "mapped", [37329]], [[12199, 12199], "mapped", [38263]], [[12200, 12200], "mapped", [38272]], [[12201, 12201], "mapped", [38428]], [[12202, 12202], "mapped", [38582]], [[12203, 12203], "mapped", [38585]], [[12204, 12204], "mapped", [38632]], [[12205, 12205], "mapped", [38737]], [[12206, 12206], "mapped", [38750]], [[12207, 12207], "mapped", [38754]], [[12208, 12208], "mapped", [38761]], [[12209, 12209], "mapped", [38859]], [[12210, 12210], "mapped", [38893]], [[12211, 12211], "mapped", [38899]], [[12212, 12212], "mapped", [38913]], [[12213, 12213], "mapped", [39080]], [[12214, 12214], "mapped", [39131]], [[12215, 12215], "mapped", [39135]], [[12216, 12216], "mapped", [39318]], [[12217, 12217], "mapped", [39321]], [[12218, 12218], "mapped", [39340]], [[12219, 12219], "mapped", [39592]], [[12220, 12220], "mapped", [39640]], [[12221, 12221], "mapped", [39647]], [[12222, 12222], "mapped", [39717]], [[12223, 12223], "mapped", [39727]], [[12224, 12224], "mapped", [39730]], [[12225, 12225], "mapped", [39740]], [[12226, 12226], "mapped", [39770]], [[12227, 12227], "mapped", [40165]], [[12228, 12228], "mapped", [40565]], [[12229, 12229], "mapped", [40575]], [[12230, 12230], "mapped", [40613]], [[12231, 12231], "mapped", [40635]], [[12232, 12232], "mapped", [40643]], [[12233, 12233], "mapped", [40653]], [[12234, 12234], "mapped", [40657]], [[12235, 12235], "mapped", [40697]], [[12236, 12236], "mapped", [40701]], [[12237, 12237], "mapped", [40718]], [[12238, 12238], "mapped", [40723]], [[12239, 12239], "mapped", [40736]], [[12240, 12240], "mapped", [40763]], [[12241, 12241], "mapped", [40778]], [[12242, 12242], "mapped", [40786]], [[12243, 12243], "mapped", [40845]], [[12244, 12244], "mapped", [40860]], [[12245, 12245], "mapped", [40864]], [[12246, 12271], "disallowed"], [[12272, 12283], "disallowed"], [[12284, 12287], "disallowed"], [[12288, 12288], "disallowed_STD3_mapped", [32]], [[12289, 12289], "valid", [], "NV8"], [[12290, 12290], "mapped", [46]], [[12291, 12292], "valid", [], "NV8"], [[12293, 12295], "valid"], [[12296, 12329], "valid", [], "NV8"], [[12330, 12333], "valid"], [[12334, 12341], "valid", [], "NV8"], [[12342, 12342], "mapped", [12306]], [[12343, 12343], "valid", [], "NV8"], [[12344, 12344], "mapped", [21313]], [[12345, 12345], "mapped", [21316]], [[12346, 12346], "mapped", [21317]], [[12347, 12347], "valid", [], "NV8"], [[12348, 12348], "valid"], [[12349, 12349], "valid", [], "NV8"], [[12350, 12350], "valid", [], "NV8"], [[12351, 12351], "valid", [], "NV8"], [[12352, 12352], "disallowed"], [[12353, 12436], "valid"], [[12437, 12438], "valid"], [[12439, 12440], "disallowed"], [[12441, 12442], "valid"], [[12443, 12443], "disallowed_STD3_mapped", [32, 12441]], [[12444, 12444], "disallowed_STD3_mapped", [32, 12442]], [[12445, 12446], "valid"], [[12447, 12447], "mapped", [12424, 12426]], [[12448, 12448], "valid", [], "NV8"], [[12449, 12542], "valid"], [[12543, 12543], "mapped", [12467, 12488]], [[12544, 12548], "disallowed"], [[12549, 12588], "valid"], [[12589, 12589], "valid"], [[12590, 12592], "disallowed"], [[12593, 12593], "mapped", [4352]], [[12594, 12594], "mapped", [4353]], [[12595, 12595], "mapped", [4522]], [[12596, 12596], "mapped", [4354]], [[12597, 12597], "mapped", [4524]], [[12598, 12598], "mapped", [4525]], [[12599, 12599], "mapped", [4355]], [[12600, 12600], "mapped", [4356]], [[12601, 12601], "mapped", [4357]], [[12602, 12602], "mapped", [4528]], [[12603, 12603], "mapped", [4529]], [[12604, 12604], "mapped", [4530]], [[12605, 12605], "mapped", [4531]], [[12606, 12606], "mapped", [4532]], [[12607, 12607], "mapped", [4533]], [[12608, 12608], "mapped", [4378]], [[12609, 12609], "mapped", [4358]], [[12610, 12610], "mapped", [4359]], [[12611, 12611], "mapped", [4360]], [[12612, 12612], "mapped", [4385]], [[12613, 12613], "mapped", [4361]], [[12614, 12614], "mapped", [4362]], [[12615, 12615], "mapped", [4363]], [[12616, 12616], "mapped", [4364]], [[12617, 12617], "mapped", [4365]], [[12618, 12618], "mapped", [4366]], [[12619, 12619], "mapped", [4367]], [[12620, 12620], "mapped", [4368]], [[12621, 12621], "mapped", [4369]], [[12622, 12622], "mapped", [4370]], [[12623, 12623], "mapped", [4449]], [[12624, 12624], "mapped", [4450]], [[12625, 12625], "mapped", [4451]], [[12626, 12626], "mapped", [4452]], [[12627, 12627], "mapped", [4453]], [[12628, 12628], "mapped", [4454]], [[12629, 12629], "mapped", [4455]], [[12630, 12630], "mapped", [4456]], [[12631, 12631], "mapped", [4457]], [[12632, 12632], "mapped", [4458]], [[12633, 12633], "mapped", [4459]], [[12634, 12634], "mapped", [4460]], [[12635, 12635], "mapped", [4461]], [[12636, 12636], "mapped", [4462]], [[12637, 12637], "mapped", [4463]], [[12638, 12638], "mapped", [4464]], [[12639, 12639], "mapped", [4465]], [[12640, 12640], "mapped", [4466]], [[12641, 12641], "mapped", [4467]], [[12642, 12642], "mapped", [4468]], [[12643, 12643], "mapped", [4469]], [[12644, 12644], "disallowed"], [[12645, 12645], "mapped", [4372]], [[12646, 12646], "mapped", [4373]], [[12647, 12647], "mapped", [4551]], [[12648, 12648], "mapped", [4552]], [[12649, 12649], "mapped", [4556]], [[12650, 12650], "mapped", [4558]], [[12651, 12651], "mapped", [4563]], [[12652, 12652], "mapped", [4567]], [[12653, 12653], "mapped", [4569]], [[12654, 12654], "mapped", [4380]], [[12655, 12655], "mapped", [4573]], [[12656, 12656], "mapped", [4575]], [[12657, 12657], "mapped", [4381]], [[12658, 12658], "mapped", [4382]], [[12659, 12659], "mapped", [4384]], [[12660, 12660], "mapped", [4386]], [[12661, 12661], "mapped", [4387]], [[12662, 12662], "mapped", [4391]], [[12663, 12663], "mapped", [4393]], [[12664, 12664], "mapped", [4395]], [[12665, 12665], "mapped", [4396]], [[12666, 12666], "mapped", [4397]], [[12667, 12667], "mapped", [4398]], [[12668, 12668], "mapped", [4399]], [[12669, 12669], "mapped", [4402]], [[12670, 12670], "mapped", [4406]], [[12671, 12671], "mapped", [4416]], [[12672, 12672], "mapped", [4423]], [[12673, 12673], "mapped", [4428]], [[12674, 12674], "mapped", [4593]], [[12675, 12675], "mapped", [4594]], [[12676, 12676], "mapped", [4439]], [[12677, 12677], "mapped", [4440]], [[12678, 12678], "mapped", [4441]], [[12679, 12679], "mapped", [4484]], [[12680, 12680], "mapped", [4485]], [[12681, 12681], "mapped", [4488]], [[12682, 12682], "mapped", [4497]], [[12683, 12683], "mapped", [4498]], [[12684, 12684], "mapped", [4500]], [[12685, 12685], "mapped", [4510]], [[12686, 12686], "mapped", [4513]], [[12687, 12687], "disallowed"], [[12688, 12689], "valid", [], "NV8"], [[12690, 12690], "mapped", [19968]], [[12691, 12691], "mapped", [20108]], [[12692, 12692], "mapped", [19977]], [[12693, 12693], "mapped", [22235]], [[12694, 12694], "mapped", [19978]], [[12695, 12695], "mapped", [20013]], [[12696, 12696], "mapped", [19979]], [[12697, 12697], "mapped", [30002]], [[12698, 12698], "mapped", [20057]], [[12699, 12699], "mapped", [19993]], [[12700, 12700], "mapped", [19969]], [[12701, 12701], "mapped", [22825]], [[12702, 12702], "mapped", [22320]], [[12703, 12703], "mapped", [20154]], [[12704, 12727], "valid"], [[12728, 12730], "valid"], [[12731, 12735], "disallowed"], [[12736, 12751], "valid", [], "NV8"], [[12752, 12771], "valid", [], "NV8"], [[12772, 12783], "disallowed"], [[12784, 12799], "valid"], [[12800, 12800], "disallowed_STD3_mapped", [40, 4352, 41]], [[12801, 12801], "disallowed_STD3_mapped", [40, 4354, 41]], [[12802, 12802], "disallowed_STD3_mapped", [40, 4355, 41]], [[12803, 12803], "disallowed_STD3_mapped", [40, 4357, 41]], [[12804, 12804], "disallowed_STD3_mapped", [40, 4358, 41]], [[12805, 12805], "disallowed_STD3_mapped", [40, 4359, 41]], [[12806, 12806], "disallowed_STD3_mapped", [40, 4361, 41]], [[12807, 12807], "disallowed_STD3_mapped", [40, 4363, 41]], [[12808, 12808], "disallowed_STD3_mapped", [40, 4364, 41]], [[12809, 12809], "disallowed_STD3_mapped", [40, 4366, 41]], [[12810, 12810], "disallowed_STD3_mapped", [40, 4367, 41]], [[12811, 12811], "disallowed_STD3_mapped", [40, 4368, 41]], [[12812, 12812], "disallowed_STD3_mapped", [40, 4369, 41]], [[12813, 12813], "disallowed_STD3_mapped", [40, 4370, 41]], [[12814, 12814], "disallowed_STD3_mapped", [40, 44032, 41]], [[12815, 12815], "disallowed_STD3_mapped", [40, 45208, 41]], [[12816, 12816], "disallowed_STD3_mapped", [40, 45796, 41]], [[12817, 12817], "disallowed_STD3_mapped", [40, 46972, 41]], [[12818, 12818], "disallowed_STD3_mapped", [40, 47560, 41]], [[12819, 12819], "disallowed_STD3_mapped", [40, 48148, 41]], [[12820, 12820], "disallowed_STD3_mapped", [40, 49324, 41]], [[12821, 12821], "disallowed_STD3_mapped", [40, 50500, 41]], [[12822, 12822], "disallowed_STD3_mapped", [40, 51088, 41]], [[12823, 12823], "disallowed_STD3_mapped", [40, 52264, 41]], [[12824, 12824], "disallowed_STD3_mapped", [40, 52852, 41]], [[12825, 12825], "disallowed_STD3_mapped", [40, 53440, 41]], [[12826, 12826], "disallowed_STD3_mapped", [40, 54028, 41]], [[12827, 12827], "disallowed_STD3_mapped", [40, 54616, 41]], [[12828, 12828], "disallowed_STD3_mapped", [40, 51452, 41]], [[12829, 12829], "disallowed_STD3_mapped", [40, 50724, 51204, 41]], [[12830, 12830], "disallowed_STD3_mapped", [40, 50724, 54980, 41]], [[12831, 12831], "disallowed"], [[12832, 12832], "disallowed_STD3_mapped", [40, 19968, 41]], [[12833, 12833], "disallowed_STD3_mapped", [40, 20108, 41]], [[12834, 12834], "disallowed_STD3_mapped", [40, 19977, 41]], [[12835, 12835], "disallowed_STD3_mapped", [40, 22235, 41]], [[12836, 12836], "disallowed_STD3_mapped", [40, 20116, 41]], [[12837, 12837], "disallowed_STD3_mapped", [40, 20845, 41]], [[12838, 12838], "disallowed_STD3_mapped", [40, 19971, 41]], [[12839, 12839], "disallowed_STD3_mapped", [40, 20843, 41]], [[12840, 12840], "disallowed_STD3_mapped", [40, 20061, 41]], [[12841, 12841], "disallowed_STD3_mapped", [40, 21313, 41]], [[12842, 12842], "disallowed_STD3_mapped", [40, 26376, 41]], [[12843, 12843], "disallowed_STD3_mapped", [40, 28779, 41]], [[12844, 12844], "disallowed_STD3_mapped", [40, 27700, 41]], [[12845, 12845], "disallowed_STD3_mapped", [40, 26408, 41]], [[12846, 12846], "disallowed_STD3_mapped", [40, 37329, 41]], [[12847, 12847], "disallowed_STD3_mapped", [40, 22303, 41]], [[12848, 12848], "disallowed_STD3_mapped", [40, 26085, 41]], [[12849, 12849], "disallowed_STD3_mapped", [40, 26666, 41]], [[12850, 12850], "disallowed_STD3_mapped", [40, 26377, 41]], [[12851, 12851], "disallowed_STD3_mapped", [40, 31038, 41]], [[12852, 12852], "disallowed_STD3_mapped", [40, 21517, 41]], [[12853, 12853], "disallowed_STD3_mapped", [40, 29305, 41]], [[12854, 12854], "disallowed_STD3_mapped", [40, 36001, 41]], [[12855, 12855], "disallowed_STD3_mapped", [40, 31069, 41]], [[12856, 12856], "disallowed_STD3_mapped", [40, 21172, 41]], [[12857, 12857], "disallowed_STD3_mapped", [40, 20195, 41]], [[12858, 12858], "disallowed_STD3_mapped", [40, 21628, 41]], [[12859, 12859], "disallowed_STD3_mapped", [40, 23398, 41]], [[12860, 12860], "disallowed_STD3_mapped", [40, 30435, 41]], [[12861, 12861], "disallowed_STD3_mapped", [40, 20225, 41]], [[12862, 12862], "disallowed_STD3_mapped", [40, 36039, 41]], [[12863, 12863], "disallowed_STD3_mapped", [40, 21332, 41]], [[12864, 12864], "disallowed_STD3_mapped", [40, 31085, 41]], [[12865, 12865], "disallowed_STD3_mapped", [40, 20241, 41]], [[12866, 12866], "disallowed_STD3_mapped", [40, 33258, 41]], [[12867, 12867], "disallowed_STD3_mapped", [40, 33267, 41]], [[12868, 12868], "mapped", [21839]], [[12869, 12869], "mapped", [24188]], [[12870, 12870], "mapped", [25991]], [[12871, 12871], "mapped", [31631]], [[12872, 12879], "valid", [], "NV8"], [[12880, 12880], "mapped", [112, 116, 101]], [[12881, 12881], "mapped", [50, 49]], [[12882, 12882], "mapped", [50, 50]], [[12883, 12883], "mapped", [50, 51]], [[12884, 12884], "mapped", [50, 52]], [[12885, 12885], "mapped", [50, 53]], [[12886, 12886], "mapped", [50, 54]], [[12887, 12887], "mapped", [50, 55]], [[12888, 12888], "mapped", [50, 56]], [[12889, 12889], "mapped", [50, 57]], [[12890, 12890], "mapped", [51, 48]], [[12891, 12891], "mapped", [51, 49]], [[12892, 12892], "mapped", [51, 50]], [[12893, 12893], "mapped", [51, 51]], [[12894, 12894], "mapped", [51, 52]], [[12895, 12895], "mapped", [51, 53]], [[12896, 12896], "mapped", [4352]], [[12897, 12897], "mapped", [4354]], [[12898, 12898], "mapped", [4355]], [[12899, 12899], "mapped", [4357]], [[12900, 12900], "mapped", [4358]], [[12901, 12901], "mapped", [4359]], [[12902, 12902], "mapped", [4361]], [[12903, 12903], "mapped", [4363]], [[12904, 12904], "mapped", [4364]], [[12905, 12905], "mapped", [4366]], [[12906, 12906], "mapped", [4367]], [[12907, 12907], "mapped", [4368]], [[12908, 12908], "mapped", [4369]], [[12909, 12909], "mapped", [4370]], [[12910, 12910], "mapped", [44032]], [[12911, 12911], "mapped", [45208]], [[12912, 12912], "mapped", [45796]], [[12913, 12913], "mapped", [46972]], [[12914, 12914], "mapped", [47560]], [[12915, 12915], "mapped", [48148]], [[12916, 12916], "mapped", [49324]], [[12917, 12917], "mapped", [50500]], [[12918, 12918], "mapped", [51088]], [[12919, 12919], "mapped", [52264]], [[12920, 12920], "mapped", [52852]], [[12921, 12921], "mapped", [53440]], [[12922, 12922], "mapped", [54028]], [[12923, 12923], "mapped", [54616]], [[12924, 12924], "mapped", [52280, 44256]], [[12925, 12925], "mapped", [51452, 51032]], [[12926, 12926], "mapped", [50864]], [[12927, 12927], "valid", [], "NV8"], [[12928, 12928], "mapped", [19968]], [[12929, 12929], "mapped", [20108]], [[12930, 12930], "mapped", [19977]], [[12931, 12931], "mapped", [22235]], [[12932, 12932], "mapped", [20116]], [[12933, 12933], "mapped", [20845]], [[12934, 12934], "mapped", [19971]], [[12935, 12935], "mapped", [20843]], [[12936, 12936], "mapped", [20061]], [[12937, 12937], "mapped", [21313]], [[12938, 12938], "mapped", [26376]], [[12939, 12939], "mapped", [28779]], [[12940, 12940], "mapped", [27700]], [[12941, 12941], "mapped", [26408]], [[12942, 12942], "mapped", [37329]], [[12943, 12943], "mapped", [22303]], [[12944, 12944], "mapped", [26085]], [[12945, 12945], "mapped", [26666]], [[12946, 12946], "mapped", [26377]], [[12947, 12947], "mapped", [31038]], [[12948, 12948], "mapped", [21517]], [[12949, 12949], "mapped", [29305]], [[12950, 12950], "mapped", [36001]], [[12951, 12951], "mapped", [31069]], [[12952, 12952], "mapped", [21172]], [[12953, 12953], "mapped", [31192]], [[12954, 12954], "mapped", [30007]], [[12955, 12955], "mapped", [22899]], [[12956, 12956], "mapped", [36969]], [[12957, 12957], "mapped", [20778]], [[12958, 12958], "mapped", [21360]], [[12959, 12959], "mapped", [27880]], [[12960, 12960], "mapped", [38917]], [[12961, 12961], "mapped", [20241]], [[12962, 12962], "mapped", [20889]], [[12963, 12963], "mapped", [27491]], [[12964, 12964], "mapped", [19978]], [[12965, 12965], "mapped", [20013]], [[12966, 12966], "mapped", [19979]], [[12967, 12967], "mapped", [24038]], [[12968, 12968], "mapped", [21491]], [[12969, 12969], "mapped", [21307]], [[12970, 12970], "mapped", [23447]], [[12971, 12971], "mapped", [23398]], [[12972, 12972], "mapped", [30435]], [[12973, 12973], "mapped", [20225]], [[12974, 12974], "mapped", [36039]], [[12975, 12975], "mapped", [21332]], [[12976, 12976], "mapped", [22812]], [[12977, 12977], "mapped", [51, 54]], [[12978, 12978], "mapped", [51, 55]], [[12979, 12979], "mapped", [51, 56]], [[12980, 12980], "mapped", [51, 57]], [[12981, 12981], "mapped", [52, 48]], [[12982, 12982], "mapped", [52, 49]], [[12983, 12983], "mapped", [52, 50]], [[12984, 12984], "mapped", [52, 51]], [[12985, 12985], "mapped", [52, 52]], [[12986, 12986], "mapped", [52, 53]], [[12987, 12987], "mapped", [52, 54]], [[12988, 12988], "mapped", [52, 55]], [[12989, 12989], "mapped", [52, 56]], [[12990, 12990], "mapped", [52, 57]], [[12991, 12991], "mapped", [53, 48]], [[12992, 12992], "mapped", [49, 26376]], [[12993, 12993], "mapped", [50, 26376]], [[12994, 12994], "mapped", [51, 26376]], [[12995, 12995], "mapped", [52, 26376]], [[12996, 12996], "mapped", [53, 26376]], [[12997, 12997], "mapped", [54, 26376]], [[12998, 12998], "mapped", [55, 26376]], [[12999, 12999], "mapped", [56, 26376]], [[13e3, 13e3], "mapped", [57, 26376]], [[13001, 13001], "mapped", [49, 48, 26376]], [[13002, 13002], "mapped", [49, 49, 26376]], [[13003, 13003], "mapped", [49, 50, 26376]], [[13004, 13004], "mapped", [104, 103]], [[13005, 13005], "mapped", [101, 114, 103]], [[13006, 13006], "mapped", [101, 118]], [[13007, 13007], "mapped", [108, 116, 100]], [[13008, 13008], "mapped", [12450]], [[13009, 13009], "mapped", [12452]], [[13010, 13010], "mapped", [12454]], [[13011, 13011], "mapped", [12456]], [[13012, 13012], "mapped", [12458]], [[13013, 13013], "mapped", [12459]], [[13014, 13014], "mapped", [12461]], [[13015, 13015], "mapped", [12463]], [[13016, 13016], "mapped", [12465]], [[13017, 13017], "mapped", [12467]], [[13018, 13018], "mapped", [12469]], [[13019, 13019], "mapped", [12471]], [[13020, 13020], "mapped", [12473]], [[13021, 13021], "mapped", [12475]], [[13022, 13022], "mapped", [12477]], [[13023, 13023], "mapped", [12479]], [[13024, 13024], "mapped", [12481]], [[13025, 13025], "mapped", [12484]], [[13026, 13026], "mapped", [12486]], [[13027, 13027], "mapped", [12488]], [[13028, 13028], "mapped", [12490]], [[13029, 13029], "mapped", [12491]], [[13030, 13030], "mapped", [12492]], [[13031, 13031], "mapped", [12493]], [[13032, 13032], "mapped", [12494]], [[13033, 13033], "mapped", [12495]], [[13034, 13034], "mapped", [12498]], [[13035, 13035], "mapped", [12501]], [[13036, 13036], "mapped", [12504]], [[13037, 13037], "mapped", [12507]], [[13038, 13038], "mapped", [12510]], [[13039, 13039], "mapped", [12511]], [[13040, 13040], "mapped", [12512]], [[13041, 13041], "mapped", [12513]], [[13042, 13042], "mapped", [12514]], [[13043, 13043], "mapped", [12516]], [[13044, 13044], "mapped", [12518]], [[13045, 13045], "mapped", [12520]], [[13046, 13046], "mapped", [12521]], [[13047, 13047], "mapped", [12522]], [[13048, 13048], "mapped", [12523]], [[13049, 13049], "mapped", [12524]], [[13050, 13050], "mapped", [12525]], [[13051, 13051], "mapped", [12527]], [[13052, 13052], "mapped", [12528]], [[13053, 13053], "mapped", [12529]], [[13054, 13054], "mapped", [12530]], [[13055, 13055], "disallowed"], [[13056, 13056], "mapped", [12450, 12497, 12540, 12488]], [[13057, 13057], "mapped", [12450, 12523, 12501, 12449]], [[13058, 13058], "mapped", [12450, 12531, 12506, 12450]], [[13059, 13059], "mapped", [12450, 12540, 12523]], [[13060, 13060], "mapped", [12452, 12491, 12531, 12464]], [[13061, 13061], "mapped", [12452, 12531, 12481]], [[13062, 13062], "mapped", [12454, 12457, 12531]], [[13063, 13063], "mapped", [12456, 12473, 12463, 12540, 12489]], [[13064, 13064], "mapped", [12456, 12540, 12459, 12540]], [[13065, 13065], "mapped", [12458, 12531, 12473]], [[13066, 13066], "mapped", [12458, 12540, 12512]], [[13067, 13067], "mapped", [12459, 12452, 12522]], [[13068, 13068], "mapped", [12459, 12521, 12483, 12488]], [[13069, 13069], "mapped", [12459, 12525, 12522, 12540]], [[13070, 13070], "mapped", [12460, 12525, 12531]], [[13071, 13071], "mapped", [12460, 12531, 12510]], [[13072, 13072], "mapped", [12462, 12460]], [[13073, 13073], "mapped", [12462, 12491, 12540]], [[13074, 13074], "mapped", [12461, 12517, 12522, 12540]], [[13075, 13075], "mapped", [12462, 12523, 12480, 12540]], [[13076, 13076], "mapped", [12461, 12525]], [[13077, 13077], "mapped", [12461, 12525, 12464, 12521, 12512]], [[13078, 13078], "mapped", [12461, 12525, 12513, 12540, 12488, 12523]], [[13079, 13079], "mapped", [12461, 12525, 12527, 12483, 12488]], [[13080, 13080], "mapped", [12464, 12521, 12512]], [[13081, 13081], "mapped", [12464, 12521, 12512, 12488, 12531]], [[13082, 13082], "mapped", [12463, 12523, 12476, 12452, 12525]], [[13083, 13083], "mapped", [12463, 12525, 12540, 12493]], [[13084, 13084], "mapped", [12465, 12540, 12473]], [[13085, 13085], "mapped", [12467, 12523, 12490]], [[13086, 13086], "mapped", [12467, 12540, 12509]], [[13087, 13087], "mapped", [12469, 12452, 12463, 12523]], [[13088, 13088], "mapped", [12469, 12531, 12481, 12540, 12512]], [[13089, 13089], "mapped", [12471, 12522, 12531, 12464]], [[13090, 13090], "mapped", [12475, 12531, 12481]], [[13091, 13091], "mapped", [12475, 12531, 12488]], [[13092, 13092], "mapped", [12480, 12540, 12473]], [[13093, 13093], "mapped", [12487, 12471]], [[13094, 13094], "mapped", [12489, 12523]], [[13095, 13095], "mapped", [12488, 12531]], [[13096, 13096], "mapped", [12490, 12494]], [[13097, 13097], "mapped", [12494, 12483, 12488]], [[13098, 13098], "mapped", [12495, 12452, 12484]], [[13099, 13099], "mapped", [12497, 12540, 12475, 12531, 12488]], [[13100, 13100], "mapped", [12497, 12540, 12484]], [[13101, 13101], "mapped", [12496, 12540, 12524, 12523]], [[13102, 13102], "mapped", [12500, 12450, 12473, 12488, 12523]], [[13103, 13103], "mapped", [12500, 12463, 12523]], [[13104, 13104], "mapped", [12500, 12467]], [[13105, 13105], "mapped", [12499, 12523]], [[13106, 13106], "mapped", [12501, 12449, 12521, 12483, 12489]], [[13107, 13107], "mapped", [12501, 12451, 12540, 12488]], [[13108, 13108], "mapped", [12502, 12483, 12471, 12455, 12523]], [[13109, 13109], "mapped", [12501, 12521, 12531]], [[13110, 13110], "mapped", [12504, 12463, 12479, 12540, 12523]], [[13111, 13111], "mapped", [12506, 12477]], [[13112, 13112], "mapped", [12506, 12491, 12498]], [[13113, 13113], "mapped", [12504, 12523, 12484]], [[13114, 13114], "mapped", [12506, 12531, 12473]], [[13115, 13115], "mapped", [12506, 12540, 12472]], [[13116, 13116], "mapped", [12505, 12540, 12479]], [[13117, 13117], "mapped", [12509, 12452, 12531, 12488]], [[13118, 13118], "mapped", [12508, 12523, 12488]], [[13119, 13119], "mapped", [12507, 12531]], [[13120, 13120], "mapped", [12509, 12531, 12489]], [[13121, 13121], "mapped", [12507, 12540, 12523]], [[13122, 13122], "mapped", [12507, 12540, 12531]], [[13123, 13123], "mapped", [12510, 12452, 12463, 12525]], [[13124, 13124], "mapped", [12510, 12452, 12523]], [[13125, 13125], "mapped", [12510, 12483, 12495]], [[13126, 13126], "mapped", [12510, 12523, 12463]], [[13127, 13127], "mapped", [12510, 12531, 12471, 12519, 12531]], [[13128, 13128], "mapped", [12511, 12463, 12525, 12531]], [[13129, 13129], "mapped", [12511, 12522]], [[13130, 13130], "mapped", [12511, 12522, 12496, 12540, 12523]], [[13131, 13131], "mapped", [12513, 12460]], [[13132, 13132], "mapped", [12513, 12460, 12488, 12531]], [[13133, 13133], "mapped", [12513, 12540, 12488, 12523]], [[13134, 13134], "mapped", [12516, 12540, 12489]], [[13135, 13135], "mapped", [12516, 12540, 12523]], [[13136, 13136], "mapped", [12518, 12450, 12531]], [[13137, 13137], "mapped", [12522, 12483, 12488, 12523]], [[13138, 13138], "mapped", [12522, 12521]], [[13139, 13139], "mapped", [12523, 12500, 12540]], [[13140, 13140], "mapped", [12523, 12540, 12502, 12523]], [[13141, 13141], "mapped", [12524, 12512]], [[13142, 13142], "mapped", [12524, 12531, 12488, 12466, 12531]], [[13143, 13143], "mapped", [12527, 12483, 12488]], [[13144, 13144], "mapped", [48, 28857]], [[13145, 13145], "mapped", [49, 28857]], [[13146, 13146], "mapped", [50, 28857]], [[13147, 13147], "mapped", [51, 28857]], [[13148, 13148], "mapped", [52, 28857]], [[13149, 13149], "mapped", [53, 28857]], [[13150, 13150], "mapped", [54, 28857]], [[13151, 13151], "mapped", [55, 28857]], [[13152, 13152], "mapped", [56, 28857]], [[13153, 13153], "mapped", [57, 28857]], [[13154, 13154], "mapped", [49, 48, 28857]], [[13155, 13155], "mapped", [49, 49, 28857]], [[13156, 13156], "mapped", [49, 50, 28857]], [[13157, 13157], "mapped", [49, 51, 28857]], [[13158, 13158], "mapped", [49, 52, 28857]], [[13159, 13159], "mapped", [49, 53, 28857]], [[13160, 13160], "mapped", [49, 54, 28857]], [[13161, 13161], "mapped", [49, 55, 28857]], [[13162, 13162], "mapped", [49, 56, 28857]], [[13163, 13163], "mapped", [49, 57, 28857]], [[13164, 13164], "mapped", [50, 48, 28857]], [[13165, 13165], "mapped", [50, 49, 28857]], [[13166, 13166], "mapped", [50, 50, 28857]], [[13167, 13167], "mapped", [50, 51, 28857]], [[13168, 13168], "mapped", [50, 52, 28857]], [[13169, 13169], "mapped", [104, 112, 97]], [[13170, 13170], "mapped", [100, 97]], [[13171, 13171], "mapped", [97, 117]], [[13172, 13172], "mapped", [98, 97, 114]], [[13173, 13173], "mapped", [111, 118]], [[13174, 13174], "mapped", [112, 99]], [[13175, 13175], "mapped", [100, 109]], [[13176, 13176], "mapped", [100, 109, 50]], [[13177, 13177], "mapped", [100, 109, 51]], [[13178, 13178], "mapped", [105, 117]], [[13179, 13179], "mapped", [24179, 25104]], [[13180, 13180], "mapped", [26157, 21644]], [[13181, 13181], "mapped", [22823, 27491]], [[13182, 13182], "mapped", [26126, 27835]], [[13183, 13183], "mapped", [26666, 24335, 20250, 31038]], [[13184, 13184], "mapped", [112, 97]], [[13185, 13185], "mapped", [110, 97]], [[13186, 13186], "mapped", [956, 97]], [[13187, 13187], "mapped", [109, 97]], [[13188, 13188], "mapped", [107, 97]], [[13189, 13189], "mapped", [107, 98]], [[13190, 13190], "mapped", [109, 98]], [[13191, 13191], "mapped", [103, 98]], [[13192, 13192], "mapped", [99, 97, 108]], [[13193, 13193], "mapped", [107, 99, 97, 108]], [[13194, 13194], "mapped", [112, 102]], [[13195, 13195], "mapped", [110, 102]], [[13196, 13196], "mapped", [956, 102]], [[13197, 13197], "mapped", [956, 103]], [[13198, 13198], "mapped", [109, 103]], [[13199, 13199], "mapped", [107, 103]], [[13200, 13200], "mapped", [104, 122]], [[13201, 13201], "mapped", [107, 104, 122]], [[13202, 13202], "mapped", [109, 104, 122]], [[13203, 13203], "mapped", [103, 104, 122]], [[13204, 13204], "mapped", [116, 104, 122]], [[13205, 13205], "mapped", [956, 108]], [[13206, 13206], "mapped", [109, 108]], [[13207, 13207], "mapped", [100, 108]], [[13208, 13208], "mapped", [107, 108]], [[13209, 13209], "mapped", [102, 109]], [[13210, 13210], "mapped", [110, 109]], [[13211, 13211], "mapped", [956, 109]], [[13212, 13212], "mapped", [109, 109]], [[13213, 13213], "mapped", [99, 109]], [[13214, 13214], "mapped", [107, 109]], [[13215, 13215], "mapped", [109, 109, 50]], [[13216, 13216], "mapped", [99, 109, 50]], [[13217, 13217], "mapped", [109, 50]], [[13218, 13218], "mapped", [107, 109, 50]], [[13219, 13219], "mapped", [109, 109, 51]], [[13220, 13220], "mapped", [99, 109, 51]], [[13221, 13221], "mapped", [109, 51]], [[13222, 13222], "mapped", [107, 109, 51]], [[13223, 13223], "mapped", [109, 8725, 115]], [[13224, 13224], "mapped", [109, 8725, 115, 50]], [[13225, 13225], "mapped", [112, 97]], [[13226, 13226], "mapped", [107, 112, 97]], [[13227, 13227], "mapped", [109, 112, 97]], [[13228, 13228], "mapped", [103, 112, 97]], [[13229, 13229], "mapped", [114, 97, 100]], [[13230, 13230], "mapped", [114, 97, 100, 8725, 115]], [[13231, 13231], "mapped", [114, 97, 100, 8725, 115, 50]], [[13232, 13232], "mapped", [112, 115]], [[13233, 13233], "mapped", [110, 115]], [[13234, 13234], "mapped", [956, 115]], [[13235, 13235], "mapped", [109, 115]], [[13236, 13236], "mapped", [112, 118]], [[13237, 13237], "mapped", [110, 118]], [[13238, 13238], "mapped", [956, 118]], [[13239, 13239], "mapped", [109, 118]], [[13240, 13240], "mapped", [107, 118]], [[13241, 13241], "mapped", [109, 118]], [[13242, 13242], "mapped", [112, 119]], [[13243, 13243], "mapped", [110, 119]], [[13244, 13244], "mapped", [956, 119]], [[13245, 13245], "mapped", [109, 119]], [[13246, 13246], "mapped", [107, 119]], [[13247, 13247], "mapped", [109, 119]], [[13248, 13248], "mapped", [107, 969]], [[13249, 13249], "mapped", [109, 969]], [[13250, 13250], "disallowed"], [[13251, 13251], "mapped", [98, 113]], [[13252, 13252], "mapped", [99, 99]], [[13253, 13253], "mapped", [99, 100]], [[13254, 13254], "mapped", [99, 8725, 107, 103]], [[13255, 13255], "disallowed"], [[13256, 13256], "mapped", [100, 98]], [[13257, 13257], "mapped", [103, 121]], [[13258, 13258], "mapped", [104, 97]], [[13259, 13259], "mapped", [104, 112]], [[13260, 13260], "mapped", [105, 110]], [[13261, 13261], "mapped", [107, 107]], [[13262, 13262], "mapped", [107, 109]], [[13263, 13263], "mapped", [107, 116]], [[13264, 13264], "mapped", [108, 109]], [[13265, 13265], "mapped", [108, 110]], [[13266, 13266], "mapped", [108, 111, 103]], [[13267, 13267], "mapped", [108, 120]], [[13268, 13268], "mapped", [109, 98]], [[13269, 13269], "mapped", [109, 105, 108]], [[13270, 13270], "mapped", [109, 111, 108]], [[13271, 13271], "mapped", [112, 104]], [[13272, 13272], "disallowed"], [[13273, 13273], "mapped", [112, 112, 109]], [[13274, 13274], "mapped", [112, 114]], [[13275, 13275], "mapped", [115, 114]], [[13276, 13276], "mapped", [115, 118]], [[13277, 13277], "mapped", [119, 98]], [[13278, 13278], "mapped", [118, 8725, 109]], [[13279, 13279], "mapped", [97, 8725, 109]], [[13280, 13280], "mapped", [49, 26085]], [[13281, 13281], "mapped", [50, 26085]], [[13282, 13282], "mapped", [51, 26085]], [[13283, 13283], "mapped", [52, 26085]], [[13284, 13284], "mapped", [53, 26085]], [[13285, 13285], "mapped", [54, 26085]], [[13286, 13286], "mapped", [55, 26085]], [[13287, 13287], "mapped", [56, 26085]], [[13288, 13288], "mapped", [57, 26085]], [[13289, 13289], "mapped", [49, 48, 26085]], [[13290, 13290], "mapped", [49, 49, 26085]], [[13291, 13291], "mapped", [49, 50, 26085]], [[13292, 13292], "mapped", [49, 51, 26085]], [[13293, 13293], "mapped", [49, 52, 26085]], [[13294, 13294], "mapped", [49, 53, 26085]], [[13295, 13295], "mapped", [49, 54, 26085]], [[13296, 13296], "mapped", [49, 55, 26085]], [[13297, 13297], "mapped", [49, 56, 26085]], [[13298, 13298], "mapped", [49, 57, 26085]], [[13299, 13299], "mapped", [50, 48, 26085]], [[13300, 13300], "mapped", [50, 49, 26085]], [[13301, 13301], "mapped", [50, 50, 26085]], [[13302, 13302], "mapped", [50, 51, 26085]], [[13303, 13303], "mapped", [50, 52, 26085]], [[13304, 13304], "mapped", [50, 53, 26085]], [[13305, 13305], "mapped", [50, 54, 26085]], [[13306, 13306], "mapped", [50, 55, 26085]], [[13307, 13307], "mapped", [50, 56, 26085]], [[13308, 13308], "mapped", [50, 57, 26085]], [[13309, 13309], "mapped", [51, 48, 26085]], [[13310, 13310], "mapped", [51, 49, 26085]], [[13311, 13311], "mapped", [103, 97, 108]], [[13312, 19893], "valid"], [[19894, 19903], "disallowed"], [[19904, 19967], "valid", [], "NV8"], [[19968, 40869], "valid"], [[40870, 40891], "valid"], [[40892, 40899], "valid"], [[40900, 40907], "valid"], [[40908, 40908], "valid"], [[40909, 40917], "valid"], [[40918, 40959], "disallowed"], [[40960, 42124], "valid"], [[42125, 42127], "disallowed"], [[42128, 42145], "valid", [], "NV8"], [[42146, 42147], "valid", [], "NV8"], [[42148, 42163], "valid", [], "NV8"], [[42164, 42164], "valid", [], "NV8"], [[42165, 42176], "valid", [], "NV8"], [[42177, 42177], "valid", [], "NV8"], [[42178, 42180], "valid", [], "NV8"], [[42181, 42181], "valid", [], "NV8"], [[42182, 42182], "valid", [], "NV8"], [[42183, 42191], "disallowed"], [[42192, 42237], "valid"], [[42238, 42239], "valid", [], "NV8"], [[42240, 42508], "valid"], [[42509, 42511], "valid", [], "NV8"], [[42512, 42539], "valid"], [[42540, 42559], "disallowed"], [[42560, 42560], "mapped", [42561]], [[42561, 42561], "valid"], [[42562, 42562], "mapped", [42563]], [[42563, 42563], "valid"], [[42564, 42564], "mapped", [42565]], [[42565, 42565], "valid"], [[42566, 42566], "mapped", [42567]], [[42567, 42567], "valid"], [[42568, 42568], "mapped", [42569]], [[42569, 42569], "valid"], [[42570, 42570], "mapped", [42571]], [[42571, 42571], "valid"], [[42572, 42572], "mapped", [42573]], [[42573, 42573], "valid"], [[42574, 42574], "mapped", [42575]], [[42575, 42575], "valid"], [[42576, 42576], "mapped", [42577]], [[42577, 42577], "valid"], [[42578, 42578], "mapped", [42579]], [[42579, 42579], "valid"], [[42580, 42580], "mapped", [42581]], [[42581, 42581], "valid"], [[42582, 42582], "mapped", [42583]], [[42583, 42583], "valid"], [[42584, 42584], "mapped", [42585]], [[42585, 42585], "valid"], [[42586, 42586], "mapped", [42587]], [[42587, 42587], "valid"], [[42588, 42588], "mapped", [42589]], [[42589, 42589], "valid"], [[42590, 42590], "mapped", [42591]], [[42591, 42591], "valid"], [[42592, 42592], "mapped", [42593]], [[42593, 42593], "valid"], [[42594, 42594], "mapped", [42595]], [[42595, 42595], "valid"], [[42596, 42596], "mapped", [42597]], [[42597, 42597], "valid"], [[42598, 42598], "mapped", [42599]], [[42599, 42599], "valid"], [[42600, 42600], "mapped", [42601]], [[42601, 42601], "valid"], [[42602, 42602], "mapped", [42603]], [[42603, 42603], "valid"], [[42604, 42604], "mapped", [42605]], [[42605, 42607], "valid"], [[42608, 42611], "valid", [], "NV8"], [[42612, 42619], "valid"], [[42620, 42621], "valid"], [[42622, 42622], "valid", [], "NV8"], [[42623, 42623], "valid"], [[42624, 42624], "mapped", [42625]], [[42625, 42625], "valid"], [[42626, 42626], "mapped", [42627]], [[42627, 42627], "valid"], [[42628, 42628], "mapped", [42629]], [[42629, 42629], "valid"], [[42630, 42630], "mapped", [42631]], [[42631, 42631], "valid"], [[42632, 42632], "mapped", [42633]], [[42633, 42633], "valid"], [[42634, 42634], "mapped", [42635]], [[42635, 42635], "valid"], [[42636, 42636], "mapped", [42637]], [[42637, 42637], "valid"], [[42638, 42638], "mapped", [42639]], [[42639, 42639], "valid"], [[42640, 42640], "mapped", [42641]], [[42641, 42641], "valid"], [[42642, 42642], "mapped", [42643]], [[42643, 42643], "valid"], [[42644, 42644], "mapped", [42645]], [[42645, 42645], "valid"], [[42646, 42646], "mapped", [42647]], [[42647, 42647], "valid"], [[42648, 42648], "mapped", [42649]], [[42649, 42649], "valid"], [[42650, 42650], "mapped", [42651]], [[42651, 42651], "valid"], [[42652, 42652], "mapped", [1098]], [[42653, 42653], "mapped", [1100]], [[42654, 42654], "valid"], [[42655, 42655], "valid"], [[42656, 42725], "valid"], [[42726, 42735], "valid", [], "NV8"], [[42736, 42737], "valid"], [[42738, 42743], "valid", [], "NV8"], [[42744, 42751], "disallowed"], [[42752, 42774], "valid", [], "NV8"], [[42775, 42778], "valid"], [[42779, 42783], "valid"], [[42784, 42785], "valid", [], "NV8"], [[42786, 42786], "mapped", [42787]], [[42787, 42787], "valid"], [[42788, 42788], "mapped", [42789]], [[42789, 42789], "valid"], [[42790, 42790], "mapped", [42791]], [[42791, 42791], "valid"], [[42792, 42792], "mapped", [42793]], [[42793, 42793], "valid"], [[42794, 42794], "mapped", [42795]], [[42795, 42795], "valid"], [[42796, 42796], "mapped", [42797]], [[42797, 42797], "valid"], [[42798, 42798], "mapped", [42799]], [[42799, 42801], "valid"], [[42802, 42802], "mapped", [42803]], [[42803, 42803], "valid"], [[42804, 42804], "mapped", [42805]], [[42805, 42805], "valid"], [[42806, 42806], "mapped", [42807]], [[42807, 42807], "valid"], [[42808, 42808], "mapped", [42809]], [[42809, 42809], "valid"], [[42810, 42810], "mapped", [42811]], [[42811, 42811], "valid"], [[42812, 42812], "mapped", [42813]], [[42813, 42813], "valid"], [[42814, 42814], "mapped", [42815]], [[42815, 42815], "valid"], [[42816, 42816], "mapped", [42817]], [[42817, 42817], "valid"], [[42818, 42818], "mapped", [42819]], [[42819, 42819], "valid"], [[42820, 42820], "mapped", [42821]], [[42821, 42821], "valid"], [[42822, 42822], "mapped", [42823]], [[42823, 42823], "valid"], [[42824, 42824], "mapped", [42825]], [[42825, 42825], "valid"], [[42826, 42826], "mapped", [42827]], [[42827, 42827], "valid"], [[42828, 42828], "mapped", [42829]], [[42829, 42829], "valid"], [[42830, 42830], "mapped", [42831]], [[42831, 42831], "valid"], [[42832, 42832], "mapped", [42833]], [[42833, 42833], "valid"], [[42834, 42834], "mapped", [42835]], [[42835, 42835], "valid"], [[42836, 42836], "mapped", [42837]], [[42837, 42837], "valid"], [[42838, 42838], "mapped", [42839]], [[42839, 42839], "valid"], [[42840, 42840], "mapped", [42841]], [[42841, 42841], "valid"], [[42842, 42842], "mapped", [42843]], [[42843, 42843], "valid"], [[42844, 42844], "mapped", [42845]], [[42845, 42845], "valid"], [[42846, 42846], "mapped", [42847]], [[42847, 42847], "valid"], [[42848, 42848], "mapped", [42849]], [[42849, 42849], "valid"], [[42850, 42850], "mapped", [42851]], [[42851, 42851], "valid"], [[42852, 42852], "mapped", [42853]], [[42853, 42853], "valid"], [[42854, 42854], "mapped", [42855]], [[42855, 42855], "valid"], [[42856, 42856], "mapped", [42857]], [[42857, 42857], "valid"], [[42858, 42858], "mapped", [42859]], [[42859, 42859], "valid"], [[42860, 42860], "mapped", [42861]], [[42861, 42861], "valid"], [[42862, 42862], "mapped", [42863]], [[42863, 42863], "valid"], [[42864, 42864], "mapped", [42863]], [[42865, 42872], "valid"], [[42873, 42873], "mapped", [42874]], [[42874, 42874], "valid"], [[42875, 42875], "mapped", [42876]], [[42876, 42876], "valid"], [[42877, 42877], "mapped", [7545]], [[42878, 42878], "mapped", [42879]], [[42879, 42879], "valid"], [[42880, 42880], "mapped", [42881]], [[42881, 42881], "valid"], [[42882, 42882], "mapped", [42883]], [[42883, 42883], "valid"], [[42884, 42884], "mapped", [42885]], [[42885, 42885], "valid"], [[42886, 42886], "mapped", [42887]], [[42887, 42888], "valid"], [[42889, 42890], "valid", [], "NV8"], [[42891, 42891], "mapped", [42892]], [[42892, 42892], "valid"], [[42893, 42893], "mapped", [613]], [[42894, 42894], "valid"], [[42895, 42895], "valid"], [[42896, 42896], "mapped", [42897]], [[42897, 42897], "valid"], [[42898, 42898], "mapped", [42899]], [[42899, 42899], "valid"], [[42900, 42901], "valid"], [[42902, 42902], "mapped", [42903]], [[42903, 42903], "valid"], [[42904, 42904], "mapped", [42905]], [[42905, 42905], "valid"], [[42906, 42906], "mapped", [42907]], [[42907, 42907], "valid"], [[42908, 42908], "mapped", [42909]], [[42909, 42909], "valid"], [[42910, 42910], "mapped", [42911]], [[42911, 42911], "valid"], [[42912, 42912], "mapped", [42913]], [[42913, 42913], "valid"], [[42914, 42914], "mapped", [42915]], [[42915, 42915], "valid"], [[42916, 42916], "mapped", [42917]], [[42917, 42917], "valid"], [[42918, 42918], "mapped", [42919]], [[42919, 42919], "valid"], [[42920, 42920], "mapped", [42921]], [[42921, 42921], "valid"], [[42922, 42922], "mapped", [614]], [[42923, 42923], "mapped", [604]], [[42924, 42924], "mapped", [609]], [[42925, 42925], "mapped", [620]], [[42926, 42927], "disallowed"], [[42928, 42928], "mapped", [670]], [[42929, 42929], "mapped", [647]], [[42930, 42930], "mapped", [669]], [[42931, 42931], "mapped", [43859]], [[42932, 42932], "mapped", [42933]], [[42933, 42933], "valid"], [[42934, 42934], "mapped", [42935]], [[42935, 42935], "valid"], [[42936, 42998], "disallowed"], [[42999, 42999], "valid"], [[43e3, 43e3], "mapped", [295]], [[43001, 43001], "mapped", [339]], [[43002, 43002], "valid"], [[43003, 43007], "valid"], [[43008, 43047], "valid"], [[43048, 43051], "valid", [], "NV8"], [[43052, 43055], "disallowed"], [[43056, 43065], "valid", [], "NV8"], [[43066, 43071], "disallowed"], [[43072, 43123], "valid"], [[43124, 43127], "valid", [], "NV8"], [[43128, 43135], "disallowed"], [[43136, 43204], "valid"], [[43205, 43213], "disallowed"], [[43214, 43215], "valid", [], "NV8"], [[43216, 43225], "valid"], [[43226, 43231], "disallowed"], [[43232, 43255], "valid"], [[43256, 43258], "valid", [], "NV8"], [[43259, 43259], "valid"], [[43260, 43260], "valid", [], "NV8"], [[43261, 43261], "valid"], [[43262, 43263], "disallowed"], [[43264, 43309], "valid"], [[43310, 43311], "valid", [], "NV8"], [[43312, 43347], "valid"], [[43348, 43358], "disallowed"], [[43359, 43359], "valid", [], "NV8"], [[43360, 43388], "valid", [], "NV8"], [[43389, 43391], "disallowed"], [[43392, 43456], "valid"], [[43457, 43469], "valid", [], "NV8"], [[43470, 43470], "disallowed"], [[43471, 43481], "valid"], [[43482, 43485], "disallowed"], [[43486, 43487], "valid", [], "NV8"], [[43488, 43518], "valid"], [[43519, 43519], "disallowed"], [[43520, 43574], "valid"], [[43575, 43583], "disallowed"], [[43584, 43597], "valid"], [[43598, 43599], "disallowed"], [[43600, 43609], "valid"], [[43610, 43611], "disallowed"], [[43612, 43615], "valid", [], "NV8"], [[43616, 43638], "valid"], [[43639, 43641], "valid", [], "NV8"], [[43642, 43643], "valid"], [[43644, 43647], "valid"], [[43648, 43714], "valid"], [[43715, 43738], "disallowed"], [[43739, 43741], "valid"], [[43742, 43743], "valid", [], "NV8"], [[43744, 43759], "valid"], [[43760, 43761], "valid", [], "NV8"], [[43762, 43766], "valid"], [[43767, 43776], "disallowed"], [[43777, 43782], "valid"], [[43783, 43784], "disallowed"], [[43785, 43790], "valid"], [[43791, 43792], "disallowed"], [[43793, 43798], "valid"], [[43799, 43807], "disallowed"], [[43808, 43814], "valid"], [[43815, 43815], "disallowed"], [[43816, 43822], "valid"], [[43823, 43823], "disallowed"], [[43824, 43866], "valid"], [[43867, 43867], "valid", [], "NV8"], [[43868, 43868], "mapped", [42791]], [[43869, 43869], "mapped", [43831]], [[43870, 43870], "mapped", [619]], [[43871, 43871], "mapped", [43858]], [[43872, 43875], "valid"], [[43876, 43877], "valid"], [[43878, 43887], "disallowed"], [[43888, 43888], "mapped", [5024]], [[43889, 43889], "mapped", [5025]], [[43890, 43890], "mapped", [5026]], [[43891, 43891], "mapped", [5027]], [[43892, 43892], "mapped", [5028]], [[43893, 43893], "mapped", [5029]], [[43894, 43894], "mapped", [5030]], [[43895, 43895], "mapped", [5031]], [[43896, 43896], "mapped", [5032]], [[43897, 43897], "mapped", [5033]], [[43898, 43898], "mapped", [5034]], [[43899, 43899], "mapped", [5035]], [[43900, 43900], "mapped", [5036]], [[43901, 43901], "mapped", [5037]], [[43902, 43902], "mapped", [5038]], [[43903, 43903], "mapped", [5039]], [[43904, 43904], "mapped", [5040]], [[43905, 43905], "mapped", [5041]], [[43906, 43906], "mapped", [5042]], [[43907, 43907], "mapped", [5043]], [[43908, 43908], "mapped", [5044]], [[43909, 43909], "mapped", [5045]], [[43910, 43910], "mapped", [5046]], [[43911, 43911], "mapped", [5047]], [[43912, 43912], "mapped", [5048]], [[43913, 43913], "mapped", [5049]], [[43914, 43914], "mapped", [5050]], [[43915, 43915], "mapped", [5051]], [[43916, 43916], "mapped", [5052]], [[43917, 43917], "mapped", [5053]], [[43918, 43918], "mapped", [5054]], [[43919, 43919], "mapped", [5055]], [[43920, 43920], "mapped", [5056]], [[43921, 43921], "mapped", [5057]], [[43922, 43922], "mapped", [5058]], [[43923, 43923], "mapped", [5059]], [[43924, 43924], "mapped", [5060]], [[43925, 43925], "mapped", [5061]], [[43926, 43926], "mapped", [5062]], [[43927, 43927], "mapped", [5063]], [[43928, 43928], "mapped", [5064]], [[43929, 43929], "mapped", [5065]], [[43930, 43930], "mapped", [5066]], [[43931, 43931], "mapped", [5067]], [[43932, 43932], "mapped", [5068]], [[43933, 43933], "mapped", [5069]], [[43934, 43934], "mapped", [5070]], [[43935, 43935], "mapped", [5071]], [[43936, 43936], "mapped", [5072]], [[43937, 43937], "mapped", [5073]], [[43938, 43938], "mapped", [5074]], [[43939, 43939], "mapped", [5075]], [[43940, 43940], "mapped", [5076]], [[43941, 43941], "mapped", [5077]], [[43942, 43942], "mapped", [5078]], [[43943, 43943], "mapped", [5079]], [[43944, 43944], "mapped", [5080]], [[43945, 43945], "mapped", [5081]], [[43946, 43946], "mapped", [5082]], [[43947, 43947], "mapped", [5083]], [[43948, 43948], "mapped", [5084]], [[43949, 43949], "mapped", [5085]], [[43950, 43950], "mapped", [5086]], [[43951, 43951], "mapped", [5087]], [[43952, 43952], "mapped", [5088]], [[43953, 43953], "mapped", [5089]], [[43954, 43954], "mapped", [5090]], [[43955, 43955], "mapped", [5091]], [[43956, 43956], "mapped", [5092]], [[43957, 43957], "mapped", [5093]], [[43958, 43958], "mapped", [5094]], [[43959, 43959], "mapped", [5095]], [[43960, 43960], "mapped", [5096]], [[43961, 43961], "mapped", [5097]], [[43962, 43962], "mapped", [5098]], [[43963, 43963], "mapped", [5099]], [[43964, 43964], "mapped", [5100]], [[43965, 43965], "mapped", [5101]], [[43966, 43966], "mapped", [5102]], [[43967, 43967], "mapped", [5103]], [[43968, 44010], "valid"], [[44011, 44011], "valid", [], "NV8"], [[44012, 44013], "valid"], [[44014, 44015], "disallowed"], [[44016, 44025], "valid"], [[44026, 44031], "disallowed"], [[44032, 55203], "valid"], [[55204, 55215], "disallowed"], [[55216, 55238], "valid", [], "NV8"], [[55239, 55242], "disallowed"], [[55243, 55291], "valid", [], "NV8"], [[55292, 55295], "disallowed"], [[55296, 57343], "disallowed"], [[57344, 63743], "disallowed"], [[63744, 63744], "mapped", [35912]], [[63745, 63745], "mapped", [26356]], [[63746, 63746], "mapped", [36554]], [[63747, 63747], "mapped", [36040]], [[63748, 63748], "mapped", [28369]], [[63749, 63749], "mapped", [20018]], [[63750, 63750], "mapped", [21477]], [[63751, 63752], "mapped", [40860]], [[63753, 63753], "mapped", [22865]], [[63754, 63754], "mapped", [37329]], [[63755, 63755], "mapped", [21895]], [[63756, 63756], "mapped", [22856]], [[63757, 63757], "mapped", [25078]], [[63758, 63758], "mapped", [30313]], [[63759, 63759], "mapped", [32645]], [[63760, 63760], "mapped", [34367]], [[63761, 63761], "mapped", [34746]], [[63762, 63762], "mapped", [35064]], [[63763, 63763], "mapped", [37007]], [[63764, 63764], "mapped", [27138]], [[63765, 63765], "mapped", [27931]], [[63766, 63766], "mapped", [28889]], [[63767, 63767], "mapped", [29662]], [[63768, 63768], "mapped", [33853]], [[63769, 63769], "mapped", [37226]], [[63770, 63770], "mapped", [39409]], [[63771, 63771], "mapped", [20098]], [[63772, 63772], "mapped", [21365]], [[63773, 63773], "mapped", [27396]], [[63774, 63774], "mapped", [29211]], [[63775, 63775], "mapped", [34349]], [[63776, 63776], "mapped", [40478]], [[63777, 63777], "mapped", [23888]], [[63778, 63778], "mapped", [28651]], [[63779, 63779], "mapped", [34253]], [[63780, 63780], "mapped", [35172]], [[63781, 63781], "mapped", [25289]], [[63782, 63782], "mapped", [33240]], [[63783, 63783], "mapped", [34847]], [[63784, 63784], "mapped", [24266]], [[63785, 63785], "mapped", [26391]], [[63786, 63786], "mapped", [28010]], [[63787, 63787], "mapped", [29436]], [[63788, 63788], "mapped", [37070]], [[63789, 63789], "mapped", [20358]], [[63790, 63790], "mapped", [20919]], [[63791, 63791], "mapped", [21214]], [[63792, 63792], "mapped", [25796]], [[63793, 63793], "mapped", [27347]], [[63794, 63794], "mapped", [29200]], [[63795, 63795], "mapped", [30439]], [[63796, 63796], "mapped", [32769]], [[63797, 63797], "mapped", [34310]], [[63798, 63798], "mapped", [34396]], [[63799, 63799], "mapped", [36335]], [[63800, 63800], "mapped", [38706]], [[63801, 63801], "mapped", [39791]], [[63802, 63802], "mapped", [40442]], [[63803, 63803], "mapped", [30860]], [[63804, 63804], "mapped", [31103]], [[63805, 63805], "mapped", [32160]], [[63806, 63806], "mapped", [33737]], [[63807, 63807], "mapped", [37636]], [[63808, 63808], "mapped", [40575]], [[63809, 63809], "mapped", [35542]], [[63810, 63810], "mapped", [22751]], [[63811, 63811], "mapped", [24324]], [[63812, 63812], "mapped", [31840]], [[63813, 63813], "mapped", [32894]], [[63814, 63814], "mapped", [29282]], [[63815, 63815], "mapped", [30922]], [[63816, 63816], "mapped", [36034]], [[63817, 63817], "mapped", [38647]], [[63818, 63818], "mapped", [22744]], [[63819, 63819], "mapped", [23650]], [[63820, 63820], "mapped", [27155]], [[63821, 63821], "mapped", [28122]], [[63822, 63822], "mapped", [28431]], [[63823, 63823], "mapped", [32047]], [[63824, 63824], "mapped", [32311]], [[63825, 63825], "mapped", [38475]], [[63826, 63826], "mapped", [21202]], [[63827, 63827], "mapped", [32907]], [[63828, 63828], "mapped", [20956]], [[63829, 63829], "mapped", [20940]], [[63830, 63830], "mapped", [31260]], [[63831, 63831], "mapped", [32190]], [[63832, 63832], "mapped", [33777]], [[63833, 63833], "mapped", [38517]], [[63834, 63834], "mapped", [35712]], [[63835, 63835], "mapped", [25295]], [[63836, 63836], "mapped", [27138]], [[63837, 63837], "mapped", [35582]], [[63838, 63838], "mapped", [20025]], [[63839, 63839], "mapped", [23527]], [[63840, 63840], "mapped", [24594]], [[63841, 63841], "mapped", [29575]], [[63842, 63842], "mapped", [30064]], [[63843, 63843], "mapped", [21271]], [[63844, 63844], "mapped", [30971]], [[63845, 63845], "mapped", [20415]], [[63846, 63846], "mapped", [24489]], [[63847, 63847], "mapped", [19981]], [[63848, 63848], "mapped", [27852]], [[63849, 63849], "mapped", [25976]], [[63850, 63850], "mapped", [32034]], [[63851, 63851], "mapped", [21443]], [[63852, 63852], "mapped", [22622]], [[63853, 63853], "mapped", [30465]], [[63854, 63854], "mapped", [33865]], [[63855, 63855], "mapped", [35498]], [[63856, 63856], "mapped", [27578]], [[63857, 63857], "mapped", [36784]], [[63858, 63858], "mapped", [27784]], [[63859, 63859], "mapped", [25342]], [[63860, 63860], "mapped", [33509]], [[63861, 63861], "mapped", [25504]], [[63862, 63862], "mapped", [30053]], [[63863, 63863], "mapped", [20142]], [[63864, 63864], "mapped", [20841]], [[63865, 63865], "mapped", [20937]], [[63866, 63866], "mapped", [26753]], [[63867, 63867], "mapped", [31975]], [[63868, 63868], "mapped", [33391]], [[63869, 63869], "mapped", [35538]], [[63870, 63870], "mapped", [37327]], [[63871, 63871], "mapped", [21237]], [[63872, 63872], "mapped", [21570]], [[63873, 63873], "mapped", [22899]], [[63874, 63874], "mapped", [24300]], [[63875, 63875], "mapped", [26053]], [[63876, 63876], "mapped", [28670]], [[63877, 63877], "mapped", [31018]], [[63878, 63878], "mapped", [38317]], [[63879, 63879], "mapped", [39530]], [[63880, 63880], "mapped", [40599]], [[63881, 63881], "mapped", [40654]], [[63882, 63882], "mapped", [21147]], [[63883, 63883], "mapped", [26310]], [[63884, 63884], "mapped", [27511]], [[63885, 63885], "mapped", [36706]], [[63886, 63886], "mapped", [24180]], [[63887, 63887], "mapped", [24976]], [[63888, 63888], "mapped", [25088]], [[63889, 63889], "mapped", [25754]], [[63890, 63890], "mapped", [28451]], [[63891, 63891], "mapped", [29001]], [[63892, 63892], "mapped", [29833]], [[63893, 63893], "mapped", [31178]], [[63894, 63894], "mapped", [32244]], [[63895, 63895], "mapped", [32879]], [[63896, 63896], "mapped", [36646]], [[63897, 63897], "mapped", [34030]], [[63898, 63898], "mapped", [36899]], [[63899, 63899], "mapped", [37706]], [[63900, 63900], "mapped", [21015]], [[63901, 63901], "mapped", [21155]], [[63902, 63902], "mapped", [21693]], [[63903, 63903], "mapped", [28872]], [[63904, 63904], "mapped", [35010]], [[63905, 63905], "mapped", [35498]], [[63906, 63906], "mapped", [24265]], [[63907, 63907], "mapped", [24565]], [[63908, 63908], "mapped", [25467]], [[63909, 63909], "mapped", [27566]], [[63910, 63910], "mapped", [31806]], [[63911, 63911], "mapped", [29557]], [[63912, 63912], "mapped", [20196]], [[63913, 63913], "mapped", [22265]], [[63914, 63914], "mapped", [23527]], [[63915, 63915], "mapped", [23994]], [[63916, 63916], "mapped", [24604]], [[63917, 63917], "mapped", [29618]], [[63918, 63918], "mapped", [29801]], [[63919, 63919], "mapped", [32666]], [[63920, 63920], "mapped", [32838]], [[63921, 63921], "mapped", [37428]], [[63922, 63922], "mapped", [38646]], [[63923, 63923], "mapped", [38728]], [[63924, 63924], "mapped", [38936]], [[63925, 63925], "mapped", [20363]], [[63926, 63926], "mapped", [31150]], [[63927, 63927], "mapped", [37300]], [[63928, 63928], "mapped", [38584]], [[63929, 63929], "mapped", [24801]], [[63930, 63930], "mapped", [20102]], [[63931, 63931], "mapped", [20698]], [[63932, 63932], "mapped", [23534]], [[63933, 63933], "mapped", [23615]], [[63934, 63934], "mapped", [26009]], [[63935, 63935], "mapped", [27138]], [[63936, 63936], "mapped", [29134]], [[63937, 63937], "mapped", [30274]], [[63938, 63938], "mapped", [34044]], [[63939, 63939], "mapped", [36988]], [[63940, 63940], "mapped", [40845]], [[63941, 63941], "mapped", [26248]], [[63942, 63942], "mapped", [38446]], [[63943, 63943], "mapped", [21129]], [[63944, 63944], "mapped", [26491]], [[63945, 63945], "mapped", [26611]], [[63946, 63946], "mapped", [27969]], [[63947, 63947], "mapped", [28316]], [[63948, 63948], "mapped", [29705]], [[63949, 63949], "mapped", [30041]], [[63950, 63950], "mapped", [30827]], [[63951, 63951], "mapped", [32016]], [[63952, 63952], "mapped", [39006]], [[63953, 63953], "mapped", [20845]], [[63954, 63954], "mapped", [25134]], [[63955, 63955], "mapped", [38520]], [[63956, 63956], "mapped", [20523]], [[63957, 63957], "mapped", [23833]], [[63958, 63958], "mapped", [28138]], [[63959, 63959], "mapped", [36650]], [[63960, 63960], "mapped", [24459]], [[63961, 63961], "mapped", [24900]], [[63962, 63962], "mapped", [26647]], [[63963, 63963], "mapped", [29575]], [[63964, 63964], "mapped", [38534]], [[63965, 63965], "mapped", [21033]], [[63966, 63966], "mapped", [21519]], [[63967, 63967], "mapped", [23653]], [[63968, 63968], "mapped", [26131]], [[63969, 63969], "mapped", [26446]], [[63970, 63970], "mapped", [26792]], [[63971, 63971], "mapped", [27877]], [[63972, 63972], "mapped", [29702]], [[63973, 63973], "mapped", [30178]], [[63974, 63974], "mapped", [32633]], [[63975, 63975], "mapped", [35023]], [[63976, 63976], "mapped", [35041]], [[63977, 63977], "mapped", [37324]], [[63978, 63978], "mapped", [38626]], [[63979, 63979], "mapped", [21311]], [[63980, 63980], "mapped", [28346]], [[63981, 63981], "mapped", [21533]], [[63982, 63982], "mapped", [29136]], [[63983, 63983], "mapped", [29848]], [[63984, 63984], "mapped", [34298]], [[63985, 63985], "mapped", [38563]], [[63986, 63986], "mapped", [40023]], [[63987, 63987], "mapped", [40607]], [[63988, 63988], "mapped", [26519]], [[63989, 63989], "mapped", [28107]], [[63990, 63990], "mapped", [33256]], [[63991, 63991], "mapped", [31435]], [[63992, 63992], "mapped", [31520]], [[63993, 63993], "mapped", [31890]], [[63994, 63994], "mapped", [29376]], [[63995, 63995], "mapped", [28825]], [[63996, 63996], "mapped", [35672]], [[63997, 63997], "mapped", [20160]], [[63998, 63998], "mapped", [33590]], [[63999, 63999], "mapped", [21050]], [[64e3, 64e3], "mapped", [20999]], [[64001, 64001], "mapped", [24230]], [[64002, 64002], "mapped", [25299]], [[64003, 64003], "mapped", [31958]], [[64004, 64004], "mapped", [23429]], [[64005, 64005], "mapped", [27934]], [[64006, 64006], "mapped", [26292]], [[64007, 64007], "mapped", [36667]], [[64008, 64008], "mapped", [34892]], [[64009, 64009], "mapped", [38477]], [[64010, 64010], "mapped", [35211]], [[64011, 64011], "mapped", [24275]], [[64012, 64012], "mapped", [20800]], [[64013, 64013], "mapped", [21952]], [[64014, 64015], "valid"], [[64016, 64016], "mapped", [22618]], [[64017, 64017], "valid"], [[64018, 64018], "mapped", [26228]], [[64019, 64020], "valid"], [[64021, 64021], "mapped", [20958]], [[64022, 64022], "mapped", [29482]], [[64023, 64023], "mapped", [30410]], [[64024, 64024], "mapped", [31036]], [[64025, 64025], "mapped", [31070]], [[64026, 64026], "mapped", [31077]], [[64027, 64027], "mapped", [31119]], [[64028, 64028], "mapped", [38742]], [[64029, 64029], "mapped", [31934]], [[64030, 64030], "mapped", [32701]], [[64031, 64031], "valid"], [[64032, 64032], "mapped", [34322]], [[64033, 64033], "valid"], [[64034, 64034], "mapped", [35576]], [[64035, 64036], "valid"], [[64037, 64037], "mapped", [36920]], [[64038, 64038], "mapped", [37117]], [[64039, 64041], "valid"], [[64042, 64042], "mapped", [39151]], [[64043, 64043], "mapped", [39164]], [[64044, 64044], "mapped", [39208]], [[64045, 64045], "mapped", [40372]], [[64046, 64046], "mapped", [37086]], [[64047, 64047], "mapped", [38583]], [[64048, 64048], "mapped", [20398]], [[64049, 64049], "mapped", [20711]], [[64050, 64050], "mapped", [20813]], [[64051, 64051], "mapped", [21193]], [[64052, 64052], "mapped", [21220]], [[64053, 64053], "mapped", [21329]], [[64054, 64054], "mapped", [21917]], [[64055, 64055], "mapped", [22022]], [[64056, 64056], "mapped", [22120]], [[64057, 64057], "mapped", [22592]], [[64058, 64058], "mapped", [22696]], [[64059, 64059], "mapped", [23652]], [[64060, 64060], "mapped", [23662]], [[64061, 64061], "mapped", [24724]], [[64062, 64062], "mapped", [24936]], [[64063, 64063], "mapped", [24974]], [[64064, 64064], "mapped", [25074]], [[64065, 64065], "mapped", [25935]], [[64066, 64066], "mapped", [26082]], [[64067, 64067], "mapped", [26257]], [[64068, 64068], "mapped", [26757]], [[64069, 64069], "mapped", [28023]], [[64070, 64070], "mapped", [28186]], [[64071, 64071], "mapped", [28450]], [[64072, 64072], "mapped", [29038]], [[64073, 64073], "mapped", [29227]], [[64074, 64074], "mapped", [29730]], [[64075, 64075], "mapped", [30865]], [[64076, 64076], "mapped", [31038]], [[64077, 64077], "mapped", [31049]], [[64078, 64078], "mapped", [31048]], [[64079, 64079], "mapped", [31056]], [[64080, 64080], "mapped", [31062]], [[64081, 64081], "mapped", [31069]], [[64082, 64082], "mapped", [31117]], [[64083, 64083], "mapped", [31118]], [[64084, 64084], "mapped", [31296]], [[64085, 64085], "mapped", [31361]], [[64086, 64086], "mapped", [31680]], [[64087, 64087], "mapped", [32244]], [[64088, 64088], "mapped", [32265]], [[64089, 64089], "mapped", [32321]], [[64090, 64090], "mapped", [32626]], [[64091, 64091], "mapped", [32773]], [[64092, 64092], "mapped", [33261]], [[64093, 64094], "mapped", [33401]], [[64095, 64095], "mapped", [33879]], [[64096, 64096], "mapped", [35088]], [[64097, 64097], "mapped", [35222]], [[64098, 64098], "mapped", [35585]], [[64099, 64099], "mapped", [35641]], [[64100, 64100], "mapped", [36051]], [[64101, 64101], "mapped", [36104]], [[64102, 64102], "mapped", [36790]], [[64103, 64103], "mapped", [36920]], [[64104, 64104], "mapped", [38627]], [[64105, 64105], "mapped", [38911]], [[64106, 64106], "mapped", [38971]], [[64107, 64107], "mapped", [24693]], [[64108, 64108], "mapped", [148206]], [[64109, 64109], "mapped", [33304]], [[64110, 64111], "disallowed"], [[64112, 64112], "mapped", [20006]], [[64113, 64113], "mapped", [20917]], [[64114, 64114], "mapped", [20840]], [[64115, 64115], "mapped", [20352]], [[64116, 64116], "mapped", [20805]], [[64117, 64117], "mapped", [20864]], [[64118, 64118], "mapped", [21191]], [[64119, 64119], "mapped", [21242]], [[64120, 64120], "mapped", [21917]], [[64121, 64121], "mapped", [21845]], [[64122, 64122], "mapped", [21913]], [[64123, 64123], "mapped", [21986]], [[64124, 64124], "mapped", [22618]], [[64125, 64125], "mapped", [22707]], [[64126, 64126], "mapped", [22852]], [[64127, 64127], "mapped", [22868]], [[64128, 64128], "mapped", [23138]], [[64129, 64129], "mapped", [23336]], [[64130, 64130], "mapped", [24274]], [[64131, 64131], "mapped", [24281]], [[64132, 64132], "mapped", [24425]], [[64133, 64133], "mapped", [24493]], [[64134, 64134], "mapped", [24792]], [[64135, 64135], "mapped", [24910]], [[64136, 64136], "mapped", [24840]], [[64137, 64137], "mapped", [24974]], [[64138, 64138], "mapped", [24928]], [[64139, 64139], "mapped", [25074]], [[64140, 64140], "mapped", [25140]], [[64141, 64141], "mapped", [25540]], [[64142, 64142], "mapped", [25628]], [[64143, 64143], "mapped", [25682]], [[64144, 64144], "mapped", [25942]], [[64145, 64145], "mapped", [26228]], [[64146, 64146], "mapped", [26391]], [[64147, 64147], "mapped", [26395]], [[64148, 64148], "mapped", [26454]], [[64149, 64149], "mapped", [27513]], [[64150, 64150], "mapped", [27578]], [[64151, 64151], "mapped", [27969]], [[64152, 64152], "mapped", [28379]], [[64153, 64153], "mapped", [28363]], [[64154, 64154], "mapped", [28450]], [[64155, 64155], "mapped", [28702]], [[64156, 64156], "mapped", [29038]], [[64157, 64157], "mapped", [30631]], [[64158, 64158], "mapped", [29237]], [[64159, 64159], "mapped", [29359]], [[64160, 64160], "mapped", [29482]], [[64161, 64161], "mapped", [29809]], [[64162, 64162], "mapped", [29958]], [[64163, 64163], "mapped", [30011]], [[64164, 64164], "mapped", [30237]], [[64165, 64165], "mapped", [30239]], [[64166, 64166], "mapped", [30410]], [[64167, 64167], "mapped", [30427]], [[64168, 64168], "mapped", [30452]], [[64169, 64169], "mapped", [30538]], [[64170, 64170], "mapped", [30528]], [[64171, 64171], "mapped", [30924]], [[64172, 64172], "mapped", [31409]], [[64173, 64173], "mapped", [31680]], [[64174, 64174], "mapped", [31867]], [[64175, 64175], "mapped", [32091]], [[64176, 64176], "mapped", [32244]], [[64177, 64177], "mapped", [32574]], [[64178, 64178], "mapped", [32773]], [[64179, 64179], "mapped", [33618]], [[64180, 64180], "mapped", [33775]], [[64181, 64181], "mapped", [34681]], [[64182, 64182], "mapped", [35137]], [[64183, 64183], "mapped", [35206]], [[64184, 64184], "mapped", [35222]], [[64185, 64185], "mapped", [35519]], [[64186, 64186], "mapped", [35576]], [[64187, 64187], "mapped", [35531]], [[64188, 64188], "mapped", [35585]], [[64189, 64189], "mapped", [35582]], [[64190, 64190], "mapped", [35565]], [[64191, 64191], "mapped", [35641]], [[64192, 64192], "mapped", [35722]], [[64193, 64193], "mapped", [36104]], [[64194, 64194], "mapped", [36664]], [[64195, 64195], "mapped", [36978]], [[64196, 64196], "mapped", [37273]], [[64197, 64197], "mapped", [37494]], [[64198, 64198], "mapped", [38524]], [[64199, 64199], "mapped", [38627]], [[64200, 64200], "mapped", [38742]], [[64201, 64201], "mapped", [38875]], [[64202, 64202], "mapped", [38911]], [[64203, 64203], "mapped", [38923]], [[64204, 64204], "mapped", [38971]], [[64205, 64205], "mapped", [39698]], [[64206, 64206], "mapped", [40860]], [[64207, 64207], "mapped", [141386]], [[64208, 64208], "mapped", [141380]], [[64209, 64209], "mapped", [144341]], [[64210, 64210], "mapped", [15261]], [[64211, 64211], "mapped", [16408]], [[64212, 64212], "mapped", [16441]], [[64213, 64213], "mapped", [152137]], [[64214, 64214], "mapped", [154832]], [[64215, 64215], "mapped", [163539]], [[64216, 64216], "mapped", [40771]], [[64217, 64217], "mapped", [40846]], [[64218, 64255], "disallowed"], [[64256, 64256], "mapped", [102, 102]], [[64257, 64257], "mapped", [102, 105]], [[64258, 64258], "mapped", [102, 108]], [[64259, 64259], "mapped", [102, 102, 105]], [[64260, 64260], "mapped", [102, 102, 108]], [[64261, 64262], "mapped", [115, 116]], [[64263, 64274], "disallowed"], [[64275, 64275], "mapped", [1396, 1398]], [[64276, 64276], "mapped", [1396, 1381]], [[64277, 64277], "mapped", [1396, 1387]], [[64278, 64278], "mapped", [1406, 1398]], [[64279, 64279], "mapped", [1396, 1389]], [[64280, 64284], "disallowed"], [[64285, 64285], "mapped", [1497, 1460]], [[64286, 64286], "valid"], [[64287, 64287], "mapped", [1522, 1463]], [[64288, 64288], "mapped", [1506]], [[64289, 64289], "mapped", [1488]], [[64290, 64290], "mapped", [1491]], [[64291, 64291], "mapped", [1492]], [[64292, 64292], "mapped", [1499]], [[64293, 64293], "mapped", [1500]], [[64294, 64294], "mapped", [1501]], [[64295, 64295], "mapped", [1512]], [[64296, 64296], "mapped", [1514]], [[64297, 64297], "disallowed_STD3_mapped", [43]], [[64298, 64298], "mapped", [1513, 1473]], [[64299, 64299], "mapped", [1513, 1474]], [[64300, 64300], "mapped", [1513, 1468, 1473]], [[64301, 64301], "mapped", [1513, 1468, 1474]], [[64302, 64302], "mapped", [1488, 1463]], [[64303, 64303], "mapped", [1488, 1464]], [[64304, 64304], "mapped", [1488, 1468]], [[64305, 64305], "mapped", [1489, 1468]], [[64306, 64306], "mapped", [1490, 1468]], [[64307, 64307], "mapped", [1491, 1468]], [[64308, 64308], "mapped", [1492, 1468]], [[64309, 64309], "mapped", [1493, 1468]], [[64310, 64310], "mapped", [1494, 1468]], [[64311, 64311], "disallowed"], [[64312, 64312], "mapped", [1496, 1468]], [[64313, 64313], "mapped", [1497, 1468]], [[64314, 64314], "mapped", [1498, 1468]], [[64315, 64315], "mapped", [1499, 1468]], [[64316, 64316], "mapped", [1500, 1468]], [[64317, 64317], "disallowed"], [[64318, 64318], "mapped", [1502, 1468]], [[64319, 64319], "disallowed"], [[64320, 64320], "mapped", [1504, 1468]], [[64321, 64321], "mapped", [1505, 1468]], [[64322, 64322], "disallowed"], [[64323, 64323], "mapped", [1507, 1468]], [[64324, 64324], "mapped", [1508, 1468]], [[64325, 64325], "disallowed"], [[64326, 64326], "mapped", [1510, 1468]], [[64327, 64327], "mapped", [1511, 1468]], [[64328, 64328], "mapped", [1512, 1468]], [[64329, 64329], "mapped", [1513, 1468]], [[64330, 64330], "mapped", [1514, 1468]], [[64331, 64331], "mapped", [1493, 1465]], [[64332, 64332], "mapped", [1489, 1471]], [[64333, 64333], "mapped", [1499, 1471]], [[64334, 64334], "mapped", [1508, 1471]], [[64335, 64335], "mapped", [1488, 1500]], [[64336, 64337], "mapped", [1649]], [[64338, 64341], "mapped", [1659]], [[64342, 64345], "mapped", [1662]], [[64346, 64349], "mapped", [1664]], [[64350, 64353], "mapped", [1658]], [[64354, 64357], "mapped", [1663]], [[64358, 64361], "mapped", [1657]], [[64362, 64365], "mapped", [1700]], [[64366, 64369], "mapped", [1702]], [[64370, 64373], "mapped", [1668]], [[64374, 64377], "mapped", [1667]], [[64378, 64381], "mapped", [1670]], [[64382, 64385], "mapped", [1671]], [[64386, 64387], "mapped", [1677]], [[64388, 64389], "mapped", [1676]], [[64390, 64391], "mapped", [1678]], [[64392, 64393], "mapped", [1672]], [[64394, 64395], "mapped", [1688]], [[64396, 64397], "mapped", [1681]], [[64398, 64401], "mapped", [1705]], [[64402, 64405], "mapped", [1711]], [[64406, 64409], "mapped", [1715]], [[64410, 64413], "mapped", [1713]], [[64414, 64415], "mapped", [1722]], [[64416, 64419], "mapped", [1723]], [[64420, 64421], "mapped", [1728]], [[64422, 64425], "mapped", [1729]], [[64426, 64429], "mapped", [1726]], [[64430, 64431], "mapped", [1746]], [[64432, 64433], "mapped", [1747]], [[64434, 64449], "valid", [], "NV8"], [[64450, 64466], "disallowed"], [[64467, 64470], "mapped", [1709]], [[64471, 64472], "mapped", [1735]], [[64473, 64474], "mapped", [1734]], [[64475, 64476], "mapped", [1736]], [[64477, 64477], "mapped", [1735, 1652]], [[64478, 64479], "mapped", [1739]], [[64480, 64481], "mapped", [1733]], [[64482, 64483], "mapped", [1737]], [[64484, 64487], "mapped", [1744]], [[64488, 64489], "mapped", [1609]], [[64490, 64491], "mapped", [1574, 1575]], [[64492, 64493], "mapped", [1574, 1749]], [[64494, 64495], "mapped", [1574, 1608]], [[64496, 64497], "mapped", [1574, 1735]], [[64498, 64499], "mapped", [1574, 1734]], [[64500, 64501], "mapped", [1574, 1736]], [[64502, 64504], "mapped", [1574, 1744]], [[64505, 64507], "mapped", [1574, 1609]], [[64508, 64511], "mapped", [1740]], [[64512, 64512], "mapped", [1574, 1580]], [[64513, 64513], "mapped", [1574, 1581]], [[64514, 64514], "mapped", [1574, 1605]], [[64515, 64515], "mapped", [1574, 1609]], [[64516, 64516], "mapped", [1574, 1610]], [[64517, 64517], "mapped", [1576, 1580]], [[64518, 64518], "mapped", [1576, 1581]], [[64519, 64519], "mapped", [1576, 1582]], [[64520, 64520], "mapped", [1576, 1605]], [[64521, 64521], "mapped", [1576, 1609]], [[64522, 64522], "mapped", [1576, 1610]], [[64523, 64523], "mapped", [1578, 1580]], [[64524, 64524], "mapped", [1578, 1581]], [[64525, 64525], "mapped", [1578, 1582]], [[64526, 64526], "mapped", [1578, 1605]], [[64527, 64527], "mapped", [1578, 1609]], [[64528, 64528], "mapped", [1578, 1610]], [[64529, 64529], "mapped", [1579, 1580]], [[64530, 64530], "mapped", [1579, 1605]], [[64531, 64531], "mapped", [1579, 1609]], [[64532, 64532], "mapped", [1579, 1610]], [[64533, 64533], "mapped", [1580, 1581]], [[64534, 64534], "mapped", [1580, 1605]], [[64535, 64535], "mapped", [1581, 1580]], [[64536, 64536], "mapped", [1581, 1605]], [[64537, 64537], "mapped", [1582, 1580]], [[64538, 64538], "mapped", [1582, 1581]], [[64539, 64539], "mapped", [1582, 1605]], [[64540, 64540], "mapped", [1587, 1580]], [[64541, 64541], "mapped", [1587, 1581]], [[64542, 64542], "mapped", [1587, 1582]], [[64543, 64543], "mapped", [1587, 1605]], [[64544, 64544], "mapped", [1589, 1581]], [[64545, 64545], "mapped", [1589, 1605]], [[64546, 64546], "mapped", [1590, 1580]], [[64547, 64547], "mapped", [1590, 1581]], [[64548, 64548], "mapped", [1590, 1582]], [[64549, 64549], "mapped", [1590, 1605]], [[64550, 64550], "mapped", [1591, 1581]], [[64551, 64551], "mapped", [1591, 1605]], [[64552, 64552], "mapped", [1592, 1605]], [[64553, 64553], "mapped", [1593, 1580]], [[64554, 64554], "mapped", [1593, 1605]], [[64555, 64555], "mapped", [1594, 1580]], [[64556, 64556], "mapped", [1594, 1605]], [[64557, 64557], "mapped", [1601, 1580]], [[64558, 64558], "mapped", [1601, 1581]], [[64559, 64559], "mapped", [1601, 1582]], [[64560, 64560], "mapped", [1601, 1605]], [[64561, 64561], "mapped", [1601, 1609]], [[64562, 64562], "mapped", [1601, 1610]], [[64563, 64563], "mapped", [1602, 1581]], [[64564, 64564], "mapped", [1602, 1605]], [[64565, 64565], "mapped", [1602, 1609]], [[64566, 64566], "mapped", [1602, 1610]], [[64567, 64567], "mapped", [1603, 1575]], [[64568, 64568], "mapped", [1603, 1580]], [[64569, 64569], "mapped", [1603, 1581]], [[64570, 64570], "mapped", [1603, 1582]], [[64571, 64571], "mapped", [1603, 1604]], [[64572, 64572], "mapped", [1603, 1605]], [[64573, 64573], "mapped", [1603, 1609]], [[64574, 64574], "mapped", [1603, 1610]], [[64575, 64575], "mapped", [1604, 1580]], [[64576, 64576], "mapped", [1604, 1581]], [[64577, 64577], "mapped", [1604, 1582]], [[64578, 64578], "mapped", [1604, 1605]], [[64579, 64579], "mapped", [1604, 1609]], [[64580, 64580], "mapped", [1604, 1610]], [[64581, 64581], "mapped", [1605, 1580]], [[64582, 64582], "mapped", [1605, 1581]], [[64583, 64583], "mapped", [1605, 1582]], [[64584, 64584], "mapped", [1605, 1605]], [[64585, 64585], "mapped", [1605, 1609]], [[64586, 64586], "mapped", [1605, 1610]], [[64587, 64587], "mapped", [1606, 1580]], [[64588, 64588], "mapped", [1606, 1581]], [[64589, 64589], "mapped", [1606, 1582]], [[64590, 64590], "mapped", [1606, 1605]], [[64591, 64591], "mapped", [1606, 1609]], [[64592, 64592], "mapped", [1606, 1610]], [[64593, 64593], "mapped", [1607, 1580]], [[64594, 64594], "mapped", [1607, 1605]], [[64595, 64595], "mapped", [1607, 1609]], [[64596, 64596], "mapped", [1607, 1610]], [[64597, 64597], "mapped", [1610, 1580]], [[64598, 64598], "mapped", [1610, 1581]], [[64599, 64599], "mapped", [1610, 1582]], [[64600, 64600], "mapped", [1610, 1605]], [[64601, 64601], "mapped", [1610, 1609]], [[64602, 64602], "mapped", [1610, 1610]], [[64603, 64603], "mapped", [1584, 1648]], [[64604, 64604], "mapped", [1585, 1648]], [[64605, 64605], "mapped", [1609, 1648]], [[64606, 64606], "disallowed_STD3_mapped", [32, 1612, 1617]], [[64607, 64607], "disallowed_STD3_mapped", [32, 1613, 1617]], [[64608, 64608], "disallowed_STD3_mapped", [32, 1614, 1617]], [[64609, 64609], "disallowed_STD3_mapped", [32, 1615, 1617]], [[64610, 64610], "disallowed_STD3_mapped", [32, 1616, 1617]], [[64611, 64611], "disallowed_STD3_mapped", [32, 1617, 1648]], [[64612, 64612], "mapped", [1574, 1585]], [[64613, 64613], "mapped", [1574, 1586]], [[64614, 64614], "mapped", [1574, 1605]], [[64615, 64615], "mapped", [1574, 1606]], [[64616, 64616], "mapped", [1574, 1609]], [[64617, 64617], "mapped", [1574, 1610]], [[64618, 64618], "mapped", [1576, 1585]], [[64619, 64619], "mapped", [1576, 1586]], [[64620, 64620], "mapped", [1576, 1605]], [[64621, 64621], "mapped", [1576, 1606]], [[64622, 64622], "mapped", [1576, 1609]], [[64623, 64623], "mapped", [1576, 1610]], [[64624, 64624], "mapped", [1578, 1585]], [[64625, 64625], "mapped", [1578, 1586]], [[64626, 64626], "mapped", [1578, 1605]], [[64627, 64627], "mapped", [1578, 1606]], [[64628, 64628], "mapped", [1578, 1609]], [[64629, 64629], "mapped", [1578, 1610]], [[64630, 64630], "mapped", [1579, 1585]], [[64631, 64631], "mapped", [1579, 1586]], [[64632, 64632], "mapped", [1579, 1605]], [[64633, 64633], "mapped", [1579, 1606]], [[64634, 64634], "mapped", [1579, 1609]], [[64635, 64635], "mapped", [1579, 1610]], [[64636, 64636], "mapped", [1601, 1609]], [[64637, 64637], "mapped", [1601, 1610]], [[64638, 64638], "mapped", [1602, 1609]], [[64639, 64639], "mapped", [1602, 1610]], [[64640, 64640], "mapped", [1603, 1575]], [[64641, 64641], "mapped", [1603, 1604]], [[64642, 64642], "mapped", [1603, 1605]], [[64643, 64643], "mapped", [1603, 1609]], [[64644, 64644], "mapped", [1603, 1610]], [[64645, 64645], "mapped", [1604, 1605]], [[64646, 64646], "mapped", [1604, 1609]], [[64647, 64647], "mapped", [1604, 1610]], [[64648, 64648], "mapped", [1605, 1575]], [[64649, 64649], "mapped", [1605, 1605]], [[64650, 64650], "mapped", [1606, 1585]], [[64651, 64651], "mapped", [1606, 1586]], [[64652, 64652], "mapped", [1606, 1605]], [[64653, 64653], "mapped", [1606, 1606]], [[64654, 64654], "mapped", [1606, 1609]], [[64655, 64655], "mapped", [1606, 1610]], [[64656, 64656], "mapped", [1609, 1648]], [[64657, 64657], "mapped", [1610, 1585]], [[64658, 64658], "mapped", [1610, 1586]], [[64659, 64659], "mapped", [1610, 1605]], [[64660, 64660], "mapped", [1610, 1606]], [[64661, 64661], "mapped", [1610, 1609]], [[64662, 64662], "mapped", [1610, 1610]], [[64663, 64663], "mapped", [1574, 1580]], [[64664, 64664], "mapped", [1574, 1581]], [[64665, 64665], "mapped", [1574, 1582]], [[64666, 64666], "mapped", [1574, 1605]], [[64667, 64667], "mapped", [1574, 1607]], [[64668, 64668], "mapped", [1576, 1580]], [[64669, 64669], "mapped", [1576, 1581]], [[64670, 64670], "mapped", [1576, 1582]], [[64671, 64671], "mapped", [1576, 1605]], [[64672, 64672], "mapped", [1576, 1607]], [[64673, 64673], "mapped", [1578, 1580]], [[64674, 64674], "mapped", [1578, 1581]], [[64675, 64675], "mapped", [1578, 1582]], [[64676, 64676], "mapped", [1578, 1605]], [[64677, 64677], "mapped", [1578, 1607]], [[64678, 64678], "mapped", [1579, 1605]], [[64679, 64679], "mapped", [1580, 1581]], [[64680, 64680], "mapped", [1580, 1605]], [[64681, 64681], "mapped", [1581, 1580]], [[64682, 64682], "mapped", [1581, 1605]], [[64683, 64683], "mapped", [1582, 1580]], [[64684, 64684], "mapped", [1582, 1605]], [[64685, 64685], "mapped", [1587, 1580]], [[64686, 64686], "mapped", [1587, 1581]], [[64687, 64687], "mapped", [1587, 1582]], [[64688, 64688], "mapped", [1587, 1605]], [[64689, 64689], "mapped", [1589, 1581]], [[64690, 64690], "mapped", [1589, 1582]], [[64691, 64691], "mapped", [1589, 1605]], [[64692, 64692], "mapped", [1590, 1580]], [[64693, 64693], "mapped", [1590, 1581]], [[64694, 64694], "mapped", [1590, 1582]], [[64695, 64695], "mapped", [1590, 1605]], [[64696, 64696], "mapped", [1591, 1581]], [[64697, 64697], "mapped", [1592, 1605]], [[64698, 64698], "mapped", [1593, 1580]], [[64699, 64699], "mapped", [1593, 1605]], [[64700, 64700], "mapped", [1594, 1580]], [[64701, 64701], "mapped", [1594, 1605]], [[64702, 64702], "mapped", [1601, 1580]], [[64703, 64703], "mapped", [1601, 1581]], [[64704, 64704], "mapped", [1601, 1582]], [[64705, 64705], "mapped", [1601, 1605]], [[64706, 64706], "mapped", [1602, 1581]], [[64707, 64707], "mapped", [1602, 1605]], [[64708, 64708], "mapped", [1603, 1580]], [[64709, 64709], "mapped", [1603, 1581]], [[64710, 64710], "mapped", [1603, 1582]], [[64711, 64711], "mapped", [1603, 1604]], [[64712, 64712], "mapped", [1603, 1605]], [[64713, 64713], "mapped", [1604, 1580]], [[64714, 64714], "mapped", [1604, 1581]], [[64715, 64715], "mapped", [1604, 1582]], [[64716, 64716], "mapped", [1604, 1605]], [[64717, 64717], "mapped", [1604, 1607]], [[64718, 64718], "mapped", [1605, 1580]], [[64719, 64719], "mapped", [1605, 1581]], [[64720, 64720], "mapped", [1605, 1582]], [[64721, 64721], "mapped", [1605, 1605]], [[64722, 64722], "mapped", [1606, 1580]], [[64723, 64723], "mapped", [1606, 1581]], [[64724, 64724], "mapped", [1606, 1582]], [[64725, 64725], "mapped", [1606, 1605]], [[64726, 64726], "mapped", [1606, 1607]], [[64727, 64727], "mapped", [1607, 1580]], [[64728, 64728], "mapped", [1607, 1605]], [[64729, 64729], "mapped", [1607, 1648]], [[64730, 64730], "mapped", [1610, 1580]], [[64731, 64731], "mapped", [1610, 1581]], [[64732, 64732], "mapped", [1610, 1582]], [[64733, 64733], "mapped", [1610, 1605]], [[64734, 64734], "mapped", [1610, 1607]], [[64735, 64735], "mapped", [1574, 1605]], [[64736, 64736], "mapped", [1574, 1607]], [[64737, 64737], "mapped", [1576, 1605]], [[64738, 64738], "mapped", [1576, 1607]], [[64739, 64739], "mapped", [1578, 1605]], [[64740, 64740], "mapped", [1578, 1607]], [[64741, 64741], "mapped", [1579, 1605]], [[64742, 64742], "mapped", [1579, 1607]], [[64743, 64743], "mapped", [1587, 1605]], [[64744, 64744], "mapped", [1587, 1607]], [[64745, 64745], "mapped", [1588, 1605]], [[64746, 64746], "mapped", [1588, 1607]], [[64747, 64747], "mapped", [1603, 1604]], [[64748, 64748], "mapped", [1603, 1605]], [[64749, 64749], "mapped", [1604, 1605]], [[64750, 64750], "mapped", [1606, 1605]], [[64751, 64751], "mapped", [1606, 1607]], [[64752, 64752], "mapped", [1610, 1605]], [[64753, 64753], "mapped", [1610, 1607]], [[64754, 64754], "mapped", [1600, 1614, 1617]], [[64755, 64755], "mapped", [1600, 1615, 1617]], [[64756, 64756], "mapped", [1600, 1616, 1617]], [[64757, 64757], "mapped", [1591, 1609]], [[64758, 64758], "mapped", [1591, 1610]], [[64759, 64759], "mapped", [1593, 1609]], [[64760, 64760], "mapped", [1593, 1610]], [[64761, 64761], "mapped", [1594, 1609]], [[64762, 64762], "mapped", [1594, 1610]], [[64763, 64763], "mapped", [1587, 1609]], [[64764, 64764], "mapped", [1587, 1610]], [[64765, 64765], "mapped", [1588, 1609]], [[64766, 64766], "mapped", [1588, 1610]], [[64767, 64767], "mapped", [1581, 1609]], [[64768, 64768], "mapped", [1581, 1610]], [[64769, 64769], "mapped", [1580, 1609]], [[64770, 64770], "mapped", [1580, 1610]], [[64771, 64771], "mapped", [1582, 1609]], [[64772, 64772], "mapped", [1582, 1610]], [[64773, 64773], "mapped", [1589, 1609]], [[64774, 64774], "mapped", [1589, 1610]], [[64775, 64775], "mapped", [1590, 1609]], [[64776, 64776], "mapped", [1590, 1610]], [[64777, 64777], "mapped", [1588, 1580]], [[64778, 64778], "mapped", [1588, 1581]], [[64779, 64779], "mapped", [1588, 1582]], [[64780, 64780], "mapped", [1588, 1605]], [[64781, 64781], "mapped", [1588, 1585]], [[64782, 64782], "mapped", [1587, 1585]], [[64783, 64783], "mapped", [1589, 1585]], [[64784, 64784], "mapped", [1590, 1585]], [[64785, 64785], "mapped", [1591, 1609]], [[64786, 64786], "mapped", [1591, 1610]], [[64787, 64787], "mapped", [1593, 1609]], [[64788, 64788], "mapped", [1593, 1610]], [[64789, 64789], "mapped", [1594, 1609]], [[64790, 64790], "mapped", [1594, 1610]], [[64791, 64791], "mapped", [1587, 1609]], [[64792, 64792], "mapped", [1587, 1610]], [[64793, 64793], "mapped", [1588, 1609]], [[64794, 64794], "mapped", [1588, 1610]], [[64795, 64795], "mapped", [1581, 1609]], [[64796, 64796], "mapped", [1581, 1610]], [[64797, 64797], "mapped", [1580, 1609]], [[64798, 64798], "mapped", [1580, 1610]], [[64799, 64799], "mapped", [1582, 1609]], [[64800, 64800], "mapped", [1582, 1610]], [[64801, 64801], "mapped", [1589, 1609]], [[64802, 64802], "mapped", [1589, 1610]], [[64803, 64803], "mapped", [1590, 1609]], [[64804, 64804], "mapped", [1590, 1610]], [[64805, 64805], "mapped", [1588, 1580]], [[64806, 64806], "mapped", [1588, 1581]], [[64807, 64807], "mapped", [1588, 1582]], [[64808, 64808], "mapped", [1588, 1605]], [[64809, 64809], "mapped", [1588, 1585]], [[64810, 64810], "mapped", [1587, 1585]], [[64811, 64811], "mapped", [1589, 1585]], [[64812, 64812], "mapped", [1590, 1585]], [[64813, 64813], "mapped", [1588, 1580]], [[64814, 64814], "mapped", [1588, 1581]], [[64815, 64815], "mapped", [1588, 1582]], [[64816, 64816], "mapped", [1588, 1605]], [[64817, 64817], "mapped", [1587, 1607]], [[64818, 64818], "mapped", [1588, 1607]], [[64819, 64819], "mapped", [1591, 1605]], [[64820, 64820], "mapped", [1587, 1580]], [[64821, 64821], "mapped", [1587, 1581]], [[64822, 64822], "mapped", [1587, 1582]], [[64823, 64823], "mapped", [1588, 1580]], [[64824, 64824], "mapped", [1588, 1581]], [[64825, 64825], "mapped", [1588, 1582]], [[64826, 64826], "mapped", [1591, 1605]], [[64827, 64827], "mapped", [1592, 1605]], [[64828, 64829], "mapped", [1575, 1611]], [[64830, 64831], "valid", [], "NV8"], [[64832, 64847], "disallowed"], [[64848, 64848], "mapped", [1578, 1580, 1605]], [[64849, 64850], "mapped", [1578, 1581, 1580]], [[64851, 64851], "mapped", [1578, 1581, 1605]], [[64852, 64852], "mapped", [1578, 1582, 1605]], [[64853, 64853], "mapped", [1578, 1605, 1580]], [[64854, 64854], "mapped", [1578, 1605, 1581]], [[64855, 64855], "mapped", [1578, 1605, 1582]], [[64856, 64857], "mapped", [1580, 1605, 1581]], [[64858, 64858], "mapped", [1581, 1605, 1610]], [[64859, 64859], "mapped", [1581, 1605, 1609]], [[64860, 64860], "mapped", [1587, 1581, 1580]], [[64861, 64861], "mapped", [1587, 1580, 1581]], [[64862, 64862], "mapped", [1587, 1580, 1609]], [[64863, 64864], "mapped", [1587, 1605, 1581]], [[64865, 64865], "mapped", [1587, 1605, 1580]], [[64866, 64867], "mapped", [1587, 1605, 1605]], [[64868, 64869], "mapped", [1589, 1581, 1581]], [[64870, 64870], "mapped", [1589, 1605, 1605]], [[64871, 64872], "mapped", [1588, 1581, 1605]], [[64873, 64873], "mapped", [1588, 1580, 1610]], [[64874, 64875], "mapped", [1588, 1605, 1582]], [[64876, 64877], "mapped", [1588, 1605, 1605]], [[64878, 64878], "mapped", [1590, 1581, 1609]], [[64879, 64880], "mapped", [1590, 1582, 1605]], [[64881, 64882], "mapped", [1591, 1605, 1581]], [[64883, 64883], "mapped", [1591, 1605, 1605]], [[64884, 64884], "mapped", [1591, 1605, 1610]], [[64885, 64885], "mapped", [1593, 1580, 1605]], [[64886, 64887], "mapped", [1593, 1605, 1605]], [[64888, 64888], "mapped", [1593, 1605, 1609]], [[64889, 64889], "mapped", [1594, 1605, 1605]], [[64890, 64890], "mapped", [1594, 1605, 1610]], [[64891, 64891], "mapped", [1594, 1605, 1609]], [[64892, 64893], "mapped", [1601, 1582, 1605]], [[64894, 64894], "mapped", [1602, 1605, 1581]], [[64895, 64895], "mapped", [1602, 1605, 1605]], [[64896, 64896], "mapped", [1604, 1581, 1605]], [[64897, 64897], "mapped", [1604, 1581, 1610]], [[64898, 64898], "mapped", [1604, 1581, 1609]], [[64899, 64900], "mapped", [1604, 1580, 1580]], [[64901, 64902], "mapped", [1604, 1582, 1605]], [[64903, 64904], "mapped", [1604, 1605, 1581]], [[64905, 64905], "mapped", [1605, 1581, 1580]], [[64906, 64906], "mapped", [1605, 1581, 1605]], [[64907, 64907], "mapped", [1605, 1581, 1610]], [[64908, 64908], "mapped", [1605, 1580, 1581]], [[64909, 64909], "mapped", [1605, 1580, 1605]], [[64910, 64910], "mapped", [1605, 1582, 1580]], [[64911, 64911], "mapped", [1605, 1582, 1605]], [[64912, 64913], "disallowed"], [[64914, 64914], "mapped", [1605, 1580, 1582]], [[64915, 64915], "mapped", [1607, 1605, 1580]], [[64916, 64916], "mapped", [1607, 1605, 1605]], [[64917, 64917], "mapped", [1606, 1581, 1605]], [[64918, 64918], "mapped", [1606, 1581, 1609]], [[64919, 64920], "mapped", [1606, 1580, 1605]], [[64921, 64921], "mapped", [1606, 1580, 1609]], [[64922, 64922], "mapped", [1606, 1605, 1610]], [[64923, 64923], "mapped", [1606, 1605, 1609]], [[64924, 64925], "mapped", [1610, 1605, 1605]], [[64926, 64926], "mapped", [1576, 1582, 1610]], [[64927, 64927], "mapped", [1578, 1580, 1610]], [[64928, 64928], "mapped", [1578, 1580, 1609]], [[64929, 64929], "mapped", [1578, 1582, 1610]], [[64930, 64930], "mapped", [1578, 1582, 1609]], [[64931, 64931], "mapped", [1578, 1605, 1610]], [[64932, 64932], "mapped", [1578, 1605, 1609]], [[64933, 64933], "mapped", [1580, 1605, 1610]], [[64934, 64934], "mapped", [1580, 1581, 1609]], [[64935, 64935], "mapped", [1580, 1605, 1609]], [[64936, 64936], "mapped", [1587, 1582, 1609]], [[64937, 64937], "mapped", [1589, 1581, 1610]], [[64938, 64938], "mapped", [1588, 1581, 1610]], [[64939, 64939], "mapped", [1590, 1581, 1610]], [[64940, 64940], "mapped", [1604, 1580, 1610]], [[64941, 64941], "mapped", [1604, 1605, 1610]], [[64942, 64942], "mapped", [1610, 1581, 1610]], [[64943, 64943], "mapped", [1610, 1580, 1610]], [[64944, 64944], "mapped", [1610, 1605, 1610]], [[64945, 64945], "mapped", [1605, 1605, 1610]], [[64946, 64946], "mapped", [1602, 1605, 1610]], [[64947, 64947], "mapped", [1606, 1581, 1610]], [[64948, 64948], "mapped", [1602, 1605, 1581]], [[64949, 64949], "mapped", [1604, 1581, 1605]], [[64950, 64950], "mapped", [1593, 1605, 1610]], [[64951, 64951], "mapped", [1603, 1605, 1610]], [[64952, 64952], "mapped", [1606, 1580, 1581]], [[64953, 64953], "mapped", [1605, 1582, 1610]], [[64954, 64954], "mapped", [1604, 1580, 1605]], [[64955, 64955], "mapped", [1603, 1605, 1605]], [[64956, 64956], "mapped", [1604, 1580, 1605]], [[64957, 64957], "mapped", [1606, 1580, 1581]], [[64958, 64958], "mapped", [1580, 1581, 1610]], [[64959, 64959], "mapped", [1581, 1580, 1610]], [[64960, 64960], "mapped", [1605, 1580, 1610]], [[64961, 64961], "mapped", [1601, 1605, 1610]], [[64962, 64962], "mapped", [1576, 1581, 1610]], [[64963, 64963], "mapped", [1603, 1605, 1605]], [[64964, 64964], "mapped", [1593, 1580, 1605]], [[64965, 64965], "mapped", [1589, 1605, 1605]], [[64966, 64966], "mapped", [1587, 1582, 1610]], [[64967, 64967], "mapped", [1606, 1580, 1610]], [[64968, 64975], "disallowed"], [[64976, 65007], "disallowed"], [[65008, 65008], "mapped", [1589, 1604, 1746]], [[65009, 65009], "mapped", [1602, 1604, 1746]], [[65010, 65010], "mapped", [1575, 1604, 1604, 1607]], [[65011, 65011], "mapped", [1575, 1603, 1576, 1585]], [[65012, 65012], "mapped", [1605, 1581, 1605, 1583]], [[65013, 65013], "mapped", [1589, 1604, 1593, 1605]], [[65014, 65014], "mapped", [1585, 1587, 1608, 1604]], [[65015, 65015], "mapped", [1593, 1604, 1610, 1607]], [[65016, 65016], "mapped", [1608, 1587, 1604, 1605]], [[65017, 65017], "mapped", [1589, 1604, 1609]], [[65018, 65018], "disallowed_STD3_mapped", [1589, 1604, 1609, 32, 1575, 1604, 1604, 1607, 32, 1593, 1604, 1610, 1607, 32, 1608, 1587, 1604, 1605]], [[65019, 65019], "disallowed_STD3_mapped", [1580, 1604, 32, 1580, 1604, 1575, 1604, 1607]], [[65020, 65020], "mapped", [1585, 1740, 1575, 1604]], [[65021, 65021], "valid", [], "NV8"], [[65022, 65023], "disallowed"], [[65024, 65039], "ignored"], [[65040, 65040], "disallowed_STD3_mapped", [44]], [[65041, 65041], "mapped", [12289]], [[65042, 65042], "disallowed"], [[65043, 65043], "disallowed_STD3_mapped", [58]], [[65044, 65044], "disallowed_STD3_mapped", [59]], [[65045, 65045], "disallowed_STD3_mapped", [33]], [[65046, 65046], "disallowed_STD3_mapped", [63]], [[65047, 65047], "mapped", [12310]], [[65048, 65048], "mapped", [12311]], [[65049, 65049], "disallowed"], [[65050, 65055], "disallowed"], [[65056, 65059], "valid"], [[65060, 65062], "valid"], [[65063, 65069], "valid"], [[65070, 65071], "valid"], [[65072, 65072], "disallowed"], [[65073, 65073], "mapped", [8212]], [[65074, 65074], "mapped", [8211]], [[65075, 65076], "disallowed_STD3_mapped", [95]], [[65077, 65077], "disallowed_STD3_mapped", [40]], [[65078, 65078], "disallowed_STD3_mapped", [41]], [[65079, 65079], "disallowed_STD3_mapped", [123]], [[65080, 65080], "disallowed_STD3_mapped", [125]], [[65081, 65081], "mapped", [12308]], [[65082, 65082], "mapped", [12309]], [[65083, 65083], "mapped", [12304]], [[65084, 65084], "mapped", [12305]], [[65085, 65085], "mapped", [12298]], [[65086, 65086], "mapped", [12299]], [[65087, 65087], "mapped", [12296]], [[65088, 65088], "mapped", [12297]], [[65089, 65089], "mapped", [12300]], [[65090, 65090], "mapped", [12301]], [[65091, 65091], "mapped", [12302]], [[65092, 65092], "mapped", [12303]], [[65093, 65094], "valid", [], "NV8"], [[65095, 65095], "disallowed_STD3_mapped", [91]], [[65096, 65096], "disallowed_STD3_mapped", [93]], [[65097, 65100], "disallowed_STD3_mapped", [32, 773]], [[65101, 65103], "disallowed_STD3_mapped", [95]], [[65104, 65104], "disallowed_STD3_mapped", [44]], [[65105, 65105], "mapped", [12289]], [[65106, 65106], "disallowed"], [[65107, 65107], "disallowed"], [[65108, 65108], "disallowed_STD3_mapped", [59]], [[65109, 65109], "disallowed_STD3_mapped", [58]], [[65110, 65110], "disallowed_STD3_mapped", [63]], [[65111, 65111], "disallowed_STD3_mapped", [33]], [[65112, 65112], "mapped", [8212]], [[65113, 65113], "disallowed_STD3_mapped", [40]], [[65114, 65114], "disallowed_STD3_mapped", [41]], [[65115, 65115], "disallowed_STD3_mapped", [123]], [[65116, 65116], "disallowed_STD3_mapped", [125]], [[65117, 65117], "mapped", [12308]], [[65118, 65118], "mapped", [12309]], [[65119, 65119], "disallowed_STD3_mapped", [35]], [[65120, 65120], "disallowed_STD3_mapped", [38]], [[65121, 65121], "disallowed_STD3_mapped", [42]], [[65122, 65122], "disallowed_STD3_mapped", [43]], [[65123, 65123], "mapped", [45]], [[65124, 65124], "disallowed_STD3_mapped", [60]], [[65125, 65125], "disallowed_STD3_mapped", [62]], [[65126, 65126], "disallowed_STD3_mapped", [61]], [[65127, 65127], "disallowed"], [[65128, 65128], "disallowed_STD3_mapped", [92]], [[65129, 65129], "disallowed_STD3_mapped", [36]], [[65130, 65130], "disallowed_STD3_mapped", [37]], [[65131, 65131], "disallowed_STD3_mapped", [64]], [[65132, 65135], "disallowed"], [[65136, 65136], "disallowed_STD3_mapped", [32, 1611]], [[65137, 65137], "mapped", [1600, 1611]], [[65138, 65138], "disallowed_STD3_mapped", [32, 1612]], [[65139, 65139], "valid"], [[65140, 65140], "disallowed_STD3_mapped", [32, 1613]], [[65141, 65141], "disallowed"], [[65142, 65142], "disallowed_STD3_mapped", [32, 1614]], [[65143, 65143], "mapped", [1600, 1614]], [[65144, 65144], "disallowed_STD3_mapped", [32, 1615]], [[65145, 65145], "mapped", [1600, 1615]], [[65146, 65146], "disallowed_STD3_mapped", [32, 1616]], [[65147, 65147], "mapped", [1600, 1616]], [[65148, 65148], "disallowed_STD3_mapped", [32, 1617]], [[65149, 65149], "mapped", [1600, 1617]], [[65150, 65150], "disallowed_STD3_mapped", [32, 1618]], [[65151, 65151], "mapped", [1600, 1618]], [[65152, 65152], "mapped", [1569]], [[65153, 65154], "mapped", [1570]], [[65155, 65156], "mapped", [1571]], [[65157, 65158], "mapped", [1572]], [[65159, 65160], "mapped", [1573]], [[65161, 65164], "mapped", [1574]], [[65165, 65166], "mapped", [1575]], [[65167, 65170], "mapped", [1576]], [[65171, 65172], "mapped", [1577]], [[65173, 65176], "mapped", [1578]], [[65177, 65180], "mapped", [1579]], [[65181, 65184], "mapped", [1580]], [[65185, 65188], "mapped", [1581]], [[65189, 65192], "mapped", [1582]], [[65193, 65194], "mapped", [1583]], [[65195, 65196], "mapped", [1584]], [[65197, 65198], "mapped", [1585]], [[65199, 65200], "mapped", [1586]], [[65201, 65204], "mapped", [1587]], [[65205, 65208], "mapped", [1588]], [[65209, 65212], "mapped", [1589]], [[65213, 65216], "mapped", [1590]], [[65217, 65220], "mapped", [1591]], [[65221, 65224], "mapped", [1592]], [[65225, 65228], "mapped", [1593]], [[65229, 65232], "mapped", [1594]], [[65233, 65236], "mapped", [1601]], [[65237, 65240], "mapped", [1602]], [[65241, 65244], "mapped", [1603]], [[65245, 65248], "mapped", [1604]], [[65249, 65252], "mapped", [1605]], [[65253, 65256], "mapped", [1606]], [[65257, 65260], "mapped", [1607]], [[65261, 65262], "mapped", [1608]], [[65263, 65264], "mapped", [1609]], [[65265, 65268], "mapped", [1610]], [[65269, 65270], "mapped", [1604, 1570]], [[65271, 65272], "mapped", [1604, 1571]], [[65273, 65274], "mapped", [1604, 1573]], [[65275, 65276], "mapped", [1604, 1575]], [[65277, 65278], "disallowed"], [[65279, 65279], "ignored"], [[65280, 65280], "disallowed"], [[65281, 65281], "disallowed_STD3_mapped", [33]], [[65282, 65282], "disallowed_STD3_mapped", [34]], [[65283, 65283], "disallowed_STD3_mapped", [35]], [[65284, 65284], "disallowed_STD3_mapped", [36]], [[65285, 65285], "disallowed_STD3_mapped", [37]], [[65286, 65286], "disallowed_STD3_mapped", [38]], [[65287, 65287], "disallowed_STD3_mapped", [39]], [[65288, 65288], "disallowed_STD3_mapped", [40]], [[65289, 65289], "disallowed_STD3_mapped", [41]], [[65290, 65290], "disallowed_STD3_mapped", [42]], [[65291, 65291], "disallowed_STD3_mapped", [43]], [[65292, 65292], "disallowed_STD3_mapped", [44]], [[65293, 65293], "mapped", [45]], [[65294, 65294], "mapped", [46]], [[65295, 65295], "disallowed_STD3_mapped", [47]], [[65296, 65296], "mapped", [48]], [[65297, 65297], "mapped", [49]], [[65298, 65298], "mapped", [50]], [[65299, 65299], "mapped", [51]], [[65300, 65300], "mapped", [52]], [[65301, 65301], "mapped", [53]], [[65302, 65302], "mapped", [54]], [[65303, 65303], "mapped", [55]], [[65304, 65304], "mapped", [56]], [[65305, 65305], "mapped", [57]], [[65306, 65306], "disallowed_STD3_mapped", [58]], [[65307, 65307], "disallowed_STD3_mapped", [59]], [[65308, 65308], "disallowed_STD3_mapped", [60]], [[65309, 65309], "disallowed_STD3_mapped", [61]], [[65310, 65310], "disallowed_STD3_mapped", [62]], [[65311, 65311], "disallowed_STD3_mapped", [63]], [[65312, 65312], "disallowed_STD3_mapped", [64]], [[65313, 65313], "mapped", [97]], [[65314, 65314], "mapped", [98]], [[65315, 65315], "mapped", [99]], [[65316, 65316], "mapped", [100]], [[65317, 65317], "mapped", [101]], [[65318, 65318], "mapped", [102]], [[65319, 65319], "mapped", [103]], [[65320, 65320], "mapped", [104]], [[65321, 65321], "mapped", [105]], [[65322, 65322], "mapped", [106]], [[65323, 65323], "mapped", [107]], [[65324, 65324], "mapped", [108]], [[65325, 65325], "mapped", [109]], [[65326, 65326], "mapped", [110]], [[65327, 65327], "mapped", [111]], [[65328, 65328], "mapped", [112]], [[65329, 65329], "mapped", [113]], [[65330, 65330], "mapped", [114]], [[65331, 65331], "mapped", [115]], [[65332, 65332], "mapped", [116]], [[65333, 65333], "mapped", [117]], [[65334, 65334], "mapped", [118]], [[65335, 65335], "mapped", [119]], [[65336, 65336], "mapped", [120]], [[65337, 65337], "mapped", [121]], [[65338, 65338], "mapped", [122]], [[65339, 65339], "disallowed_STD3_mapped", [91]], [[65340, 65340], "disallowed_STD3_mapped", [92]], [[65341, 65341], "disallowed_STD3_mapped", [93]], [[65342, 65342], "disallowed_STD3_mapped", [94]], [[65343, 65343], "disallowed_STD3_mapped", [95]], [[65344, 65344], "disallowed_STD3_mapped", [96]], [[65345, 65345], "mapped", [97]], [[65346, 65346], "mapped", [98]], [[65347, 65347], "mapped", [99]], [[65348, 65348], "mapped", [100]], [[65349, 65349], "mapped", [101]], [[65350, 65350], "mapped", [102]], [[65351, 65351], "mapped", [103]], [[65352, 65352], "mapped", [104]], [[65353, 65353], "mapped", [105]], [[65354, 65354], "mapped", [106]], [[65355, 65355], "mapped", [107]], [[65356, 65356], "mapped", [108]], [[65357, 65357], "mapped", [109]], [[65358, 65358], "mapped", [110]], [[65359, 65359], "mapped", [111]], [[65360, 65360], "mapped", [112]], [[65361, 65361], "mapped", [113]], [[65362, 65362], "mapped", [114]], [[65363, 65363], "mapped", [115]], [[65364, 65364], "mapped", [116]], [[65365, 65365], "mapped", [117]], [[65366, 65366], "mapped", [118]], [[65367, 65367], "mapped", [119]], [[65368, 65368], "mapped", [120]], [[65369, 65369], "mapped", [121]], [[65370, 65370], "mapped", [122]], [[65371, 65371], "disallowed_STD3_mapped", [123]], [[65372, 65372], "disallowed_STD3_mapped", [124]], [[65373, 65373], "disallowed_STD3_mapped", [125]], [[65374, 65374], "disallowed_STD3_mapped", [126]], [[65375, 65375], "mapped", [10629]], [[65376, 65376], "mapped", [10630]], [[65377, 65377], "mapped", [46]], [[65378, 65378], "mapped", [12300]], [[65379, 65379], "mapped", [12301]], [[65380, 65380], "mapped", [12289]], [[65381, 65381], "mapped", [12539]], [[65382, 65382], "mapped", [12530]], [[65383, 65383], "mapped", [12449]], [[65384, 65384], "mapped", [12451]], [[65385, 65385], "mapped", [12453]], [[65386, 65386], "mapped", [12455]], [[65387, 65387], "mapped", [12457]], [[65388, 65388], "mapped", [12515]], [[65389, 65389], "mapped", [12517]], [[65390, 65390], "mapped", [12519]], [[65391, 65391], "mapped", [12483]], [[65392, 65392], "mapped", [12540]], [[65393, 65393], "mapped", [12450]], [[65394, 65394], "mapped", [12452]], [[65395, 65395], "mapped", [12454]], [[65396, 65396], "mapped", [12456]], [[65397, 65397], "mapped", [12458]], [[65398, 65398], "mapped", [12459]], [[65399, 65399], "mapped", [12461]], [[65400, 65400], "mapped", [12463]], [[65401, 65401], "mapped", [12465]], [[65402, 65402], "mapped", [12467]], [[65403, 65403], "mapped", [12469]], [[65404, 65404], "mapped", [12471]], [[65405, 65405], "mapped", [12473]], [[65406, 65406], "mapped", [12475]], [[65407, 65407], "mapped", [12477]], [[65408, 65408], "mapped", [12479]], [[65409, 65409], "mapped", [12481]], [[65410, 65410], "mapped", [12484]], [[65411, 65411], "mapped", [12486]], [[65412, 65412], "mapped", [12488]], [[65413, 65413], "mapped", [12490]], [[65414, 65414], "mapped", [12491]], [[65415, 65415], "mapped", [12492]], [[65416, 65416], "mapped", [12493]], [[65417, 65417], "mapped", [12494]], [[65418, 65418], "mapped", [12495]], [[65419, 65419], "mapped", [12498]], [[65420, 65420], "mapped", [12501]], [[65421, 65421], "mapped", [12504]], [[65422, 65422], "mapped", [12507]], [[65423, 65423], "mapped", [12510]], [[65424, 65424], "mapped", [12511]], [[65425, 65425], "mapped", [12512]], [[65426, 65426], "mapped", [12513]], [[65427, 65427], "mapped", [12514]], [[65428, 65428], "mapped", [12516]], [[65429, 65429], "mapped", [12518]], [[65430, 65430], "mapped", [12520]], [[65431, 65431], "mapped", [12521]], [[65432, 65432], "mapped", [12522]], [[65433, 65433], "mapped", [12523]], [[65434, 65434], "mapped", [12524]], [[65435, 65435], "mapped", [12525]], [[65436, 65436], "mapped", [12527]], [[65437, 65437], "mapped", [12531]], [[65438, 65438], "mapped", [12441]], [[65439, 65439], "mapped", [12442]], [[65440, 65440], "disallowed"], [[65441, 65441], "mapped", [4352]], [[65442, 65442], "mapped", [4353]], [[65443, 65443], "mapped", [4522]], [[65444, 65444], "mapped", [4354]], [[65445, 65445], "mapped", [4524]], [[65446, 65446], "mapped", [4525]], [[65447, 65447], "mapped", [4355]], [[65448, 65448], "mapped", [4356]], [[65449, 65449], "mapped", [4357]], [[65450, 65450], "mapped", [4528]], [[65451, 65451], "mapped", [4529]], [[65452, 65452], "mapped", [4530]], [[65453, 65453], "mapped", [4531]], [[65454, 65454], "mapped", [4532]], [[65455, 65455], "mapped", [4533]], [[65456, 65456], "mapped", [4378]], [[65457, 65457], "mapped", [4358]], [[65458, 65458], "mapped", [4359]], [[65459, 65459], "mapped", [4360]], [[65460, 65460], "mapped", [4385]], [[65461, 65461], "mapped", [4361]], [[65462, 65462], "mapped", [4362]], [[65463, 65463], "mapped", [4363]], [[65464, 65464], "mapped", [4364]], [[65465, 65465], "mapped", [4365]], [[65466, 65466], "mapped", [4366]], [[65467, 65467], "mapped", [4367]], [[65468, 65468], "mapped", [4368]], [[65469, 65469], "mapped", [4369]], [[65470, 65470], "mapped", [4370]], [[65471, 65473], "disallowed"], [[65474, 65474], "mapped", [4449]], [[65475, 65475], "mapped", [4450]], [[65476, 65476], "mapped", [4451]], [[65477, 65477], "mapped", [4452]], [[65478, 65478], "mapped", [4453]], [[65479, 65479], "mapped", [4454]], [[65480, 65481], "disallowed"], [[65482, 65482], "mapped", [4455]], [[65483, 65483], "mapped", [4456]], [[65484, 65484], "mapped", [4457]], [[65485, 65485], "mapped", [4458]], [[65486, 65486], "mapped", [4459]], [[65487, 65487], "mapped", [4460]], [[65488, 65489], "disallowed"], [[65490, 65490], "mapped", [4461]], [[65491, 65491], "mapped", [4462]], [[65492, 65492], "mapped", [4463]], [[65493, 65493], "mapped", [4464]], [[65494, 65494], "mapped", [4465]], [[65495, 65495], "mapped", [4466]], [[65496, 65497], "disallowed"], [[65498, 65498], "mapped", [4467]], [[65499, 65499], "mapped", [4468]], [[65500, 65500], "mapped", [4469]], [[65501, 65503], "disallowed"], [[65504, 65504], "mapped", [162]], [[65505, 65505], "mapped", [163]], [[65506, 65506], "mapped", [172]], [[65507, 65507], "disallowed_STD3_mapped", [32, 772]], [[65508, 65508], "mapped", [166]], [[65509, 65509], "mapped", [165]], [[65510, 65510], "mapped", [8361]], [[65511, 65511], "disallowed"], [[65512, 65512], "mapped", [9474]], [[65513, 65513], "mapped", [8592]], [[65514, 65514], "mapped", [8593]], [[65515, 65515], "mapped", [8594]], [[65516, 65516], "mapped", [8595]], [[65517, 65517], "mapped", [9632]], [[65518, 65518], "mapped", [9675]], [[65519, 65528], "disallowed"], [[65529, 65531], "disallowed"], [[65532, 65532], "disallowed"], [[65533, 65533], "disallowed"], [[65534, 65535], "disallowed"], [[65536, 65547], "valid"], [[65548, 65548], "disallowed"], [[65549, 65574], "valid"], [[65575, 65575], "disallowed"], [[65576, 65594], "valid"], [[65595, 65595], "disallowed"], [[65596, 65597], "valid"], [[65598, 65598], "disallowed"], [[65599, 65613], "valid"], [[65614, 65615], "disallowed"], [[65616, 65629], "valid"], [[65630, 65663], "disallowed"], [[65664, 65786], "valid"], [[65787, 65791], "disallowed"], [[65792, 65794], "valid", [], "NV8"], [[65795, 65798], "disallowed"], [[65799, 65843], "valid", [], "NV8"], [[65844, 65846], "disallowed"], [[65847, 65855], "valid", [], "NV8"], [[65856, 65930], "valid", [], "NV8"], [[65931, 65932], "valid", [], "NV8"], [[65933, 65935], "disallowed"], [[65936, 65947], "valid", [], "NV8"], [[65948, 65951], "disallowed"], [[65952, 65952], "valid", [], "NV8"], [[65953, 65999], "disallowed"], [[66e3, 66044], "valid", [], "NV8"], [[66045, 66045], "valid"], [[66046, 66175], "disallowed"], [[66176, 66204], "valid"], [[66205, 66207], "disallowed"], [[66208, 66256], "valid"], [[66257, 66271], "disallowed"], [[66272, 66272], "valid"], [[66273, 66299], "valid", [], "NV8"], [[66300, 66303], "disallowed"], [[66304, 66334], "valid"], [[66335, 66335], "valid"], [[66336, 66339], "valid", [], "NV8"], [[66340, 66351], "disallowed"], [[66352, 66368], "valid"], [[66369, 66369], "valid", [], "NV8"], [[66370, 66377], "valid"], [[66378, 66378], "valid", [], "NV8"], [[66379, 66383], "disallowed"], [[66384, 66426], "valid"], [[66427, 66431], "disallowed"], [[66432, 66461], "valid"], [[66462, 66462], "disallowed"], [[66463, 66463], "valid", [], "NV8"], [[66464, 66499], "valid"], [[66500, 66503], "disallowed"], [[66504, 66511], "valid"], [[66512, 66517], "valid", [], "NV8"], [[66518, 66559], "disallowed"], [[66560, 66560], "mapped", [66600]], [[66561, 66561], "mapped", [66601]], [[66562, 66562], "mapped", [66602]], [[66563, 66563], "mapped", [66603]], [[66564, 66564], "mapped", [66604]], [[66565, 66565], "mapped", [66605]], [[66566, 66566], "mapped", [66606]], [[66567, 66567], "mapped", [66607]], [[66568, 66568], "mapped", [66608]], [[66569, 66569], "mapped", [66609]], [[66570, 66570], "mapped", [66610]], [[66571, 66571], "mapped", [66611]], [[66572, 66572], "mapped", [66612]], [[66573, 66573], "mapped", [66613]], [[66574, 66574], "mapped", [66614]], [[66575, 66575], "mapped", [66615]], [[66576, 66576], "mapped", [66616]], [[66577, 66577], "mapped", [66617]], [[66578, 66578], "mapped", [66618]], [[66579, 66579], "mapped", [66619]], [[66580, 66580], "mapped", [66620]], [[66581, 66581], "mapped", [66621]], [[66582, 66582], "mapped", [66622]], [[66583, 66583], "mapped", [66623]], [[66584, 66584], "mapped", [66624]], [[66585, 66585], "mapped", [66625]], [[66586, 66586], "mapped", [66626]], [[66587, 66587], "mapped", [66627]], [[66588, 66588], "mapped", [66628]], [[66589, 66589], "mapped", [66629]], [[66590, 66590], "mapped", [66630]], [[66591, 66591], "mapped", [66631]], [[66592, 66592], "mapped", [66632]], [[66593, 66593], "mapped", [66633]], [[66594, 66594], "mapped", [66634]], [[66595, 66595], "mapped", [66635]], [[66596, 66596], "mapped", [66636]], [[66597, 66597], "mapped", [66637]], [[66598, 66598], "mapped", [66638]], [[66599, 66599], "mapped", [66639]], [[66600, 66637], "valid"], [[66638, 66717], "valid"], [[66718, 66719], "disallowed"], [[66720, 66729], "valid"], [[66730, 66815], "disallowed"], [[66816, 66855], "valid"], [[66856, 66863], "disallowed"], [[66864, 66915], "valid"], [[66916, 66926], "disallowed"], [[66927, 66927], "valid", [], "NV8"], [[66928, 67071], "disallowed"], [[67072, 67382], "valid"], [[67383, 67391], "disallowed"], [[67392, 67413], "valid"], [[67414, 67423], "disallowed"], [[67424, 67431], "valid"], [[67432, 67583], "disallowed"], [[67584, 67589], "valid"], [[67590, 67591], "disallowed"], [[67592, 67592], "valid"], [[67593, 67593], "disallowed"], [[67594, 67637], "valid"], [[67638, 67638], "disallowed"], [[67639, 67640], "valid"], [[67641, 67643], "disallowed"], [[67644, 67644], "valid"], [[67645, 67646], "disallowed"], [[67647, 67647], "valid"], [[67648, 67669], "valid"], [[67670, 67670], "disallowed"], [[67671, 67679], "valid", [], "NV8"], [[67680, 67702], "valid"], [[67703, 67711], "valid", [], "NV8"], [[67712, 67742], "valid"], [[67743, 67750], "disallowed"], [[67751, 67759], "valid", [], "NV8"], [[67760, 67807], "disallowed"], [[67808, 67826], "valid"], [[67827, 67827], "disallowed"], [[67828, 67829], "valid"], [[67830, 67834], "disallowed"], [[67835, 67839], "valid", [], "NV8"], [[67840, 67861], "valid"], [[67862, 67865], "valid", [], "NV8"], [[67866, 67867], "valid", [], "NV8"], [[67868, 67870], "disallowed"], [[67871, 67871], "valid", [], "NV8"], [[67872, 67897], "valid"], [[67898, 67902], "disallowed"], [[67903, 67903], "valid", [], "NV8"], [[67904, 67967], "disallowed"], [[67968, 68023], "valid"], [[68024, 68027], "disallowed"], [[68028, 68029], "valid", [], "NV8"], [[68030, 68031], "valid"], [[68032, 68047], "valid", [], "NV8"], [[68048, 68049], "disallowed"], [[68050, 68095], "valid", [], "NV8"], [[68096, 68099], "valid"], [[68100, 68100], "disallowed"], [[68101, 68102], "valid"], [[68103, 68107], "disallowed"], [[68108, 68115], "valid"], [[68116, 68116], "disallowed"], [[68117, 68119], "valid"], [[68120, 68120], "disallowed"], [[68121, 68147], "valid"], [[68148, 68151], "disallowed"], [[68152, 68154], "valid"], [[68155, 68158], "disallowed"], [[68159, 68159], "valid"], [[68160, 68167], "valid", [], "NV8"], [[68168, 68175], "disallowed"], [[68176, 68184], "valid", [], "NV8"], [[68185, 68191], "disallowed"], [[68192, 68220], "valid"], [[68221, 68223], "valid", [], "NV8"], [[68224, 68252], "valid"], [[68253, 68255], "valid", [], "NV8"], [[68256, 68287], "disallowed"], [[68288, 68295], "valid"], [[68296, 68296], "valid", [], "NV8"], [[68297, 68326], "valid"], [[68327, 68330], "disallowed"], [[68331, 68342], "valid", [], "NV8"], [[68343, 68351], "disallowed"], [[68352, 68405], "valid"], [[68406, 68408], "disallowed"], [[68409, 68415], "valid", [], "NV8"], [[68416, 68437], "valid"], [[68438, 68439], "disallowed"], [[68440, 68447], "valid", [], "NV8"], [[68448, 68466], "valid"], [[68467, 68471], "disallowed"], [[68472, 68479], "valid", [], "NV8"], [[68480, 68497], "valid"], [[68498, 68504], "disallowed"], [[68505, 68508], "valid", [], "NV8"], [[68509, 68520], "disallowed"], [[68521, 68527], "valid", [], "NV8"], [[68528, 68607], "disallowed"], [[68608, 68680], "valid"], [[68681, 68735], "disallowed"], [[68736, 68736], "mapped", [68800]], [[68737, 68737], "mapped", [68801]], [[68738, 68738], "mapped", [68802]], [[68739, 68739], "mapped", [68803]], [[68740, 68740], "mapped", [68804]], [[68741, 68741], "mapped", [68805]], [[68742, 68742], "mapped", [68806]], [[68743, 68743], "mapped", [68807]], [[68744, 68744], "mapped", [68808]], [[68745, 68745], "mapped", [68809]], [[68746, 68746], "mapped", [68810]], [[68747, 68747], "mapped", [68811]], [[68748, 68748], "mapped", [68812]], [[68749, 68749], "mapped", [68813]], [[68750, 68750], "mapped", [68814]], [[68751, 68751], "mapped", [68815]], [[68752, 68752], "mapped", [68816]], [[68753, 68753], "mapped", [68817]], [[68754, 68754], "mapped", [68818]], [[68755, 68755], "mapped", [68819]], [[68756, 68756], "mapped", [68820]], [[68757, 68757], "mapped", [68821]], [[68758, 68758], "mapped", [68822]], [[68759, 68759], "mapped", [68823]], [[68760, 68760], "mapped", [68824]], [[68761, 68761], "mapped", [68825]], [[68762, 68762], "mapped", [68826]], [[68763, 68763], "mapped", [68827]], [[68764, 68764], "mapped", [68828]], [[68765, 68765], "mapped", [68829]], [[68766, 68766], "mapped", [68830]], [[68767, 68767], "mapped", [68831]], [[68768, 68768], "mapped", [68832]], [[68769, 68769], "mapped", [68833]], [[68770, 68770], "mapped", [68834]], [[68771, 68771], "mapped", [68835]], [[68772, 68772], "mapped", [68836]], [[68773, 68773], "mapped", [68837]], [[68774, 68774], "mapped", [68838]], [[68775, 68775], "mapped", [68839]], [[68776, 68776], "mapped", [68840]], [[68777, 68777], "mapped", [68841]], [[68778, 68778], "mapped", [68842]], [[68779, 68779], "mapped", [68843]], [[68780, 68780], "mapped", [68844]], [[68781, 68781], "mapped", [68845]], [[68782, 68782], "mapped", [68846]], [[68783, 68783], "mapped", [68847]], [[68784, 68784], "mapped", [68848]], [[68785, 68785], "mapped", [68849]], [[68786, 68786], "mapped", [68850]], [[68787, 68799], "disallowed"], [[68800, 68850], "valid"], [[68851, 68857], "disallowed"], [[68858, 68863], "valid", [], "NV8"], [[68864, 69215], "disallowed"], [[69216, 69246], "valid", [], "NV8"], [[69247, 69631], "disallowed"], [[69632, 69702], "valid"], [[69703, 69709], "valid", [], "NV8"], [[69710, 69713], "disallowed"], [[69714, 69733], "valid", [], "NV8"], [[69734, 69743], "valid"], [[69744, 69758], "disallowed"], [[69759, 69759], "valid"], [[69760, 69818], "valid"], [[69819, 69820], "valid", [], "NV8"], [[69821, 69821], "disallowed"], [[69822, 69825], "valid", [], "NV8"], [[69826, 69839], "disallowed"], [[69840, 69864], "valid"], [[69865, 69871], "disallowed"], [[69872, 69881], "valid"], [[69882, 69887], "disallowed"], [[69888, 69940], "valid"], [[69941, 69941], "disallowed"], [[69942, 69951], "valid"], [[69952, 69955], "valid", [], "NV8"], [[69956, 69967], "disallowed"], [[69968, 70003], "valid"], [[70004, 70005], "valid", [], "NV8"], [[70006, 70006], "valid"], [[70007, 70015], "disallowed"], [[70016, 70084], "valid"], [[70085, 70088], "valid", [], "NV8"], [[70089, 70089], "valid", [], "NV8"], [[70090, 70092], "valid"], [[70093, 70093], "valid", [], "NV8"], [[70094, 70095], "disallowed"], [[70096, 70105], "valid"], [[70106, 70106], "valid"], [[70107, 70107], "valid", [], "NV8"], [[70108, 70108], "valid"], [[70109, 70111], "valid", [], "NV8"], [[70112, 70112], "disallowed"], [[70113, 70132], "valid", [], "NV8"], [[70133, 70143], "disallowed"], [[70144, 70161], "valid"], [[70162, 70162], "disallowed"], [[70163, 70199], "valid"], [[70200, 70205], "valid", [], "NV8"], [[70206, 70271], "disallowed"], [[70272, 70278], "valid"], [[70279, 70279], "disallowed"], [[70280, 70280], "valid"], [[70281, 70281], "disallowed"], [[70282, 70285], "valid"], [[70286, 70286], "disallowed"], [[70287, 70301], "valid"], [[70302, 70302], "disallowed"], [[70303, 70312], "valid"], [[70313, 70313], "valid", [], "NV8"], [[70314, 70319], "disallowed"], [[70320, 70378], "valid"], [[70379, 70383], "disallowed"], [[70384, 70393], "valid"], [[70394, 70399], "disallowed"], [[70400, 70400], "valid"], [[70401, 70403], "valid"], [[70404, 70404], "disallowed"], [[70405, 70412], "valid"], [[70413, 70414], "disallowed"], [[70415, 70416], "valid"], [[70417, 70418], "disallowed"], [[70419, 70440], "valid"], [[70441, 70441], "disallowed"], [[70442, 70448], "valid"], [[70449, 70449], "disallowed"], [[70450, 70451], "valid"], [[70452, 70452], "disallowed"], [[70453, 70457], "valid"], [[70458, 70459], "disallowed"], [[70460, 70468], "valid"], [[70469, 70470], "disallowed"], [[70471, 70472], "valid"], [[70473, 70474], "disallowed"], [[70475, 70477], "valid"], [[70478, 70479], "disallowed"], [[70480, 70480], "valid"], [[70481, 70486], "disallowed"], [[70487, 70487], "valid"], [[70488, 70492], "disallowed"], [[70493, 70499], "valid"], [[70500, 70501], "disallowed"], [[70502, 70508], "valid"], [[70509, 70511], "disallowed"], [[70512, 70516], "valid"], [[70517, 70783], "disallowed"], [[70784, 70853], "valid"], [[70854, 70854], "valid", [], "NV8"], [[70855, 70855], "valid"], [[70856, 70863], "disallowed"], [[70864, 70873], "valid"], [[70874, 71039], "disallowed"], [[71040, 71093], "valid"], [[71094, 71095], "disallowed"], [[71096, 71104], "valid"], [[71105, 71113], "valid", [], "NV8"], [[71114, 71127], "valid", [], "NV8"], [[71128, 71133], "valid"], [[71134, 71167], "disallowed"], [[71168, 71232], "valid"], [[71233, 71235], "valid", [], "NV8"], [[71236, 71236], "valid"], [[71237, 71247], "disallowed"], [[71248, 71257], "valid"], [[71258, 71295], "disallowed"], [[71296, 71351], "valid"], [[71352, 71359], "disallowed"], [[71360, 71369], "valid"], [[71370, 71423], "disallowed"], [[71424, 71449], "valid"], [[71450, 71452], "disallowed"], [[71453, 71467], "valid"], [[71468, 71471], "disallowed"], [[71472, 71481], "valid"], [[71482, 71487], "valid", [], "NV8"], [[71488, 71839], "disallowed"], [[71840, 71840], "mapped", [71872]], [[71841, 71841], "mapped", [71873]], [[71842, 71842], "mapped", [71874]], [[71843, 71843], "mapped", [71875]], [[71844, 71844], "mapped", [71876]], [[71845, 71845], "mapped", [71877]], [[71846, 71846], "mapped", [71878]], [[71847, 71847], "mapped", [71879]], [[71848, 71848], "mapped", [71880]], [[71849, 71849], "mapped", [71881]], [[71850, 71850], "mapped", [71882]], [[71851, 71851], "mapped", [71883]], [[71852, 71852], "mapped", [71884]], [[71853, 71853], "mapped", [71885]], [[71854, 71854], "mapped", [71886]], [[71855, 71855], "mapped", [71887]], [[71856, 71856], "mapped", [71888]], [[71857, 71857], "mapped", [71889]], [[71858, 71858], "mapped", [71890]], [[71859, 71859], "mapped", [71891]], [[71860, 71860], "mapped", [71892]], [[71861, 71861], "mapped", [71893]], [[71862, 71862], "mapped", [71894]], [[71863, 71863], "mapped", [71895]], [[71864, 71864], "mapped", [71896]], [[71865, 71865], "mapped", [71897]], [[71866, 71866], "mapped", [71898]], [[71867, 71867], "mapped", [71899]], [[71868, 71868], "mapped", [71900]], [[71869, 71869], "mapped", [71901]], [[71870, 71870], "mapped", [71902]], [[71871, 71871], "mapped", [71903]], [[71872, 71913], "valid"], [[71914, 71922], "valid", [], "NV8"], [[71923, 71934], "disallowed"], [[71935, 71935], "valid"], [[71936, 72383], "disallowed"], [[72384, 72440], "valid"], [[72441, 73727], "disallowed"], [[73728, 74606], "valid"], [[74607, 74648], "valid"], [[74649, 74649], "valid"], [[74650, 74751], "disallowed"], [[74752, 74850], "valid", [], "NV8"], [[74851, 74862], "valid", [], "NV8"], [[74863, 74863], "disallowed"], [[74864, 74867], "valid", [], "NV8"], [[74868, 74868], "valid", [], "NV8"], [[74869, 74879], "disallowed"], [[74880, 75075], "valid"], [[75076, 77823], "disallowed"], [[77824, 78894], "valid"], [[78895, 82943], "disallowed"], [[82944, 83526], "valid"], [[83527, 92159], "disallowed"], [[92160, 92728], "valid"], [[92729, 92735], "disallowed"], [[92736, 92766], "valid"], [[92767, 92767], "disallowed"], [[92768, 92777], "valid"], [[92778, 92781], "disallowed"], [[92782, 92783], "valid", [], "NV8"], [[92784, 92879], "disallowed"], [[92880, 92909], "valid"], [[92910, 92911], "disallowed"], [[92912, 92916], "valid"], [[92917, 92917], "valid", [], "NV8"], [[92918, 92927], "disallowed"], [[92928, 92982], "valid"], [[92983, 92991], "valid", [], "NV8"], [[92992, 92995], "valid"], [[92996, 92997], "valid", [], "NV8"], [[92998, 93007], "disallowed"], [[93008, 93017], "valid"], [[93018, 93018], "disallowed"], [[93019, 93025], "valid", [], "NV8"], [[93026, 93026], "disallowed"], [[93027, 93047], "valid"], [[93048, 93052], "disallowed"], [[93053, 93071], "valid"], [[93072, 93951], "disallowed"], [[93952, 94020], "valid"], [[94021, 94031], "disallowed"], [[94032, 94078], "valid"], [[94079, 94094], "disallowed"], [[94095, 94111], "valid"], [[94112, 110591], "disallowed"], [[110592, 110593], "valid"], [[110594, 113663], "disallowed"], [[113664, 113770], "valid"], [[113771, 113775], "disallowed"], [[113776, 113788], "valid"], [[113789, 113791], "disallowed"], [[113792, 113800], "valid"], [[113801, 113807], "disallowed"], [[113808, 113817], "valid"], [[113818, 113819], "disallowed"], [[113820, 113820], "valid", [], "NV8"], [[113821, 113822], "valid"], [[113823, 113823], "valid", [], "NV8"], [[113824, 113827], "ignored"], [[113828, 118783], "disallowed"], [[118784, 119029], "valid", [], "NV8"], [[119030, 119039], "disallowed"], [[119040, 119078], "valid", [], "NV8"], [[119079, 119080], "disallowed"], [[119081, 119081], "valid", [], "NV8"], [[119082, 119133], "valid", [], "NV8"], [[119134, 119134], "mapped", [119127, 119141]], [[119135, 119135], "mapped", [119128, 119141]], [[119136, 119136], "mapped", [119128, 119141, 119150]], [[119137, 119137], "mapped", [119128, 119141, 119151]], [[119138, 119138], "mapped", [119128, 119141, 119152]], [[119139, 119139], "mapped", [119128, 119141, 119153]], [[119140, 119140], "mapped", [119128, 119141, 119154]], [[119141, 119154], "valid", [], "NV8"], [[119155, 119162], "disallowed"], [[119163, 119226], "valid", [], "NV8"], [[119227, 119227], "mapped", [119225, 119141]], [[119228, 119228], "mapped", [119226, 119141]], [[119229, 119229], "mapped", [119225, 119141, 119150]], [[119230, 119230], "mapped", [119226, 119141, 119150]], [[119231, 119231], "mapped", [119225, 119141, 119151]], [[119232, 119232], "mapped", [119226, 119141, 119151]], [[119233, 119261], "valid", [], "NV8"], [[119262, 119272], "valid", [], "NV8"], [[119273, 119295], "disallowed"], [[119296, 119365], "valid", [], "NV8"], [[119366, 119551], "disallowed"], [[119552, 119638], "valid", [], "NV8"], [[119639, 119647], "disallowed"], [[119648, 119665], "valid", [], "NV8"], [[119666, 119807], "disallowed"], [[119808, 119808], "mapped", [97]], [[119809, 119809], "mapped", [98]], [[119810, 119810], "mapped", [99]], [[119811, 119811], "mapped", [100]], [[119812, 119812], "mapped", [101]], [[119813, 119813], "mapped", [102]], [[119814, 119814], "mapped", [103]], [[119815, 119815], "mapped", [104]], [[119816, 119816], "mapped", [105]], [[119817, 119817], "mapped", [106]], [[119818, 119818], "mapped", [107]], [[119819, 119819], "mapped", [108]], [[119820, 119820], "mapped", [109]], [[119821, 119821], "mapped", [110]], [[119822, 119822], "mapped", [111]], [[119823, 119823], "mapped", [112]], [[119824, 119824], "mapped", [113]], [[119825, 119825], "mapped", [114]], [[119826, 119826], "mapped", [115]], [[119827, 119827], "mapped", [116]], [[119828, 119828], "mapped", [117]], [[119829, 119829], "mapped", [118]], [[119830, 119830], "mapped", [119]], [[119831, 119831], "mapped", [120]], [[119832, 119832], "mapped", [121]], [[119833, 119833], "mapped", [122]], [[119834, 119834], "mapped", [97]], [[119835, 119835], "mapped", [98]], [[119836, 119836], "mapped", [99]], [[119837, 119837], "mapped", [100]], [[119838, 119838], "mapped", [101]], [[119839, 119839], "mapped", [102]], [[119840, 119840], "mapped", [103]], [[119841, 119841], "mapped", [104]], [[119842, 119842], "mapped", [105]], [[119843, 119843], "mapped", [106]], [[119844, 119844], "mapped", [107]], [[119845, 119845], "mapped", [108]], [[119846, 119846], "mapped", [109]], [[119847, 119847], "mapped", [110]], [[119848, 119848], "mapped", [111]], [[119849, 119849], "mapped", [112]], [[119850, 119850], "mapped", [113]], [[119851, 119851], "mapped", [114]], [[119852, 119852], "mapped", [115]], [[119853, 119853], "mapped", [116]], [[119854, 119854], "mapped", [117]], [[119855, 119855], "mapped", [118]], [[119856, 119856], "mapped", [119]], [[119857, 119857], "mapped", [120]], [[119858, 119858], "mapped", [121]], [[119859, 119859], "mapped", [122]], [[119860, 119860], "mapped", [97]], [[119861, 119861], "mapped", [98]], [[119862, 119862], "mapped", [99]], [[119863, 119863], "mapped", [100]], [[119864, 119864], "mapped", [101]], [[119865, 119865], "mapped", [102]], [[119866, 119866], "mapped", [103]], [[119867, 119867], "mapped", [104]], [[119868, 119868], "mapped", [105]], [[119869, 119869], "mapped", [106]], [[119870, 119870], "mapped", [107]], [[119871, 119871], "mapped", [108]], [[119872, 119872], "mapped", [109]], [[119873, 119873], "mapped", [110]], [[119874, 119874], "mapped", [111]], [[119875, 119875], "mapped", [112]], [[119876, 119876], "mapped", [113]], [[119877, 119877], "mapped", [114]], [[119878, 119878], "mapped", [115]], [[119879, 119879], "mapped", [116]], [[119880, 119880], "mapped", [117]], [[119881, 119881], "mapped", [118]], [[119882, 119882], "mapped", [119]], [[119883, 119883], "mapped", [120]], [[119884, 119884], "mapped", [121]], [[119885, 119885], "mapped", [122]], [[119886, 119886], "mapped", [97]], [[119887, 119887], "mapped", [98]], [[119888, 119888], "mapped", [99]], [[119889, 119889], "mapped", [100]], [[119890, 119890], "mapped", [101]], [[119891, 119891], "mapped", [102]], [[119892, 119892], "mapped", [103]], [[119893, 119893], "disallowed"], [[119894, 119894], "mapped", [105]], [[119895, 119895], "mapped", [106]], [[119896, 119896], "mapped", [107]], [[119897, 119897], "mapped", [108]], [[119898, 119898], "mapped", [109]], [[119899, 119899], "mapped", [110]], [[119900, 119900], "mapped", [111]], [[119901, 119901], "mapped", [112]], [[119902, 119902], "mapped", [113]], [[119903, 119903], "mapped", [114]], [[119904, 119904], "mapped", [115]], [[119905, 119905], "mapped", [116]], [[119906, 119906], "mapped", [117]], [[119907, 119907], "mapped", [118]], [[119908, 119908], "mapped", [119]], [[119909, 119909], "mapped", [120]], [[119910, 119910], "mapped", [121]], [[119911, 119911], "mapped", [122]], [[119912, 119912], "mapped", [97]], [[119913, 119913], "mapped", [98]], [[119914, 119914], "mapped", [99]], [[119915, 119915], "mapped", [100]], [[119916, 119916], "mapped", [101]], [[119917, 119917], "mapped", [102]], [[119918, 119918], "mapped", [103]], [[119919, 119919], "mapped", [104]], [[119920, 119920], "mapped", [105]], [[119921, 119921], "mapped", [106]], [[119922, 119922], "mapped", [107]], [[119923, 119923], "mapped", [108]], [[119924, 119924], "mapped", [109]], [[119925, 119925], "mapped", [110]], [[119926, 119926], "mapped", [111]], [[119927, 119927], "mapped", [112]], [[119928, 119928], "mapped", [113]], [[119929, 119929], "mapped", [114]], [[119930, 119930], "mapped", [115]], [[119931, 119931], "mapped", [116]], [[119932, 119932], "mapped", [117]], [[119933, 119933], "mapped", [118]], [[119934, 119934], "mapped", [119]], [[119935, 119935], "mapped", [120]], [[119936, 119936], "mapped", [121]], [[119937, 119937], "mapped", [122]], [[119938, 119938], "mapped", [97]], [[119939, 119939], "mapped", [98]], [[119940, 119940], "mapped", [99]], [[119941, 119941], "mapped", [100]], [[119942, 119942], "mapped", [101]], [[119943, 119943], "mapped", [102]], [[119944, 119944], "mapped", [103]], [[119945, 119945], "mapped", [104]], [[119946, 119946], "mapped", [105]], [[119947, 119947], "mapped", [106]], [[119948, 119948], "mapped", [107]], [[119949, 119949], "mapped", [108]], [[119950, 119950], "mapped", [109]], [[119951, 119951], "mapped", [110]], [[119952, 119952], "mapped", [111]], [[119953, 119953], "mapped", [112]], [[119954, 119954], "mapped", [113]], [[119955, 119955], "mapped", [114]], [[119956, 119956], "mapped", [115]], [[119957, 119957], "mapped", [116]], [[119958, 119958], "mapped", [117]], [[119959, 119959], "mapped", [118]], [[119960, 119960], "mapped", [119]], [[119961, 119961], "mapped", [120]], [[119962, 119962], "mapped", [121]], [[119963, 119963], "mapped", [122]], [[119964, 119964], "mapped", [97]], [[119965, 119965], "disallowed"], [[119966, 119966], "mapped", [99]], [[119967, 119967], "mapped", [100]], [[119968, 119969], "disallowed"], [[119970, 119970], "mapped", [103]], [[119971, 119972], "disallowed"], [[119973, 119973], "mapped", [106]], [[119974, 119974], "mapped", [107]], [[119975, 119976], "disallowed"], [[119977, 119977], "mapped", [110]], [[119978, 119978], "mapped", [111]], [[119979, 119979], "mapped", [112]], [[119980, 119980], "mapped", [113]], [[119981, 119981], "disallowed"], [[119982, 119982], "mapped", [115]], [[119983, 119983], "mapped", [116]], [[119984, 119984], "mapped", [117]], [[119985, 119985], "mapped", [118]], [[119986, 119986], "mapped", [119]], [[119987, 119987], "mapped", [120]], [[119988, 119988], "mapped", [121]], [[119989, 119989], "mapped", [122]], [[119990, 119990], "mapped", [97]], [[119991, 119991], "mapped", [98]], [[119992, 119992], "mapped", [99]], [[119993, 119993], "mapped", [100]], [[119994, 119994], "disallowed"], [[119995, 119995], "mapped", [102]], [[119996, 119996], "disallowed"], [[119997, 119997], "mapped", [104]], [[119998, 119998], "mapped", [105]], [[119999, 119999], "mapped", [106]], [[12e4, 12e4], "mapped", [107]], [[120001, 120001], "mapped", [108]], [[120002, 120002], "mapped", [109]], [[120003, 120003], "mapped", [110]], [[120004, 120004], "disallowed"], [[120005, 120005], "mapped", [112]], [[120006, 120006], "mapped", [113]], [[120007, 120007], "mapped", [114]], [[120008, 120008], "mapped", [115]], [[120009, 120009], "mapped", [116]], [[120010, 120010], "mapped", [117]], [[120011, 120011], "mapped", [118]], [[120012, 120012], "mapped", [119]], [[120013, 120013], "mapped", [120]], [[120014, 120014], "mapped", [121]], [[120015, 120015], "mapped", [122]], [[120016, 120016], "mapped", [97]], [[120017, 120017], "mapped", [98]], [[120018, 120018], "mapped", [99]], [[120019, 120019], "mapped", [100]], [[120020, 120020], "mapped", [101]], [[120021, 120021], "mapped", [102]], [[120022, 120022], "mapped", [103]], [[120023, 120023], "mapped", [104]], [[120024, 120024], "mapped", [105]], [[120025, 120025], "mapped", [106]], [[120026, 120026], "mapped", [107]], [[120027, 120027], "mapped", [108]], [[120028, 120028], "mapped", [109]], [[120029, 120029], "mapped", [110]], [[120030, 120030], "mapped", [111]], [[120031, 120031], "mapped", [112]], [[120032, 120032], "mapped", [113]], [[120033, 120033], "mapped", [114]], [[120034, 120034], "mapped", [115]], [[120035, 120035], "mapped", [116]], [[120036, 120036], "mapped", [117]], [[120037, 120037], "mapped", [118]], [[120038, 120038], "mapped", [119]], [[120039, 120039], "mapped", [120]], [[120040, 120040], "mapped", [121]], [[120041, 120041], "mapped", [122]], [[120042, 120042], "mapped", [97]], [[120043, 120043], "mapped", [98]], [[120044, 120044], "mapped", [99]], [[120045, 120045], "mapped", [100]], [[120046, 120046], "mapped", [101]], [[120047, 120047], "mapped", [102]], [[120048, 120048], "mapped", [103]], [[120049, 120049], "mapped", [104]], [[120050, 120050], "mapped", [105]], [[120051, 120051], "mapped", [106]], [[120052, 120052], "mapped", [107]], [[120053, 120053], "mapped", [108]], [[120054, 120054], "mapped", [109]], [[120055, 120055], "mapped", [110]], [[120056, 120056], "mapped", [111]], [[120057, 120057], "mapped", [112]], [[120058, 120058], "mapped", [113]], [[120059, 120059], "mapped", [114]], [[120060, 120060], "mapped", [115]], [[120061, 120061], "mapped", [116]], [[120062, 120062], "mapped", [117]], [[120063, 120063], "mapped", [118]], [[120064, 120064], "mapped", [119]], [[120065, 120065], "mapped", [120]], [[120066, 120066], "mapped", [121]], [[120067, 120067], "mapped", [122]], [[120068, 120068], "mapped", [97]], [[120069, 120069], "mapped", [98]], [[120070, 120070], "disallowed"], [[120071, 120071], "mapped", [100]], [[120072, 120072], "mapped", [101]], [[120073, 120073], "mapped", [102]], [[120074, 120074], "mapped", [103]], [[120075, 120076], "disallowed"], [[120077, 120077], "mapped", [106]], [[120078, 120078], "mapped", [107]], [[120079, 120079], "mapped", [108]], [[120080, 120080], "mapped", [109]], [[120081, 120081], "mapped", [110]], [[120082, 120082], "mapped", [111]], [[120083, 120083], "mapped", [112]], [[120084, 120084], "mapped", [113]], [[120085, 120085], "disallowed"], [[120086, 120086], "mapped", [115]], [[120087, 120087], "mapped", [116]], [[120088, 120088], "mapped", [117]], [[120089, 120089], "mapped", [118]], [[120090, 120090], "mapped", [119]], [[120091, 120091], "mapped", [120]], [[120092, 120092], "mapped", [121]], [[120093, 120093], "disallowed"], [[120094, 120094], "mapped", [97]], [[120095, 120095], "mapped", [98]], [[120096, 120096], "mapped", [99]], [[120097, 120097], "mapped", [100]], [[120098, 120098], "mapped", [101]], [[120099, 120099], "mapped", [102]], [[120100, 120100], "mapped", [103]], [[120101, 120101], "mapped", [104]], [[120102, 120102], "mapped", [105]], [[120103, 120103], "mapped", [106]], [[120104, 120104], "mapped", [107]], [[120105, 120105], "mapped", [108]], [[120106, 120106], "mapped", [109]], [[120107, 120107], "mapped", [110]], [[120108, 120108], "mapped", [111]], [[120109, 120109], "mapped", [112]], [[120110, 120110], "mapped", [113]], [[120111, 120111], "mapped", [114]], [[120112, 120112], "mapped", [115]], [[120113, 120113], "mapped", [116]], [[120114, 120114], "mapped", [117]], [[120115, 120115], "mapped", [118]], [[120116, 120116], "mapped", [119]], [[120117, 120117], "mapped", [120]], [[120118, 120118], "mapped", [121]], [[120119, 120119], "mapped", [122]], [[120120, 120120], "mapped", [97]], [[120121, 120121], "mapped", [98]], [[120122, 120122], "disallowed"], [[120123, 120123], "mapped", [100]], [[120124, 120124], "mapped", [101]], [[120125, 120125], "mapped", [102]], [[120126, 120126], "mapped", [103]], [[120127, 120127], "disallowed"], [[120128, 120128], "mapped", [105]], [[120129, 120129], "mapped", [106]], [[120130, 120130], "mapped", [107]], [[120131, 120131], "mapped", [108]], [[120132, 120132], "mapped", [109]], [[120133, 120133], "disallowed"], [[120134, 120134], "mapped", [111]], [[120135, 120137], "disallowed"], [[120138, 120138], "mapped", [115]], [[120139, 120139], "mapped", [116]], [[120140, 120140], "mapped", [117]], [[120141, 120141], "mapped", [118]], [[120142, 120142], "mapped", [119]], [[120143, 120143], "mapped", [120]], [[120144, 120144], "mapped", [121]], [[120145, 120145], "disallowed"], [[120146, 120146], "mapped", [97]], [[120147, 120147], "mapped", [98]], [[120148, 120148], "mapped", [99]], [[120149, 120149], "mapped", [100]], [[120150, 120150], "mapped", [101]], [[120151, 120151], "mapped", [102]], [[120152, 120152], "mapped", [103]], [[120153, 120153], "mapped", [104]], [[120154, 120154], "mapped", [105]], [[120155, 120155], "mapped", [106]], [[120156, 120156], "mapped", [107]], [[120157, 120157], "mapped", [108]], [[120158, 120158], "mapped", [109]], [[120159, 120159], "mapped", [110]], [[120160, 120160], "mapped", [111]], [[120161, 120161], "mapped", [112]], [[120162, 120162], "mapped", [113]], [[120163, 120163], "mapped", [114]], [[120164, 120164], "mapped", [115]], [[120165, 120165], "mapped", [116]], [[120166, 120166], "mapped", [117]], [[120167, 120167], "mapped", [118]], [[120168, 120168], "mapped", [119]], [[120169, 120169], "mapped", [120]], [[120170, 120170], "mapped", [121]], [[120171, 120171], "mapped", [122]], [[120172, 120172], "mapped", [97]], [[120173, 120173], "mapped", [98]], [[120174, 120174], "mapped", [99]], [[120175, 120175], "mapped", [100]], [[120176, 120176], "mapped", [101]], [[120177, 120177], "mapped", [102]], [[120178, 120178], "mapped", [103]], [[120179, 120179], "mapped", [104]], [[120180, 120180], "mapped", [105]], [[120181, 120181], "mapped", [106]], [[120182, 120182], "mapped", [107]], [[120183, 120183], "mapped", [108]], [[120184, 120184], "mapped", [109]], [[120185, 120185], "mapped", [110]], [[120186, 120186], "mapped", [111]], [[120187, 120187], "mapped", [112]], [[120188, 120188], "mapped", [113]], [[120189, 120189], "mapped", [114]], [[120190, 120190], "mapped", [115]], [[120191, 120191], "mapped", [116]], [[120192, 120192], "mapped", [117]], [[120193, 120193], "mapped", [118]], [[120194, 120194], "mapped", [119]], [[120195, 120195], "mapped", [120]], [[120196, 120196], "mapped", [121]], [[120197, 120197], "mapped", [122]], [[120198, 120198], "mapped", [97]], [[120199, 120199], "mapped", [98]], [[120200, 120200], "mapped", [99]], [[120201, 120201], "mapped", [100]], [[120202, 120202], "mapped", [101]], [[120203, 120203], "mapped", [102]], [[120204, 120204], "mapped", [103]], [[120205, 120205], "mapped", [104]], [[120206, 120206], "mapped", [105]], [[120207, 120207], "mapped", [106]], [[120208, 120208], "mapped", [107]], [[120209, 120209], "mapped", [108]], [[120210, 120210], "mapped", [109]], [[120211, 120211], "mapped", [110]], [[120212, 120212], "mapped", [111]], [[120213, 120213], "mapped", [112]], [[120214, 120214], "mapped", [113]], [[120215, 120215], "mapped", [114]], [[120216, 120216], "mapped", [115]], [[120217, 120217], "mapped", [116]], [[120218, 120218], "mapped", [117]], [[120219, 120219], "mapped", [118]], [[120220, 120220], "mapped", [119]], [[120221, 120221], "mapped", [120]], [[120222, 120222], "mapped", [121]], [[120223, 120223], "mapped", [122]], [[120224, 120224], "mapped", [97]], [[120225, 120225], "mapped", [98]], [[120226, 120226], "mapped", [99]], [[120227, 120227], "mapped", [100]], [[120228, 120228], "mapped", [101]], [[120229, 120229], "mapped", [102]], [[120230, 120230], "mapped", [103]], [[120231, 120231], "mapped", [104]], [[120232, 120232], "mapped", [105]], [[120233, 120233], "mapped", [106]], [[120234, 120234], "mapped", [107]], [[120235, 120235], "mapped", [108]], [[120236, 120236], "mapped", [109]], [[120237, 120237], "mapped", [110]], [[120238, 120238], "mapped", [111]], [[120239, 120239], "mapped", [112]], [[120240, 120240], "mapped", [113]], [[120241, 120241], "mapped", [114]], [[120242, 120242], "mapped", [115]], [[120243, 120243], "mapped", [116]], [[120244, 120244], "mapped", [117]], [[120245, 120245], "mapped", [118]], [[120246, 120246], "mapped", [119]], [[120247, 120247], "mapped", [120]], [[120248, 120248], "mapped", [121]], [[120249, 120249], "mapped", [122]], [[120250, 120250], "mapped", [97]], [[120251, 120251], "mapped", [98]], [[120252, 120252], "mapped", [99]], [[120253, 120253], "mapped", [100]], [[120254, 120254], "mapped", [101]], [[120255, 120255], "mapped", [102]], [[120256, 120256], "mapped", [103]], [[120257, 120257], "mapped", [104]], [[120258, 120258], "mapped", [105]], [[120259, 120259], "mapped", [106]], [[120260, 120260], "mapped", [107]], [[120261, 120261], "mapped", [108]], [[120262, 120262], "mapped", [109]], [[120263, 120263], "mapped", [110]], [[120264, 120264], "mapped", [111]], [[120265, 120265], "mapped", [112]], [[120266, 120266], "mapped", [113]], [[120267, 120267], "mapped", [114]], [[120268, 120268], "mapped", [115]], [[120269, 120269], "mapped", [116]], [[120270, 120270], "mapped", [117]], [[120271, 120271], "mapped", [118]], [[120272, 120272], "mapped", [119]], [[120273, 120273], "mapped", [120]], [[120274, 120274], "mapped", [121]], [[120275, 120275], "mapped", [122]], [[120276, 120276], "mapped", [97]], [[120277, 120277], "mapped", [98]], [[120278, 120278], "mapped", [99]], [[120279, 120279], "mapped", [100]], [[120280, 120280], "mapped", [101]], [[120281, 120281], "mapped", [102]], [[120282, 120282], "mapped", [103]], [[120283, 120283], "mapped", [104]], [[120284, 120284], "mapped", [105]], [[120285, 120285], "mapped", [106]], [[120286, 120286], "mapped", [107]], [[120287, 120287], "mapped", [108]], [[120288, 120288], "mapped", [109]], [[120289, 120289], "mapped", [110]], [[120290, 120290], "mapped", [111]], [[120291, 120291], "mapped", [112]], [[120292, 120292], "mapped", [113]], [[120293, 120293], "mapped", [114]], [[120294, 120294], "mapped", [115]], [[120295, 120295], "mapped", [116]], [[120296, 120296], "mapped", [117]], [[120297, 120297], "mapped", [118]], [[120298, 120298], "mapped", [119]], [[120299, 120299], "mapped", [120]], [[120300, 120300], "mapped", [121]], [[120301, 120301], "mapped", [122]], [[120302, 120302], "mapped", [97]], [[120303, 120303], "mapped", [98]], [[120304, 120304], "mapped", [99]], [[120305, 120305], "mapped", [100]], [[120306, 120306], "mapped", [101]], [[120307, 120307], "mapped", [102]], [[120308, 120308], "mapped", [103]], [[120309, 120309], "mapped", [104]], [[120310, 120310], "mapped", [105]], [[120311, 120311], "mapped", [106]], [[120312, 120312], "mapped", [107]], [[120313, 120313], "mapped", [108]], [[120314, 120314], "mapped", [109]], [[120315, 120315], "mapped", [110]], [[120316, 120316], "mapped", [111]], [[120317, 120317], "mapped", [112]], [[120318, 120318], "mapped", [113]], [[120319, 120319], "mapped", [114]], [[120320, 120320], "mapped", [115]], [[120321, 120321], "mapped", [116]], [[120322, 120322], "mapped", [117]], [[120323, 120323], "mapped", [118]], [[120324, 120324], "mapped", [119]], [[120325, 120325], "mapped", [120]], [[120326, 120326], "mapped", [121]], [[120327, 120327], "mapped", [122]], [[120328, 120328], "mapped", [97]], [[120329, 120329], "mapped", [98]], [[120330, 120330], "mapped", [99]], [[120331, 120331], "mapped", [100]], [[120332, 120332], "mapped", [101]], [[120333, 120333], "mapped", [102]], [[120334, 120334], "mapped", [103]], [[120335, 120335], "mapped", [104]], [[120336, 120336], "mapped", [105]], [[120337, 120337], "mapped", [106]], [[120338, 120338], "mapped", [107]], [[120339, 120339], "mapped", [108]], [[120340, 120340], "mapped", [109]], [[120341, 120341], "mapped", [110]], [[120342, 120342], "mapped", [111]], [[120343, 120343], "mapped", [112]], [[120344, 120344], "mapped", [113]], [[120345, 120345], "mapped", [114]], [[120346, 120346], "mapped", [115]], [[120347, 120347], "mapped", [116]], [[120348, 120348], "mapped", [117]], [[120349, 120349], "mapped", [118]], [[120350, 120350], "mapped", [119]], [[120351, 120351], "mapped", [120]], [[120352, 120352], "mapped", [121]], [[120353, 120353], "mapped", [122]], [[120354, 120354], "mapped", [97]], [[120355, 120355], "mapped", [98]], [[120356, 120356], "mapped", [99]], [[120357, 120357], "mapped", [100]], [[120358, 120358], "mapped", [101]], [[120359, 120359], "mapped", [102]], [[120360, 120360], "mapped", [103]], [[120361, 120361], "mapped", [104]], [[120362, 120362], "mapped", [105]], [[120363, 120363], "mapped", [106]], [[120364, 120364], "mapped", [107]], [[120365, 120365], "mapped", [108]], [[120366, 120366], "mapped", [109]], [[120367, 120367], "mapped", [110]], [[120368, 120368], "mapped", [111]], [[120369, 120369], "mapped", [112]], [[120370, 120370], "mapped", [113]], [[120371, 120371], "mapped", [114]], [[120372, 120372], "mapped", [115]], [[120373, 120373], "mapped", [116]], [[120374, 120374], "mapped", [117]], [[120375, 120375], "mapped", [118]], [[120376, 120376], "mapped", [119]], [[120377, 120377], "mapped", [120]], [[120378, 120378], "mapped", [121]], [[120379, 120379], "mapped", [122]], [[120380, 120380], "mapped", [97]], [[120381, 120381], "mapped", [98]], [[120382, 120382], "mapped", [99]], [[120383, 120383], "mapped", [100]], [[120384, 120384], "mapped", [101]], [[120385, 120385], "mapped", [102]], [[120386, 120386], "mapped", [103]], [[120387, 120387], "mapped", [104]], [[120388, 120388], "mapped", [105]], [[120389, 120389], "mapped", [106]], [[120390, 120390], "mapped", [107]], [[120391, 120391], "mapped", [108]], [[120392, 120392], "mapped", [109]], [[120393, 120393], "mapped", [110]], [[120394, 120394], "mapped", [111]], [[120395, 120395], "mapped", [112]], [[120396, 120396], "mapped", [113]], [[120397, 120397], "mapped", [114]], [[120398, 120398], "mapped", [115]], [[120399, 120399], "mapped", [116]], [[120400, 120400], "mapped", [117]], [[120401, 120401], "mapped", [118]], [[120402, 120402], "mapped", [119]], [[120403, 120403], "mapped", [120]], [[120404, 120404], "mapped", [121]], [[120405, 120405], "mapped", [122]], [[120406, 120406], "mapped", [97]], [[120407, 120407], "mapped", [98]], [[120408, 120408], "mapped", [99]], [[120409, 120409], "mapped", [100]], [[120410, 120410], "mapped", [101]], [[120411, 120411], "mapped", [102]], [[120412, 120412], "mapped", [103]], [[120413, 120413], "mapped", [104]], [[120414, 120414], "mapped", [105]], [[120415, 120415], "mapped", [106]], [[120416, 120416], "mapped", [107]], [[120417, 120417], "mapped", [108]], [[120418, 120418], "mapped", [109]], [[120419, 120419], "mapped", [110]], [[120420, 120420], "mapped", [111]], [[120421, 120421], "mapped", [112]], [[120422, 120422], "mapped", [113]], [[120423, 120423], "mapped", [114]], [[120424, 120424], "mapped", [115]], [[120425, 120425], "mapped", [116]], [[120426, 120426], "mapped", [117]], [[120427, 120427], "mapped", [118]], [[120428, 120428], "mapped", [119]], [[120429, 120429], "mapped", [120]], [[120430, 120430], "mapped", [121]], [[120431, 120431], "mapped", [122]], [[120432, 120432], "mapped", [97]], [[120433, 120433], "mapped", [98]], [[120434, 120434], "mapped", [99]], [[120435, 120435], "mapped", [100]], [[120436, 120436], "mapped", [101]], [[120437, 120437], "mapped", [102]], [[120438, 120438], "mapped", [103]], [[120439, 120439], "mapped", [104]], [[120440, 120440], "mapped", [105]], [[120441, 120441], "mapped", [106]], [[120442, 120442], "mapped", [107]], [[120443, 120443], "mapped", [108]], [[120444, 120444], "mapped", [109]], [[120445, 120445], "mapped", [110]], [[120446, 120446], "mapped", [111]], [[120447, 120447], "mapped", [112]], [[120448, 120448], "mapped", [113]], [[120449, 120449], "mapped", [114]], [[120450, 120450], "mapped", [115]], [[120451, 120451], "mapped", [116]], [[120452, 120452], "mapped", [117]], [[120453, 120453], "mapped", [118]], [[120454, 120454], "mapped", [119]], [[120455, 120455], "mapped", [120]], [[120456, 120456], "mapped", [121]], [[120457, 120457], "mapped", [122]], [[120458, 120458], "mapped", [97]], [[120459, 120459], "mapped", [98]], [[120460, 120460], "mapped", [99]], [[120461, 120461], "mapped", [100]], [[120462, 120462], "mapped", [101]], [[120463, 120463], "mapped", [102]], [[120464, 120464], "mapped", [103]], [[120465, 120465], "mapped", [104]], [[120466, 120466], "mapped", [105]], [[120467, 120467], "mapped", [106]], [[120468, 120468], "mapped", [107]], [[120469, 120469], "mapped", [108]], [[120470, 120470], "mapped", [109]], [[120471, 120471], "mapped", [110]], [[120472, 120472], "mapped", [111]], [[120473, 120473], "mapped", [112]], [[120474, 120474], "mapped", [113]], [[120475, 120475], "mapped", [114]], [[120476, 120476], "mapped", [115]], [[120477, 120477], "mapped", [116]], [[120478, 120478], "mapped", [117]], [[120479, 120479], "mapped", [118]], [[120480, 120480], "mapped", [119]], [[120481, 120481], "mapped", [120]], [[120482, 120482], "mapped", [121]], [[120483, 120483], "mapped", [122]], [[120484, 120484], "mapped", [305]], [[120485, 120485], "mapped", [567]], [[120486, 120487], "disallowed"], [[120488, 120488], "mapped", [945]], [[120489, 120489], "mapped", [946]], [[120490, 120490], "mapped", [947]], [[120491, 120491], "mapped", [948]], [[120492, 120492], "mapped", [949]], [[120493, 120493], "mapped", [950]], [[120494, 120494], "mapped", [951]], [[120495, 120495], "mapped", [952]], [[120496, 120496], "mapped", [953]], [[120497, 120497], "mapped", [954]], [[120498, 120498], "mapped", [955]], [[120499, 120499], "mapped", [956]], [[120500, 120500], "mapped", [957]], [[120501, 120501], "mapped", [958]], [[120502, 120502], "mapped", [959]], [[120503, 120503], "mapped", [960]], [[120504, 120504], "mapped", [961]], [[120505, 120505], "mapped", [952]], [[120506, 120506], "mapped", [963]], [[120507, 120507], "mapped", [964]], [[120508, 120508], "mapped", [965]], [[120509, 120509], "mapped", [966]], [[120510, 120510], "mapped", [967]], [[120511, 120511], "mapped", [968]], [[120512, 120512], "mapped", [969]], [[120513, 120513], "mapped", [8711]], [[120514, 120514], "mapped", [945]], [[120515, 120515], "mapped", [946]], [[120516, 120516], "mapped", [947]], [[120517, 120517], "mapped", [948]], [[120518, 120518], "mapped", [949]], [[120519, 120519], "mapped", [950]], [[120520, 120520], "mapped", [951]], [[120521, 120521], "mapped", [952]], [[120522, 120522], "mapped", [953]], [[120523, 120523], "mapped", [954]], [[120524, 120524], "mapped", [955]], [[120525, 120525], "mapped", [956]], [[120526, 120526], "mapped", [957]], [[120527, 120527], "mapped", [958]], [[120528, 120528], "mapped", [959]], [[120529, 120529], "mapped", [960]], [[120530, 120530], "mapped", [961]], [[120531, 120532], "mapped", [963]], [[120533, 120533], "mapped", [964]], [[120534, 120534], "mapped", [965]], [[120535, 120535], "mapped", [966]], [[120536, 120536], "mapped", [967]], [[120537, 120537], "mapped", [968]], [[120538, 120538], "mapped", [969]], [[120539, 120539], "mapped", [8706]], [[120540, 120540], "mapped", [949]], [[120541, 120541], "mapped", [952]], [[120542, 120542], "mapped", [954]], [[120543, 120543], "mapped", [966]], [[120544, 120544], "mapped", [961]], [[120545, 120545], "mapped", [960]], [[120546, 120546], "mapped", [945]], [[120547, 120547], "mapped", [946]], [[120548, 120548], "mapped", [947]], [[120549, 120549], "mapped", [948]], [[120550, 120550], "mapped", [949]], [[120551, 120551], "mapped", [950]], [[120552, 120552], "mapped", [951]], [[120553, 120553], "mapped", [952]], [[120554, 120554], "mapped", [953]], [[120555, 120555], "mapped", [954]], [[120556, 120556], "mapped", [955]], [[120557, 120557], "mapped", [956]], [[120558, 120558], "mapped", [957]], [[120559, 120559], "mapped", [958]], [[120560, 120560], "mapped", [959]], [[120561, 120561], "mapped", [960]], [[120562, 120562], "mapped", [961]], [[120563, 120563], "mapped", [952]], [[120564, 120564], "mapped", [963]], [[120565, 120565], "mapped", [964]], [[120566, 120566], "mapped", [965]], [[120567, 120567], "mapped", [966]], [[120568, 120568], "mapped", [967]], [[120569, 120569], "mapped", [968]], [[120570, 120570], "mapped", [969]], [[120571, 120571], "mapped", [8711]], [[120572, 120572], "mapped", [945]], [[120573, 120573], "mapped", [946]], [[120574, 120574], "mapped", [947]], [[120575, 120575], "mapped", [948]], [[120576, 120576], "mapped", [949]], [[120577, 120577], "mapped", [950]], [[120578, 120578], "mapped", [951]], [[120579, 120579], "mapped", [952]], [[120580, 120580], "mapped", [953]], [[120581, 120581], "mapped", [954]], [[120582, 120582], "mapped", [955]], [[120583, 120583], "mapped", [956]], [[120584, 120584], "mapped", [957]], [[120585, 120585], "mapped", [958]], [[120586, 120586], "mapped", [959]], [[120587, 120587], "mapped", [960]], [[120588, 120588], "mapped", [961]], [[120589, 120590], "mapped", [963]], [[120591, 120591], "mapped", [964]], [[120592, 120592], "mapped", [965]], [[120593, 120593], "mapped", [966]], [[120594, 120594], "mapped", [967]], [[120595, 120595], "mapped", [968]], [[120596, 120596], "mapped", [969]], [[120597, 120597], "mapped", [8706]], [[120598, 120598], "mapped", [949]], [[120599, 120599], "mapped", [952]], [[120600, 120600], "mapped", [954]], [[120601, 120601], "mapped", [966]], [[120602, 120602], "mapped", [961]], [[120603, 120603], "mapped", [960]], [[120604, 120604], "mapped", [945]], [[120605, 120605], "mapped", [946]], [[120606, 120606], "mapped", [947]], [[120607, 120607], "mapped", [948]], [[120608, 120608], "mapped", [949]], [[120609, 120609], "mapped", [950]], [[120610, 120610], "mapped", [951]], [[120611, 120611], "mapped", [952]], [[120612, 120612], "mapped", [953]], [[120613, 120613], "mapped", [954]], [[120614, 120614], "mapped", [955]], [[120615, 120615], "mapped", [956]], [[120616, 120616], "mapped", [957]], [[120617, 120617], "mapped", [958]], [[120618, 120618], "mapped", [959]], [[120619, 120619], "mapped", [960]], [[120620, 120620], "mapped", [961]], [[120621, 120621], "mapped", [952]], [[120622, 120622], "mapped", [963]], [[120623, 120623], "mapped", [964]], [[120624, 120624], "mapped", [965]], [[120625, 120625], "mapped", [966]], [[120626, 120626], "mapped", [967]], [[120627, 120627], "mapped", [968]], [[120628, 120628], "mapped", [969]], [[120629, 120629], "mapped", [8711]], [[120630, 120630], "mapped", [945]], [[120631, 120631], "mapped", [946]], [[120632, 120632], "mapped", [947]], [[120633, 120633], "mapped", [948]], [[120634, 120634], "mapped", [949]], [[120635, 120635], "mapped", [950]], [[120636, 120636], "mapped", [951]], [[120637, 120637], "mapped", [952]], [[120638, 120638], "mapped", [953]], [[120639, 120639], "mapped", [954]], [[120640, 120640], "mapped", [955]], [[120641, 120641], "mapped", [956]], [[120642, 120642], "mapped", [957]], [[120643, 120643], "mapped", [958]], [[120644, 120644], "mapped", [959]], [[120645, 120645], "mapped", [960]], [[120646, 120646], "mapped", [961]], [[120647, 120648], "mapped", [963]], [[120649, 120649], "mapped", [964]], [[120650, 120650], "mapped", [965]], [[120651, 120651], "mapped", [966]], [[120652, 120652], "mapped", [967]], [[120653, 120653], "mapped", [968]], [[120654, 120654], "mapped", [969]], [[120655, 120655], "mapped", [8706]], [[120656, 120656], "mapped", [949]], [[120657, 120657], "mapped", [952]], [[120658, 120658], "mapped", [954]], [[120659, 120659], "mapped", [966]], [[120660, 120660], "mapped", [961]], [[120661, 120661], "mapped", [960]], [[120662, 120662], "mapped", [945]], [[120663, 120663], "mapped", [946]], [[120664, 120664], "mapped", [947]], [[120665, 120665], "mapped", [948]], [[120666, 120666], "mapped", [949]], [[120667, 120667], "mapped", [950]], [[120668, 120668], "mapped", [951]], [[120669, 120669], "mapped", [952]], [[120670, 120670], "mapped", [953]], [[120671, 120671], "mapped", [954]], [[120672, 120672], "mapped", [955]], [[120673, 120673], "mapped", [956]], [[120674, 120674], "mapped", [957]], [[120675, 120675], "mapped", [958]], [[120676, 120676], "mapped", [959]], [[120677, 120677], "mapped", [960]], [[120678, 120678], "mapped", [961]], [[120679, 120679], "mapped", [952]], [[120680, 120680], "mapped", [963]], [[120681, 120681], "mapped", [964]], [[120682, 120682], "mapped", [965]], [[120683, 120683], "mapped", [966]], [[120684, 120684], "mapped", [967]], [[120685, 120685], "mapped", [968]], [[120686, 120686], "mapped", [969]], [[120687, 120687], "mapped", [8711]], [[120688, 120688], "mapped", [945]], [[120689, 120689], "mapped", [946]], [[120690, 120690], "mapped", [947]], [[120691, 120691], "mapped", [948]], [[120692, 120692], "mapped", [949]], [[120693, 120693], "mapped", [950]], [[120694, 120694], "mapped", [951]], [[120695, 120695], "mapped", [952]], [[120696, 120696], "mapped", [953]], [[120697, 120697], "mapped", [954]], [[120698, 120698], "mapped", [955]], [[120699, 120699], "mapped", [956]], [[120700, 120700], "mapped", [957]], [[120701, 120701], "mapped", [958]], [[120702, 120702], "mapped", [959]], [[120703, 120703], "mapped", [960]], [[120704, 120704], "mapped", [961]], [[120705, 120706], "mapped", [963]], [[120707, 120707], "mapped", [964]], [[120708, 120708], "mapped", [965]], [[120709, 120709], "mapped", [966]], [[120710, 120710], "mapped", [967]], [[120711, 120711], "mapped", [968]], [[120712, 120712], "mapped", [969]], [[120713, 120713], "mapped", [8706]], [[120714, 120714], "mapped", [949]], [[120715, 120715], "mapped", [952]], [[120716, 120716], "mapped", [954]], [[120717, 120717], "mapped", [966]], [[120718, 120718], "mapped", [961]], [[120719, 120719], "mapped", [960]], [[120720, 120720], "mapped", [945]], [[120721, 120721], "mapped", [946]], [[120722, 120722], "mapped", [947]], [[120723, 120723], "mapped", [948]], [[120724, 120724], "mapped", [949]], [[120725, 120725], "mapped", [950]], [[120726, 120726], "mapped", [951]], [[120727, 120727], "mapped", [952]], [[120728, 120728], "mapped", [953]], [[120729, 120729], "mapped", [954]], [[120730, 120730], "mapped", [955]], [[120731, 120731], "mapped", [956]], [[120732, 120732], "mapped", [957]], [[120733, 120733], "mapped", [958]], [[120734, 120734], "mapped", [959]], [[120735, 120735], "mapped", [960]], [[120736, 120736], "mapped", [961]], [[120737, 120737], "mapped", [952]], [[120738, 120738], "mapped", [963]], [[120739, 120739], "mapped", [964]], [[120740, 120740], "mapped", [965]], [[120741, 120741], "mapped", [966]], [[120742, 120742], "mapped", [967]], [[120743, 120743], "mapped", [968]], [[120744, 120744], "mapped", [969]], [[120745, 120745], "mapped", [8711]], [[120746, 120746], "mapped", [945]], [[120747, 120747], "mapped", [946]], [[120748, 120748], "mapped", [947]], [[120749, 120749], "mapped", [948]], [[120750, 120750], "mapped", [949]], [[120751, 120751], "mapped", [950]], [[120752, 120752], "mapped", [951]], [[120753, 120753], "mapped", [952]], [[120754, 120754], "mapped", [953]], [[120755, 120755], "mapped", [954]], [[120756, 120756], "mapped", [955]], [[120757, 120757], "mapped", [956]], [[120758, 120758], "mapped", [957]], [[120759, 120759], "mapped", [958]], [[120760, 120760], "mapped", [959]], [[120761, 120761], "mapped", [960]], [[120762, 120762], "mapped", [961]], [[120763, 120764], "mapped", [963]], [[120765, 120765], "mapped", [964]], [[120766, 120766], "mapped", [965]], [[120767, 120767], "mapped", [966]], [[120768, 120768], "mapped", [967]], [[120769, 120769], "mapped", [968]], [[120770, 120770], "mapped", [969]], [[120771, 120771], "mapped", [8706]], [[120772, 120772], "mapped", [949]], [[120773, 120773], "mapped", [952]], [[120774, 120774], "mapped", [954]], [[120775, 120775], "mapped", [966]], [[120776, 120776], "mapped", [961]], [[120777, 120777], "mapped", [960]], [[120778, 120779], "mapped", [989]], [[120780, 120781], "disallowed"], [[120782, 120782], "mapped", [48]], [[120783, 120783], "mapped", [49]], [[120784, 120784], "mapped", [50]], [[120785, 120785], "mapped", [51]], [[120786, 120786], "mapped", [52]], [[120787, 120787], "mapped", [53]], [[120788, 120788], "mapped", [54]], [[120789, 120789], "mapped", [55]], [[120790, 120790], "mapped", [56]], [[120791, 120791], "mapped", [57]], [[120792, 120792], "mapped", [48]], [[120793, 120793], "mapped", [49]], [[120794, 120794], "mapped", [50]], [[120795, 120795], "mapped", [51]], [[120796, 120796], "mapped", [52]], [[120797, 120797], "mapped", [53]], [[120798, 120798], "mapped", [54]], [[120799, 120799], "mapped", [55]], [[120800, 120800], "mapped", [56]], [[120801, 120801], "mapped", [57]], [[120802, 120802], "mapped", [48]], [[120803, 120803], "mapped", [49]], [[120804, 120804], "mapped", [50]], [[120805, 120805], "mapped", [51]], [[120806, 120806], "mapped", [52]], [[120807, 120807], "mapped", [53]], [[120808, 120808], "mapped", [54]], [[120809, 120809], "mapped", [55]], [[120810, 120810], "mapped", [56]], [[120811, 120811], "mapped", [57]], [[120812, 120812], "mapped", [48]], [[120813, 120813], "mapped", [49]], [[120814, 120814], "mapped", [50]], [[120815, 120815], "mapped", [51]], [[120816, 120816], "mapped", [52]], [[120817, 120817], "mapped", [53]], [[120818, 120818], "mapped", [54]], [[120819, 120819], "mapped", [55]], [[120820, 120820], "mapped", [56]], [[120821, 120821], "mapped", [57]], [[120822, 120822], "mapped", [48]], [[120823, 120823], "mapped", [49]], [[120824, 120824], "mapped", [50]], [[120825, 120825], "mapped", [51]], [[120826, 120826], "mapped", [52]], [[120827, 120827], "mapped", [53]], [[120828, 120828], "mapped", [54]], [[120829, 120829], "mapped", [55]], [[120830, 120830], "mapped", [56]], [[120831, 120831], "mapped", [57]], [[120832, 121343], "valid", [], "NV8"], [[121344, 121398], "valid"], [[121399, 121402], "valid", [], "NV8"], [[121403, 121452], "valid"], [[121453, 121460], "valid", [], "NV8"], [[121461, 121461], "valid"], [[121462, 121475], "valid", [], "NV8"], [[121476, 121476], "valid"], [[121477, 121483], "valid", [], "NV8"], [[121484, 121498], "disallowed"], [[121499, 121503], "valid"], [[121504, 121504], "disallowed"], [[121505, 121519], "valid"], [[121520, 124927], "disallowed"], [[124928, 125124], "valid"], [[125125, 125126], "disallowed"], [[125127, 125135], "valid", [], "NV8"], [[125136, 125142], "valid"], [[125143, 126463], "disallowed"], [[126464, 126464], "mapped", [1575]], [[126465, 126465], "mapped", [1576]], [[126466, 126466], "mapped", [1580]], [[126467, 126467], "mapped", [1583]], [[126468, 126468], "disallowed"], [[126469, 126469], "mapped", [1608]], [[126470, 126470], "mapped", [1586]], [[126471, 126471], "mapped", [1581]], [[126472, 126472], "mapped", [1591]], [[126473, 126473], "mapped", [1610]], [[126474, 126474], "mapped", [1603]], [[126475, 126475], "mapped", [1604]], [[126476, 126476], "mapped", [1605]], [[126477, 126477], "mapped", [1606]], [[126478, 126478], "mapped", [1587]], [[126479, 126479], "mapped", [1593]], [[126480, 126480], "mapped", [1601]], [[126481, 126481], "mapped", [1589]], [[126482, 126482], "mapped", [1602]], [[126483, 126483], "mapped", [1585]], [[126484, 126484], "mapped", [1588]], [[126485, 126485], "mapped", [1578]], [[126486, 126486], "mapped", [1579]], [[126487, 126487], "mapped", [1582]], [[126488, 126488], "mapped", [1584]], [[126489, 126489], "mapped", [1590]], [[126490, 126490], "mapped", [1592]], [[126491, 126491], "mapped", [1594]], [[126492, 126492], "mapped", [1646]], [[126493, 126493], "mapped", [1722]], [[126494, 126494], "mapped", [1697]], [[126495, 126495], "mapped", [1647]], [[126496, 126496], "disallowed"], [[126497, 126497], "mapped", [1576]], [[126498, 126498], "mapped", [1580]], [[126499, 126499], "disallowed"], [[126500, 126500], "mapped", [1607]], [[126501, 126502], "disallowed"], [[126503, 126503], "mapped", [1581]], [[126504, 126504], "disallowed"], [[126505, 126505], "mapped", [1610]], [[126506, 126506], "mapped", [1603]], [[126507, 126507], "mapped", [1604]], [[126508, 126508], "mapped", [1605]], [[126509, 126509], "mapped", [1606]], [[126510, 126510], "mapped", [1587]], [[126511, 126511], "mapped", [1593]], [[126512, 126512], "mapped", [1601]], [[126513, 126513], "mapped", [1589]], [[126514, 126514], "mapped", [1602]], [[126515, 126515], "disallowed"], [[126516, 126516], "mapped", [1588]], [[126517, 126517], "mapped", [1578]], [[126518, 126518], "mapped", [1579]], [[126519, 126519], "mapped", [1582]], [[126520, 126520], "disallowed"], [[126521, 126521], "mapped", [1590]], [[126522, 126522], "disallowed"], [[126523, 126523], "mapped", [1594]], [[126524, 126529], "disallowed"], [[126530, 126530], "mapped", [1580]], [[126531, 126534], "disallowed"], [[126535, 126535], "mapped", [1581]], [[126536, 126536], "disallowed"], [[126537, 126537], "mapped", [1610]], [[126538, 126538], "disallowed"], [[126539, 126539], "mapped", [1604]], [[126540, 126540], "disallowed"], [[126541, 126541], "mapped", [1606]], [[126542, 126542], "mapped", [1587]], [[126543, 126543], "mapped", [1593]], [[126544, 126544], "disallowed"], [[126545, 126545], "mapped", [1589]], [[126546, 126546], "mapped", [1602]], [[126547, 126547], "disallowed"], [[126548, 126548], "mapped", [1588]], [[126549, 126550], "disallowed"], [[126551, 126551], "mapped", [1582]], [[126552, 126552], "disallowed"], [[126553, 126553], "mapped", [1590]], [[126554, 126554], "disallowed"], [[126555, 126555], "mapped", [1594]], [[126556, 126556], "disallowed"], [[126557, 126557], "mapped", [1722]], [[126558, 126558], "disallowed"], [[126559, 126559], "mapped", [1647]], [[126560, 126560], "disallowed"], [[126561, 126561], "mapped", [1576]], [[126562, 126562], "mapped", [1580]], [[126563, 126563], "disallowed"], [[126564, 126564], "mapped", [1607]], [[126565, 126566], "disallowed"], [[126567, 126567], "mapped", [1581]], [[126568, 126568], "mapped", [1591]], [[126569, 126569], "mapped", [1610]], [[126570, 126570], "mapped", [1603]], [[126571, 126571], "disallowed"], [[126572, 126572], "mapped", [1605]], [[126573, 126573], "mapped", [1606]], [[126574, 126574], "mapped", [1587]], [[126575, 126575], "mapped", [1593]], [[126576, 126576], "mapped", [1601]], [[126577, 126577], "mapped", [1589]], [[126578, 126578], "mapped", [1602]], [[126579, 126579], "disallowed"], [[126580, 126580], "mapped", [1588]], [[126581, 126581], "mapped", [1578]], [[126582, 126582], "mapped", [1579]], [[126583, 126583], "mapped", [1582]], [[126584, 126584], "disallowed"], [[126585, 126585], "mapped", [1590]], [[126586, 126586], "mapped", [1592]], [[126587, 126587], "mapped", [1594]], [[126588, 126588], "mapped", [1646]], [[126589, 126589], "disallowed"], [[126590, 126590], "mapped", [1697]], [[126591, 126591], "disallowed"], [[126592, 126592], "mapped", [1575]], [[126593, 126593], "mapped", [1576]], [[126594, 126594], "mapped", [1580]], [[126595, 126595], "mapped", [1583]], [[126596, 126596], "mapped", [1607]], [[126597, 126597], "mapped", [1608]], [[126598, 126598], "mapped", [1586]], [[126599, 126599], "mapped", [1581]], [[126600, 126600], "mapped", [1591]], [[126601, 126601], "mapped", [1610]], [[126602, 126602], "disallowed"], [[126603, 126603], "mapped", [1604]], [[126604, 126604], "mapped", [1605]], [[126605, 126605], "mapped", [1606]], [[126606, 126606], "mapped", [1587]], [[126607, 126607], "mapped", [1593]], [[126608, 126608], "mapped", [1601]], [[126609, 126609], "mapped", [1589]], [[126610, 126610], "mapped", [1602]], [[126611, 126611], "mapped", [1585]], [[126612, 126612], "mapped", [1588]], [[126613, 126613], "mapped", [1578]], [[126614, 126614], "mapped", [1579]], [[126615, 126615], "mapped", [1582]], [[126616, 126616], "mapped", [1584]], [[126617, 126617], "mapped", [1590]], [[126618, 126618], "mapped", [1592]], [[126619, 126619], "mapped", [1594]], [[126620, 126624], "disallowed"], [[126625, 126625], "mapped", [1576]], [[126626, 126626], "mapped", [1580]], [[126627, 126627], "mapped", [1583]], [[126628, 126628], "disallowed"], [[126629, 126629], "mapped", [1608]], [[126630, 126630], "mapped", [1586]], [[126631, 126631], "mapped", [1581]], [[126632, 126632], "mapped", [1591]], [[126633, 126633], "mapped", [1610]], [[126634, 126634], "disallowed"], [[126635, 126635], "mapped", [1604]], [[126636, 126636], "mapped", [1605]], [[126637, 126637], "mapped", [1606]], [[126638, 126638], "mapped", [1587]], [[126639, 126639], "mapped", [1593]], [[126640, 126640], "mapped", [1601]], [[126641, 126641], "mapped", [1589]], [[126642, 126642], "mapped", [1602]], [[126643, 126643], "mapped", [1585]], [[126644, 126644], "mapped", [1588]], [[126645, 126645], "mapped", [1578]], [[126646, 126646], "mapped", [1579]], [[126647, 126647], "mapped", [1582]], [[126648, 126648], "mapped", [1584]], [[126649, 126649], "mapped", [1590]], [[126650, 126650], "mapped", [1592]], [[126651, 126651], "mapped", [1594]], [[126652, 126703], "disallowed"], [[126704, 126705], "valid", [], "NV8"], [[126706, 126975], "disallowed"], [[126976, 127019], "valid", [], "NV8"], [[127020, 127023], "disallowed"], [[127024, 127123], "valid", [], "NV8"], [[127124, 127135], "disallowed"], [[127136, 127150], "valid", [], "NV8"], [[127151, 127152], "disallowed"], [[127153, 127166], "valid", [], "NV8"], [[127167, 127167], "valid", [], "NV8"], [[127168, 127168], "disallowed"], [[127169, 127183], "valid", [], "NV8"], [[127184, 127184], "disallowed"], [[127185, 127199], "valid", [], "NV8"], [[127200, 127221], "valid", [], "NV8"], [[127222, 127231], "disallowed"], [[127232, 127232], "disallowed"], [[127233, 127233], "disallowed_STD3_mapped", [48, 44]], [[127234, 127234], "disallowed_STD3_mapped", [49, 44]], [[127235, 127235], "disallowed_STD3_mapped", [50, 44]], [[127236, 127236], "disallowed_STD3_mapped", [51, 44]], [[127237, 127237], "disallowed_STD3_mapped", [52, 44]], [[127238, 127238], "disallowed_STD3_mapped", [53, 44]], [[127239, 127239], "disallowed_STD3_mapped", [54, 44]], [[127240, 127240], "disallowed_STD3_mapped", [55, 44]], [[127241, 127241], "disallowed_STD3_mapped", [56, 44]], [[127242, 127242], "disallowed_STD3_mapped", [57, 44]], [[127243, 127244], "valid", [], "NV8"], [[127245, 127247], "disallowed"], [[127248, 127248], "disallowed_STD3_mapped", [40, 97, 41]], [[127249, 127249], "disallowed_STD3_mapped", [40, 98, 41]], [[127250, 127250], "disallowed_STD3_mapped", [40, 99, 41]], [[127251, 127251], "disallowed_STD3_mapped", [40, 100, 41]], [[127252, 127252], "disallowed_STD3_mapped", [40, 101, 41]], [[127253, 127253], "disallowed_STD3_mapped", [40, 102, 41]], [[127254, 127254], "disallowed_STD3_mapped", [40, 103, 41]], [[127255, 127255], "disallowed_STD3_mapped", [40, 104, 41]], [[127256, 127256], "disallowed_STD3_mapped", [40, 105, 41]], [[127257, 127257], "disallowed_STD3_mapped", [40, 106, 41]], [[127258, 127258], "disallowed_STD3_mapped", [40, 107, 41]], [[127259, 127259], "disallowed_STD3_mapped", [40, 108, 41]], [[127260, 127260], "disallowed_STD3_mapped", [40, 109, 41]], [[127261, 127261], "disallowed_STD3_mapped", [40, 110, 41]], [[127262, 127262], "disallowed_STD3_mapped", [40, 111, 41]], [[127263, 127263], "disallowed_STD3_mapped", [40, 112, 41]], [[127264, 127264], "disallowed_STD3_mapped", [40, 113, 41]], [[127265, 127265], "disallowed_STD3_mapped", [40, 114, 41]], [[127266, 127266], "disallowed_STD3_mapped", [40, 115, 41]], [[127267, 127267], "disallowed_STD3_mapped", [40, 116, 41]], [[127268, 127268], "disallowed_STD3_mapped", [40, 117, 41]], [[127269, 127269], "disallowed_STD3_mapped", [40, 118, 41]], [[127270, 127270], "disallowed_STD3_mapped", [40, 119, 41]], [[127271, 127271], "disallowed_STD3_mapped", [40, 120, 41]], [[127272, 127272], "disallowed_STD3_mapped", [40, 121, 41]], [[127273, 127273], "disallowed_STD3_mapped", [40, 122, 41]], [[127274, 127274], "mapped", [12308, 115, 12309]], [[127275, 127275], "mapped", [99]], [[127276, 127276], "mapped", [114]], [[127277, 127277], "mapped", [99, 100]], [[127278, 127278], "mapped", [119, 122]], [[127279, 127279], "disallowed"], [[127280, 127280], "mapped", [97]], [[127281, 127281], "mapped", [98]], [[127282, 127282], "mapped", [99]], [[127283, 127283], "mapped", [100]], [[127284, 127284], "mapped", [101]], [[127285, 127285], "mapped", [102]], [[127286, 127286], "mapped", [103]], [[127287, 127287], "mapped", [104]], [[127288, 127288], "mapped", [105]], [[127289, 127289], "mapped", [106]], [[127290, 127290], "mapped", [107]], [[127291, 127291], "mapped", [108]], [[127292, 127292], "mapped", [109]], [[127293, 127293], "mapped", [110]], [[127294, 127294], "mapped", [111]], [[127295, 127295], "mapped", [112]], [[127296, 127296], "mapped", [113]], [[127297, 127297], "mapped", [114]], [[127298, 127298], "mapped", [115]], [[127299, 127299], "mapped", [116]], [[127300, 127300], "mapped", [117]], [[127301, 127301], "mapped", [118]], [[127302, 127302], "mapped", [119]], [[127303, 127303], "mapped", [120]], [[127304, 127304], "mapped", [121]], [[127305, 127305], "mapped", [122]], [[127306, 127306], "mapped", [104, 118]], [[127307, 127307], "mapped", [109, 118]], [[127308, 127308], "mapped", [115, 100]], [[127309, 127309], "mapped", [115, 115]], [[127310, 127310], "mapped", [112, 112, 118]], [[127311, 127311], "mapped", [119, 99]], [[127312, 127318], "valid", [], "NV8"], [[127319, 127319], "valid", [], "NV8"], [[127320, 127326], "valid", [], "NV8"], [[127327, 127327], "valid", [], "NV8"], [[127328, 127337], "valid", [], "NV8"], [[127338, 127338], "mapped", [109, 99]], [[127339, 127339], "mapped", [109, 100]], [[127340, 127343], "disallowed"], [[127344, 127352], "valid", [], "NV8"], [[127353, 127353], "valid", [], "NV8"], [[127354, 127354], "valid", [], "NV8"], [[127355, 127356], "valid", [], "NV8"], [[127357, 127358], "valid", [], "NV8"], [[127359, 127359], "valid", [], "NV8"], [[127360, 127369], "valid", [], "NV8"], [[127370, 127373], "valid", [], "NV8"], [[127374, 127375], "valid", [], "NV8"], [[127376, 127376], "mapped", [100, 106]], [[127377, 127386], "valid", [], "NV8"], [[127387, 127461], "disallowed"], [[127462, 127487], "valid", [], "NV8"], [[127488, 127488], "mapped", [12411, 12363]], [[127489, 127489], "mapped", [12467, 12467]], [[127490, 127490], "mapped", [12469]], [[127491, 127503], "disallowed"], [[127504, 127504], "mapped", [25163]], [[127505, 127505], "mapped", [23383]], [[127506, 127506], "mapped", [21452]], [[127507, 127507], "mapped", [12487]], [[127508, 127508], "mapped", [20108]], [[127509, 127509], "mapped", [22810]], [[127510, 127510], "mapped", [35299]], [[127511, 127511], "mapped", [22825]], [[127512, 127512], "mapped", [20132]], [[127513, 127513], "mapped", [26144]], [[127514, 127514], "mapped", [28961]], [[127515, 127515], "mapped", [26009]], [[127516, 127516], "mapped", [21069]], [[127517, 127517], "mapped", [24460]], [[127518, 127518], "mapped", [20877]], [[127519, 127519], "mapped", [26032]], [[127520, 127520], "mapped", [21021]], [[127521, 127521], "mapped", [32066]], [[127522, 127522], "mapped", [29983]], [[127523, 127523], "mapped", [36009]], [[127524, 127524], "mapped", [22768]], [[127525, 127525], "mapped", [21561]], [[127526, 127526], "mapped", [28436]], [[127527, 127527], "mapped", [25237]], [[127528, 127528], "mapped", [25429]], [[127529, 127529], "mapped", [19968]], [[127530, 127530], "mapped", [19977]], [[127531, 127531], "mapped", [36938]], [[127532, 127532], "mapped", [24038]], [[127533, 127533], "mapped", [20013]], [[127534, 127534], "mapped", [21491]], [[127535, 127535], "mapped", [25351]], [[127536, 127536], "mapped", [36208]], [[127537, 127537], "mapped", [25171]], [[127538, 127538], "mapped", [31105]], [[127539, 127539], "mapped", [31354]], [[127540, 127540], "mapped", [21512]], [[127541, 127541], "mapped", [28288]], [[127542, 127542], "mapped", [26377]], [[127543, 127543], "mapped", [26376]], [[127544, 127544], "mapped", [30003]], [[127545, 127545], "mapped", [21106]], [[127546, 127546], "mapped", [21942]], [[127547, 127551], "disallowed"], [[127552, 127552], "mapped", [12308, 26412, 12309]], [[127553, 127553], "mapped", [12308, 19977, 12309]], [[127554, 127554], "mapped", [12308, 20108, 12309]], [[127555, 127555], "mapped", [12308, 23433, 12309]], [[127556, 127556], "mapped", [12308, 28857, 12309]], [[127557, 127557], "mapped", [12308, 25171, 12309]], [[127558, 127558], "mapped", [12308, 30423, 12309]], [[127559, 127559], "mapped", [12308, 21213, 12309]], [[127560, 127560], "mapped", [12308, 25943, 12309]], [[127561, 127567], "disallowed"], [[127568, 127568], "mapped", [24471]], [[127569, 127569], "mapped", [21487]], [[127570, 127743], "disallowed"], [[127744, 127776], "valid", [], "NV8"], [[127777, 127788], "valid", [], "NV8"], [[127789, 127791], "valid", [], "NV8"], [[127792, 127797], "valid", [], "NV8"], [[127798, 127798], "valid", [], "NV8"], [[127799, 127868], "valid", [], "NV8"], [[127869, 127869], "valid", [], "NV8"], [[127870, 127871], "valid", [], "NV8"], [[127872, 127891], "valid", [], "NV8"], [[127892, 127903], "valid", [], "NV8"], [[127904, 127940], "valid", [], "NV8"], [[127941, 127941], "valid", [], "NV8"], [[127942, 127946], "valid", [], "NV8"], [[127947, 127950], "valid", [], "NV8"], [[127951, 127955], "valid", [], "NV8"], [[127956, 127967], "valid", [], "NV8"], [[127968, 127984], "valid", [], "NV8"], [[127985, 127991], "valid", [], "NV8"], [[127992, 127999], "valid", [], "NV8"], [[128e3, 128062], "valid", [], "NV8"], [[128063, 128063], "valid", [], "NV8"], [[128064, 128064], "valid", [], "NV8"], [[128065, 128065], "valid", [], "NV8"], [[128066, 128247], "valid", [], "NV8"], [[128248, 128248], "valid", [], "NV8"], [[128249, 128252], "valid", [], "NV8"], [[128253, 128254], "valid", [], "NV8"], [[128255, 128255], "valid", [], "NV8"], [[128256, 128317], "valid", [], "NV8"], [[128318, 128319], "valid", [], "NV8"], [[128320, 128323], "valid", [], "NV8"], [[128324, 128330], "valid", [], "NV8"], [[128331, 128335], "valid", [], "NV8"], [[128336, 128359], "valid", [], "NV8"], [[128360, 128377], "valid", [], "NV8"], [[128378, 128378], "disallowed"], [[128379, 128419], "valid", [], "NV8"], [[128420, 128420], "disallowed"], [[128421, 128506], "valid", [], "NV8"], [[128507, 128511], "valid", [], "NV8"], [[128512, 128512], "valid", [], "NV8"], [[128513, 128528], "valid", [], "NV8"], [[128529, 128529], "valid", [], "NV8"], [[128530, 128532], "valid", [], "NV8"], [[128533, 128533], "valid", [], "NV8"], [[128534, 128534], "valid", [], "NV8"], [[128535, 128535], "valid", [], "NV8"], [[128536, 128536], "valid", [], "NV8"], [[128537, 128537], "valid", [], "NV8"], [[128538, 128538], "valid", [], "NV8"], [[128539, 128539], "valid", [], "NV8"], [[128540, 128542], "valid", [], "NV8"], [[128543, 128543], "valid", [], "NV8"], [[128544, 128549], "valid", [], "NV8"], [[128550, 128551], "valid", [], "NV8"], [[128552, 128555], "valid", [], "NV8"], [[128556, 128556], "valid", [], "NV8"], [[128557, 128557], "valid", [], "NV8"], [[128558, 128559], "valid", [], "NV8"], [[128560, 128563], "valid", [], "NV8"], [[128564, 128564], "valid", [], "NV8"], [[128565, 128576], "valid", [], "NV8"], [[128577, 128578], "valid", [], "NV8"], [[128579, 128580], "valid", [], "NV8"], [[128581, 128591], "valid", [], "NV8"], [[128592, 128639], "valid", [], "NV8"], [[128640, 128709], "valid", [], "NV8"], [[128710, 128719], "valid", [], "NV8"], [[128720, 128720], "valid", [], "NV8"], [[128721, 128735], "disallowed"], [[128736, 128748], "valid", [], "NV8"], [[128749, 128751], "disallowed"], [[128752, 128755], "valid", [], "NV8"], [[128756, 128767], "disallowed"], [[128768, 128883], "valid", [], "NV8"], [[128884, 128895], "disallowed"], [[128896, 128980], "valid", [], "NV8"], [[128981, 129023], "disallowed"], [[129024, 129035], "valid", [], "NV8"], [[129036, 129039], "disallowed"], [[129040, 129095], "valid", [], "NV8"], [[129096, 129103], "disallowed"], [[129104, 129113], "valid", [], "NV8"], [[129114, 129119], "disallowed"], [[129120, 129159], "valid", [], "NV8"], [[129160, 129167], "disallowed"], [[129168, 129197], "valid", [], "NV8"], [[129198, 129295], "disallowed"], [[129296, 129304], "valid", [], "NV8"], [[129305, 129407], "disallowed"], [[129408, 129412], "valid", [], "NV8"], [[129413, 129471], "disallowed"], [[129472, 129472], "valid", [], "NV8"], [[129473, 131069], "disallowed"], [[131070, 131071], "disallowed"], [[131072, 173782], "valid"], [[173783, 173823], "disallowed"], [[173824, 177972], "valid"], [[177973, 177983], "disallowed"], [[177984, 178205], "valid"], [[178206, 178207], "disallowed"], [[178208, 183969], "valid"], [[183970, 194559], "disallowed"], [[194560, 194560], "mapped", [20029]], [[194561, 194561], "mapped", [20024]], [[194562, 194562], "mapped", [20033]], [[194563, 194563], "mapped", [131362]], [[194564, 194564], "mapped", [20320]], [[194565, 194565], "mapped", [20398]], [[194566, 194566], "mapped", [20411]], [[194567, 194567], "mapped", [20482]], [[194568, 194568], "mapped", [20602]], [[194569, 194569], "mapped", [20633]], [[194570, 194570], "mapped", [20711]], [[194571, 194571], "mapped", [20687]], [[194572, 194572], "mapped", [13470]], [[194573, 194573], "mapped", [132666]], [[194574, 194574], "mapped", [20813]], [[194575, 194575], "mapped", [20820]], [[194576, 194576], "mapped", [20836]], [[194577, 194577], "mapped", [20855]], [[194578, 194578], "mapped", [132380]], [[194579, 194579], "mapped", [13497]], [[194580, 194580], "mapped", [20839]], [[194581, 194581], "mapped", [20877]], [[194582, 194582], "mapped", [132427]], [[194583, 194583], "mapped", [20887]], [[194584, 194584], "mapped", [20900]], [[194585, 194585], "mapped", [20172]], [[194586, 194586], "mapped", [20908]], [[194587, 194587], "mapped", [20917]], [[194588, 194588], "mapped", [168415]], [[194589, 194589], "mapped", [20981]], [[194590, 194590], "mapped", [20995]], [[194591, 194591], "mapped", [13535]], [[194592, 194592], "mapped", [21051]], [[194593, 194593], "mapped", [21062]], [[194594, 194594], "mapped", [21106]], [[194595, 194595], "mapped", [21111]], [[194596, 194596], "mapped", [13589]], [[194597, 194597], "mapped", [21191]], [[194598, 194598], "mapped", [21193]], [[194599, 194599], "mapped", [21220]], [[194600, 194600], "mapped", [21242]], [[194601, 194601], "mapped", [21253]], [[194602, 194602], "mapped", [21254]], [[194603, 194603], "mapped", [21271]], [[194604, 194604], "mapped", [21321]], [[194605, 194605], "mapped", [21329]], [[194606, 194606], "mapped", [21338]], [[194607, 194607], "mapped", [21363]], [[194608, 194608], "mapped", [21373]], [[194609, 194611], "mapped", [21375]], [[194612, 194612], "mapped", [133676]], [[194613, 194613], "mapped", [28784]], [[194614, 194614], "mapped", [21450]], [[194615, 194615], "mapped", [21471]], [[194616, 194616], "mapped", [133987]], [[194617, 194617], "mapped", [21483]], [[194618, 194618], "mapped", [21489]], [[194619, 194619], "mapped", [21510]], [[194620, 194620], "mapped", [21662]], [[194621, 194621], "mapped", [21560]], [[194622, 194622], "mapped", [21576]], [[194623, 194623], "mapped", [21608]], [[194624, 194624], "mapped", [21666]], [[194625, 194625], "mapped", [21750]], [[194626, 194626], "mapped", [21776]], [[194627, 194627], "mapped", [21843]], [[194628, 194628], "mapped", [21859]], [[194629, 194630], "mapped", [21892]], [[194631, 194631], "mapped", [21913]], [[194632, 194632], "mapped", [21931]], [[194633, 194633], "mapped", [21939]], [[194634, 194634], "mapped", [21954]], [[194635, 194635], "mapped", [22294]], [[194636, 194636], "mapped", [22022]], [[194637, 194637], "mapped", [22295]], [[194638, 194638], "mapped", [22097]], [[194639, 194639], "mapped", [22132]], [[194640, 194640], "mapped", [20999]], [[194641, 194641], "mapped", [22766]], [[194642, 194642], "mapped", [22478]], [[194643, 194643], "mapped", [22516]], [[194644, 194644], "mapped", [22541]], [[194645, 194645], "mapped", [22411]], [[194646, 194646], "mapped", [22578]], [[194647, 194647], "mapped", [22577]], [[194648, 194648], "mapped", [22700]], [[194649, 194649], "mapped", [136420]], [[194650, 194650], "mapped", [22770]], [[194651, 194651], "mapped", [22775]], [[194652, 194652], "mapped", [22790]], [[194653, 194653], "mapped", [22810]], [[194654, 194654], "mapped", [22818]], [[194655, 194655], "mapped", [22882]], [[194656, 194656], "mapped", [136872]], [[194657, 194657], "mapped", [136938]], [[194658, 194658], "mapped", [23020]], [[194659, 194659], "mapped", [23067]], [[194660, 194660], "mapped", [23079]], [[194661, 194661], "mapped", [23e3]], [[194662, 194662], "mapped", [23142]], [[194663, 194663], "mapped", [14062]], [[194664, 194664], "disallowed"], [[194665, 194665], "mapped", [23304]], [[194666, 194667], "mapped", [23358]], [[194668, 194668], "mapped", [137672]], [[194669, 194669], "mapped", [23491]], [[194670, 194670], "mapped", [23512]], [[194671, 194671], "mapped", [23527]], [[194672, 194672], "mapped", [23539]], [[194673, 194673], "mapped", [138008]], [[194674, 194674], "mapped", [23551]], [[194675, 194675], "mapped", [23558]], [[194676, 194676], "disallowed"], [[194677, 194677], "mapped", [23586]], [[194678, 194678], "mapped", [14209]], [[194679, 194679], "mapped", [23648]], [[194680, 194680], "mapped", [23662]], [[194681, 194681], "mapped", [23744]], [[194682, 194682], "mapped", [23693]], [[194683, 194683], "mapped", [138724]], [[194684, 194684], "mapped", [23875]], [[194685, 194685], "mapped", [138726]], [[194686, 194686], "mapped", [23918]], [[194687, 194687], "mapped", [23915]], [[194688, 194688], "mapped", [23932]], [[194689, 194689], "mapped", [24033]], [[194690, 194690], "mapped", [24034]], [[194691, 194691], "mapped", [14383]], [[194692, 194692], "mapped", [24061]], [[194693, 194693], "mapped", [24104]], [[194694, 194694], "mapped", [24125]], [[194695, 194695], "mapped", [24169]], [[194696, 194696], "mapped", [14434]], [[194697, 194697], "mapped", [139651]], [[194698, 194698], "mapped", [14460]], [[194699, 194699], "mapped", [24240]], [[194700, 194700], "mapped", [24243]], [[194701, 194701], "mapped", [24246]], [[194702, 194702], "mapped", [24266]], [[194703, 194703], "mapped", [172946]], [[194704, 194704], "mapped", [24318]], [[194705, 194706], "mapped", [140081]], [[194707, 194707], "mapped", [33281]], [[194708, 194709], "mapped", [24354]], [[194710, 194710], "mapped", [14535]], [[194711, 194711], "mapped", [144056]], [[194712, 194712], "mapped", [156122]], [[194713, 194713], "mapped", [24418]], [[194714, 194714], "mapped", [24427]], [[194715, 194715], "mapped", [14563]], [[194716, 194716], "mapped", [24474]], [[194717, 194717], "mapped", [24525]], [[194718, 194718], "mapped", [24535]], [[194719, 194719], "mapped", [24569]], [[194720, 194720], "mapped", [24705]], [[194721, 194721], "mapped", [14650]], [[194722, 194722], "mapped", [14620]], [[194723, 194723], "mapped", [24724]], [[194724, 194724], "mapped", [141012]], [[194725, 194725], "mapped", [24775]], [[194726, 194726], "mapped", [24904]], [[194727, 194727], "mapped", [24908]], [[194728, 194728], "mapped", [24910]], [[194729, 194729], "mapped", [24908]], [[194730, 194730], "mapped", [24954]], [[194731, 194731], "mapped", [24974]], [[194732, 194732], "mapped", [25010]], [[194733, 194733], "mapped", [24996]], [[194734, 194734], "mapped", [25007]], [[194735, 194735], "mapped", [25054]], [[194736, 194736], "mapped", [25074]], [[194737, 194737], "mapped", [25078]], [[194738, 194738], "mapped", [25104]], [[194739, 194739], "mapped", [25115]], [[194740, 194740], "mapped", [25181]], [[194741, 194741], "mapped", [25265]], [[194742, 194742], "mapped", [25300]], [[194743, 194743], "mapped", [25424]], [[194744, 194744], "mapped", [142092]], [[194745, 194745], "mapped", [25405]], [[194746, 194746], "mapped", [25340]], [[194747, 194747], "mapped", [25448]], [[194748, 194748], "mapped", [25475]], [[194749, 194749], "mapped", [25572]], [[194750, 194750], "mapped", [142321]], [[194751, 194751], "mapped", [25634]], [[194752, 194752], "mapped", [25541]], [[194753, 194753], "mapped", [25513]], [[194754, 194754], "mapped", [14894]], [[194755, 194755], "mapped", [25705]], [[194756, 194756], "mapped", [25726]], [[194757, 194757], "mapped", [25757]], [[194758, 194758], "mapped", [25719]], [[194759, 194759], "mapped", [14956]], [[194760, 194760], "mapped", [25935]], [[194761, 194761], "mapped", [25964]], [[194762, 194762], "mapped", [143370]], [[194763, 194763], "mapped", [26083]], [[194764, 194764], "mapped", [26360]], [[194765, 194765], "mapped", [26185]], [[194766, 194766], "mapped", [15129]], [[194767, 194767], "mapped", [26257]], [[194768, 194768], "mapped", [15112]], [[194769, 194769], "mapped", [15076]], [[194770, 194770], "mapped", [20882]], [[194771, 194771], "mapped", [20885]], [[194772, 194772], "mapped", [26368]], [[194773, 194773], "mapped", [26268]], [[194774, 194774], "mapped", [32941]], [[194775, 194775], "mapped", [17369]], [[194776, 194776], "mapped", [26391]], [[194777, 194777], "mapped", [26395]], [[194778, 194778], "mapped", [26401]], [[194779, 194779], "mapped", [26462]], [[194780, 194780], "mapped", [26451]], [[194781, 194781], "mapped", [144323]], [[194782, 194782], "mapped", [15177]], [[194783, 194783], "mapped", [26618]], [[194784, 194784], "mapped", [26501]], [[194785, 194785], "mapped", [26706]], [[194786, 194786], "mapped", [26757]], [[194787, 194787], "mapped", [144493]], [[194788, 194788], "mapped", [26766]], [[194789, 194789], "mapped", [26655]], [[194790, 194790], "mapped", [26900]], [[194791, 194791], "mapped", [15261]], [[194792, 194792], "mapped", [26946]], [[194793, 194793], "mapped", [27043]], [[194794, 194794], "mapped", [27114]], [[194795, 194795], "mapped", [27304]], [[194796, 194796], "mapped", [145059]], [[194797, 194797], "mapped", [27355]], [[194798, 194798], "mapped", [15384]], [[194799, 194799], "mapped", [27425]], [[194800, 194800], "mapped", [145575]], [[194801, 194801], "mapped", [27476]], [[194802, 194802], "mapped", [15438]], [[194803, 194803], "mapped", [27506]], [[194804, 194804], "mapped", [27551]], [[194805, 194805], "mapped", [27578]], [[194806, 194806], "mapped", [27579]], [[194807, 194807], "mapped", [146061]], [[194808, 194808], "mapped", [138507]], [[194809, 194809], "mapped", [146170]], [[194810, 194810], "mapped", [27726]], [[194811, 194811], "mapped", [146620]], [[194812, 194812], "mapped", [27839]], [[194813, 194813], "mapped", [27853]], [[194814, 194814], "mapped", [27751]], [[194815, 194815], "mapped", [27926]], [[194816, 194816], "mapped", [27966]], [[194817, 194817], "mapped", [28023]], [[194818, 194818], "mapped", [27969]], [[194819, 194819], "mapped", [28009]], [[194820, 194820], "mapped", [28024]], [[194821, 194821], "mapped", [28037]], [[194822, 194822], "mapped", [146718]], [[194823, 194823], "mapped", [27956]], [[194824, 194824], "mapped", [28207]], [[194825, 194825], "mapped", [28270]], [[194826, 194826], "mapped", [15667]], [[194827, 194827], "mapped", [28363]], [[194828, 194828], "mapped", [28359]], [[194829, 194829], "mapped", [147153]], [[194830, 194830], "mapped", [28153]], [[194831, 194831], "mapped", [28526]], [[194832, 194832], "mapped", [147294]], [[194833, 194833], "mapped", [147342]], [[194834, 194834], "mapped", [28614]], [[194835, 194835], "mapped", [28729]], [[194836, 194836], "mapped", [28702]], [[194837, 194837], "mapped", [28699]], [[194838, 194838], "mapped", [15766]], [[194839, 194839], "mapped", [28746]], [[194840, 194840], "mapped", [28797]], [[194841, 194841], "mapped", [28791]], [[194842, 194842], "mapped", [28845]], [[194843, 194843], "mapped", [132389]], [[194844, 194844], "mapped", [28997]], [[194845, 194845], "mapped", [148067]], [[194846, 194846], "mapped", [29084]], [[194847, 194847], "disallowed"], [[194848, 194848], "mapped", [29224]], [[194849, 194849], "mapped", [29237]], [[194850, 194850], "mapped", [29264]], [[194851, 194851], "mapped", [149e3]], [[194852, 194852], "mapped", [29312]], [[194853, 194853], "mapped", [29333]], [[194854, 194854], "mapped", [149301]], [[194855, 194855], "mapped", [149524]], [[194856, 194856], "mapped", [29562]], [[194857, 194857], "mapped", [29579]], [[194858, 194858], "mapped", [16044]], [[194859, 194859], "mapped", [29605]], [[194860, 194861], "mapped", [16056]], [[194862, 194862], "mapped", [29767]], [[194863, 194863], "mapped", [29788]], [[194864, 194864], "mapped", [29809]], [[194865, 194865], "mapped", [29829]], [[194866, 194866], "mapped", [29898]], [[194867, 194867], "mapped", [16155]], [[194868, 194868], "mapped", [29988]], [[194869, 194869], "mapped", [150582]], [[194870, 194870], "mapped", [30014]], [[194871, 194871], "mapped", [150674]], [[194872, 194872], "mapped", [30064]], [[194873, 194873], "mapped", [139679]], [[194874, 194874], "mapped", [30224]], [[194875, 194875], "mapped", [151457]], [[194876, 194876], "mapped", [151480]], [[194877, 194877], "mapped", [151620]], [[194878, 194878], "mapped", [16380]], [[194879, 194879], "mapped", [16392]], [[194880, 194880], "mapped", [30452]], [[194881, 194881], "mapped", [151795]], [[194882, 194882], "mapped", [151794]], [[194883, 194883], "mapped", [151833]], [[194884, 194884], "mapped", [151859]], [[194885, 194885], "mapped", [30494]], [[194886, 194887], "mapped", [30495]], [[194888, 194888], "mapped", [30538]], [[194889, 194889], "mapped", [16441]], [[194890, 194890], "mapped", [30603]], [[194891, 194891], "mapped", [16454]], [[194892, 194892], "mapped", [16534]], [[194893, 194893], "mapped", [152605]], [[194894, 194894], "mapped", [30798]], [[194895, 194895], "mapped", [30860]], [[194896, 194896], "mapped", [30924]], [[194897, 194897], "mapped", [16611]], [[194898, 194898], "mapped", [153126]], [[194899, 194899], "mapped", [31062]], [[194900, 194900], "mapped", [153242]], [[194901, 194901], "mapped", [153285]], [[194902, 194902], "mapped", [31119]], [[194903, 194903], "mapped", [31211]], [[194904, 194904], "mapped", [16687]], [[194905, 194905], "mapped", [31296]], [[194906, 194906], "mapped", [31306]], [[194907, 194907], "mapped", [31311]], [[194908, 194908], "mapped", [153980]], [[194909, 194910], "mapped", [154279]], [[194911, 194911], "disallowed"], [[194912, 194912], "mapped", [16898]], [[194913, 194913], "mapped", [154539]], [[194914, 194914], "mapped", [31686]], [[194915, 194915], "mapped", [31689]], [[194916, 194916], "mapped", [16935]], [[194917, 194917], "mapped", [154752]], [[194918, 194918], "mapped", [31954]], [[194919, 194919], "mapped", [17056]], [[194920, 194920], "mapped", [31976]], [[194921, 194921], "mapped", [31971]], [[194922, 194922], "mapped", [32e3]], [[194923, 194923], "mapped", [155526]], [[194924, 194924], "mapped", [32099]], [[194925, 194925], "mapped", [17153]], [[194926, 194926], "mapped", [32199]], [[194927, 194927], "mapped", [32258]], [[194928, 194928], "mapped", [32325]], [[194929, 194929], "mapped", [17204]], [[194930, 194930], "mapped", [156200]], [[194931, 194931], "mapped", [156231]], [[194932, 194932], "mapped", [17241]], [[194933, 194933], "mapped", [156377]], [[194934, 194934], "mapped", [32634]], [[194935, 194935], "mapped", [156478]], [[194936, 194936], "mapped", [32661]], [[194937, 194937], "mapped", [32762]], [[194938, 194938], "mapped", [32773]], [[194939, 194939], "mapped", [156890]], [[194940, 194940], "mapped", [156963]], [[194941, 194941], "mapped", [32864]], [[194942, 194942], "mapped", [157096]], [[194943, 194943], "mapped", [32880]], [[194944, 194944], "mapped", [144223]], [[194945, 194945], "mapped", [17365]], [[194946, 194946], "mapped", [32946]], [[194947, 194947], "mapped", [33027]], [[194948, 194948], "mapped", [17419]], [[194949, 194949], "mapped", [33086]], [[194950, 194950], "mapped", [23221]], [[194951, 194951], "mapped", [157607]], [[194952, 194952], "mapped", [157621]], [[194953, 194953], "mapped", [144275]], [[194954, 194954], "mapped", [144284]], [[194955, 194955], "mapped", [33281]], [[194956, 194956], "mapped", [33284]], [[194957, 194957], "mapped", [36766]], [[194958, 194958], "mapped", [17515]], [[194959, 194959], "mapped", [33425]], [[194960, 194960], "mapped", [33419]], [[194961, 194961], "mapped", [33437]], [[194962, 194962], "mapped", [21171]], [[194963, 194963], "mapped", [33457]], [[194964, 194964], "mapped", [33459]], [[194965, 194965], "mapped", [33469]], [[194966, 194966], "mapped", [33510]], [[194967, 194967], "mapped", [158524]], [[194968, 194968], "mapped", [33509]], [[194969, 194969], "mapped", [33565]], [[194970, 194970], "mapped", [33635]], [[194971, 194971], "mapped", [33709]], [[194972, 194972], "mapped", [33571]], [[194973, 194973], "mapped", [33725]], [[194974, 194974], "mapped", [33767]], [[194975, 194975], "mapped", [33879]], [[194976, 194976], "mapped", [33619]], [[194977, 194977], "mapped", [33738]], [[194978, 194978], "mapped", [33740]], [[194979, 194979], "mapped", [33756]], [[194980, 194980], "mapped", [158774]], [[194981, 194981], "mapped", [159083]], [[194982, 194982], "mapped", [158933]], [[194983, 194983], "mapped", [17707]], [[194984, 194984], "mapped", [34033]], [[194985, 194985], "mapped", [34035]], [[194986, 194986], "mapped", [34070]], [[194987, 194987], "mapped", [160714]], [[194988, 194988], "mapped", [34148]], [[194989, 194989], "mapped", [159532]], [[194990, 194990], "mapped", [17757]], [[194991, 194991], "mapped", [17761]], [[194992, 194992], "mapped", [159665]], [[194993, 194993], "mapped", [159954]], [[194994, 194994], "mapped", [17771]], [[194995, 194995], "mapped", [34384]], [[194996, 194996], "mapped", [34396]], [[194997, 194997], "mapped", [34407]], [[194998, 194998], "mapped", [34409]], [[194999, 194999], "mapped", [34473]], [[195e3, 195e3], "mapped", [34440]], [[195001, 195001], "mapped", [34574]], [[195002, 195002], "mapped", [34530]], [[195003, 195003], "mapped", [34681]], [[195004, 195004], "mapped", [34600]], [[195005, 195005], "mapped", [34667]], [[195006, 195006], "mapped", [34694]], [[195007, 195007], "disallowed"], [[195008, 195008], "mapped", [34785]], [[195009, 195009], "mapped", [34817]], [[195010, 195010], "mapped", [17913]], [[195011, 195011], "mapped", [34912]], [[195012, 195012], "mapped", [34915]], [[195013, 195013], "mapped", [161383]], [[195014, 195014], "mapped", [35031]], [[195015, 195015], "mapped", [35038]], [[195016, 195016], "mapped", [17973]], [[195017, 195017], "mapped", [35066]], [[195018, 195018], "mapped", [13499]], [[195019, 195019], "mapped", [161966]], [[195020, 195020], "mapped", [162150]], [[195021, 195021], "mapped", [18110]], [[195022, 195022], "mapped", [18119]], [[195023, 195023], "mapped", [35488]], [[195024, 195024], "mapped", [35565]], [[195025, 195025], "mapped", [35722]], [[195026, 195026], "mapped", [35925]], [[195027, 195027], "mapped", [162984]], [[195028, 195028], "mapped", [36011]], [[195029, 195029], "mapped", [36033]], [[195030, 195030], "mapped", [36123]], [[195031, 195031], "mapped", [36215]], [[195032, 195032], "mapped", [163631]], [[195033, 195033], "mapped", [133124]], [[195034, 195034], "mapped", [36299]], [[195035, 195035], "mapped", [36284]], [[195036, 195036], "mapped", [36336]], [[195037, 195037], "mapped", [133342]], [[195038, 195038], "mapped", [36564]], [[195039, 195039], "mapped", [36664]], [[195040, 195040], "mapped", [165330]], [[195041, 195041], "mapped", [165357]], [[195042, 195042], "mapped", [37012]], [[195043, 195043], "mapped", [37105]], [[195044, 195044], "mapped", [37137]], [[195045, 195045], "mapped", [165678]], [[195046, 195046], "mapped", [37147]], [[195047, 195047], "mapped", [37432]], [[195048, 195048], "mapped", [37591]], [[195049, 195049], "mapped", [37592]], [[195050, 195050], "mapped", [37500]], [[195051, 195051], "mapped", [37881]], [[195052, 195052], "mapped", [37909]], [[195053, 195053], "mapped", [166906]], [[195054, 195054], "mapped", [38283]], [[195055, 195055], "mapped", [18837]], [[195056, 195056], "mapped", [38327]], [[195057, 195057], "mapped", [167287]], [[195058, 195058], "mapped", [18918]], [[195059, 195059], "mapped", [38595]], [[195060, 195060], "mapped", [23986]], [[195061, 195061], "mapped", [38691]], [[195062, 195062], "mapped", [168261]], [[195063, 195063], "mapped", [168474]], [[195064, 195064], "mapped", [19054]], [[195065, 195065], "mapped", [19062]], [[195066, 195066], "mapped", [38880]], [[195067, 195067], "mapped", [168970]], [[195068, 195068], "mapped", [19122]], [[195069, 195069], "mapped", [169110]], [[195070, 195071], "mapped", [38923]], [[195072, 195072], "mapped", [38953]], [[195073, 195073], "mapped", [169398]], [[195074, 195074], "mapped", [39138]], [[195075, 195075], "mapped", [19251]], [[195076, 195076], "mapped", [39209]], [[195077, 195077], "mapped", [39335]], [[195078, 195078], "mapped", [39362]], [[195079, 195079], "mapped", [39422]], [[195080, 195080], "mapped", [19406]], [[195081, 195081], "mapped", [170800]], [[195082, 195082], "mapped", [39698]], [[195083, 195083], "mapped", [4e4]], [[195084, 195084], "mapped", [40189]], [[195085, 195085], "mapped", [19662]], [[195086, 195086], "mapped", [19693]], [[195087, 195087], "mapped", [40295]], [[195088, 195088], "mapped", [172238]], [[195089, 195089], "mapped", [19704]], [[195090, 195090], "mapped", [172293]], [[195091, 195091], "mapped", [172558]], [[195092, 195092], "mapped", [172689]], [[195093, 195093], "mapped", [40635]], [[195094, 195094], "mapped", [19798]], [[195095, 195095], "mapped", [40697]], [[195096, 195096], "mapped", [40702]], [[195097, 195097], "mapped", [40709]], [[195098, 195098], "mapped", [40719]], [[195099, 195099], "mapped", [40726]], [[195100, 195100], "mapped", [40763]], [[195101, 195101], "mapped", [173568]], [[195102, 196605], "disallowed"], [[196606, 196607], "disallowed"], [[196608, 262141], "disallowed"], [[262142, 262143], "disallowed"], [[262144, 327677], "disallowed"], [[327678, 327679], "disallowed"], [[327680, 393213], "disallowed"], [[393214, 393215], "disallowed"], [[393216, 458749], "disallowed"], [[458750, 458751], "disallowed"], [[458752, 524285], "disallowed"], [[524286, 524287], "disallowed"], [[524288, 589821], "disallowed"], [[589822, 589823], "disallowed"], [[589824, 655357], "disallowed"], [[655358, 655359], "disallowed"], [[655360, 720893], "disallowed"], [[720894, 720895], "disallowed"], [[720896, 786429], "disallowed"], [[786430, 786431], "disallowed"], [[786432, 851965], "disallowed"], [[851966, 851967], "disallowed"], [[851968, 917501], "disallowed"], [[917502, 917503], "disallowed"], [[917504, 917504], "disallowed"], [[917505, 917505], "disallowed"], [[917506, 917535], "disallowed"], [[917536, 917631], "disallowed"], [[917632, 917759], "disallowed"], [[917760, 917999], "ignored"], [[918e3, 983037], "disallowed"], [[983038, 983039], "disallowed"], [[983040, 1048573], "disallowed"], [[1048574, 1048575], "disallowed"], [[1048576, 1114109], "disallowed"], [[1114110, 1114111], "disallowed"]];
  }
});

// node_modules/tr46/index.js
var require_tr46 = __commonJS({
  "node_modules/tr46/index.js"(exports, module2) {
    "use strict";
    var punycode = require("punycode");
    var mappingTable = require_mappingTable();
    var PROCESSING_OPTIONS = {
      TRANSITIONAL: 0,
      NONTRANSITIONAL: 1
    };
    function normalize(str) {
      return str.split("\0").map(function(s) {
        return s.normalize("NFC");
      }).join("\0");
    }
    function findStatus(val) {
      var start = 0;
      var end = mappingTable.length - 1;
      while (start <= end) {
        var mid = Math.floor((start + end) / 2);
        var target = mappingTable[mid];
        if (target[0][0] <= val && target[0][1] >= val) {
          return target;
        } else if (target[0][0] > val) {
          end = mid - 1;
        } else {
          start = mid + 1;
        }
      }
      return null;
    }
    var regexAstralSymbols = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g;
    function countSymbols(string) {
      return string.replace(regexAstralSymbols, "_").length;
    }
    function mapChars(domain_name, useSTD3, processing_option) {
      var hasError = false;
      var processed = "";
      var len = countSymbols(domain_name);
      for (var i = 0; i < len; ++i) {
        var codePoint = domain_name.codePointAt(i);
        var status = findStatus(codePoint);
        switch (status[1]) {
          case "disallowed":
            hasError = true;
            processed += String.fromCodePoint(codePoint);
            break;
          case "ignored":
            break;
          case "mapped":
            processed += String.fromCodePoint.apply(String, status[2]);
            break;
          case "deviation":
            if (processing_option === PROCESSING_OPTIONS.TRANSITIONAL) {
              processed += String.fromCodePoint.apply(String, status[2]);
            } else {
              processed += String.fromCodePoint(codePoint);
            }
            break;
          case "valid":
            processed += String.fromCodePoint(codePoint);
            break;
          case "disallowed_STD3_mapped":
            if (useSTD3) {
              hasError = true;
              processed += String.fromCodePoint(codePoint);
            } else {
              processed += String.fromCodePoint.apply(String, status[2]);
            }
            break;
          case "disallowed_STD3_valid":
            if (useSTD3) {
              hasError = true;
            }
            processed += String.fromCodePoint(codePoint);
            break;
        }
      }
      return {
        string: processed,
        error: hasError
      };
    }
    var combiningMarksRegex = /[\u0300-\u036F\u0483-\u0489\u0591-\u05BD\u05BF\u05C1\u05C2\u05C4\u05C5\u05C7\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7\u06E8\u06EA-\u06ED\u0711\u0730-\u074A\u07A6-\u07B0\u07EB-\u07F3\u0816-\u0819\u081B-\u0823\u0825-\u0827\u0829-\u082D\u0859-\u085B\u08E4-\u0903\u093A-\u093C\u093E-\u094F\u0951-\u0957\u0962\u0963\u0981-\u0983\u09BC\u09BE-\u09C4\u09C7\u09C8\u09CB-\u09CD\u09D7\u09E2\u09E3\u0A01-\u0A03\u0A3C\u0A3E-\u0A42\u0A47\u0A48\u0A4B-\u0A4D\u0A51\u0A70\u0A71\u0A75\u0A81-\u0A83\u0ABC\u0ABE-\u0AC5\u0AC7-\u0AC9\u0ACB-\u0ACD\u0AE2\u0AE3\u0B01-\u0B03\u0B3C\u0B3E-\u0B44\u0B47\u0B48\u0B4B-\u0B4D\u0B56\u0B57\u0B62\u0B63\u0B82\u0BBE-\u0BC2\u0BC6-\u0BC8\u0BCA-\u0BCD\u0BD7\u0C00-\u0C03\u0C3E-\u0C44\u0C46-\u0C48\u0C4A-\u0C4D\u0C55\u0C56\u0C62\u0C63\u0C81-\u0C83\u0CBC\u0CBE-\u0CC4\u0CC6-\u0CC8\u0CCA-\u0CCD\u0CD5\u0CD6\u0CE2\u0CE3\u0D01-\u0D03\u0D3E-\u0D44\u0D46-\u0D48\u0D4A-\u0D4D\u0D57\u0D62\u0D63\u0D82\u0D83\u0DCA\u0DCF-\u0DD4\u0DD6\u0DD8-\u0DDF\u0DF2\u0DF3\u0E31\u0E34-\u0E3A\u0E47-\u0E4E\u0EB1\u0EB4-\u0EB9\u0EBB\u0EBC\u0EC8-\u0ECD\u0F18\u0F19\u0F35\u0F37\u0F39\u0F3E\u0F3F\u0F71-\u0F84\u0F86\u0F87\u0F8D-\u0F97\u0F99-\u0FBC\u0FC6\u102B-\u103E\u1056-\u1059\u105E-\u1060\u1062-\u1064\u1067-\u106D\u1071-\u1074\u1082-\u108D\u108F\u109A-\u109D\u135D-\u135F\u1712-\u1714\u1732-\u1734\u1752\u1753\u1772\u1773\u17B4-\u17D3\u17DD\u180B-\u180D\u18A9\u1920-\u192B\u1930-\u193B\u19B0-\u19C0\u19C8\u19C9\u1A17-\u1A1B\u1A55-\u1A5E\u1A60-\u1A7C\u1A7F\u1AB0-\u1ABE\u1B00-\u1B04\u1B34-\u1B44\u1B6B-\u1B73\u1B80-\u1B82\u1BA1-\u1BAD\u1BE6-\u1BF3\u1C24-\u1C37\u1CD0-\u1CD2\u1CD4-\u1CE8\u1CED\u1CF2-\u1CF4\u1CF8\u1CF9\u1DC0-\u1DF5\u1DFC-\u1DFF\u20D0-\u20F0\u2CEF-\u2CF1\u2D7F\u2DE0-\u2DFF\u302A-\u302F\u3099\u309A\uA66F-\uA672\uA674-\uA67D\uA69F\uA6F0\uA6F1\uA802\uA806\uA80B\uA823-\uA827\uA880\uA881\uA8B4-\uA8C4\uA8E0-\uA8F1\uA926-\uA92D\uA947-\uA953\uA980-\uA983\uA9B3-\uA9C0\uA9E5\uAA29-\uAA36\uAA43\uAA4C\uAA4D\uAA7B-\uAA7D\uAAB0\uAAB2-\uAAB4\uAAB7\uAAB8\uAABE\uAABF\uAAC1\uAAEB-\uAAEF\uAAF5\uAAF6\uABE3-\uABEA\uABEC\uABED\uFB1E\uFE00-\uFE0F\uFE20-\uFE2D]|\uD800[\uDDFD\uDEE0\uDF76-\uDF7A]|\uD802[\uDE01-\uDE03\uDE05\uDE06\uDE0C-\uDE0F\uDE38-\uDE3A\uDE3F\uDEE5\uDEE6]|\uD804[\uDC00-\uDC02\uDC38-\uDC46\uDC7F-\uDC82\uDCB0-\uDCBA\uDD00-\uDD02\uDD27-\uDD34\uDD73\uDD80-\uDD82\uDDB3-\uDDC0\uDE2C-\uDE37\uDEDF-\uDEEA\uDF01-\uDF03\uDF3C\uDF3E-\uDF44\uDF47\uDF48\uDF4B-\uDF4D\uDF57\uDF62\uDF63\uDF66-\uDF6C\uDF70-\uDF74]|\uD805[\uDCB0-\uDCC3\uDDAF-\uDDB5\uDDB8-\uDDC0\uDE30-\uDE40\uDEAB-\uDEB7]|\uD81A[\uDEF0-\uDEF4\uDF30-\uDF36]|\uD81B[\uDF51-\uDF7E\uDF8F-\uDF92]|\uD82F[\uDC9D\uDC9E]|\uD834[\uDD65-\uDD69\uDD6D-\uDD72\uDD7B-\uDD82\uDD85-\uDD8B\uDDAA-\uDDAD\uDE42-\uDE44]|\uD83A[\uDCD0-\uDCD6]|\uDB40[\uDD00-\uDDEF]/;
    function validateLabel(label, processing_option) {
      if (label.substr(0, 4) === "xn--") {
        label = punycode.toUnicode(label);
        processing_option = PROCESSING_OPTIONS.NONTRANSITIONAL;
      }
      var error = false;
      if (normalize(label) !== label || label[3] === "-" && label[4] === "-" || label[0] === "-" || label[label.length - 1] === "-" || label.indexOf(".") !== -1 || label.search(combiningMarksRegex) === 0) {
        error = true;
      }
      var len = countSymbols(label);
      for (var i = 0; i < len; ++i) {
        var status = findStatus(label.codePointAt(i));
        if (processing === PROCESSING_OPTIONS.TRANSITIONAL && status[1] !== "valid" || processing === PROCESSING_OPTIONS.NONTRANSITIONAL && status[1] !== "valid" && status[1] !== "deviation") {
          error = true;
          break;
        }
      }
      return {
        label,
        error
      };
    }
    function processing(domain_name, useSTD3, processing_option) {
      var result = mapChars(domain_name, useSTD3, processing_option);
      result.string = normalize(result.string);
      var labels = result.string.split(".");
      for (var i = 0; i < labels.length; ++i) {
        try {
          var validation = validateLabel(labels[i]);
          labels[i] = validation.label;
          result.error = result.error || validation.error;
        } catch (e) {
          result.error = true;
        }
      }
      return {
        string: labels.join("."),
        error: result.error
      };
    }
    module2.exports.toASCII = function(domain_name, useSTD3, processing_option, verifyDnsLength) {
      var result = processing(domain_name, useSTD3, processing_option);
      var labels = result.string.split(".");
      labels = labels.map(function(l) {
        try {
          return punycode.toASCII(l);
        } catch (e) {
          result.error = true;
          return l;
        }
      });
      if (verifyDnsLength) {
        var total = labels.slice(0, labels.length - 1).join(".").length;
        if (total.length > 253 || total.length === 0) {
          result.error = true;
        }
        for (var i = 0; i < labels.length; ++i) {
          if (labels.length > 63 || labels.length === 0) {
            result.error = true;
            break;
          }
        }
      }
      if (result.error)
        return null;
      return labels.join(".");
    };
    module2.exports.toUnicode = function(domain_name, useSTD3) {
      var result = processing(domain_name, useSTD3, PROCESSING_OPTIONS.NONTRANSITIONAL);
      return {
        domain: result.string,
        error: result.error
      };
    };
    module2.exports.PROCESSING_OPTIONS = PROCESSING_OPTIONS;
  }
});

// node_modules/whatwg-url/lib/url-state-machine.js
var require_url_state_machine = __commonJS({
  "node_modules/whatwg-url/lib/url-state-machine.js"(exports, module2) {
    "use strict";
    var punycode = require("punycode");
    var tr46 = require_tr46();
    var specialSchemes = {
      ftp: 21,
      file: null,
      gopher: 70,
      http: 80,
      https: 443,
      ws: 80,
      wss: 443
    };
    var failure = Symbol("failure");
    function countSymbols(str) {
      return punycode.ucs2.decode(str).length;
    }
    function at(input, idx) {
      const c = input[idx];
      return isNaN(c) ? void 0 : String.fromCodePoint(c);
    }
    function isASCIIDigit(c) {
      return c >= 48 && c <= 57;
    }
    function isASCIIAlpha(c) {
      return c >= 65 && c <= 90 || c >= 97 && c <= 122;
    }
    function isASCIIAlphanumeric(c) {
      return isASCIIAlpha(c) || isASCIIDigit(c);
    }
    function isASCIIHex(c) {
      return isASCIIDigit(c) || c >= 65 && c <= 70 || c >= 97 && c <= 102;
    }
    function isSingleDot(buffer) {
      return buffer === "." || buffer.toLowerCase() === "%2e";
    }
    function isDoubleDot(buffer) {
      buffer = buffer.toLowerCase();
      return buffer === ".." || buffer === "%2e." || buffer === ".%2e" || buffer === "%2e%2e";
    }
    function isWindowsDriveLetterCodePoints(cp1, cp2) {
      return isASCIIAlpha(cp1) && (cp2 === 58 || cp2 === 124);
    }
    function isWindowsDriveLetterString(string) {
      return string.length === 2 && isASCIIAlpha(string.codePointAt(0)) && (string[1] === ":" || string[1] === "|");
    }
    function isNormalizedWindowsDriveLetterString(string) {
      return string.length === 2 && isASCIIAlpha(string.codePointAt(0)) && string[1] === ":";
    }
    function containsForbiddenHostCodePoint(string) {
      return string.search(/\u0000|\u0009|\u000A|\u000D|\u0020|#|%|\/|:|\?|@|\[|\\|\]/) !== -1;
    }
    function containsForbiddenHostCodePointExcludingPercent(string) {
      return string.search(/\u0000|\u0009|\u000A|\u000D|\u0020|#|\/|:|\?|@|\[|\\|\]/) !== -1;
    }
    function isSpecialScheme(scheme) {
      return specialSchemes[scheme] !== void 0;
    }
    function isSpecial(url) {
      return isSpecialScheme(url.scheme);
    }
    function defaultPort(scheme) {
      return specialSchemes[scheme];
    }
    function percentEncode(c) {
      let hex = c.toString(16).toUpperCase();
      if (hex.length === 1) {
        hex = "0" + hex;
      }
      return "%" + hex;
    }
    function utf8PercentEncode(c) {
      const buf = new Buffer(c);
      let str = "";
      for (let i = 0; i < buf.length; ++i) {
        str += percentEncode(buf[i]);
      }
      return str;
    }
    function utf8PercentDecode(str) {
      const input = new Buffer(str);
      const output = [];
      for (let i = 0; i < input.length; ++i) {
        if (input[i] !== 37) {
          output.push(input[i]);
        } else if (input[i] === 37 && isASCIIHex(input[i + 1]) && isASCIIHex(input[i + 2])) {
          output.push(parseInt(input.slice(i + 1, i + 3).toString(), 16));
          i += 2;
        } else {
          output.push(input[i]);
        }
      }
      return new Buffer(output).toString();
    }
    function isC0ControlPercentEncode(c) {
      return c <= 31 || c > 126;
    }
    var extraPathPercentEncodeSet = /* @__PURE__ */ new Set([32, 34, 35, 60, 62, 63, 96, 123, 125]);
    function isPathPercentEncode(c) {
      return isC0ControlPercentEncode(c) || extraPathPercentEncodeSet.has(c);
    }
    var extraUserinfoPercentEncodeSet = /* @__PURE__ */ new Set([47, 58, 59, 61, 64, 91, 92, 93, 94, 124]);
    function isUserinfoPercentEncode(c) {
      return isPathPercentEncode(c) || extraUserinfoPercentEncodeSet.has(c);
    }
    function percentEncodeChar(c, encodeSetPredicate) {
      const cStr = String.fromCodePoint(c);
      if (encodeSetPredicate(c)) {
        return utf8PercentEncode(cStr);
      }
      return cStr;
    }
    function parseIPv4Number(input) {
      let R = 10;
      if (input.length >= 2 && input.charAt(0) === "0" && input.charAt(1).toLowerCase() === "x") {
        input = input.substring(2);
        R = 16;
      } else if (input.length >= 2 && input.charAt(0) === "0") {
        input = input.substring(1);
        R = 8;
      }
      if (input === "") {
        return 0;
      }
      const regex = R === 10 ? /[^0-9]/ : R === 16 ? /[^0-9A-Fa-f]/ : /[^0-7]/;
      if (regex.test(input)) {
        return failure;
      }
      return parseInt(input, R);
    }
    function parseIPv4(input) {
      const parts = input.split(".");
      if (parts[parts.length - 1] === "") {
        if (parts.length > 1) {
          parts.pop();
        }
      }
      if (parts.length > 4) {
        return input;
      }
      const numbers = [];
      for (const part of parts) {
        if (part === "") {
          return input;
        }
        const n = parseIPv4Number(part);
        if (n === failure) {
          return input;
        }
        numbers.push(n);
      }
      for (let i = 0; i < numbers.length - 1; ++i) {
        if (numbers[i] > 255) {
          return failure;
        }
      }
      if (numbers[numbers.length - 1] >= Math.pow(256, 5 - numbers.length)) {
        return failure;
      }
      let ipv4 = numbers.pop();
      let counter = 0;
      for (const n of numbers) {
        ipv4 += n * Math.pow(256, 3 - counter);
        ++counter;
      }
      return ipv4;
    }
    function serializeIPv4(address) {
      let output = "";
      let n = address;
      for (let i = 1; i <= 4; ++i) {
        output = String(n % 256) + output;
        if (i !== 4) {
          output = "." + output;
        }
        n = Math.floor(n / 256);
      }
      return output;
    }
    function parseIPv6(input) {
      const address = [0, 0, 0, 0, 0, 0, 0, 0];
      let pieceIndex = 0;
      let compress = null;
      let pointer = 0;
      input = punycode.ucs2.decode(input);
      if (input[pointer] === 58) {
        if (input[pointer + 1] !== 58) {
          return failure;
        }
        pointer += 2;
        ++pieceIndex;
        compress = pieceIndex;
      }
      while (pointer < input.length) {
        if (pieceIndex === 8) {
          return failure;
        }
        if (input[pointer] === 58) {
          if (compress !== null) {
            return failure;
          }
          ++pointer;
          ++pieceIndex;
          compress = pieceIndex;
          continue;
        }
        let value = 0;
        let length = 0;
        while (length < 4 && isASCIIHex(input[pointer])) {
          value = value * 16 + parseInt(at(input, pointer), 16);
          ++pointer;
          ++length;
        }
        if (input[pointer] === 46) {
          if (length === 0) {
            return failure;
          }
          pointer -= length;
          if (pieceIndex > 6) {
            return failure;
          }
          let numbersSeen = 0;
          while (input[pointer] !== void 0) {
            let ipv4Piece = null;
            if (numbersSeen > 0) {
              if (input[pointer] === 46 && numbersSeen < 4) {
                ++pointer;
              } else {
                return failure;
              }
            }
            if (!isASCIIDigit(input[pointer])) {
              return failure;
            }
            while (isASCIIDigit(input[pointer])) {
              const number = parseInt(at(input, pointer));
              if (ipv4Piece === null) {
                ipv4Piece = number;
              } else if (ipv4Piece === 0) {
                return failure;
              } else {
                ipv4Piece = ipv4Piece * 10 + number;
              }
              if (ipv4Piece > 255) {
                return failure;
              }
              ++pointer;
            }
            address[pieceIndex] = address[pieceIndex] * 256 + ipv4Piece;
            ++numbersSeen;
            if (numbersSeen === 2 || numbersSeen === 4) {
              ++pieceIndex;
            }
          }
          if (numbersSeen !== 4) {
            return failure;
          }
          break;
        } else if (input[pointer] === 58) {
          ++pointer;
          if (input[pointer] === void 0) {
            return failure;
          }
        } else if (input[pointer] !== void 0) {
          return failure;
        }
        address[pieceIndex] = value;
        ++pieceIndex;
      }
      if (compress !== null) {
        let swaps = pieceIndex - compress;
        pieceIndex = 7;
        while (pieceIndex !== 0 && swaps > 0) {
          const temp = address[compress + swaps - 1];
          address[compress + swaps - 1] = address[pieceIndex];
          address[pieceIndex] = temp;
          --pieceIndex;
          --swaps;
        }
      } else if (compress === null && pieceIndex !== 8) {
        return failure;
      }
      return address;
    }
    function serializeIPv6(address) {
      let output = "";
      const seqResult = findLongestZeroSequence(address);
      const compress = seqResult.idx;
      let ignore0 = false;
      for (let pieceIndex = 0; pieceIndex <= 7; ++pieceIndex) {
        if (ignore0 && address[pieceIndex] === 0) {
          continue;
        } else if (ignore0) {
          ignore0 = false;
        }
        if (compress === pieceIndex) {
          const separator = pieceIndex === 0 ? "::" : ":";
          output += separator;
          ignore0 = true;
          continue;
        }
        output += address[pieceIndex].toString(16);
        if (pieceIndex !== 7) {
          output += ":";
        }
      }
      return output;
    }
    function parseHost(input, isSpecialArg) {
      if (input[0] === "[") {
        if (input[input.length - 1] !== "]") {
          return failure;
        }
        return parseIPv6(input.substring(1, input.length - 1));
      }
      if (!isSpecialArg) {
        return parseOpaqueHost(input);
      }
      const domain = utf8PercentDecode(input);
      const asciiDomain = tr46.toASCII(domain, false, tr46.PROCESSING_OPTIONS.NONTRANSITIONAL, false);
      if (asciiDomain === null) {
        return failure;
      }
      if (containsForbiddenHostCodePoint(asciiDomain)) {
        return failure;
      }
      const ipv4Host = parseIPv4(asciiDomain);
      if (typeof ipv4Host === "number" || ipv4Host === failure) {
        return ipv4Host;
      }
      return asciiDomain;
    }
    function parseOpaqueHost(input) {
      if (containsForbiddenHostCodePointExcludingPercent(input)) {
        return failure;
      }
      let output = "";
      const decoded = punycode.ucs2.decode(input);
      for (let i = 0; i < decoded.length; ++i) {
        output += percentEncodeChar(decoded[i], isC0ControlPercentEncode);
      }
      return output;
    }
    function findLongestZeroSequence(arr) {
      let maxIdx = null;
      let maxLen = 1;
      let currStart = null;
      let currLen = 0;
      for (let i = 0; i < arr.length; ++i) {
        if (arr[i] !== 0) {
          if (currLen > maxLen) {
            maxIdx = currStart;
            maxLen = currLen;
          }
          currStart = null;
          currLen = 0;
        } else {
          if (currStart === null) {
            currStart = i;
          }
          ++currLen;
        }
      }
      if (currLen > maxLen) {
        maxIdx = currStart;
        maxLen = currLen;
      }
      return {
        idx: maxIdx,
        len: maxLen
      };
    }
    function serializeHost(host) {
      if (typeof host === "number") {
        return serializeIPv4(host);
      }
      if (host instanceof Array) {
        return "[" + serializeIPv6(host) + "]";
      }
      return host;
    }
    function trimControlChars(url) {
      return url.replace(/^[\u0000-\u001F\u0020]+|[\u0000-\u001F\u0020]+$/g, "");
    }
    function trimTabAndNewline(url) {
      return url.replace(/\u0009|\u000A|\u000D/g, "");
    }
    function shortenPath(url) {
      const path = url.path;
      if (path.length === 0) {
        return;
      }
      if (url.scheme === "file" && path.length === 1 && isNormalizedWindowsDriveLetter(path[0])) {
        return;
      }
      path.pop();
    }
    function includesCredentials(url) {
      return url.username !== "" || url.password !== "";
    }
    function cannotHaveAUsernamePasswordPort(url) {
      return url.host === null || url.host === "" || url.cannotBeABaseURL || url.scheme === "file";
    }
    function isNormalizedWindowsDriveLetter(string) {
      return /^[A-Za-z]:$/.test(string);
    }
    function URLStateMachine(input, base, encodingOverride, url, stateOverride) {
      this.pointer = 0;
      this.input = input;
      this.base = base || null;
      this.encodingOverride = encodingOverride || "utf-8";
      this.stateOverride = stateOverride;
      this.url = url;
      this.failure = false;
      this.parseError = false;
      if (!this.url) {
        this.url = {
          scheme: "",
          username: "",
          password: "",
          host: null,
          port: null,
          path: [],
          query: null,
          fragment: null,
          cannotBeABaseURL: false
        };
        const res2 = trimControlChars(this.input);
        if (res2 !== this.input) {
          this.parseError = true;
        }
        this.input = res2;
      }
      const res = trimTabAndNewline(this.input);
      if (res !== this.input) {
        this.parseError = true;
      }
      this.input = res;
      this.state = stateOverride || "scheme start";
      this.buffer = "";
      this.atFlag = false;
      this.arrFlag = false;
      this.passwordTokenSeenFlag = false;
      this.input = punycode.ucs2.decode(this.input);
      for (; this.pointer <= this.input.length; ++this.pointer) {
        const c = this.input[this.pointer];
        const cStr = isNaN(c) ? void 0 : String.fromCodePoint(c);
        const ret = this["parse " + this.state](c, cStr);
        if (!ret) {
          break;
        } else if (ret === failure) {
          this.failure = true;
          break;
        }
      }
    }
    URLStateMachine.prototype["parse scheme start"] = function parseSchemeStart(c, cStr) {
      if (isASCIIAlpha(c)) {
        this.buffer += cStr.toLowerCase();
        this.state = "scheme";
      } else if (!this.stateOverride) {
        this.state = "no scheme";
        --this.pointer;
      } else {
        this.parseError = true;
        return failure;
      }
      return true;
    };
    URLStateMachine.prototype["parse scheme"] = function parseScheme(c, cStr) {
      if (isASCIIAlphanumeric(c) || c === 43 || c === 45 || c === 46) {
        this.buffer += cStr.toLowerCase();
      } else if (c === 58) {
        if (this.stateOverride) {
          if (isSpecial(this.url) && !isSpecialScheme(this.buffer)) {
            return false;
          }
          if (!isSpecial(this.url) && isSpecialScheme(this.buffer)) {
            return false;
          }
          if ((includesCredentials(this.url) || this.url.port !== null) && this.buffer === "file") {
            return false;
          }
          if (this.url.scheme === "file" && (this.url.host === "" || this.url.host === null)) {
            return false;
          }
        }
        this.url.scheme = this.buffer;
        this.buffer = "";
        if (this.stateOverride) {
          return false;
        }
        if (this.url.scheme === "file") {
          if (this.input[this.pointer + 1] !== 47 || this.input[this.pointer + 2] !== 47) {
            this.parseError = true;
          }
          this.state = "file";
        } else if (isSpecial(this.url) && this.base !== null && this.base.scheme === this.url.scheme) {
          this.state = "special relative or authority";
        } else if (isSpecial(this.url)) {
          this.state = "special authority slashes";
        } else if (this.input[this.pointer + 1] === 47) {
          this.state = "path or authority";
          ++this.pointer;
        } else {
          this.url.cannotBeABaseURL = true;
          this.url.path.push("");
          this.state = "cannot-be-a-base-URL path";
        }
      } else if (!this.stateOverride) {
        this.buffer = "";
        this.state = "no scheme";
        this.pointer = -1;
      } else {
        this.parseError = true;
        return failure;
      }
      return true;
    };
    URLStateMachine.prototype["parse no scheme"] = function parseNoScheme(c) {
      if (this.base === null || this.base.cannotBeABaseURL && c !== 35) {
        return failure;
      } else if (this.base.cannotBeABaseURL && c === 35) {
        this.url.scheme = this.base.scheme;
        this.url.path = this.base.path.slice();
        this.url.query = this.base.query;
        this.url.fragment = "";
        this.url.cannotBeABaseURL = true;
        this.state = "fragment";
      } else if (this.base.scheme === "file") {
        this.state = "file";
        --this.pointer;
      } else {
        this.state = "relative";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse special relative or authority"] = function parseSpecialRelativeOrAuthority(c) {
      if (c === 47 && this.input[this.pointer + 1] === 47) {
        this.state = "special authority ignore slashes";
        ++this.pointer;
      } else {
        this.parseError = true;
        this.state = "relative";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse path or authority"] = function parsePathOrAuthority(c) {
      if (c === 47) {
        this.state = "authority";
      } else {
        this.state = "path";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse relative"] = function parseRelative(c) {
      this.url.scheme = this.base.scheme;
      if (isNaN(c)) {
        this.url.username = this.base.username;
        this.url.password = this.base.password;
        this.url.host = this.base.host;
        this.url.port = this.base.port;
        this.url.path = this.base.path.slice();
        this.url.query = this.base.query;
      } else if (c === 47) {
        this.state = "relative slash";
      } else if (c === 63) {
        this.url.username = this.base.username;
        this.url.password = this.base.password;
        this.url.host = this.base.host;
        this.url.port = this.base.port;
        this.url.path = this.base.path.slice();
        this.url.query = "";
        this.state = "query";
      } else if (c === 35) {
        this.url.username = this.base.username;
        this.url.password = this.base.password;
        this.url.host = this.base.host;
        this.url.port = this.base.port;
        this.url.path = this.base.path.slice();
        this.url.query = this.base.query;
        this.url.fragment = "";
        this.state = "fragment";
      } else if (isSpecial(this.url) && c === 92) {
        this.parseError = true;
        this.state = "relative slash";
      } else {
        this.url.username = this.base.username;
        this.url.password = this.base.password;
        this.url.host = this.base.host;
        this.url.port = this.base.port;
        this.url.path = this.base.path.slice(0, this.base.path.length - 1);
        this.state = "path";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse relative slash"] = function parseRelativeSlash(c) {
      if (isSpecial(this.url) && (c === 47 || c === 92)) {
        if (c === 92) {
          this.parseError = true;
        }
        this.state = "special authority ignore slashes";
      } else if (c === 47) {
        this.state = "authority";
      } else {
        this.url.username = this.base.username;
        this.url.password = this.base.password;
        this.url.host = this.base.host;
        this.url.port = this.base.port;
        this.state = "path";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse special authority slashes"] = function parseSpecialAuthoritySlashes(c) {
      if (c === 47 && this.input[this.pointer + 1] === 47) {
        this.state = "special authority ignore slashes";
        ++this.pointer;
      } else {
        this.parseError = true;
        this.state = "special authority ignore slashes";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse special authority ignore slashes"] = function parseSpecialAuthorityIgnoreSlashes(c) {
      if (c !== 47 && c !== 92) {
        this.state = "authority";
        --this.pointer;
      } else {
        this.parseError = true;
      }
      return true;
    };
    URLStateMachine.prototype["parse authority"] = function parseAuthority(c, cStr) {
      if (c === 64) {
        this.parseError = true;
        if (this.atFlag) {
          this.buffer = "%40" + this.buffer;
        }
        this.atFlag = true;
        const len = countSymbols(this.buffer);
        for (let pointer = 0; pointer < len; ++pointer) {
          const codePoint = this.buffer.codePointAt(pointer);
          if (codePoint === 58 && !this.passwordTokenSeenFlag) {
            this.passwordTokenSeenFlag = true;
            continue;
          }
          const encodedCodePoints = percentEncodeChar(codePoint, isUserinfoPercentEncode);
          if (this.passwordTokenSeenFlag) {
            this.url.password += encodedCodePoints;
          } else {
            this.url.username += encodedCodePoints;
          }
        }
        this.buffer = "";
      } else if (isNaN(c) || c === 47 || c === 63 || c === 35 || isSpecial(this.url) && c === 92) {
        if (this.atFlag && this.buffer === "") {
          this.parseError = true;
          return failure;
        }
        this.pointer -= countSymbols(this.buffer) + 1;
        this.buffer = "";
        this.state = "host";
      } else {
        this.buffer += cStr;
      }
      return true;
    };
    URLStateMachine.prototype["parse hostname"] = URLStateMachine.prototype["parse host"] = function parseHostName(c, cStr) {
      if (this.stateOverride && this.url.scheme === "file") {
        --this.pointer;
        this.state = "file host";
      } else if (c === 58 && !this.arrFlag) {
        if (this.buffer === "") {
          this.parseError = true;
          return failure;
        }
        const host = parseHost(this.buffer, isSpecial(this.url));
        if (host === failure) {
          return failure;
        }
        this.url.host = host;
        this.buffer = "";
        this.state = "port";
        if (this.stateOverride === "hostname") {
          return false;
        }
      } else if (isNaN(c) || c === 47 || c === 63 || c === 35 || isSpecial(this.url) && c === 92) {
        --this.pointer;
        if (isSpecial(this.url) && this.buffer === "") {
          this.parseError = true;
          return failure;
        } else if (this.stateOverride && this.buffer === "" && (includesCredentials(this.url) || this.url.port !== null)) {
          this.parseError = true;
          return false;
        }
        const host = parseHost(this.buffer, isSpecial(this.url));
        if (host === failure) {
          return failure;
        }
        this.url.host = host;
        this.buffer = "";
        this.state = "path start";
        if (this.stateOverride) {
          return false;
        }
      } else {
        if (c === 91) {
          this.arrFlag = true;
        } else if (c === 93) {
          this.arrFlag = false;
        }
        this.buffer += cStr;
      }
      return true;
    };
    URLStateMachine.prototype["parse port"] = function parsePort(c, cStr) {
      if (isASCIIDigit(c)) {
        this.buffer += cStr;
      } else if (isNaN(c) || c === 47 || c === 63 || c === 35 || isSpecial(this.url) && c === 92 || this.stateOverride) {
        if (this.buffer !== "") {
          const port = parseInt(this.buffer);
          if (port > Math.pow(2, 16) - 1) {
            this.parseError = true;
            return failure;
          }
          this.url.port = port === defaultPort(this.url.scheme) ? null : port;
          this.buffer = "";
        }
        if (this.stateOverride) {
          return false;
        }
        this.state = "path start";
        --this.pointer;
      } else {
        this.parseError = true;
        return failure;
      }
      return true;
    };
    var fileOtherwiseCodePoints = /* @__PURE__ */ new Set([47, 92, 63, 35]);
    URLStateMachine.prototype["parse file"] = function parseFile(c) {
      this.url.scheme = "file";
      if (c === 47 || c === 92) {
        if (c === 92) {
          this.parseError = true;
        }
        this.state = "file slash";
      } else if (this.base !== null && this.base.scheme === "file") {
        if (isNaN(c)) {
          this.url.host = this.base.host;
          this.url.path = this.base.path.slice();
          this.url.query = this.base.query;
        } else if (c === 63) {
          this.url.host = this.base.host;
          this.url.path = this.base.path.slice();
          this.url.query = "";
          this.state = "query";
        } else if (c === 35) {
          this.url.host = this.base.host;
          this.url.path = this.base.path.slice();
          this.url.query = this.base.query;
          this.url.fragment = "";
          this.state = "fragment";
        } else {
          if (this.input.length - this.pointer - 1 === 0 || !isWindowsDriveLetterCodePoints(c, this.input[this.pointer + 1]) || this.input.length - this.pointer - 1 >= 2 && !fileOtherwiseCodePoints.has(this.input[this.pointer + 2])) {
            this.url.host = this.base.host;
            this.url.path = this.base.path.slice();
            shortenPath(this.url);
          } else {
            this.parseError = true;
          }
          this.state = "path";
          --this.pointer;
        }
      } else {
        this.state = "path";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse file slash"] = function parseFileSlash(c) {
      if (c === 47 || c === 92) {
        if (c === 92) {
          this.parseError = true;
        }
        this.state = "file host";
      } else {
        if (this.base !== null && this.base.scheme === "file") {
          if (isNormalizedWindowsDriveLetterString(this.base.path[0])) {
            this.url.path.push(this.base.path[0]);
          } else {
            this.url.host = this.base.host;
          }
        }
        this.state = "path";
        --this.pointer;
      }
      return true;
    };
    URLStateMachine.prototype["parse file host"] = function parseFileHost(c, cStr) {
      if (isNaN(c) || c === 47 || c === 92 || c === 63 || c === 35) {
        --this.pointer;
        if (!this.stateOverride && isWindowsDriveLetterString(this.buffer)) {
          this.parseError = true;
          this.state = "path";
        } else if (this.buffer === "") {
          this.url.host = "";
          if (this.stateOverride) {
            return false;
          }
          this.state = "path start";
        } else {
          let host = parseHost(this.buffer, isSpecial(this.url));
          if (host === failure) {
            return failure;
          }
          if (host === "localhost") {
            host = "";
          }
          this.url.host = host;
          if (this.stateOverride) {
            return false;
          }
          this.buffer = "";
          this.state = "path start";
        }
      } else {
        this.buffer += cStr;
      }
      return true;
    };
    URLStateMachine.prototype["parse path start"] = function parsePathStart(c) {
      if (isSpecial(this.url)) {
        if (c === 92) {
          this.parseError = true;
        }
        this.state = "path";
        if (c !== 47 && c !== 92) {
          --this.pointer;
        }
      } else if (!this.stateOverride && c === 63) {
        this.url.query = "";
        this.state = "query";
      } else if (!this.stateOverride && c === 35) {
        this.url.fragment = "";
        this.state = "fragment";
      } else if (c !== void 0) {
        this.state = "path";
        if (c !== 47) {
          --this.pointer;
        }
      }
      return true;
    };
    URLStateMachine.prototype["parse path"] = function parsePath(c) {
      if (isNaN(c) || c === 47 || isSpecial(this.url) && c === 92 || !this.stateOverride && (c === 63 || c === 35)) {
        if (isSpecial(this.url) && c === 92) {
          this.parseError = true;
        }
        if (isDoubleDot(this.buffer)) {
          shortenPath(this.url);
          if (c !== 47 && !(isSpecial(this.url) && c === 92)) {
            this.url.path.push("");
          }
        } else if (isSingleDot(this.buffer) && c !== 47 && !(isSpecial(this.url) && c === 92)) {
          this.url.path.push("");
        } else if (!isSingleDot(this.buffer)) {
          if (this.url.scheme === "file" && this.url.path.length === 0 && isWindowsDriveLetterString(this.buffer)) {
            if (this.url.host !== "" && this.url.host !== null) {
              this.parseError = true;
              this.url.host = "";
            }
            this.buffer = this.buffer[0] + ":";
          }
          this.url.path.push(this.buffer);
        }
        this.buffer = "";
        if (this.url.scheme === "file" && (c === void 0 || c === 63 || c === 35)) {
          while (this.url.path.length > 1 && this.url.path[0] === "") {
            this.parseError = true;
            this.url.path.shift();
          }
        }
        if (c === 63) {
          this.url.query = "";
          this.state = "query";
        }
        if (c === 35) {
          this.url.fragment = "";
          this.state = "fragment";
        }
      } else {
        if (c === 37 && (!isASCIIHex(this.input[this.pointer + 1]) || !isASCIIHex(this.input[this.pointer + 2]))) {
          this.parseError = true;
        }
        this.buffer += percentEncodeChar(c, isPathPercentEncode);
      }
      return true;
    };
    URLStateMachine.prototype["parse cannot-be-a-base-URL path"] = function parseCannotBeABaseURLPath(c) {
      if (c === 63) {
        this.url.query = "";
        this.state = "query";
      } else if (c === 35) {
        this.url.fragment = "";
        this.state = "fragment";
      } else {
        if (!isNaN(c) && c !== 37) {
          this.parseError = true;
        }
        if (c === 37 && (!isASCIIHex(this.input[this.pointer + 1]) || !isASCIIHex(this.input[this.pointer + 2]))) {
          this.parseError = true;
        }
        if (!isNaN(c)) {
          this.url.path[0] = this.url.path[0] + percentEncodeChar(c, isC0ControlPercentEncode);
        }
      }
      return true;
    };
    URLStateMachine.prototype["parse query"] = function parseQuery(c, cStr) {
      if (isNaN(c) || !this.stateOverride && c === 35) {
        if (!isSpecial(this.url) || this.url.scheme === "ws" || this.url.scheme === "wss") {
          this.encodingOverride = "utf-8";
        }
        const buffer = new Buffer(this.buffer);
        for (let i = 0; i < buffer.length; ++i) {
          if (buffer[i] < 33 || buffer[i] > 126 || buffer[i] === 34 || buffer[i] === 35 || buffer[i] === 60 || buffer[i] === 62) {
            this.url.query += percentEncode(buffer[i]);
          } else {
            this.url.query += String.fromCodePoint(buffer[i]);
          }
        }
        this.buffer = "";
        if (c === 35) {
          this.url.fragment = "";
          this.state = "fragment";
        }
      } else {
        if (c === 37 && (!isASCIIHex(this.input[this.pointer + 1]) || !isASCIIHex(this.input[this.pointer + 2]))) {
          this.parseError = true;
        }
        this.buffer += cStr;
      }
      return true;
    };
    URLStateMachine.prototype["parse fragment"] = function parseFragment(c) {
      if (isNaN(c)) {
      } else if (c === 0) {
        this.parseError = true;
      } else {
        if (c === 37 && (!isASCIIHex(this.input[this.pointer + 1]) || !isASCIIHex(this.input[this.pointer + 2]))) {
          this.parseError = true;
        }
        this.url.fragment += percentEncodeChar(c, isC0ControlPercentEncode);
      }
      return true;
    };
    function serializeURL(url, excludeFragment) {
      let output = url.scheme + ":";
      if (url.host !== null) {
        output += "//";
        if (url.username !== "" || url.password !== "") {
          output += url.username;
          if (url.password !== "") {
            output += ":" + url.password;
          }
          output += "@";
        }
        output += serializeHost(url.host);
        if (url.port !== null) {
          output += ":" + url.port;
        }
      } else if (url.host === null && url.scheme === "file") {
        output += "//";
      }
      if (url.cannotBeABaseURL) {
        output += url.path[0];
      } else {
        for (const string of url.path) {
          output += "/" + string;
        }
      }
      if (url.query !== null) {
        output += "?" + url.query;
      }
      if (!excludeFragment && url.fragment !== null) {
        output += "#" + url.fragment;
      }
      return output;
    }
    function serializeOrigin(tuple) {
      let result = tuple.scheme + "://";
      result += serializeHost(tuple.host);
      if (tuple.port !== null) {
        result += ":" + tuple.port;
      }
      return result;
    }
    module2.exports.serializeURL = serializeURL;
    module2.exports.serializeURLOrigin = function(url) {
      switch (url.scheme) {
        case "blob":
          try {
            return module2.exports.serializeURLOrigin(module2.exports.parseURL(url.path[0]));
          } catch (e) {
            return "null";
          }
        case "ftp":
        case "gopher":
        case "http":
        case "https":
        case "ws":
        case "wss":
          return serializeOrigin({
            scheme: url.scheme,
            host: url.host,
            port: url.port
          });
        case "file":
          return "file://";
        default:
          return "null";
      }
    };
    module2.exports.basicURLParse = function(input, options) {
      if (options === void 0) {
        options = {};
      }
      const usm = new URLStateMachine(input, options.baseURL, options.encodingOverride, options.url, options.stateOverride);
      if (usm.failure) {
        return "failure";
      }
      return usm.url;
    };
    module2.exports.setTheUsername = function(url, username) {
      url.username = "";
      const decoded = punycode.ucs2.decode(username);
      for (let i = 0; i < decoded.length; ++i) {
        url.username += percentEncodeChar(decoded[i], isUserinfoPercentEncode);
      }
    };
    module2.exports.setThePassword = function(url, password) {
      url.password = "";
      const decoded = punycode.ucs2.decode(password);
      for (let i = 0; i < decoded.length; ++i) {
        url.password += percentEncodeChar(decoded[i], isUserinfoPercentEncode);
      }
    };
    module2.exports.serializeHost = serializeHost;
    module2.exports.cannotHaveAUsernamePasswordPort = cannotHaveAUsernamePasswordPort;
    module2.exports.serializeInteger = function(integer) {
      return String(integer);
    };
    module2.exports.parseURL = function(input, options) {
      if (options === void 0) {
        options = {};
      }
      return module2.exports.basicURLParse(input, { baseURL: options.baseURL, encodingOverride: options.encodingOverride });
    };
  }
});

// node_modules/whatwg-url/lib/URL-impl.js
var require_URL_impl = __commonJS({
  "node_modules/whatwg-url/lib/URL-impl.js"(exports) {
    "use strict";
    var usm = require_url_state_machine();
    exports.implementation = class URLImpl {
      constructor(constructorArgs) {
        const url = constructorArgs[0];
        const base = constructorArgs[1];
        let parsedBase = null;
        if (base !== void 0) {
          parsedBase = usm.basicURLParse(base);
          if (parsedBase === "failure") {
            throw new TypeError("Invalid base URL");
          }
        }
        const parsedURL = usm.basicURLParse(url, { baseURL: parsedBase });
        if (parsedURL === "failure") {
          throw new TypeError("Invalid URL");
        }
        this._url = parsedURL;
      }
      get href() {
        return usm.serializeURL(this._url);
      }
      set href(v) {
        const parsedURL = usm.basicURLParse(v);
        if (parsedURL === "failure") {
          throw new TypeError("Invalid URL");
        }
        this._url = parsedURL;
      }
      get origin() {
        return usm.serializeURLOrigin(this._url);
      }
      get protocol() {
        return this._url.scheme + ":";
      }
      set protocol(v) {
        usm.basicURLParse(v + ":", { url: this._url, stateOverride: "scheme start" });
      }
      get username() {
        return this._url.username;
      }
      set username(v) {
        if (usm.cannotHaveAUsernamePasswordPort(this._url)) {
          return;
        }
        usm.setTheUsername(this._url, v);
      }
      get password() {
        return this._url.password;
      }
      set password(v) {
        if (usm.cannotHaveAUsernamePasswordPort(this._url)) {
          return;
        }
        usm.setThePassword(this._url, v);
      }
      get host() {
        const url = this._url;
        if (url.host === null) {
          return "";
        }
        if (url.port === null) {
          return usm.serializeHost(url.host);
        }
        return usm.serializeHost(url.host) + ":" + usm.serializeInteger(url.port);
      }
      set host(v) {
        if (this._url.cannotBeABaseURL) {
          return;
        }
        usm.basicURLParse(v, { url: this._url, stateOverride: "host" });
      }
      get hostname() {
        if (this._url.host === null) {
          return "";
        }
        return usm.serializeHost(this._url.host);
      }
      set hostname(v) {
        if (this._url.cannotBeABaseURL) {
          return;
        }
        usm.basicURLParse(v, { url: this._url, stateOverride: "hostname" });
      }
      get port() {
        if (this._url.port === null) {
          return "";
        }
        return usm.serializeInteger(this._url.port);
      }
      set port(v) {
        if (usm.cannotHaveAUsernamePasswordPort(this._url)) {
          return;
        }
        if (v === "") {
          this._url.port = null;
        } else {
          usm.basicURLParse(v, { url: this._url, stateOverride: "port" });
        }
      }
      get pathname() {
        if (this._url.cannotBeABaseURL) {
          return this._url.path[0];
        }
        if (this._url.path.length === 0) {
          return "";
        }
        return "/" + this._url.path.join("/");
      }
      set pathname(v) {
        if (this._url.cannotBeABaseURL) {
          return;
        }
        this._url.path = [];
        usm.basicURLParse(v, { url: this._url, stateOverride: "path start" });
      }
      get search() {
        if (this._url.query === null || this._url.query === "") {
          return "";
        }
        return "?" + this._url.query;
      }
      set search(v) {
        const url = this._url;
        if (v === "") {
          url.query = null;
          return;
        }
        const input = v[0] === "?" ? v.substring(1) : v;
        url.query = "";
        usm.basicURLParse(input, { url, stateOverride: "query" });
      }
      get hash() {
        if (this._url.fragment === null || this._url.fragment === "") {
          return "";
        }
        return "#" + this._url.fragment;
      }
      set hash(v) {
        if (v === "") {
          this._url.fragment = null;
          return;
        }
        const input = v[0] === "#" ? v.substring(1) : v;
        this._url.fragment = "";
        usm.basicURLParse(input, { url: this._url, stateOverride: "fragment" });
      }
      toJSON() {
        return this.href;
      }
    };
  }
});

// node_modules/whatwg-url/lib/URL.js
var require_URL = __commonJS({
  "node_modules/whatwg-url/lib/URL.js"(exports, module2) {
    "use strict";
    var conversions = require_lib();
    var utils = require_utils();
    var Impl = require_URL_impl();
    var impl = utils.implSymbol;
    function URL2(url) {
      if (!this || this[impl] || !(this instanceof URL2)) {
        throw new TypeError("Failed to construct 'URL': Please use the 'new' operator, this DOM object constructor cannot be called as a function.");
      }
      if (arguments.length < 1) {
        throw new TypeError("Failed to construct 'URL': 1 argument required, but only " + arguments.length + " present.");
      }
      const args = [];
      for (let i = 0; i < arguments.length && i < 2; ++i) {
        args[i] = arguments[i];
      }
      args[0] = conversions["USVString"](args[0]);
      if (args[1] !== void 0) {
        args[1] = conversions["USVString"](args[1]);
      }
      module2.exports.setup(this, args);
    }
    URL2.prototype.toJSON = function toJSON() {
      if (!this || !module2.exports.is(this)) {
        throw new TypeError("Illegal invocation");
      }
      const args = [];
      for (let i = 0; i < arguments.length && i < 0; ++i) {
        args[i] = arguments[i];
      }
      return this[impl].toJSON.apply(this[impl], args);
    };
    Object.defineProperty(URL2.prototype, "href", {
      get() {
        return this[impl].href;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].href = V;
      },
      enumerable: true,
      configurable: true
    });
    URL2.prototype.toString = function() {
      if (!this || !module2.exports.is(this)) {
        throw new TypeError("Illegal invocation");
      }
      return this.href;
    };
    Object.defineProperty(URL2.prototype, "origin", {
      get() {
        return this[impl].origin;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "protocol", {
      get() {
        return this[impl].protocol;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].protocol = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "username", {
      get() {
        return this[impl].username;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].username = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "password", {
      get() {
        return this[impl].password;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].password = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "host", {
      get() {
        return this[impl].host;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].host = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "hostname", {
      get() {
        return this[impl].hostname;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].hostname = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "port", {
      get() {
        return this[impl].port;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].port = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "pathname", {
      get() {
        return this[impl].pathname;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].pathname = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "search", {
      get() {
        return this[impl].search;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].search = V;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(URL2.prototype, "hash", {
      get() {
        return this[impl].hash;
      },
      set(V) {
        V = conversions["USVString"](V);
        this[impl].hash = V;
      },
      enumerable: true,
      configurable: true
    });
    module2.exports = {
      is(obj) {
        return !!obj && obj[impl] instanceof Impl.implementation;
      },
      create(constructorArgs, privateData) {
        let obj = Object.create(URL2.prototype);
        this.setup(obj, constructorArgs, privateData);
        return obj;
      },
      setup(obj, constructorArgs, privateData) {
        if (!privateData)
          privateData = {};
        privateData.wrapper = obj;
        obj[impl] = new Impl.implementation(constructorArgs, privateData);
        obj[impl][utils.wrapperSymbol] = obj;
      },
      interface: URL2,
      expose: {
        Window: { URL: URL2 },
        Worker: { URL: URL2 }
      }
    };
  }
});

// node_modules/whatwg-url/lib/public-api.js
var require_public_api = __commonJS({
  "node_modules/whatwg-url/lib/public-api.js"(exports) {
    "use strict";
    exports.URL = require_URL().interface;
    exports.serializeURL = require_url_state_machine().serializeURL;
    exports.serializeURLOrigin = require_url_state_machine().serializeURLOrigin;
    exports.basicURLParse = require_url_state_machine().basicURLParse;
    exports.setTheUsername = require_url_state_machine().setTheUsername;
    exports.setThePassword = require_url_state_machine().setThePassword;
    exports.serializeHost = require_url_state_machine().serializeHost;
    exports.serializeInteger = require_url_state_machine().serializeInteger;
    exports.parseURL = require_url_state_machine().parseURL;
  }
});

// node_modules/node-fetch/lib/index.js
var require_lib2 = __commonJS({
  "node_modules/node-fetch/lib/index.js"(exports, module2) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    function _interopDefault(ex) {
      return ex && typeof ex === "object" && "default" in ex ? ex["default"] : ex;
    }
    var Stream = _interopDefault(require("stream"));
    var http = _interopDefault(require("http"));
    var Url = _interopDefault(require("url"));
    var whatwgUrl = _interopDefault(require_public_api());
    var https = _interopDefault(require("https"));
    var zlib = _interopDefault(require("zlib"));
    var Readable = Stream.Readable;
    var BUFFER = Symbol("buffer");
    var TYPE = Symbol("type");
    var Blob = class {
      constructor() {
        this[TYPE] = "";
        const blobParts = arguments[0];
        const options = arguments[1];
        const buffers = [];
        let size = 0;
        if (blobParts) {
          const a = blobParts;
          const length = Number(a.length);
          for (let i = 0; i < length; i++) {
            const element = a[i];
            let buffer;
            if (element instanceof Buffer) {
              buffer = element;
            } else if (ArrayBuffer.isView(element)) {
              buffer = Buffer.from(element.buffer, element.byteOffset, element.byteLength);
            } else if (element instanceof ArrayBuffer) {
              buffer = Buffer.from(element);
            } else if (element instanceof Blob) {
              buffer = element[BUFFER];
            } else {
              buffer = Buffer.from(typeof element === "string" ? element : String(element));
            }
            size += buffer.length;
            buffers.push(buffer);
          }
        }
        this[BUFFER] = Buffer.concat(buffers);
        let type = options && options.type !== void 0 && String(options.type).toLowerCase();
        if (type && !/[^\u0020-\u007E]/.test(type)) {
          this[TYPE] = type;
        }
      }
      get size() {
        return this[BUFFER].length;
      }
      get type() {
        return this[TYPE];
      }
      text() {
        return Promise.resolve(this[BUFFER].toString());
      }
      arrayBuffer() {
        const buf = this[BUFFER];
        const ab = buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
        return Promise.resolve(ab);
      }
      stream() {
        const readable = new Readable();
        readable._read = function() {
        };
        readable.push(this[BUFFER]);
        readable.push(null);
        return readable;
      }
      toString() {
        return "[object Blob]";
      }
      slice() {
        const size = this.size;
        const start = arguments[0];
        const end = arguments[1];
        let relativeStart, relativeEnd;
        if (start === void 0) {
          relativeStart = 0;
        } else if (start < 0) {
          relativeStart = Math.max(size + start, 0);
        } else {
          relativeStart = Math.min(start, size);
        }
        if (end === void 0) {
          relativeEnd = size;
        } else if (end < 0) {
          relativeEnd = Math.max(size + end, 0);
        } else {
          relativeEnd = Math.min(end, size);
        }
        const span = Math.max(relativeEnd - relativeStart, 0);
        const buffer = this[BUFFER];
        const slicedBuffer = buffer.slice(relativeStart, relativeStart + span);
        const blob = new Blob([], { type: arguments[2] });
        blob[BUFFER] = slicedBuffer;
        return blob;
      }
    };
    Object.defineProperties(Blob.prototype, {
      size: { enumerable: true },
      type: { enumerable: true },
      slice: { enumerable: true }
    });
    Object.defineProperty(Blob.prototype, Symbol.toStringTag, {
      value: "Blob",
      writable: false,
      enumerable: false,
      configurable: true
    });
    function FetchError(message, type, systemError) {
      Error.call(this, message);
      this.message = message;
      this.type = type;
      if (systemError) {
        this.code = this.errno = systemError.code;
      }
      Error.captureStackTrace(this, this.constructor);
    }
    FetchError.prototype = Object.create(Error.prototype);
    FetchError.prototype.constructor = FetchError;
    FetchError.prototype.name = "FetchError";
    var convert;
    try {
      convert = require("encoding").convert;
    } catch (e) {
    }
    var INTERNALS = Symbol("Body internals");
    var PassThrough = Stream.PassThrough;
    function Body(body) {
      var _this = this;
      var _ref = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : {}, _ref$size = _ref.size;
      let size = _ref$size === void 0 ? 0 : _ref$size;
      var _ref$timeout = _ref.timeout;
      let timeout = _ref$timeout === void 0 ? 0 : _ref$timeout;
      if (body == null) {
        body = null;
      } else if (isURLSearchParams(body)) {
        body = Buffer.from(body.toString());
      } else if (isBlob(body))
        ;
      else if (Buffer.isBuffer(body))
        ;
      else if (Object.prototype.toString.call(body) === "[object ArrayBuffer]") {
        body = Buffer.from(body);
      } else if (ArrayBuffer.isView(body)) {
        body = Buffer.from(body.buffer, body.byteOffset, body.byteLength);
      } else if (body instanceof Stream)
        ;
      else {
        body = Buffer.from(String(body));
      }
      this[INTERNALS] = {
        body,
        disturbed: false,
        error: null
      };
      this.size = size;
      this.timeout = timeout;
      if (body instanceof Stream) {
        body.on("error", function(err) {
          const error = err.name === "AbortError" ? err : new FetchError(`Invalid response body while trying to fetch ${_this.url}: ${err.message}`, "system", err);
          _this[INTERNALS].error = error;
        });
      }
    }
    Body.prototype = {
      get body() {
        return this[INTERNALS].body;
      },
      get bodyUsed() {
        return this[INTERNALS].disturbed;
      },
      arrayBuffer() {
        return consumeBody.call(this).then(function(buf) {
          return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
        });
      },
      blob() {
        let ct = this.headers && this.headers.get("content-type") || "";
        return consumeBody.call(this).then(function(buf) {
          return Object.assign(
            new Blob([], {
              type: ct.toLowerCase()
            }),
            {
              [BUFFER]: buf
            }
          );
        });
      },
      json() {
        var _this2 = this;
        return consumeBody.call(this).then(function(buffer) {
          try {
            return JSON.parse(buffer.toString());
          } catch (err) {
            return Body.Promise.reject(new FetchError(`invalid json response body at ${_this2.url} reason: ${err.message}`, "invalid-json"));
          }
        });
      },
      text() {
        return consumeBody.call(this).then(function(buffer) {
          return buffer.toString();
        });
      },
      buffer() {
        return consumeBody.call(this);
      },
      textConverted() {
        var _this3 = this;
        return consumeBody.call(this).then(function(buffer) {
          return convertBody(buffer, _this3.headers);
        });
      }
    };
    Object.defineProperties(Body.prototype, {
      body: { enumerable: true },
      bodyUsed: { enumerable: true },
      arrayBuffer: { enumerable: true },
      blob: { enumerable: true },
      json: { enumerable: true },
      text: { enumerable: true }
    });
    Body.mixIn = function(proto) {
      for (const name of Object.getOwnPropertyNames(Body.prototype)) {
        if (!(name in proto)) {
          const desc = Object.getOwnPropertyDescriptor(Body.prototype, name);
          Object.defineProperty(proto, name, desc);
        }
      }
    };
    function consumeBody() {
      var _this4 = this;
      if (this[INTERNALS].disturbed) {
        return Body.Promise.reject(new TypeError(`body used already for: ${this.url}`));
      }
      this[INTERNALS].disturbed = true;
      if (this[INTERNALS].error) {
        return Body.Promise.reject(this[INTERNALS].error);
      }
      let body = this.body;
      if (body === null) {
        return Body.Promise.resolve(Buffer.alloc(0));
      }
      if (isBlob(body)) {
        body = body.stream();
      }
      if (Buffer.isBuffer(body)) {
        return Body.Promise.resolve(body);
      }
      if (!(body instanceof Stream)) {
        return Body.Promise.resolve(Buffer.alloc(0));
      }
      let accum = [];
      let accumBytes = 0;
      let abort = false;
      return new Body.Promise(function(resolve, reject) {
        let resTimeout;
        if (_this4.timeout) {
          resTimeout = setTimeout(function() {
            abort = true;
            reject(new FetchError(`Response timeout while trying to fetch ${_this4.url} (over ${_this4.timeout}ms)`, "body-timeout"));
          }, _this4.timeout);
        }
        body.on("error", function(err) {
          if (err.name === "AbortError") {
            abort = true;
            reject(err);
          } else {
            reject(new FetchError(`Invalid response body while trying to fetch ${_this4.url}: ${err.message}`, "system", err));
          }
        });
        body.on("data", function(chunk) {
          if (abort || chunk === null) {
            return;
          }
          if (_this4.size && accumBytes + chunk.length > _this4.size) {
            abort = true;
            reject(new FetchError(`content size at ${_this4.url} over limit: ${_this4.size}`, "max-size"));
            return;
          }
          accumBytes += chunk.length;
          accum.push(chunk);
        });
        body.on("end", function() {
          if (abort) {
            return;
          }
          clearTimeout(resTimeout);
          try {
            resolve(Buffer.concat(accum, accumBytes));
          } catch (err) {
            reject(new FetchError(`Could not create Buffer from response body for ${_this4.url}: ${err.message}`, "system", err));
          }
        });
      });
    }
    function convertBody(buffer, headers) {
      if (typeof convert !== "function") {
        throw new Error("The package `encoding` must be installed to use the textConverted() function");
      }
      const ct = headers.get("content-type");
      let charset = "utf-8";
      let res, str;
      if (ct) {
        res = /charset=([^;]*)/i.exec(ct);
      }
      str = buffer.slice(0, 1024).toString();
      if (!res && str) {
        res = /<meta.+?charset=(['"])(.+?)\1/i.exec(str);
      }
      if (!res && str) {
        res = /<meta[\s]+?http-equiv=(['"])content-type\1[\s]+?content=(['"])(.+?)\2/i.exec(str);
        if (!res) {
          res = /<meta[\s]+?content=(['"])(.+?)\1[\s]+?http-equiv=(['"])content-type\3/i.exec(str);
          if (res) {
            res.pop();
          }
        }
        if (res) {
          res = /charset=(.*)/i.exec(res.pop());
        }
      }
      if (!res && str) {
        res = /<\?xml.+?encoding=(['"])(.+?)\1/i.exec(str);
      }
      if (res) {
        charset = res.pop();
        if (charset === "gb2312" || charset === "gbk") {
          charset = "gb18030";
        }
      }
      return convert(buffer, "UTF-8", charset).toString();
    }
    function isURLSearchParams(obj) {
      if (typeof obj !== "object" || typeof obj.append !== "function" || typeof obj.delete !== "function" || typeof obj.get !== "function" || typeof obj.getAll !== "function" || typeof obj.has !== "function" || typeof obj.set !== "function") {
        return false;
      }
      return obj.constructor.name === "URLSearchParams" || Object.prototype.toString.call(obj) === "[object URLSearchParams]" || typeof obj.sort === "function";
    }
    function isBlob(obj) {
      return typeof obj === "object" && typeof obj.arrayBuffer === "function" && typeof obj.type === "string" && typeof obj.stream === "function" && typeof obj.constructor === "function" && typeof obj.constructor.name === "string" && /^(Blob|File)$/.test(obj.constructor.name) && /^(Blob|File)$/.test(obj[Symbol.toStringTag]);
    }
    function clone(instance) {
      let p1, p2;
      let body = instance.body;
      if (instance.bodyUsed) {
        throw new Error("cannot clone body after it is used");
      }
      if (body instanceof Stream && typeof body.getBoundary !== "function") {
        p1 = new PassThrough();
        p2 = new PassThrough();
        body.pipe(p1);
        body.pipe(p2);
        instance[INTERNALS].body = p1;
        body = p2;
      }
      return body;
    }
    function extractContentType(body) {
      if (body === null) {
        return null;
      } else if (typeof body === "string") {
        return "text/plain;charset=UTF-8";
      } else if (isURLSearchParams(body)) {
        return "application/x-www-form-urlencoded;charset=UTF-8";
      } else if (isBlob(body)) {
        return body.type || null;
      } else if (Buffer.isBuffer(body)) {
        return null;
      } else if (Object.prototype.toString.call(body) === "[object ArrayBuffer]") {
        return null;
      } else if (ArrayBuffer.isView(body)) {
        return null;
      } else if (typeof body.getBoundary === "function") {
        return `multipart/form-data;boundary=${body.getBoundary()}`;
      } else if (body instanceof Stream) {
        return null;
      } else {
        return "text/plain;charset=UTF-8";
      }
    }
    function getTotalBytes(instance) {
      const body = instance.body;
      if (body === null) {
        return 0;
      } else if (isBlob(body)) {
        return body.size;
      } else if (Buffer.isBuffer(body)) {
        return body.length;
      } else if (body && typeof body.getLengthSync === "function") {
        if (body._lengthRetrievers && body._lengthRetrievers.length == 0 || body.hasKnownLength && body.hasKnownLength()) {
          return body.getLengthSync();
        }
        return null;
      } else {
        return null;
      }
    }
    function writeToStream(dest, instance) {
      const body = instance.body;
      if (body === null) {
        dest.end();
      } else if (isBlob(body)) {
        body.stream().pipe(dest);
      } else if (Buffer.isBuffer(body)) {
        dest.write(body);
        dest.end();
      } else {
        body.pipe(dest);
      }
    }
    Body.Promise = global.Promise;
    var invalidTokenRegex = /[^\^_`a-zA-Z\-0-9!#$%&'*+.|~]/;
    var invalidHeaderCharRegex = /[^\t\x20-\x7e\x80-\xff]/;
    function validateName(name) {
      name = `${name}`;
      if (invalidTokenRegex.test(name) || name === "") {
        throw new TypeError(`${name} is not a legal HTTP header name`);
      }
    }
    function validateValue(value) {
      value = `${value}`;
      if (invalidHeaderCharRegex.test(value)) {
        throw new TypeError(`${value} is not a legal HTTP header value`);
      }
    }
    function find(map, name) {
      name = name.toLowerCase();
      for (const key in map) {
        if (key.toLowerCase() === name) {
          return key;
        }
      }
      return void 0;
    }
    var MAP = Symbol("map");
    var Headers = class {
      constructor() {
        let init = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : void 0;
        this[MAP] = /* @__PURE__ */ Object.create(null);
        if (init instanceof Headers) {
          const rawHeaders = init.raw();
          const headerNames = Object.keys(rawHeaders);
          for (const headerName of headerNames) {
            for (const value of rawHeaders[headerName]) {
              this.append(headerName, value);
            }
          }
          return;
        }
        if (init == null)
          ;
        else if (typeof init === "object") {
          const method = init[Symbol.iterator];
          if (method != null) {
            if (typeof method !== "function") {
              throw new TypeError("Header pairs must be iterable");
            }
            const pairs = [];
            for (const pair of init) {
              if (typeof pair !== "object" || typeof pair[Symbol.iterator] !== "function") {
                throw new TypeError("Each header pair must be iterable");
              }
              pairs.push(Array.from(pair));
            }
            for (const pair of pairs) {
              if (pair.length !== 2) {
                throw new TypeError("Each header pair must be a name/value tuple");
              }
              this.append(pair[0], pair[1]);
            }
          } else {
            for (const key of Object.keys(init)) {
              const value = init[key];
              this.append(key, value);
            }
          }
        } else {
          throw new TypeError("Provided initializer must be an object");
        }
      }
      get(name) {
        name = `${name}`;
        validateName(name);
        const key = find(this[MAP], name);
        if (key === void 0) {
          return null;
        }
        return this[MAP][key].join(", ");
      }
      forEach(callback) {
        let thisArg = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : void 0;
        let pairs = getHeaders(this);
        let i = 0;
        while (i < pairs.length) {
          var _pairs$i = pairs[i];
          const name = _pairs$i[0], value = _pairs$i[1];
          callback.call(thisArg, value, name, this);
          pairs = getHeaders(this);
          i++;
        }
      }
      set(name, value) {
        name = `${name}`;
        value = `${value}`;
        validateName(name);
        validateValue(value);
        const key = find(this[MAP], name);
        this[MAP][key !== void 0 ? key : name] = [value];
      }
      append(name, value) {
        name = `${name}`;
        value = `${value}`;
        validateName(name);
        validateValue(value);
        const key = find(this[MAP], name);
        if (key !== void 0) {
          this[MAP][key].push(value);
        } else {
          this[MAP][name] = [value];
        }
      }
      has(name) {
        name = `${name}`;
        validateName(name);
        return find(this[MAP], name) !== void 0;
      }
      delete(name) {
        name = `${name}`;
        validateName(name);
        const key = find(this[MAP], name);
        if (key !== void 0) {
          delete this[MAP][key];
        }
      }
      raw() {
        return this[MAP];
      }
      keys() {
        return createHeadersIterator(this, "key");
      }
      values() {
        return createHeadersIterator(this, "value");
      }
      [Symbol.iterator]() {
        return createHeadersIterator(this, "key+value");
      }
    };
    Headers.prototype.entries = Headers.prototype[Symbol.iterator];
    Object.defineProperty(Headers.prototype, Symbol.toStringTag, {
      value: "Headers",
      writable: false,
      enumerable: false,
      configurable: true
    });
    Object.defineProperties(Headers.prototype, {
      get: { enumerable: true },
      forEach: { enumerable: true },
      set: { enumerable: true },
      append: { enumerable: true },
      has: { enumerable: true },
      delete: { enumerable: true },
      keys: { enumerable: true },
      values: { enumerable: true },
      entries: { enumerable: true }
    });
    function getHeaders(headers) {
      let kind = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : "key+value";
      const keys = Object.keys(headers[MAP]).sort();
      return keys.map(kind === "key" ? function(k) {
        return k.toLowerCase();
      } : kind === "value" ? function(k) {
        return headers[MAP][k].join(", ");
      } : function(k) {
        return [k.toLowerCase(), headers[MAP][k].join(", ")];
      });
    }
    var INTERNAL = Symbol("internal");
    function createHeadersIterator(target, kind) {
      const iterator = Object.create(HeadersIteratorPrototype);
      iterator[INTERNAL] = {
        target,
        kind,
        index: 0
      };
      return iterator;
    }
    var HeadersIteratorPrototype = Object.setPrototypeOf({
      next() {
        if (!this || Object.getPrototypeOf(this) !== HeadersIteratorPrototype) {
          throw new TypeError("Value of `this` is not a HeadersIterator");
        }
        var _INTERNAL = this[INTERNAL];
        const target = _INTERNAL.target, kind = _INTERNAL.kind, index = _INTERNAL.index;
        const values = getHeaders(target, kind);
        const len = values.length;
        if (index >= len) {
          return {
            value: void 0,
            done: true
          };
        }
        this[INTERNAL].index = index + 1;
        return {
          value: values[index],
          done: false
        };
      }
    }, Object.getPrototypeOf(Object.getPrototypeOf([][Symbol.iterator]())));
    Object.defineProperty(HeadersIteratorPrototype, Symbol.toStringTag, {
      value: "HeadersIterator",
      writable: false,
      enumerable: false,
      configurable: true
    });
    function exportNodeCompatibleHeaders(headers) {
      const obj = Object.assign({ __proto__: null }, headers[MAP]);
      const hostHeaderKey = find(headers[MAP], "Host");
      if (hostHeaderKey !== void 0) {
        obj[hostHeaderKey] = obj[hostHeaderKey][0];
      }
      return obj;
    }
    function createHeadersLenient(obj) {
      const headers = new Headers();
      for (const name of Object.keys(obj)) {
        if (invalidTokenRegex.test(name)) {
          continue;
        }
        if (Array.isArray(obj[name])) {
          for (const val of obj[name]) {
            if (invalidHeaderCharRegex.test(val)) {
              continue;
            }
            if (headers[MAP][name] === void 0) {
              headers[MAP][name] = [val];
            } else {
              headers[MAP][name].push(val);
            }
          }
        } else if (!invalidHeaderCharRegex.test(obj[name])) {
          headers[MAP][name] = [obj[name]];
        }
      }
      return headers;
    }
    var INTERNALS$1 = Symbol("Response internals");
    var STATUS_CODES = http.STATUS_CODES;
    var Response = class {
      constructor() {
        let body = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : null;
        let opts = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : {};
        Body.call(this, body, opts);
        const status = opts.status || 200;
        const headers = new Headers(opts.headers);
        if (body != null && !headers.has("Content-Type")) {
          const contentType = extractContentType(body);
          if (contentType) {
            headers.append("Content-Type", contentType);
          }
        }
        this[INTERNALS$1] = {
          url: opts.url,
          status,
          statusText: opts.statusText || STATUS_CODES[status],
          headers,
          counter: opts.counter
        };
      }
      get url() {
        return this[INTERNALS$1].url || "";
      }
      get status() {
        return this[INTERNALS$1].status;
      }
      get ok() {
        return this[INTERNALS$1].status >= 200 && this[INTERNALS$1].status < 300;
      }
      get redirected() {
        return this[INTERNALS$1].counter > 0;
      }
      get statusText() {
        return this[INTERNALS$1].statusText;
      }
      get headers() {
        return this[INTERNALS$1].headers;
      }
      clone() {
        return new Response(clone(this), {
          url: this.url,
          status: this.status,
          statusText: this.statusText,
          headers: this.headers,
          ok: this.ok,
          redirected: this.redirected
        });
      }
    };
    Body.mixIn(Response.prototype);
    Object.defineProperties(Response.prototype, {
      url: { enumerable: true },
      status: { enumerable: true },
      ok: { enumerable: true },
      redirected: { enumerable: true },
      statusText: { enumerable: true },
      headers: { enumerable: true },
      clone: { enumerable: true }
    });
    Object.defineProperty(Response.prototype, Symbol.toStringTag, {
      value: "Response",
      writable: false,
      enumerable: false,
      configurable: true
    });
    var INTERNALS$2 = Symbol("Request internals");
    var URL2 = Url.URL || whatwgUrl.URL;
    var parse_url = Url.parse;
    var format_url = Url.format;
    function parseURL(urlStr) {
      if (/^[a-zA-Z][a-zA-Z\d+\-.]*:/.exec(urlStr)) {
        urlStr = new URL2(urlStr).toString();
      }
      return parse_url(urlStr);
    }
    var streamDestructionSupported = "destroy" in Stream.Readable.prototype;
    function isRequest(input) {
      return typeof input === "object" && typeof input[INTERNALS$2] === "object";
    }
    function isAbortSignal(signal) {
      const proto = signal && typeof signal === "object" && Object.getPrototypeOf(signal);
      return !!(proto && proto.constructor.name === "AbortSignal");
    }
    var Request = class {
      constructor(input) {
        let init = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : {};
        let parsedURL;
        if (!isRequest(input)) {
          if (input && input.href) {
            parsedURL = parseURL(input.href);
          } else {
            parsedURL = parseURL(`${input}`);
          }
          input = {};
        } else {
          parsedURL = parseURL(input.url);
        }
        let method = init.method || input.method || "GET";
        method = method.toUpperCase();
        if ((init.body != null || isRequest(input) && input.body !== null) && (method === "GET" || method === "HEAD")) {
          throw new TypeError("Request with GET/HEAD method cannot have body");
        }
        let inputBody = init.body != null ? init.body : isRequest(input) && input.body !== null ? clone(input) : null;
        Body.call(this, inputBody, {
          timeout: init.timeout || input.timeout || 0,
          size: init.size || input.size || 0
        });
        const headers = new Headers(init.headers || input.headers || {});
        if (inputBody != null && !headers.has("Content-Type")) {
          const contentType = extractContentType(inputBody);
          if (contentType) {
            headers.append("Content-Type", contentType);
          }
        }
        let signal = isRequest(input) ? input.signal : null;
        if ("signal" in init)
          signal = init.signal;
        if (signal != null && !isAbortSignal(signal)) {
          throw new TypeError("Expected signal to be an instanceof AbortSignal");
        }
        this[INTERNALS$2] = {
          method,
          redirect: init.redirect || input.redirect || "follow",
          headers,
          parsedURL,
          signal
        };
        this.follow = init.follow !== void 0 ? init.follow : input.follow !== void 0 ? input.follow : 20;
        this.compress = init.compress !== void 0 ? init.compress : input.compress !== void 0 ? input.compress : true;
        this.counter = init.counter || input.counter || 0;
        this.agent = init.agent || input.agent;
      }
      get method() {
        return this[INTERNALS$2].method;
      }
      get url() {
        return format_url(this[INTERNALS$2].parsedURL);
      }
      get headers() {
        return this[INTERNALS$2].headers;
      }
      get redirect() {
        return this[INTERNALS$2].redirect;
      }
      get signal() {
        return this[INTERNALS$2].signal;
      }
      clone() {
        return new Request(this);
      }
    };
    Body.mixIn(Request.prototype);
    Object.defineProperty(Request.prototype, Symbol.toStringTag, {
      value: "Request",
      writable: false,
      enumerable: false,
      configurable: true
    });
    Object.defineProperties(Request.prototype, {
      method: { enumerable: true },
      url: { enumerable: true },
      headers: { enumerable: true },
      redirect: { enumerable: true },
      clone: { enumerable: true },
      signal: { enumerable: true }
    });
    function getNodeRequestOptions(request) {
      const parsedURL = request[INTERNALS$2].parsedURL;
      const headers = new Headers(request[INTERNALS$2].headers);
      if (!headers.has("Accept")) {
        headers.set("Accept", "*/*");
      }
      if (!parsedURL.protocol || !parsedURL.hostname) {
        throw new TypeError("Only absolute URLs are supported");
      }
      if (!/^https?:$/.test(parsedURL.protocol)) {
        throw new TypeError("Only HTTP(S) protocols are supported");
      }
      if (request.signal && request.body instanceof Stream.Readable && !streamDestructionSupported) {
        throw new Error("Cancellation of streamed requests with AbortSignal is not supported in node < 8");
      }
      let contentLengthValue = null;
      if (request.body == null && /^(POST|PUT)$/i.test(request.method)) {
        contentLengthValue = "0";
      }
      if (request.body != null) {
        const totalBytes = getTotalBytes(request);
        if (typeof totalBytes === "number") {
          contentLengthValue = String(totalBytes);
        }
      }
      if (contentLengthValue) {
        headers.set("Content-Length", contentLengthValue);
      }
      if (!headers.has("User-Agent")) {
        headers.set("User-Agent", "node-fetch/1.0 (+https://github.com/bitinn/node-fetch)");
      }
      if (request.compress && !headers.has("Accept-Encoding")) {
        headers.set("Accept-Encoding", "gzip,deflate");
      }
      let agent = request.agent;
      if (typeof agent === "function") {
        agent = agent(parsedURL);
      }
      if (!headers.has("Connection") && !agent) {
        headers.set("Connection", "close");
      }
      return Object.assign({}, parsedURL, {
        method: request.method,
        headers: exportNodeCompatibleHeaders(headers),
        agent
      });
    }
    function AbortError(message) {
      Error.call(this, message);
      this.type = "aborted";
      this.message = message;
      Error.captureStackTrace(this, this.constructor);
    }
    AbortError.prototype = Object.create(Error.prototype);
    AbortError.prototype.constructor = AbortError;
    AbortError.prototype.name = "AbortError";
    var URL$1 = Url.URL || whatwgUrl.URL;
    var PassThrough$1 = Stream.PassThrough;
    var isDomainOrSubdomain = function isDomainOrSubdomain2(destination, original) {
      const orig = new URL$1(original).hostname;
      const dest = new URL$1(destination).hostname;
      return orig === dest || orig[orig.length - dest.length - 1] === "." && orig.endsWith(dest);
    };
    function fetch(url, opts) {
      if (!fetch.Promise) {
        throw new Error("native promise missing, set fetch.Promise to your favorite alternative");
      }
      Body.Promise = fetch.Promise;
      return new fetch.Promise(function(resolve, reject) {
        const request = new Request(url, opts);
        const options = getNodeRequestOptions(request);
        const send = (options.protocol === "https:" ? https : http).request;
        const signal = request.signal;
        let response = null;
        const abort = function abort2() {
          let error = new AbortError("The user aborted a request.");
          reject(error);
          if (request.body && request.body instanceof Stream.Readable) {
            request.body.destroy(error);
          }
          if (!response || !response.body)
            return;
          response.body.emit("error", error);
        };
        if (signal && signal.aborted) {
          abort();
          return;
        }
        const abortAndFinalize = function abortAndFinalize2() {
          abort();
          finalize();
        };
        const req = send(options);
        let reqTimeout;
        if (signal) {
          signal.addEventListener("abort", abortAndFinalize);
        }
        function finalize() {
          req.abort();
          if (signal)
            signal.removeEventListener("abort", abortAndFinalize);
          clearTimeout(reqTimeout);
        }
        if (request.timeout) {
          req.once("socket", function(socket) {
            reqTimeout = setTimeout(function() {
              reject(new FetchError(`network timeout at: ${request.url}`, "request-timeout"));
              finalize();
            }, request.timeout);
          });
        }
        req.on("error", function(err) {
          reject(new FetchError(`request to ${request.url} failed, reason: ${err.message}`, "system", err));
          finalize();
        });
        req.on("response", function(res) {
          clearTimeout(reqTimeout);
          const headers = createHeadersLenient(res.headers);
          if (fetch.isRedirect(res.statusCode)) {
            const location = headers.get("Location");
            let locationURL = null;
            try {
              locationURL = location === null ? null : new URL$1(location, request.url).toString();
            } catch (err) {
              if (request.redirect !== "manual") {
                reject(new FetchError(`uri requested responds with an invalid redirect URL: ${location}`, "invalid-redirect"));
                finalize();
                return;
              }
            }
            switch (request.redirect) {
              case "error":
                reject(new FetchError(`uri requested responds with a redirect, redirect mode is set to error: ${request.url}`, "no-redirect"));
                finalize();
                return;
              case "manual":
                if (locationURL !== null) {
                  try {
                    headers.set("Location", locationURL);
                  } catch (err) {
                    reject(err);
                  }
                }
                break;
              case "follow":
                if (locationURL === null) {
                  break;
                }
                if (request.counter >= request.follow) {
                  reject(new FetchError(`maximum redirect reached at: ${request.url}`, "max-redirect"));
                  finalize();
                  return;
                }
                const requestOpts = {
                  headers: new Headers(request.headers),
                  follow: request.follow,
                  counter: request.counter + 1,
                  agent: request.agent,
                  compress: request.compress,
                  method: request.method,
                  body: request.body,
                  signal: request.signal,
                  timeout: request.timeout,
                  size: request.size
                };
                if (!isDomainOrSubdomain(request.url, locationURL)) {
                  for (const name of ["authorization", "www-authenticate", "cookie", "cookie2"]) {
                    requestOpts.headers.delete(name);
                  }
                }
                if (res.statusCode !== 303 && request.body && getTotalBytes(request) === null) {
                  reject(new FetchError("Cannot follow redirect with body being a readable stream", "unsupported-redirect"));
                  finalize();
                  return;
                }
                if (res.statusCode === 303 || (res.statusCode === 301 || res.statusCode === 302) && request.method === "POST") {
                  requestOpts.method = "GET";
                  requestOpts.body = void 0;
                  requestOpts.headers.delete("content-length");
                }
                resolve(fetch(new Request(locationURL, requestOpts)));
                finalize();
                return;
            }
          }
          res.once("end", function() {
            if (signal)
              signal.removeEventListener("abort", abortAndFinalize);
          });
          let body = res.pipe(new PassThrough$1());
          const response_options = {
            url: request.url,
            status: res.statusCode,
            statusText: res.statusMessage,
            headers,
            size: request.size,
            timeout: request.timeout,
            counter: request.counter
          };
          const codings = headers.get("Content-Encoding");
          if (!request.compress || request.method === "HEAD" || codings === null || res.statusCode === 204 || res.statusCode === 304) {
            response = new Response(body, response_options);
            resolve(response);
            return;
          }
          const zlibOptions = {
            flush: zlib.Z_SYNC_FLUSH,
            finishFlush: zlib.Z_SYNC_FLUSH
          };
          if (codings == "gzip" || codings == "x-gzip") {
            body = body.pipe(zlib.createGunzip(zlibOptions));
            response = new Response(body, response_options);
            resolve(response);
            return;
          }
          if (codings == "deflate" || codings == "x-deflate") {
            const raw = res.pipe(new PassThrough$1());
            raw.once("data", function(chunk) {
              if ((chunk[0] & 15) === 8) {
                body = body.pipe(zlib.createInflate());
              } else {
                body = body.pipe(zlib.createInflateRaw());
              }
              response = new Response(body, response_options);
              resolve(response);
            });
            return;
          }
          if (codings == "br" && typeof zlib.createBrotliDecompress === "function") {
            body = body.pipe(zlib.createBrotliDecompress());
            response = new Response(body, response_options);
            resolve(response);
            return;
          }
          response = new Response(body, response_options);
          resolve(response);
        });
        writeToStream(req, request);
      });
    }
    fetch.isRedirect = function(code) {
      return code === 301 || code === 302 || code === 303 || code === 307 || code === 308;
    };
    fetch.Promise = global.Promise;
    module2.exports = exports = fetch;
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.default = exports;
    exports.Headers = Headers;
    exports.Request = Request;
    exports.Response = Response;
    exports.FetchError = FetchError;
  }
});

// node_modules/cross-fetch/dist/node-ponyfill.js
var require_node_ponyfill = __commonJS({
  "node_modules/cross-fetch/dist/node-ponyfill.js"(exports, module2) {
    var nodeFetch = require_lib2();
    var realFetch = nodeFetch.default || nodeFetch;
    var fetch = function(url, options) {
      if (/^\/\//.test(url)) {
        url = "https:" + url;
      }
      return realFetch.call(this, url, options);
    };
    fetch.ponyfill = true;
    module2.exports = exports = fetch;
    exports.fetch = fetch;
    exports.Headers = nodeFetch.Headers;
    exports.Request = nodeFetch.Request;
    exports.Response = nodeFetch.Response;
    exports.default = fetch;
  }
});

// node_modules/@raycast/utils/dist/useFetch.js
var require_useFetch = __commonJS({
  "node_modules/@raycast/utils/dist/useFetch.js"(exports) {
    "use strict";
    var __importDefault = exports && exports.__importDefault || function(mod) {
      return mod && mod.__esModule ? mod : { "default": mod };
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useFetch = void 0;
    var react_1 = require("react");
    var media_typer_1 = __importDefault(require_media_typer());
    var content_type_1 = __importDefault(require_content_type());
    var useCachedPromise_1 = require_useCachedPromise();
    var useLatest_1 = require_useLatest();
    var cross_fetch_1 = require_node_ponyfill();
    function isJSON(contentTypeHeader) {
      if (contentTypeHeader) {
        const ct = content_type_1.default.parse(contentTypeHeader);
        const mediaType = media_typer_1.default.parse(ct.type);
        if (mediaType.subtype === "json") {
          return true;
        }
        if (mediaType.suffix === "json") {
          return true;
        }
        if (mediaType.suffix && /\bjson\b/i.test(mediaType.suffix)) {
          return true;
        }
        if (mediaType.subtype && /\bjson\b/i.test(mediaType.subtype)) {
          return true;
        }
      }
      return false;
    }
    async function defaultParsing(response) {
      if (!response.ok) {
        throw new Error(response.statusText);
      }
      const contentTypeHeader = response.headers.get("content-type");
      if (contentTypeHeader && isJSON(contentTypeHeader)) {
        return await response.json();
      }
      return await response.text();
    }
    function useFetch(url, options) {
      const { parseResponse, initialData, execute: execute2, keepPreviousData, onError, onData, onWillExecute, ...fetchOptions } = options || {};
      const useCachedPromiseOptions = {
        initialData,
        execute: execute2,
        keepPreviousData,
        onError,
        onData,
        onWillExecute
      };
      const parseResponseRef = (0, useLatest_1.useLatest)(parseResponse || defaultParsing);
      const abortable = (0, react_1.useRef)();
      const fn = (0, react_1.useCallback)(async (url2, options2) => {
        const res = await (0, cross_fetch_1.fetch)(url2, { signal: abortable.current?.signal, ...options2 });
        return await parseResponseRef.current(res);
      }, [parseResponseRef]);
      return (0, useCachedPromise_1.useCachedPromise)(fn, [url, fetchOptions], { ...useCachedPromiseOptions, abortable });
    }
    exports.useFetch = useFetch;
  }
});

// node_modules/signal-exit/signals.js
var require_signals = __commonJS({
  "node_modules/signal-exit/signals.js"(exports, module2) {
    module2.exports = [
      "SIGABRT",
      "SIGALRM",
      "SIGHUP",
      "SIGINT",
      "SIGTERM"
    ];
    if (process.platform !== "win32") {
      module2.exports.push(
        "SIGVTALRM",
        "SIGXCPU",
        "SIGXFSZ",
        "SIGUSR2",
        "SIGTRAP",
        "SIGSYS",
        "SIGQUIT",
        "SIGIOT"
      );
    }
    if (process.platform === "linux") {
      module2.exports.push(
        "SIGIO",
        "SIGPOLL",
        "SIGPWR",
        "SIGSTKFLT",
        "SIGUNUSED"
      );
    }
  }
});

// node_modules/signal-exit/index.js
var require_signal_exit = __commonJS({
  "node_modules/signal-exit/index.js"(exports, module2) {
    var process2 = global.process;
    var processOk = function(process3) {
      return process3 && typeof process3 === "object" && typeof process3.removeListener === "function" && typeof process3.emit === "function" && typeof process3.reallyExit === "function" && typeof process3.listeners === "function" && typeof process3.kill === "function" && typeof process3.pid === "number" && typeof process3.on === "function";
    };
    if (!processOk(process2)) {
      module2.exports = function() {
        return function() {
        };
      };
    } else {
      assert = require("assert");
      signals = require_signals();
      isWin = /^win/i.test(process2.platform);
      EE = require("events");
      if (typeof EE !== "function") {
        EE = EE.EventEmitter;
      }
      if (process2.__signal_exit_emitter__) {
        emitter = process2.__signal_exit_emitter__;
      } else {
        emitter = process2.__signal_exit_emitter__ = new EE();
        emitter.count = 0;
        emitter.emitted = {};
      }
      if (!emitter.infinite) {
        emitter.setMaxListeners(Infinity);
        emitter.infinite = true;
      }
      module2.exports = function(cb, opts) {
        if (!processOk(global.process)) {
          return function() {
          };
        }
        assert.equal(typeof cb, "function", "a callback must be provided for exit handler");
        if (loaded === false) {
          load();
        }
        var ev = "exit";
        if (opts && opts.alwaysLast) {
          ev = "afterexit";
        }
        var remove = function() {
          emitter.removeListener(ev, cb);
          if (emitter.listeners("exit").length === 0 && emitter.listeners("afterexit").length === 0) {
            unload();
          }
        };
        emitter.on(ev, cb);
        return remove;
      };
      unload = function unload2() {
        if (!loaded || !processOk(global.process)) {
          return;
        }
        loaded = false;
        signals.forEach(function(sig) {
          try {
            process2.removeListener(sig, sigListeners[sig]);
          } catch (er) {
          }
        });
        process2.emit = originalProcessEmit;
        process2.reallyExit = originalProcessReallyExit;
        emitter.count -= 1;
      };
      module2.exports.unload = unload;
      emit = function emit2(event, code, signal) {
        if (emitter.emitted[event]) {
          return;
        }
        emitter.emitted[event] = true;
        emitter.emit(event, code, signal);
      };
      sigListeners = {};
      signals.forEach(function(sig) {
        sigListeners[sig] = function listener() {
          if (!processOk(global.process)) {
            return;
          }
          var listeners = process2.listeners(sig);
          if (listeners.length === emitter.count) {
            unload();
            emit("exit", null, sig);
            emit("afterexit", null, sig);
            if (isWin && sig === "SIGHUP") {
              sig = "SIGINT";
            }
            process2.kill(process2.pid, sig);
          }
        };
      });
      module2.exports.signals = function() {
        return signals;
      };
      loaded = false;
      load = function load2() {
        if (loaded || !processOk(global.process)) {
          return;
        }
        loaded = true;
        emitter.count += 1;
        signals = signals.filter(function(sig) {
          try {
            process2.on(sig, sigListeners[sig]);
            return true;
          } catch (er) {
            return false;
          }
        });
        process2.emit = processEmit;
        process2.reallyExit = processReallyExit;
      };
      module2.exports.load = load;
      originalProcessReallyExit = process2.reallyExit;
      processReallyExit = function processReallyExit2(code) {
        if (!processOk(global.process)) {
          return;
        }
        process2.exitCode = code || 0;
        emit("exit", process2.exitCode, null);
        emit("afterexit", process2.exitCode, null);
        originalProcessReallyExit.call(process2, process2.exitCode);
      };
      originalProcessEmit = process2.emit;
      processEmit = function processEmit2(ev, arg) {
        if (ev === "exit" && processOk(global.process)) {
          if (arg !== void 0) {
            process2.exitCode = arg;
          }
          var ret = originalProcessEmit.apply(this, arguments);
          emit("exit", process2.exitCode, null);
          emit("afterexit", process2.exitCode, null);
          return ret;
        } else {
          return originalProcessEmit.apply(this, arguments);
        }
      };
    }
    var assert;
    var signals;
    var isWin;
    var EE;
    var emitter;
    var unload;
    var emit;
    var sigListeners;
    var loaded;
    var load;
    var originalProcessReallyExit;
    var processReallyExit;
    var originalProcessEmit;
    var processEmit;
  }
});

// node_modules/@raycast/utils/dist/exec-utils.js
var require_exec_utils = __commonJS({
  "node_modules/@raycast/utils/dist/exec-utils.js"(exports) {
    "use strict";
    var __importDefault = exports && exports.__importDefault || function(mod) {
      return mod && mod.__esModule ? mod : { "default": mod };
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.getSpawnedResult = exports.getSpawnedPromise = void 0;
    var node_buffer_1 = require("node:buffer");
    var node_stream_1 = __importDefault(require("node:stream"));
    var node_util_1 = require("node:util");
    var signal_exit_1 = __importDefault(require_signal_exit());
    function getSpawnedPromise(spawned, { timeout } = {}) {
      const spawnedPromise = new Promise((resolve, reject) => {
        spawned.on("exit", (exitCode, signal) => {
          resolve({ exitCode, signal, timedOut: false });
        });
        spawned.on("error", (error) => {
          reject(error);
        });
        if (spawned.stdin) {
          spawned.stdin.on("error", (error) => {
            reject(error);
          });
        }
      });
      if (timeout === 0 || timeout === void 0) {
        return spawnedPromise;
      }
      let timeoutId;
      const timeoutPromise = new Promise((_resolve, reject) => {
        timeoutId = setTimeout(() => {
          spawned.kill("SIGTERM");
          reject(Object.assign(new Error("Timed out"), { timedOut: true, signal: "SIGTERM" }));
        }, timeout);
      });
      const safeSpawnedPromise = spawnedPromise.finally(() => {
        clearTimeout(timeoutId);
      });
      const removeExitHandler = (0, signal_exit_1.default)(() => {
        spawned.kill();
      });
      return Promise.race([timeoutPromise, safeSpawnedPromise]).finally(() => removeExitHandler());
    }
    exports.getSpawnedPromise = getSpawnedPromise;
    var MaxBufferError = class extends Error {
      constructor() {
        super("The output is too big");
        this.name = "MaxBufferError";
      }
    };
    var streamPipelinePromisified = (0, node_util_1.promisify)(node_stream_1.default.pipeline);
    function bufferStream(options) {
      const { encoding } = options;
      const isBuffer = encoding === "buffer";
      const stream = new node_stream_1.default.PassThrough({ objectMode: false });
      if (encoding && encoding !== "buffer") {
        stream.setEncoding(encoding);
      }
      let length = 0;
      const chunks = [];
      stream.on("data", (chunk) => {
        chunks.push(chunk);
        length += chunk.length;
      });
      stream.getBufferedValue = () => {
        return isBuffer ? Buffer.concat(chunks, length) : chunks.join("");
      };
      stream.getBufferedLength = () => length;
      return stream;
    }
    async function getStream(inputStream, options) {
      const stream = bufferStream(options);
      await new Promise((resolve, reject) => {
        const rejectPromise = (error) => {
          if (error && stream.getBufferedLength() <= node_buffer_1.constants.MAX_LENGTH) {
            error.bufferedData = stream.getBufferedValue();
          }
          reject(error);
        };
        (async () => {
          try {
            await streamPipelinePromisified(inputStream, stream);
            resolve();
          } catch (error) {
            rejectPromise(error);
          }
        })();
        stream.on("data", () => {
          if (stream.getBufferedLength() > 1e3 * 1e3 * 80) {
            rejectPromise(new MaxBufferError());
          }
        });
      });
      return stream.getBufferedValue();
    }
    async function getBufferedData(stream, streamPromise) {
      stream.destroy();
      try {
        return await streamPromise;
      } catch (error) {
        return error.bufferedData;
      }
    }
    async function getSpawnedResult({ stdout, stderr }, { encoding }, processDone) {
      const stdoutPromise = getStream(stdout, { encoding });
      const stderrPromise = getStream(stderr, { encoding });
      try {
        return await Promise.all([processDone, stdoutPromise, stderrPromise]);
      } catch (error) {
        return Promise.all([
          {
            error,
            exitCode: null,
            signal: error.signal,
            timedOut: error.timedOut || false
          },
          getBufferedData(stdout, stdoutPromise),
          getBufferedData(stderr, stderrPromise)
        ]);
      }
    }
    exports.getSpawnedResult = getSpawnedResult;
  }
});

// node_modules/@raycast/utils/dist/useExec.js
var require_useExec = __commonJS({
  "node_modules/@raycast/utils/dist/useExec.js"(exports) {
    "use strict";
    var __importDefault = exports && exports.__importDefault || function(mod) {
      return mod && mod.__esModule ? mod : { "default": mod };
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useExec = void 0;
    var node_child_process_1 = __importDefault(require("node:child_process"));
    var react_1 = require("react");
    var useCachedPromise_1 = require_useCachedPromise();
    var useLatest_1 = require_useLatest();
    var exec_utils_1 = require_exec_utils();
    var SPACES_REGEXP = / +/g;
    function parseCommand(command, args) {
      if (args) {
        return [command, ...args];
      }
      const tokens = [];
      for (const token of command.trim().split(SPACES_REGEXP)) {
        const previousToken = tokens[tokens.length - 1];
        if (previousToken && previousToken.endsWith("\\")) {
          tokens[tokens.length - 1] = `${previousToken.slice(0, -1)} ${token}`;
        } else {
          tokens.push(token);
        }
      }
      return tokens;
    }
    function stripFinalNewline(input) {
      const LF = typeof input === "string" ? "\n" : "\n".charCodeAt(0);
      const CR = typeof input === "string" ? "\r" : "\r".charCodeAt(0);
      if (input[input.length - 1] === LF) {
        input = input.slice(0, -1);
      }
      if (input[input.length - 1] === CR) {
        input = input.slice(0, -1);
      }
      return input;
    }
    function handleOutput(options, value) {
      if (options.stripFinalNewline) {
        return stripFinalNewline(value);
      }
      return value;
    }
    var getErrorPrefix = ({ timedOut, timeout, signal, exitCode }) => {
      if (timedOut) {
        return `timed out after ${timeout} milliseconds`;
      }
      if (signal !== void 0) {
        return `was killed with ${signal}`;
      }
      if (exitCode !== void 0) {
        return `failed with exit code ${exitCode}`;
      }
      return "failed";
    };
    var makeError = ({ stdout, stderr, error, signal, exitCode, command, timedOut, options }) => {
      const prefix = getErrorPrefix({ timedOut, timeout: options?.timeout, signal, exitCode });
      const execaMessage = `Command ${prefix}: ${command}`;
      const shortMessage = error ? `${execaMessage}
${error.message}` : execaMessage;
      const message = [shortMessage, stderr, stdout].filter(Boolean).join("\n");
      if (error) {
        error.originalMessage = error.message;
        error.message = message;
      } else {
        error = new Error(message);
      }
      error.shortMessage = shortMessage;
      error.command = command;
      error.exitCode = exitCode;
      error.signal = signal;
      error.stdout = stdout;
      error.stderr = stderr;
      if ("bufferedData" in error) {
        delete error["bufferedData"];
      }
      return error;
    };
    function defaultParsing({ stdout, stderr, error, exitCode, signal, timedOut, command, options }) {
      if (error || exitCode !== 0 || signal !== null) {
        const returnedError = makeError({
          error,
          exitCode,
          signal,
          stdout,
          stderr,
          command,
          timedOut,
          options
        });
        throw returnedError;
      }
      return stdout;
    }
    function useExec(command, optionsOrArgs, options) {
      const { parseOutput, input, onData, onWillExecute, initialData, execute: execute2, keepPreviousData, onError, ...execOptions } = Array.isArray(optionsOrArgs) ? options || {} : optionsOrArgs || {};
      const useCachedPromiseOptions = {
        initialData,
        execute: execute2,
        keepPreviousData,
        onError,
        onData,
        onWillExecute
      };
      const abortable = (0, react_1.useRef)();
      const parseOutputRef = (0, useLatest_1.useLatest)(parseOutput || defaultParsing);
      const fn = (0, react_1.useCallback)(async (_command, _args, _options, input2) => {
        const [file, ...args] = parseCommand(_command, _args);
        const command2 = [file, ...args].join(" ");
        const options2 = {
          stripFinalNewline: true,
          ..._options,
          signal: abortable.current?.signal,
          encoding: _options?.encoding === null ? "buffer" : _options?.encoding || "utf8",
          env: { ...process.env, ..._options?.env }
        };
        const spawned = node_child_process_1.default.spawn(file, args, options2);
        const spawnedPromise = (0, exec_utils_1.getSpawnedPromise)(spawned, options2);
        if (input2) {
          spawned.stdin.end(input2);
        }
        const [{ error, exitCode, signal, timedOut }, stdoutResult, stderrResult] = await (0, exec_utils_1.getSpawnedResult)(spawned, options2, spawnedPromise);
        const stdout = handleOutput(options2, stdoutResult);
        const stderr = handleOutput(options2, stderrResult);
        return parseOutputRef.current({
          stdout,
          stderr,
          error,
          exitCode,
          signal,
          timedOut,
          command: command2,
          options: options2
        });
      }, [parseOutputRef]);
      return (0, useCachedPromise_1.useCachedPromise)(fn, [command, Array.isArray(optionsOrArgs) ? optionsOrArgs : [], execOptions, input], {
        ...useCachedPromiseOptions,
        abortable
      });
    }
    exports.useExec = useExec;
  }
});

// node_modules/@raycast/utils/dist/useSQL.js
var require_useSQL = __commonJS({
  "node_modules/@raycast/utils/dist/useSQL.js"(exports) {
    "use strict";
    var __importDefault = exports && exports.__importDefault || function(mod) {
      return mod && mod.__esModule ? mod : { "default": mod };
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useSQL = void 0;
    var jsx_runtime_1 = require("react/jsx-runtime");
    var api_1 = require("@raycast/api");
    var node_fs_1 = require("node:fs");
    var promises_1 = require("node:fs/promises");
    var node_os_1 = __importDefault(require("node:os"));
    var node_child_process_1 = __importDefault(require("node:child_process"));
    var node_path_1 = __importDefault(require("node:path"));
    var object_hash_1 = __importDefault(require_object_hash());
    var react_1 = require("react");
    var usePromise_1 = require_usePromise();
    var useLatest_1 = require_useLatest();
    var exec_utils_1 = require_exec_utils();
    function useSQL(databasePath, query, options) {
      const { permissionPriming, ...usePromiseOptions } = options || {};
      const [permissionView, setPermissionView] = (0, react_1.useState)();
      const latestOptions = (0, useLatest_1.useLatest)(options || {});
      const abortable = (0, react_1.useRef)();
      const handleError = (0, react_1.useCallback)((_error) => {
        console.error(_error);
        const error = _error instanceof Error && _error.message.includes("authorization denied") ? new PermissionError("You do not have permission to access the database.") : _error;
        if (isPermissionError(error)) {
          setPermissionView((0, jsx_runtime_1.jsx)(PermissionErrorScreen, { priming: latestOptions.current.permissionPriming }));
        } else {
          if (latestOptions.current.onError) {
            latestOptions.current.onError(error);
          } else {
            console.error(error);
            if (api_1.environment.launchType !== api_1.LaunchType.Background) {
              (0, api_1.showToast)({
                style: api_1.Toast.Style.Failure,
                title: "Cannot query the data",
                message: error.message,
                primaryAction: {
                  title: "Copy Logs",
                  onAction(toast) {
                    toast.hide();
                    api_1.Clipboard.copy(error?.stack || error?.message || "");
                  }
                }
              });
            }
          }
        }
      }, [latestOptions]);
      const fn = (0, react_1.useMemo)(() => {
        if (!(0, node_fs_1.existsSync)(databasePath)) {
          throw new Error("The database does not exist");
        }
        let workaroundCopiedDb = void 0;
        return async (query2) => {
          const abortSignal = abortable.current?.signal;
          const spawned = node_child_process_1.default.spawn("sqlite3", ["--json", "--readonly", databasePath, query2], {
            signal: abortSignal
          });
          const spawnedPromise = (0, exec_utils_1.getSpawnedPromise)(spawned);
          let [{ error, exitCode, signal }, stdoutResult, stderrResult] = await (0, exec_utils_1.getSpawnedResult)(spawned, { encoding: "utf-8" }, spawnedPromise);
          checkAborted(abortSignal);
          if (stderrResult.match("(5)") || stderrResult.match("(14)")) {
            if (!workaroundCopiedDb) {
              const tempFolder = node_path_1.default.join(node_os_1.default.tmpdir(), "useSQL", (0, object_hash_1.default)(databasePath));
              await (0, promises_1.mkdir)(tempFolder, { recursive: true });
              checkAborted(abortSignal);
              workaroundCopiedDb = node_path_1.default.join(tempFolder, "db.db");
              await (0, promises_1.copyFile)(databasePath, workaroundCopiedDb);
              await (0, promises_1.writeFile)(workaroundCopiedDb + "-shm", "");
              await (0, promises_1.writeFile)(workaroundCopiedDb + "-wal", "");
              checkAborted(abortSignal);
            }
            const spawned2 = node_child_process_1.default.spawn("sqlite3", ["--json", "--readonly", "--vfs", "unix-none", workaroundCopiedDb, query2], {
              signal: abortSignal
            });
            const spawnedPromise2 = (0, exec_utils_1.getSpawnedPromise)(spawned2);
            [{ error, exitCode, signal }, stdoutResult, stderrResult] = await (0, exec_utils_1.getSpawnedResult)(spawned2, { encoding: "utf-8" }, spawnedPromise2);
            checkAborted(abortSignal);
          }
          if (error || exitCode !== 0 || signal !== null) {
            throw new Error(stderrResult);
          }
          return JSON.parse(stdoutResult.trim() || "[]");
        };
      }, [databasePath]);
      return {
        ...(0, usePromise_1.usePromise)(fn, [query], { ...usePromiseOptions, onError: handleError }),
        permissionView
      };
    }
    exports.useSQL = useSQL;
    var PermissionError = class extends Error {
      constructor(message) {
        super(message);
        this.name = "PermissionError";
      }
    };
    function isPermissionError(error) {
      return error instanceof Error && error.name === "PermissionError";
    }
    var macosVenturaAndLater = parseInt(node_os_1.default.release().split(".")[0]) >= 22;
    var preferencesString = macosVenturaAndLater ? "Settings" : "Preferences";
    function PermissionErrorScreen(props) {
      const action = macosVenturaAndLater ? {
        title: "Open System Settings -> Privacy",
        target: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
      } : {
        title: "Open System Preferences -> Security",
        target: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
      };
      if (api_1.environment.commandMode === "menu-bar") {
        return (0, jsx_runtime_1.jsxs)(api_1.MenuBarExtra, { icon: api_1.Icon.Warning, title: api_1.environment.commandName, children: [(0, jsx_runtime_1.jsx)(api_1.MenuBarExtra.Item, { title: "Raycast needs full disk access", tooltip: `You can revert this access in ${preferencesString} whenever you want` }), props.priming ? (0, jsx_runtime_1.jsx)(api_1.MenuBarExtra.Item, { title: props.priming, tooltip: `You can revert this access in ${preferencesString} whenever you want` }) : null, (0, jsx_runtime_1.jsx)(api_1.MenuBarExtra.Separator, {}), (0, jsx_runtime_1.jsx)(api_1.MenuBarExtra.Item, { title: action.title, onAction: () => (0, api_1.open)(action.target) })] });
      }
      return (0, jsx_runtime_1.jsx)(api_1.List, { children: (0, jsx_runtime_1.jsx)(api_1.List.EmptyView, { icon: {
        source: {
          light: "https://raycast.com/uploads/extensions-utils-security-permissions-light.png",
          dark: "https://raycast.com/uploads/extensions-utils-security-permissions-dark.png"
        }
      }, title: "Raycast needs full disk access.", description: `${props.priming ? props.priming + "\n" : ""}You can revert this access in ${preferencesString} whenever you want.`, actions: (0, jsx_runtime_1.jsx)(api_1.ActionPanel, { children: (0, jsx_runtime_1.jsx)(api_1.Action.Open, { ...action }) }) }) });
    }
    function checkAborted(signal) {
      if (signal?.aborted) {
        const error = new Error("aborted");
        error.name = "AbortError";
        throw error;
      }
    }
  }
});

// node_modules/@raycast/utils/dist/useForm.js
var require_useForm = __commonJS({
  "node_modules/@raycast/utils/dist/useForm.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.useForm = exports.FormValidation = void 0;
    var react_1 = require("react");
    var useLatest_1 = require_useLatest();
    var FormValidation;
    (function(FormValidation2) {
      FormValidation2["Required"] = "required";
    })(FormValidation = exports.FormValidation || (exports.FormValidation = {}));
    function validationError(validation, value) {
      if (validation) {
        if (typeof validation === "function") {
          return validation(value);
        } else if (validation === FormValidation.Required) {
          let valueIsValid = typeof value !== "undefined" && value !== null;
          if (valueIsValid) {
            switch (typeof value) {
              case "string":
                valueIsValid = value.length > 0;
                break;
              case "object":
                if (Array.isArray(value)) {
                  valueIsValid = value.length > 0;
                } else if (value instanceof Date) {
                  valueIsValid = value.getTime() > 0;
                }
                break;
              default:
                break;
            }
          }
          if (!valueIsValid) {
            return "The item is required";
          }
        }
      }
    }
    function useForm(props) {
      const { onSubmit: _onSubmit, validation, initialValues = {} } = props;
      const [values, setValues] = (0, react_1.useState)(initialValues);
      const [errors, setErrors] = (0, react_1.useState)({});
      const refs = (0, react_1.useRef)({});
      const latestValidation = (0, useLatest_1.useLatest)(validation || {});
      const latestOnSubmit = (0, useLatest_1.useLatest)(_onSubmit);
      const focus = (0, react_1.useCallback)((id) => {
        refs.current[id]?.focus();
      }, [refs]);
      const handleSubmit = (0, react_1.useCallback)(async (values2) => {
        let validationErrors = false;
        for (const [id, validation2] of Object.entries(latestValidation.current)) {
          const error = validationError(validation2, values2[id]);
          if (error) {
            if (!validationErrors) {
              validationErrors = {};
              focus(id);
            }
            validationErrors[id] = error;
          }
        }
        if (validationErrors) {
          setErrors(validationErrors);
          return false;
        }
        const result = await latestOnSubmit.current(values2);
        return typeof result === "boolean" ? result : true;
      }, [latestValidation, latestOnSubmit, focus]);
      const setValidationError = (0, react_1.useCallback)((id, error) => {
        setErrors((errors2) => ({ ...errors2, [id]: error }));
      }, [setErrors]);
      const setValue = (0, react_1.useCallback)(function(id, value) {
        setValues((values2) => ({ ...values2, [id]: value }));
      }, [setValues]);
      const itemProps = (0, react_1.useMemo)(() => {
        return new Proxy(
          {},
          {
            get(target, id) {
              const validation2 = latestValidation.current[id];
              const value = values[id];
              return {
                onChange(value2) {
                  if (errors[id]) {
                    const error = validationError(validation2, value2);
                    if (!error) {
                      setValidationError(id, void 0);
                    }
                  }
                  setValue(id, value2);
                },
                onBlur(event) {
                  const error = validationError(validation2, event.target.value);
                  if (error) {
                    setValidationError(id, error);
                  }
                },
                error: errors[id],
                id,
                value: typeof value === "undefined" ? null : value,
                ref: (instance) => {
                  refs.current[id] = instance;
                }
              };
            }
          }
        );
      }, [errors, latestValidation, setValidationError, values, refs, setValue]);
      const reset = (0, react_1.useCallback)((initialValues2 = {}) => {
        setValues(initialValues2);
        setErrors({});
      }, [setValues, setErrors]);
      return { handleSubmit, setValidationError, setValue, values, itemProps, focus, reset };
    }
    exports.useForm = useForm;
  }
});

// node_modules/@raycast/utils/dist/icon/color.js
var require_color = __commonJS({
  "node_modules/@raycast/utils/dist/icon/color.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.slightlyLighterColor = exports.slightlyDarkerColor = void 0;
    function hexToRGB(hex) {
      let r = 0;
      let g = 0;
      let b = 0;
      if (hex.length === 4) {
        r = parseInt(`${hex[1]}${hex[1]}`, 16);
        g = parseInt(`${hex[2]}${hex[2]}`, 16);
        b = parseInt(`${hex[3]}${hex[3]}`, 16);
      } else if (hex.length === 7) {
        r = parseInt(`${hex[1]}${hex[2]}`, 16);
        g = parseInt(`${hex[3]}${hex[4]}`, 16);
        b = parseInt(`${hex[5]}${hex[6]}`, 16);
      } else {
        throw new Error(`Malformed hex color: ${hex}`);
      }
      return { r, g, b };
    }
    function rgbToHex({ r, g, b }) {
      let rString = r.toString(16);
      let gString = g.toString(16);
      let bString = b.toString(16);
      if (rString.length === 1) {
        rString = `0${rString}`;
      }
      if (gString.length === 1) {
        gString = `0${gString}`;
      }
      if (bString.length === 1) {
        bString = `0${bString}`;
      }
      return `#${rString}${gString}${bString}`;
    }
    function rgbToHSL({ r, g, b }) {
      r /= 255;
      g /= 255;
      b /= 255;
      const cmin = Math.min(r, g, b);
      const cmax = Math.max(r, g, b);
      const delta = cmax - cmin;
      let h = 0;
      let s = 0;
      let l = 0;
      if (delta === 0) {
        h = 0;
      } else if (cmax === r) {
        h = (g - b) / delta % 6;
      } else if (cmax === g) {
        h = (b - r) / delta + 2;
      } else {
        h = (r - g) / delta + 4;
      }
      h = Math.round(h * 60);
      if (h < 0) {
        h += 360;
      }
      l = (cmax + cmin) / 2;
      s = delta === 0 ? 0 : delta / (1 - Math.abs(2 * l - 1));
      s = +(s * 100).toFixed(1);
      l = +(l * 100).toFixed(1);
      return { h, s, l };
    }
    function hslToRGB({ h, s, l }) {
      s /= 100;
      l /= 100;
      const c = (1 - Math.abs(2 * l - 1)) * s;
      const x = c * (1 - Math.abs(h / 60 % 2 - 1));
      const m = l - c / 2;
      let r = 0;
      let g = 0;
      let b = 0;
      if (h >= 0 && h < 60) {
        r = c;
        g = x;
        b = 0;
      } else if (h >= 60 && h < 120) {
        r = x;
        g = c;
        b = 0;
      } else if (h >= 120 && h < 180) {
        r = 0;
        g = c;
        b = x;
      } else if (h >= 180 && h < 240) {
        r = 0;
        g = x;
        b = c;
      } else if (h >= 240 && h < 300) {
        r = x;
        g = 0;
        b = c;
      } else if (h >= 300 && h < 360) {
        r = c;
        g = 0;
        b = x;
      }
      r = Math.round((r + m) * 255);
      g = Math.round((g + m) * 255);
      b = Math.round((b + m) * 255);
      return { r, g, b };
    }
    function hexToHSL(hex) {
      return rgbToHSL(hexToRGB(hex));
    }
    function hslToHex(hsl) {
      return rgbToHex(hslToRGB(hsl));
    }
    function clamp(value, min, max) {
      return min < max ? value < min ? min : value > max ? max : value : value < max ? max : value > min ? min : value;
    }
    var offset = 12;
    function slightlyDarkerColor(hex) {
      const hsl = hexToHSL(hex);
      return hslToHex({
        h: hsl.h,
        s: hsl.s,
        l: clamp(hsl.l - offset, 0, 100)
      });
    }
    exports.slightlyDarkerColor = slightlyDarkerColor;
    function slightlyLighterColor(hex) {
      const hsl = hexToHSL(hex);
      return hslToHex({
        h: hsl.h,
        s: hsl.s,
        l: clamp(hsl.l + offset, 0, 100)
      });
    }
    exports.slightlyLighterColor = slightlyLighterColor;
  }
});

// node_modules/@raycast/utils/dist/icon/avatar.js
var require_avatar = __commonJS({
  "node_modules/@raycast/utils/dist/icon/avatar.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.getAvatarIcon = void 0;
    var color_1 = require_color();
    function getWholeCharAndI(str, i) {
      const code = str.charCodeAt(i);
      if (Number.isNaN(code)) {
        return ["", i];
      }
      if (code < 55296 || code > 57343) {
        return [str.charAt(i), i];
      }
      if (55296 <= code && code <= 56319) {
        if (str.length <= i + 1) {
          throw new Error("High surrogate without following low surrogate");
        }
        const next = str.charCodeAt(i + 1);
        if (56320 > next || next > 57343) {
          throw new Error("High surrogate without following low surrogate");
        }
        return [str.charAt(i) + str.charAt(i + 1), i + 1];
      }
      if (i === 0) {
        throw new Error("Low surrogate without preceding high surrogate");
      }
      const prev = str.charCodeAt(i - 1);
      if (55296 > prev || prev > 56319) {
        throw new Error("Low surrogate without preceding high surrogate");
      }
      return [str.charAt(i + 1), i + 1];
    }
    var avatarColorSet = [
      "#DC829A",
      "#D64854",
      "#D47600",
      "#D36CDD",
      "#52A9E4",
      "#7871E8",
      "#70920F",
      "#43B93A",
      "#EB6B3E",
      "#26B795",
      "#D85A9B",
      "#A067DC",
      "#BD9500",
      "#5385D9"
    ];
    function getAvatarIcon(name, options) {
      const words = name.trim().split(" ");
      let initials;
      if (words.length == 1 && getWholeCharAndI(words[0], 0)[0]) {
        initials = getWholeCharAndI(words[0], 0)[0];
      } else if (words.length > 1) {
        const firstWordFirstLetter = getWholeCharAndI(words[0], 0)[0] || "";
        const lastWordFirstLetter = getWholeCharAndI(words[words.length - 1], 0)[0] ?? "";
        initials = firstWordFirstLetter + lastWordFirstLetter;
      } else {
        initials = "";
      }
      let backgroundColor;
      if (options?.background) {
        backgroundColor = options?.background;
      } else {
        let initialsCharIndex = 0;
        let [char, i] = getWholeCharAndI(initials, 0);
        while (char) {
          initialsCharIndex += char.charCodeAt(0);
          [char, i] = getWholeCharAndI(initials, i + 1);
        }
        const colorIndex = initialsCharIndex % avatarColorSet.length;
        backgroundColor = avatarColorSet[colorIndex];
      }
      const padding = 0;
      const radius = 50 - padding;
      const svg = `<svg width="100px" height="100px">
  ${options?.gradient !== false ? `<defs>
      <linearGradient id="Gradient" x1="0.25" x2="0.75" y1="0" y2="1">
        <stop offset="0%" stop-color="${(0, color_1.slightlyLighterColor)(backgroundColor)}"/>
        <stop offset="50%" stop-color="${backgroundColor}"/>
        <stop offset="100%" stop-color="${(0, color_1.slightlyDarkerColor)(backgroundColor)}"/>
      </linearGradient>
  </defs>` : ""}
      <circle cx="50" cy="50" r="${radius}" fill="${options?.gradient !== false ? "url(#Gradient)" : backgroundColor}" />
      ${initials ? `<text x="50" y="80" font-size="${radius - 1}" font-family="Inter, sans-serif" text-anchor="middle" fill="white">${initials.toUpperCase()}</text>` : ""}
    </svg>
  `.replaceAll("\n", "");
      return `data:image/svg+xml,${svg}`;
    }
    exports.getAvatarIcon = getAvatarIcon;
  }
});

// node_modules/@raycast/utils/dist/icon/favicon.js
var require_favicon = __commonJS({
  "node_modules/@raycast/utils/dist/icon/favicon.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.getFavicon = void 0;
    var api_1 = require("@raycast/api");
    var url_1 = require("url");
    function getFavicon2(url, options) {
      try {
        const urlObj = typeof url === "string" ? new url_1.URL(url) : url;
        const hostname = urlObj.hostname;
        return {
          source: `https://www.google.com/s2/favicons?sz=${options?.size ?? 64}&domain=${hostname}`,
          fallback: options?.fallback ?? api_1.Icon.Link,
          mask: options?.mask
        };
      } catch (e) {
        console.error(e);
        return api_1.Icon.Link;
      }
    }
    exports.getFavicon = getFavicon2;
  }
});

// node_modules/@raycast/utils/dist/icon/progress.js
var require_progress = __commonJS({
  "node_modules/@raycast/utils/dist/icon/progress.js"(exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    exports.getProgressIcon = void 0;
    var api_1 = require("@raycast/api");
    function polarToCartesian(centerX, centerY, radius, angleInDegrees) {
      const angleInRadians = (angleInDegrees - 90) * Math.PI / 180;
      return {
        x: centerX + radius * Math.cos(angleInRadians),
        y: centerY + radius * Math.sin(angleInRadians)
      };
    }
    function describeArc(x, y, radius, startAngle, endAngle) {
      const start = polarToCartesian(x, y, radius, endAngle);
      const end = polarToCartesian(x, y, radius, startAngle);
      const largeArcFlag = endAngle - startAngle <= 180 ? "0" : "1";
      const d = ["M", start.x, start.y, "A", radius, radius, 0, largeArcFlag, 0, end.x, end.y].join(" ");
      return d;
    }
    function getProgressIcon(progress, color = "#FF6363", options) {
      const background = options?.background || (api_1.environment.theme === "light" ? "black" : "white");
      const backgroundOpacity = options?.backgroundOpacity || 0.1;
      const stroke = 10;
      const padding = 5;
      const radius = 50 - padding - stroke / 2;
      const svg = `<svg width="100px" height="100px">
      <circle cx="50" cy="50" r="${radius}" stroke-width="${stroke}" stroke="${progress < 1 ? background : color}" opacity="${progress < 1 ? backgroundOpacity : "1"}" fill="none" />
      ${progress > 0 && progress < 1 ? `<path d="${describeArc(50, 50, radius, 0, progress * 360)}" stroke="${color}" stroke-width="${stroke}" fill="none" />` : ""}
    </svg>
  `.replaceAll("\n", "");
      return `data:image/svg+xml,${svg}`;
    }
    exports.getProgressIcon = getProgressIcon;
  }
});

// node_modules/@raycast/utils/dist/icon/index.js
var require_icon = __commonJS({
  "node_modules/@raycast/utils/dist/icon/index.js"(exports) {
    "use strict";
    var __createBinding = exports && exports.__createBinding || (Object.create ? function(o, m, k, k2) {
      if (k2 === void 0)
        k2 = k;
      var desc = Object.getOwnPropertyDescriptor(m, k);
      if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
        desc = { enumerable: true, get: function() {
          return m[k];
        } };
      }
      Object.defineProperty(o, k2, desc);
    } : function(o, m, k, k2) {
      if (k2 === void 0)
        k2 = k;
      o[k2] = m[k];
    });
    var __exportStar = exports && exports.__exportStar || function(m, exports2) {
      for (var p in m)
        if (p !== "default" && !Object.prototype.hasOwnProperty.call(exports2, p))
          __createBinding(exports2, m, p);
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    __exportStar(require_avatar(), exports);
    __exportStar(require_favicon(), exports);
    __exportStar(require_progress(), exports);
  }
});

// node_modules/@raycast/utils/dist/index.js
var require_dist = __commonJS({
  "node_modules/@raycast/utils/dist/index.js"(exports) {
    "use strict";
    var __createBinding = exports && exports.__createBinding || (Object.create ? function(o, m, k, k2) {
      if (k2 === void 0)
        k2 = k;
      var desc = Object.getOwnPropertyDescriptor(m, k);
      if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
        desc = { enumerable: true, get: function() {
          return m[k];
        } };
      }
      Object.defineProperty(o, k2, desc);
    } : function(o, m, k, k2) {
      if (k2 === void 0)
        k2 = k;
      o[k2] = m[k];
    });
    var __exportStar = exports && exports.__exportStar || function(m, exports2) {
      for (var p in m)
        if (p !== "default" && !Object.prototype.hasOwnProperty.call(exports2, p))
          __createBinding(exports2, m, p);
    };
    Object.defineProperty(exports, "__esModule", { value: true });
    __exportStar(require_usePromise(), exports);
    __exportStar(require_useCachedState(), exports);
    __exportStar(require_useCachedPromise(), exports);
    __exportStar(require_useFetch(), exports);
    __exportStar(require_useExec(), exports);
    __exportStar(require_useSQL(), exports);
    __exportStar(require_useForm(), exports);
    __exportStar(require_icon(), exports);
  }
});

// src/index.tsx
var src_exports = {};
__export(src_exports, {
  default: () => Command
});
module.exports = __toCommonJS(src_exports);
var import_api8 = require("@raycast/api");
var import_react2 = require("react");

// src/cli.ts
var import_child_process = require("child_process");
var serializeFromJson = (jsonArray) => {
  const array = JSON.parse(jsonArray);
  const res = array.map(
    (obj) => ({
      ...obj,
      lastModified: new Date(parseInt(obj.last_modified_gmt, 10) * 1e3),
      lastTouch: new Date(parseInt(obj.last_touch, 10) * 1e3)
    })
  );
  return res;
};
var execute = async (command, opts = { log: { stdout: false } }) => {
  const PATH = "/usr/gnu/bin:/usr/local/bin:/bin:/usr/bin:.:/opt/homebrew/bin";
  const wrappedCommand = `zsh -l -c 'export PATH="$PATH:${PATH}" && ${command}'`;
  console.log(`Executing: ${wrappedCommand}`);
  const startTimestamp = Date.now();
  return new Promise(
    (res, rej) => (0, import_child_process.exec)(wrappedCommand, (error, stdout, stderr) => {
      const endTimestamp = Date.now();
      const tookSeconds = (endTimestamp - startTimestamp) / 1e3;
      if (error) {
        console.error(`[${tookSeconds}s] Failed:
${stderr}`);
        rej(error);
      }
      console.log(`[${tookSeconds}s] Success${opts.log.stdout ? `:
${stdout}` : ""}`);
      res(stdout.trim());
    })
  );
};
var lastPass = (email, password) => ({
  isLogged: () => execute("lpass status").then((stdout) => stdout.includes(email)).catch(() => false),
  login: () => execute(`echo "${password}" | LPASS_DISABLE_PINENTRY=1 lpass login ${email}`),
  sync: () => execute("lpass sync").then(() => {
  }),
  show: (id, opts = { sync: "auto" }) => execute(`echo "${password}" | LPASS_DISABLE_PINENTRY=1 lpass show --sync=${opts.sync} --json ${id}`).then(
    (stdout) => serializeFromJson(stdout)[0]
  ),
  list: (opts = { sync: "auto" }) => execute(
    `echo "${password}" | LPASS_DISABLE_PINENTRY=1 lpass ls --sync=${opts.sync} --format="%ai<=>%an<=>%au<=>%ap<=>%al"`
  ).then((stdout) => {
    const items = stdout.split("\n").map((line) => {
      const [id, name, username, password2, url] = line.split("<=>");
      return { id, name, username, password: password2, url };
    }).filter(({ name }) => name);
    return items;
  }),
  export: (opts = { sync: "auto" }) => execute(
    `echo "${password}" | LPASS_DISABLE_PINENTRY=1 lpass export --sync=${opts.sync} --fields=id,name,username,password,url`
  ).then((stdout) => {
    const items = stdout.split("\n").filter((line) => line.trim() !== "").slice(1).map((line) => {
      const [id, name, username, password2, url] = line.split(",");
      return { id, name, username, password: password2, url };
    }).filter(({ name }) => name);
    return items;
  })
});

// src/components/unknownError.tsx
var import_api = require("@raycast/api");
var import_jsx_runtime = require("react/jsx-runtime");
var UnknownError = ({ error }) => /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api.Detail, {
  markdown: [
    "# Oops! Something went wrong!",
    "Please check error for more information.",
    "```error",
    error.stack,
    "```"
  ].join("\n")
});

// src/components/commandNotFoundError.tsx
var import_api2 = require("@raycast/api");
var import_jsx_runtime = require("react/jsx-runtime");
var CommandNotFoundError = () => /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api2.Detail, {
  markdown: [
    "# LastPass CLI is missing!",
    "Please make sure that",
    "",
    "1. LastPass cli is [correctly installed](https://github.com/lastpass/lastpass-cli#installing-on-os-x)",
    "2. Command `zsh -l -c 'lpass status'` passes"
  ].join("\n"),
  actions: /* @__PURE__ */ (0, import_jsx_runtime.jsxs)(import_api2.ActionPanel, {
    children: [
      /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api2.Action.CopyToClipboard, {
        title: "Copy Homebrew Installation Command",
        content: "brew install lastpass-cli"
      }),
      /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api2.Action.OpenInBrowser, {
        url: "https://github.com/lastpass/lastpass-cli#installing-on-os-x"
      })
    ]
  })
});

// src/components/accountDetail.tsx
var import_api4 = require("@raycast/api");
var import_react = require("react");

// src/utils.ts
var import_api3 = require("@raycast/api");
var import_utils = __toESM(require_dist());
var isValidUrl = (urlLike) => urlLike && urlLike !== "http://sn";
var getDomainFavicon = (url) => {
  if (!url) {
    return import_api3.Icon.Key;
  }
  try {
    new URL(url || "");
    return (0, import_utils.getFavicon)(url);
  } catch {
    return import_api3.Icon.Key;
  }
};

// src/components/accountDetail.tsx
var import_jsx_runtime = require("react/jsx-runtime");
var AccountDetail = (args) => {
  const [data, setData] = (0, import_react.useState)();
  const [error, setError] = (0, import_react.useState)();
  (0, import_react.useEffect)(() => {
    (async () => args.getData().then(setData, setError))();
  }, []);
  return error ? /* @__PURE__ */ (0, import_jsx_runtime.jsx)(UnknownError, {
    error
  }) : /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.List.Item.Detail, {
    isLoading: !data,
    markdown: data?.note && data.note.split("\n").join("\n"),
    metadata: data && /* @__PURE__ */ (0, import_jsx_runtime.jsxs)(import_api4.List.Item.Detail.Metadata, {
      children: [
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "ID",
          text: data.id
        }),
        isValidUrl(data.url) && /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Url",
          text: data.url
        }),
        data.username && /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Username",
          text: data.username
        }),
        data.password && /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Password",
          text: data.password
        }),
        data.group && /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Group",
          text: data.group
        }),
        data.fullname && /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Full Name",
          text: data.fullname
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Last modified",
          text: `${data.lastModified.toLocaleTimeString()} - ${data.lastModified.toLocaleDateString()}`
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api4.Detail.Metadata.Label, {
          title: "Last touched",
          text: `${data.lastTouch.toLocaleTimeString()} - ${data.lastTouch.toLocaleDateString()}`
        })
      ]
    })
  });
};

// src/components/emptyListView.tsx
var import_api5 = require("@raycast/api");
var import_jsx_runtime = require("react/jsx-runtime");
var EmptyListView = () => /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api5.List.EmptyView, {
  title: "Sorry, you have no accounts"
});

// src/components/listItem.tsx
var import_api6 = require("@raycast/api");
var import_jsx_runtime = require("react/jsx-runtime");
var ListItem = (props) => /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.List.Item, {
  id: props.id,
  icon: getDomainFavicon(props.url),
  title: props.name,
  detail: /* @__PURE__ */ (0, import_jsx_runtime.jsx)(AccountDetail, {
    getData: props.getDetails
  }),
  keywords: [props.id],
  actions: /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.ActionPanel, {
    children: /* @__PURE__ */ (0, import_jsx_runtime.jsxs)(import_api6.ActionPanel.Section, {
      children: [
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.Action.Paste, {
          icon: import_api6.Icon.Clipboard,
          title: "Paste Password",
          shortcut: { modifiers: [], key: "enter" },
          content: props.password || ""
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.Action.CopyToClipboard, {
          icon: import_api6.Icon.Clipboard,
          title: "Paste Username",
          shortcut: { modifiers: ["shift"], key: "enter" },
          content: props.username || ""
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.Action.CopyToClipboard, {
          icon: import_api6.Icon.Clipboard,
          title: "Copy Password",
          shortcut: { modifiers: ["cmd"], key: "p" },
          content: props.password || ""
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.Action.CopyToClipboard, {
          icon: import_api6.Icon.Clipboard,
          title: "Copy Username",
          shortcut: { modifiers: ["cmd"], key: "u" },
          content: props.username || ""
        }),
        /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api6.Action.CopyToClipboard, {
          icon: import_api6.Icon.Clipboard,
          title: "Copy Url",
          shortcut: { modifiers: ["cmd"], key: "l" },
          content: props.url || ""
        })
      ]
    })
  })
}, props.id);

// src/components/errorDetails.tsx
var import_api7 = require("@raycast/api");
var import_jsx_runtime = require("react/jsx-runtime");
var ErrorDetails = (args) => {
  if (args.error.message.includes("command not found")) {
    (0, import_api7.showToast)({
      style: import_api7.Toast.Style.Failure,
      title: "LastPass CLI not found",
      message: args.error.message
    });
    return /* @__PURE__ */ (0, import_jsx_runtime.jsx)(CommandNotFoundError, {});
  } else {
    (0, import_api7.showToast)({
      style: import_api7.Toast.Style.Failure,
      title: "Something went wrong",
      message: args.error.message
    });
    return /* @__PURE__ */ (0, import_jsx_runtime.jsx)(UnknownError, {
      error: args.error
    });
  }
};

// src/index.tsx
var import_jsx_runtime = require("react/jsx-runtime");
var calculateSyncState = async (syncRate) => {
  const localStorageKey = "lastpass-sync-timestamp";
  const currentTimestamp = Date.now();
  const lastSyncTimestamp = await import_api8.LocalStorage.getItem(localStorageKey) || currentTimestamp;
  await import_api8.LocalStorage.setItem(localStorageKey, currentTimestamp);
  const timestampDiff = parseInt(syncRate, 10);
  const isSyncNow = currentTimestamp - lastSyncTimestamp > timestampDiff;
  return isSyncNow ? "now" : "no";
};
function Command() {
  const { email, password, syncRate } = (0, import_api8.getPreferenceValues)();
  const api = lastPass(email, password);
  const [isLoading, setIsLoading] = (0, import_react2.useState)(true);
  const [accounts, setAccounts] = (0, import_react2.useState)([]);
  const [error, setError] = (0, import_react2.useState)(null);
  (0, import_react2.useEffect)(() => {
    (async () => {
      try {
        const isLogged = await api.isLogged();
        if (!isLogged) {
          await api.login();
        }
        const accounts2 = await calculateSyncState(syncRate).then((sync) => api.list({ sync }));
        setAccounts(accounts2);
        setIsLoading(false);
      } catch (error2) {
        if (error2 instanceof Error) {
          setError(error2);
        }
      }
    })();
  }, []);
  if (error) {
    return /* @__PURE__ */ (0, import_jsx_runtime.jsx)(ErrorDetails, {
      error
    });
  }
  const actions = /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api8.ActionPanel, {
    children: /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api8.ActionPanel.Section, {
      children: /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api8.Action, {
        icon: import_api8.Icon.ArrowClockwise,
        title: "Manual Sync",
        shortcut: { modifiers: ["cmd"], key: "s" },
        onAction: () => api.export({ sync: "now" }).then(setAccounts, setError)
      })
    })
  });
  return /* @__PURE__ */ (0, import_jsx_runtime.jsx)(import_api8.List, {
    isLoading,
    isShowingDetail: true,
    actions,
    children: !accounts.length ? /* @__PURE__ */ (0, import_jsx_runtime.jsx)(EmptyListView, {}) : accounts.map((account) => /* @__PURE__ */ (0, import_jsx_runtime.jsx)(ListItem, {
      ...account,
      getDetails: () => calculateSyncState(syncRate).then((sync) => api.show(account.id, { sync }))
    }))
  });
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {});
/*!
 * content-type
 * Copyright(c) 2015 Douglas Christopher Wilson
 * MIT Licensed
 */
/*!
 * media-typer
 * Copyright(c) 2014-2017 Douglas Christopher Wilson
 * MIT Licensed
 */
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL2RlcXVhbC9saXRlL2luZGV4LmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L3VzZURlZXBNZW1vLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L3VzZUxhdGVzdC5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvQHJheWNhc3QvdXRpbHMvZGlzdC91c2VQcm9taXNlLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L3VzZUNhY2hlZFN0YXRlLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9vYmplY3QtaGFzaC9pbmRleC5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvQHJheWNhc3QvdXRpbHMvZGlzdC91c2VDYWNoZWRQcm9taXNlLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9tZWRpYS10eXBlci9pbmRleC5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvY29udGVudC10eXBlL2luZGV4LmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy93ZWJpZGwtY29udmVyc2lvbnMvbGliL2luZGV4LmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy93aGF0d2ctdXJsL2xpYi91dGlscy5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvdHI0Ni9pbmRleC5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvd2hhdHdnLXVybC9saWIvdXJsLXN0YXRlLW1hY2hpbmUuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL3doYXR3Zy11cmwvbGliL1VSTC1pbXBsLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy93aGF0d2ctdXJsL2xpYi9VUkwuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL3doYXR3Zy11cmwvbGliL3B1YmxpYy1hcGkuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL25vZGUtZmV0Y2gvbGliL2luZGV4LmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9jcm9zcy1mZXRjaC9kaXN0L25vZGUtcG9ueWZpbGwuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL0ByYXljYXN0L3V0aWxzL2Rpc3QvdXNlRmV0Y2guanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL3NpZ25hbC1leGl0L3NpZ25hbHMuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL3NpZ25hbC1leGl0L2luZGV4LmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L2V4ZWMtdXRpbHMuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL0ByYXljYXN0L3V0aWxzL2Rpc3QvdXNlRXhlYy5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvQHJheWNhc3QvdXRpbHMvZGlzdC91c2VTUUwuanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL0ByYXljYXN0L3V0aWxzL2Rpc3QvdXNlRm9ybS5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvQHJheWNhc3QvdXRpbHMvZGlzdC9pY29uL2NvbG9yLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L2ljb24vYXZhdGFyLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L2ljb24vZmF2aWNvbi5qcyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9ub2RlX21vZHVsZXMvQHJheWNhc3QvdXRpbHMvZGlzdC9pY29uL3Byb2dyZXNzLmpzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL25vZGVfbW9kdWxlcy9AcmF5Y2FzdC91dGlscy9kaXN0L2ljb24vaW5kZXguanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvbm9kZV9tb2R1bGVzL0ByYXljYXN0L3V0aWxzL2Rpc3QvaW5kZXguanMiLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvc3JjL2luZGV4LnRzeCIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9zcmMvY2xpLnRzIiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL3NyYy9jb21wb25lbnRzL3Vua25vd25FcnJvci50c3giLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvc3JjL2NvbXBvbmVudHMvY29tbWFuZE5vdEZvdW5kRXJyb3IudHN4IiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL3NyYy9jb21wb25lbnRzL2FjY291bnREZXRhaWwudHN4IiwgIi4uLy4uLy4uLy4uL21lL3JheWNhc3QvZXh0ZW5zaW9ucy9leHRlbnNpb25zL2xhc3RwYXNzL3NyYy91dGlscy50cyIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9zcmMvY29tcG9uZW50cy9lbXB0eUxpc3RWaWV3LnRzeCIsICIuLi8uLi8uLi8uLi9tZS9yYXljYXN0L2V4dGVuc2lvbnMvZXh0ZW5zaW9ucy9sYXN0cGFzcy9zcmMvY29tcG9uZW50cy9saXN0SXRlbS50c3giLCAiLi4vLi4vLi4vLi4vbWUvcmF5Y2FzdC9leHRlbnNpb25zL2V4dGVuc2lvbnMvbGFzdHBhc3Mvc3JjL2NvbXBvbmVudHMvZXJyb3JEZXRhaWxzLnRzeCJdLAogICJzb3VyY2VzQ29udGVudCI6IFsidmFyIGhhcyA9IE9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHk7XG5cbmZ1bmN0aW9uIGRlcXVhbChmb28sIGJhcikge1xuXHR2YXIgY3RvciwgbGVuO1xuXHRpZiAoZm9vID09PSBiYXIpIHJldHVybiB0cnVlO1xuXG5cdGlmIChmb28gJiYgYmFyICYmIChjdG9yPWZvby5jb25zdHJ1Y3RvcikgPT09IGJhci5jb25zdHJ1Y3Rvcikge1xuXHRcdGlmIChjdG9yID09PSBEYXRlKSByZXR1cm4gZm9vLmdldFRpbWUoKSA9PT0gYmFyLmdldFRpbWUoKTtcblx0XHRpZiAoY3RvciA9PT0gUmVnRXhwKSByZXR1cm4gZm9vLnRvU3RyaW5nKCkgPT09IGJhci50b1N0cmluZygpO1xuXG5cdFx0aWYgKGN0b3IgPT09IEFycmF5KSB7XG5cdFx0XHRpZiAoKGxlbj1mb28ubGVuZ3RoKSA9PT0gYmFyLmxlbmd0aCkge1xuXHRcdFx0XHR3aGlsZSAobGVuLS0gJiYgZGVxdWFsKGZvb1tsZW5dLCBiYXJbbGVuXSkpO1xuXHRcdFx0fVxuXHRcdFx0cmV0dXJuIGxlbiA9PT0gLTE7XG5cdFx0fVxuXG5cdFx0aWYgKCFjdG9yIHx8IHR5cGVvZiBmb28gPT09ICdvYmplY3QnKSB7XG5cdFx0XHRsZW4gPSAwO1xuXHRcdFx0Zm9yIChjdG9yIGluIGZvbykge1xuXHRcdFx0XHRpZiAoaGFzLmNhbGwoZm9vLCBjdG9yKSAmJiArK2xlbiAmJiAhaGFzLmNhbGwoYmFyLCBjdG9yKSkgcmV0dXJuIGZhbHNlO1xuXHRcdFx0XHRpZiAoIShjdG9yIGluIGJhcikgfHwgIWRlcXVhbChmb29bY3Rvcl0sIGJhcltjdG9yXSkpIHJldHVybiBmYWxzZTtcblx0XHRcdH1cblx0XHRcdHJldHVybiBPYmplY3Qua2V5cyhiYXIpLmxlbmd0aCA9PT0gbGVuO1xuXHRcdH1cblx0fVxuXG5cdHJldHVybiBmb28gIT09IGZvbyAmJiBiYXIgIT09IGJhcjtcbn1cblxuZXhwb3J0cy5kZXF1YWwgPSBkZXF1YWw7IiwgIlwidXNlIHN0cmljdFwiO1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy51c2VEZWVwTWVtbyA9IHZvaWQgMDtcbmNvbnN0IHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XG5jb25zdCBsaXRlXzEgPSByZXF1aXJlKFwiZGVxdWFsL2xpdGVcIik7XG4vKipcbiAqIEBwYXJhbSB2YWx1ZSB0aGUgdmFsdWUgdG8gYmUgbWVtb2l6ZWQgKHVzdWFsbHkgYSBkZXBlbmRlbmN5IGxpc3QpXG4gKiBAcmV0dXJucyBhIG1lbW9pemVkIHZlcnNpb24gb2YgdGhlIHZhbHVlIGFzIGxvbmcgYXMgaXQgcmVtYWlucyBkZWVwbHkgZXF1YWxcbiAqL1xuZnVuY3Rpb24gdXNlRGVlcE1lbW8odmFsdWUpIHtcbiAgICBjb25zdCByZWYgPSAoMCwgcmVhY3RfMS51c2VSZWYpKHZhbHVlKTtcbiAgICBjb25zdCBzaWduYWxSZWYgPSAoMCwgcmVhY3RfMS51c2VSZWYpKDApO1xuICAgIGlmICghKDAsIGxpdGVfMS5kZXF1YWwpKHZhbHVlLCByZWYuY3VycmVudCkpIHtcbiAgICAgICAgcmVmLmN1cnJlbnQgPSB2YWx1ZTtcbiAgICAgICAgc2lnbmFsUmVmLmN1cnJlbnQgKz0gMTtcbiAgICB9XG4gICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIHJlYWN0LWhvb2tzL2V4aGF1c3RpdmUtZGVwc1xuICAgIHJldHVybiAoMCwgcmVhY3RfMS51c2VNZW1vKSgoKSA9PiByZWYuY3VycmVudCwgW3NpZ25hbFJlZi5jdXJyZW50XSk7XG59XG5leHBvcnRzLnVzZURlZXBNZW1vID0gdXNlRGVlcE1lbW87XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLnVzZUxhdGVzdCA9IHZvaWQgMDtcbmNvbnN0IHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XG4vKipcbiAqIFJldHVybnMgdGhlIGxhdGVzdCBzdGF0ZS5cbiAqXG4gKiBUaGlzIGlzIG1vc3RseSB1c2VmdWwgdG8gZ2V0IGFjY2VzcyB0byB0aGUgbGF0ZXN0IHZhbHVlIG9mIHNvbWUgcHJvcHMgb3Igc3RhdGUgaW5zaWRlIGFuIGFzeW5jaHJvbm91cyBjYWxsYmFjaywgaW5zdGVhZCBvZiB0aGF0IHZhbHVlIGF0IHRoZSB0aW1lIHRoZSBjYWxsYmFjayB3YXMgY3JlYXRlZCBmcm9tLlxuICovXG5mdW5jdGlvbiB1c2VMYXRlc3QodmFsdWUpIHtcbiAgICBjb25zdCByZWYgPSAoMCwgcmVhY3RfMS51c2VSZWYpKHZhbHVlKTtcbiAgICByZWYuY3VycmVudCA9IHZhbHVlO1xuICAgIHJldHVybiByZWY7XG59XG5leHBvcnRzLnVzZUxhdGVzdCA9IHVzZUxhdGVzdDtcbiIsICJcInVzZSBzdHJpY3RcIjtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMudXNlUHJvbWlzZSA9IHZvaWQgMDtcbmNvbnN0IHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XG5jb25zdCBhcGlfMSA9IHJlcXVpcmUoXCJAcmF5Y2FzdC9hcGlcIik7XG5jb25zdCB1c2VEZWVwTWVtb18xID0gcmVxdWlyZShcIi4vdXNlRGVlcE1lbW9cIik7XG5jb25zdCB1c2VMYXRlc3RfMSA9IHJlcXVpcmUoXCIuL3VzZUxhdGVzdFwiKTtcbmZ1bmN0aW9uIHVzZVByb21pc2UoZm4sIGFyZ3MsIG9wdGlvbnMpIHtcbiAgICBjb25zdCBsYXN0Q2FsbElkID0gKDAsIHJlYWN0XzEudXNlUmVmKSgwKTtcbiAgICBjb25zdCBbc3RhdGUsIHNldF0gPSAoMCwgcmVhY3RfMS51c2VTdGF0ZSkoeyBpc0xvYWRpbmc6IHRydWUgfSk7XG4gICAgY29uc3QgZm5SZWYgPSAoMCwgdXNlTGF0ZXN0XzEudXNlTGF0ZXN0KShmbik7XG4gICAgY29uc3QgbGF0ZXN0QWJvcnRhYmxlID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkob3B0aW9ucz8uYWJvcnRhYmxlKTtcbiAgICBjb25zdCBsYXRlc3RBcmdzID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkoYXJncyB8fCBbXSk7XG4gICAgY29uc3QgbGF0ZXN0T25FcnJvciA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKG9wdGlvbnM/Lm9uRXJyb3IpO1xuICAgIGNvbnN0IGxhdGVzdE9uRGF0YSA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKG9wdGlvbnM/Lm9uRGF0YSk7XG4gICAgY29uc3QgbGF0ZXN0T25XaWxsRXhlY3V0ZSA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKG9wdGlvbnM/Lm9uV2lsbEV4ZWN1dGUpO1xuICAgIGNvbnN0IGxhdGVzdFZhbHVlID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkoc3RhdGUuZGF0YSk7XG4gICAgY29uc3QgbGF0ZXN0Q2FsbGJhY2sgPSAoMCwgcmVhY3RfMS51c2VSZWYpKCk7XG4gICAgY29uc3QgY2FsbGJhY2sgPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoKC4uLmFyZ3MpID0+IHtcbiAgICAgICAgY29uc3QgY2FsbElkID0gKytsYXN0Q2FsbElkLmN1cnJlbnQ7XG4gICAgICAgIGlmIChsYXRlc3RBYm9ydGFibGUuY3VycmVudCkge1xuICAgICAgICAgICAgbGF0ZXN0QWJvcnRhYmxlLmN1cnJlbnQuY3VycmVudD8uYWJvcnQoKTtcbiAgICAgICAgICAgIGxhdGVzdEFib3J0YWJsZS5jdXJyZW50LmN1cnJlbnQgPSBuZXcgQWJvcnRDb250cm9sbGVyKCk7XG4gICAgICAgIH1cbiAgICAgICAgbGF0ZXN0T25XaWxsRXhlY3V0ZS5jdXJyZW50Py4oYXJncyk7XG4gICAgICAgIHNldCgocHJldlN0YXRlKSA9PiAoeyAuLi5wcmV2U3RhdGUsIGlzTG9hZGluZzogdHJ1ZSB9KSk7XG4gICAgICAgIHJldHVybiBmblJlZi5jdXJyZW50KC4uLmFyZ3MpLnRoZW4oKGRhdGEpID0+IHtcbiAgICAgICAgICAgIGlmIChjYWxsSWQgPT09IGxhc3RDYWxsSWQuY3VycmVudCkge1xuICAgICAgICAgICAgICAgIGlmIChsYXRlc3RPbkRhdGEuY3VycmVudCkge1xuICAgICAgICAgICAgICAgICAgICBsYXRlc3RPbkRhdGEuY3VycmVudChkYXRhKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgc2V0KHsgZGF0YSwgaXNMb2FkaW5nOiBmYWxzZSB9KTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHJldHVybiBkYXRhO1xuICAgICAgICB9LCAoZXJyb3IpID0+IHtcbiAgICAgICAgICAgIGlmIChlcnJvci5uYW1lID09IFwiQWJvcnRFcnJvclwiKSB7XG4gICAgICAgICAgICAgICAgcmV0dXJuIGVycm9yO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKGNhbGxJZCA9PT0gbGFzdENhbGxJZC5jdXJyZW50KSB7XG4gICAgICAgICAgICAgICAgLy8gaGFuZGxlIGVycm9yc1xuICAgICAgICAgICAgICAgIGlmIChsYXRlc3RPbkVycm9yLmN1cnJlbnQpIHtcbiAgICAgICAgICAgICAgICAgICAgbGF0ZXN0T25FcnJvci5jdXJyZW50KGVycm9yKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnNvbGUuZXJyb3IoZXJyb3IpO1xuICAgICAgICAgICAgICAgICAgICBpZiAoYXBpXzEuZW52aXJvbm1lbnQubGF1bmNoVHlwZSAhPT0gYXBpXzEuTGF1bmNoVHlwZS5CYWNrZ3JvdW5kKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAoMCwgYXBpXzEuc2hvd1RvYXN0KSh7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc3R5bGU6IGFwaV8xLlRvYXN0LlN0eWxlLkZhaWx1cmUsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdGl0bGU6IFwiRmFpbGVkIHRvIGZldGNoIGxhdGVzdCBkYXRhXCIsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogZXJyb3IubWVzc2FnZSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmltYXJ5QWN0aW9uOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRpdGxlOiBcIlJldHJ5XCIsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9uQWN0aW9uKHRvYXN0KSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0b2FzdC5oaWRlKCk7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYXRlc3RDYWxsYmFjay5jdXJyZW50Py4oLi4uKGxhdGVzdEFyZ3MuY3VycmVudCB8fCBbXSkpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc2Vjb25kYXJ5QWN0aW9uOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRpdGxlOiBcIkNvcHkgTG9nc1wiLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvbkFjdGlvbih0b2FzdCkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdG9hc3QuaGlkZSgpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXBpXzEuQ2xpcGJvYXJkLmNvcHkoZXJyb3I/LnN0YWNrIHx8IGVycm9yPy5tZXNzYWdlIHx8IFwiXCIpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBzZXQoeyBlcnJvciwgaXNMb2FkaW5nOiBmYWxzZSB9KTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIHJldHVybiBlcnJvcjtcbiAgICAgICAgfSk7XG4gICAgfSwgW2xhdGVzdEFib3J0YWJsZSwgbGF0ZXN0T25EYXRhLCBsYXRlc3RPbkVycm9yLCBsYXRlc3RBcmdzLCBmblJlZiwgc2V0LCBsYXRlc3RDYWxsYmFjaywgbGF0ZXN0T25XaWxsRXhlY3V0ZV1cbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgQHR5cGVzY3JpcHQtZXNsaW50L25vLWV4cGxpY2l0LWFueVxuICAgICk7XG4gICAgbGF0ZXN0Q2FsbGJhY2suY3VycmVudCA9IGNhbGxiYWNrO1xuICAgIGNvbnN0IHJldmFsaWRhdGUgPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoKCkgPT4ge1xuICAgICAgICByZXR1cm4gY2FsbGJhY2soLi4uKGxhdGVzdEFyZ3MuY3VycmVudCB8fCBbXSkpO1xuICAgIH0sIFtjYWxsYmFjaywgbGF0ZXN0QXJnc10pO1xuICAgIGNvbnN0IG11dGF0ZSA9ICgwLCByZWFjdF8xLnVzZUNhbGxiYWNrKShhc3luYyAoYXN5bmNVcGRhdGUsIG9wdGlvbnMpID0+IHtcbiAgICAgICAgbGV0IGRhdGFCZWZvcmVPcHRpbWlzdGljVXBkYXRlO1xuICAgICAgICB0cnkge1xuICAgICAgICAgICAgaWYgKG9wdGlvbnM/Lm9wdGltaXN0aWNVcGRhdGUpIHtcbiAgICAgICAgICAgICAgICBpZiAodHlwZW9mIG9wdGlvbnM/LnJvbGxiYWNrT25FcnJvciAhPT0gXCJmdW5jdGlvblwiICYmIG9wdGlvbnM/LnJvbGxiYWNrT25FcnJvciAhPT0gZmFsc2UpIHtcbiAgICAgICAgICAgICAgICAgICAgLy8ga2VlcCB0cmFjayBvZiB0aGUgZGF0YSBiZWZvcmUgdGhlIG9wdGltaXN0aWMgdXBkYXRlLFxuICAgICAgICAgICAgICAgICAgICAvLyBidXQgb25seSBpZiB3ZSBuZWVkIGl0IChlZy4gb25seSB3aGVuIHdlIHdhbnQgdG8gYXV0b21hdGljYWxseSByb2xsYmFjayBhZnRlcilcbiAgICAgICAgICAgICAgICAgICAgZGF0YUJlZm9yZU9wdGltaXN0aWNVcGRhdGUgPSBzdHJ1Y3R1cmVkQ2xvbmUobGF0ZXN0VmFsdWUuY3VycmVudD8udmFsdWUpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBjb25zdCB1cGRhdGUgPSBvcHRpb25zLm9wdGltaXN0aWNVcGRhdGU7XG4gICAgICAgICAgICAgICAgc2V0KChwcmV2U3RhdGUpID0+ICh7IC4uLnByZXZTdGF0ZSwgZGF0YTogdXBkYXRlKHByZXZTdGF0ZS5kYXRhKSB9KSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICByZXR1cm4gYXdhaXQgYXN5bmNVcGRhdGU7XG4gICAgICAgIH1cbiAgICAgICAgY2F0Y2ggKGVycikge1xuICAgICAgICAgICAgaWYgKHR5cGVvZiBvcHRpb25zPy5yb2xsYmFja09uRXJyb3IgPT09IFwiZnVuY3Rpb25cIikge1xuICAgICAgICAgICAgICAgIGNvbnN0IHVwZGF0ZSA9IG9wdGlvbnMucm9sbGJhY2tPbkVycm9yO1xuICAgICAgICAgICAgICAgIHNldCgocHJldlN0YXRlKSA9PiAoeyAuLi5wcmV2U3RhdGUsIGRhdGE6IHVwZGF0ZShwcmV2U3RhdGUuZGF0YSkgfSkpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgZWxzZSBpZiAob3B0aW9ucz8ub3B0aW1pc3RpY1VwZGF0ZSAmJiBvcHRpb25zPy5yb2xsYmFja09uRXJyb3IgIT09IGZhbHNlKSB7XG4gICAgICAgICAgICAgICAgc2V0KChwcmV2U3RhdGUpID0+ICh7IC4uLnByZXZTdGF0ZSwgZGF0YTogZGF0YUJlZm9yZU9wdGltaXN0aWNVcGRhdGUgfSkpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgdGhyb3cgZXJyO1xuICAgICAgICB9XG4gICAgICAgIGZpbmFsbHkge1xuICAgICAgICAgICAgaWYgKG9wdGlvbnM/LnNob3VsZFJldmFsaWRhdGVBZnRlciAhPT0gZmFsc2UpIHtcbiAgICAgICAgICAgICAgICBpZiAoYXBpXzEuZW52aXJvbm1lbnQubGF1bmNoVHlwZSA9PT0gYXBpXzEuTGF1bmNoVHlwZS5CYWNrZ3JvdW5kIHx8IGFwaV8xLmVudmlyb25tZW50LmNvbW1hbmRNb2RlID09PSBcIm1lbnUtYmFyXCIpIHtcbiAgICAgICAgICAgICAgICAgICAgLy8gd2hlbiBpbiB0aGUgYmFja2dyb3VuZCBvciBpbiBhIG1lbnUgYmFyLCB3ZSBhcmUgZ29pbmcgdG8gYXdhaXQgdGhlIHJldmFsaWRhdGlvblxuICAgICAgICAgICAgICAgICAgICAvLyB0byBtYWtlIHN1cmUgd2UgZ2V0IHRoZSByaWdodCBkYXRhIGF0IHRoZSBlbmQgb2YgdGhlIG11dGF0aW9uXG4gICAgICAgICAgICAgICAgICAgIGF3YWl0IHJldmFsaWRhdGUoKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIHJldmFsaWRhdGUoKTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICB9LCBbcmV2YWxpZGF0ZSwgbGF0ZXN0VmFsdWUsIHNldF0pO1xuICAgIC8vIHJldmFsaWRhdGUgd2hlbiB0aGUgYXJncyBjaGFuZ2VcbiAgICAoMCwgcmVhY3RfMS51c2VFZmZlY3QpKCgpID0+IHtcbiAgICAgICAgaWYgKG9wdGlvbnM/LmV4ZWN1dGUgIT09IGZhbHNlKSB7XG4gICAgICAgICAgICBjYWxsYmFjayguLi4oYXJncyB8fCBbXSkpO1xuICAgICAgICB9XG4gICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSByZWFjdC1ob29rcy9leGhhdXN0aXZlLWRlcHNcbiAgICB9LCBbKDAsIHVzZURlZXBNZW1vXzEudXNlRGVlcE1lbW8pKFthcmdzLCBvcHRpb25zPy5leGVjdXRlLCBjYWxsYmFja10pXSk7XG4gICAgLy8gYWJvcnQgcmVxdWVzdCB3aGVuIHVubW91bnRpbmdcbiAgICAoMCwgcmVhY3RfMS51c2VFZmZlY3QpKCgpID0+IHtcbiAgICAgICAgcmV0dXJuICgpID0+IHtcbiAgICAgICAgICAgIGlmIChsYXRlc3RBYm9ydGFibGUuY3VycmVudCkge1xuICAgICAgICAgICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSByZWFjdC1ob29rcy9leGhhdXN0aXZlLWRlcHNcbiAgICAgICAgICAgICAgICBsYXRlc3RBYm9ydGFibGUuY3VycmVudC5jdXJyZW50Py5hYm9ydCgpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9O1xuICAgIH0sIFtsYXRlc3RBYm9ydGFibGVdKTtcbiAgICByZXR1cm4geyAuLi5zdGF0ZSwgcmV2YWxpZGF0ZSwgbXV0YXRlIH07XG59XG5leHBvcnRzLnVzZVByb21pc2UgPSB1c2VQcm9taXNlO1xuIiwgIlwidXNlIHN0cmljdFwiO1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy51c2VDYWNoZWRTdGF0ZSA9IHZvaWQgMDtcbmNvbnN0IHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XG5jb25zdCBhcGlfMSA9IHJlcXVpcmUoXCJAcmF5Y2FzdC9hcGlcIik7XG5jb25zdCB1c2VMYXRlc3RfMSA9IHJlcXVpcmUoXCIuL3VzZUxhdGVzdFwiKTtcbi8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAdHlwZXNjcmlwdC1lc2xpbnQvbm8tZXhwbGljaXQtYW55XG5mdW5jdGlvbiByZXBsYWNlcihrZXksIF92YWx1ZSkge1xuICAgIGNvbnN0IHZhbHVlID0gdGhpc1trZXldO1xuICAgIGlmICh2YWx1ZSBpbnN0YW5jZW9mIERhdGUpIHtcbiAgICAgICAgcmV0dXJuIGBfX3JheWNhc3RfY2FjaGVkX2RhdGVfXyR7dmFsdWUudG9TdHJpbmcoKX1gO1xuICAgIH1cbiAgICBpZiAoQnVmZmVyLmlzQnVmZmVyKHZhbHVlKSkge1xuICAgICAgICByZXR1cm4gYF9fcmF5Y2FzdF9jYWNoZWRfYnVmZmVyX18ke3ZhbHVlLnRvU3RyaW5nKFwiYmFzZTY0XCIpfWA7XG4gICAgfVxuICAgIHJldHVybiBfdmFsdWU7XG59XG5mdW5jdGlvbiByZXZpdmVyKF9rZXksIHZhbHVlKSB7XG4gICAgaWYgKHR5cGVvZiB2YWx1ZSA9PT0gXCJzdHJpbmdcIiAmJiB2YWx1ZS5zdGFydHNXaXRoKFwiX19yYXljYXN0X2NhY2hlZF9kYXRlX19cIikpIHtcbiAgICAgICAgcmV0dXJuIG5ldyBEYXRlKHZhbHVlLnJlcGxhY2UoXCJfX3JheWNhc3RfY2FjaGVkX2RhdGVfX1wiLCBcIlwiKSk7XG4gICAgfVxuICAgIGlmICh0eXBlb2YgdmFsdWUgPT09IFwic3RyaW5nXCIgJiYgdmFsdWUuc3RhcnRzV2l0aChcIl9fcmF5Y2FzdF9jYWNoZWRfYnVmZmVyX19cIikpIHtcbiAgICAgICAgcmV0dXJuIEJ1ZmZlci5mcm9tKHZhbHVlLnJlcGxhY2UoXCJfX3JheWNhc3RfY2FjaGVkX2J1ZmZlcl9fXCIsIFwiXCIpLCBcImJhc2U2NFwiKTtcbiAgICB9XG4gICAgcmV0dXJuIHZhbHVlO1xufVxuY29uc3Qgcm9vdENhY2hlID0gU3ltYm9sKFwiY2FjaGUgd2l0aG91dCBuYW1lc3BhY2VcIik7XG5jb25zdCBjYWNoZU1hcCA9IG5ldyBNYXAoKTtcbmZ1bmN0aW9uIHVzZUNhY2hlZFN0YXRlKGtleSwgaW5pdGlhbFN0YXRlLCBjb25maWcpIHtcbiAgICBjb25zdCBjYWNoZUtleSA9IGNvbmZpZz8uY2FjaGVOYW1lc3BhY2UgfHwgcm9vdENhY2hlO1xuICAgIGNvbnN0IGNhY2hlID0gY2FjaGVNYXAuZ2V0KGNhY2hlS2V5KSB8fCBjYWNoZU1hcC5zZXQoY2FjaGVLZXksIG5ldyBhcGlfMS5DYWNoZSh7IG5hbWVzcGFjZTogY29uZmlnPy5jYWNoZU5hbWVzcGFjZSB9KSkuZ2V0KGNhY2hlS2V5KTtcbiAgICBpZiAoIWNhY2hlKSB7XG4gICAgICAgIHRocm93IG5ldyBFcnJvcihcIk1pc3NpbmcgY2FjaGVcIik7XG4gICAgfVxuICAgIGNvbnN0IGtleVJlZiA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKGtleSk7XG4gICAgY29uc3QgaW5pdGlhbFZhbHVlUmVmID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkoaW5pdGlhbFN0YXRlKTtcbiAgICBjb25zdCBjYWNoZWRTdGF0ZSA9ICgwLCByZWFjdF8xLnVzZVN5bmNFeHRlcm5hbFN0b3JlKShjYWNoZS5zdWJzY3JpYmUsICgpID0+IHtcbiAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgIHJldHVybiBjYWNoZS5nZXQoa2V5UmVmLmN1cnJlbnQpO1xuICAgICAgICB9XG4gICAgICAgIGNhdGNoIChlcnJvcikge1xuICAgICAgICAgICAgY29uc29sZS5lcnJvcihcIkNvdWxkIG5vdCBnZXQgQ2FjaGUgZGF0YTpcIiwgZXJyb3IpO1xuICAgICAgICAgICAgcmV0dXJuIHVuZGVmaW5lZDtcbiAgICAgICAgfVxuICAgIH0pO1xuICAgIGNvbnN0IHN0YXRlID0gKDAsIHJlYWN0XzEudXNlTWVtbykoKCkgPT4ge1xuICAgICAgICBpZiAodHlwZW9mIGNhY2hlZFN0YXRlICE9PSBcInVuZGVmaW5lZFwiKSB7XG4gICAgICAgICAgICBpZiAoY2FjaGVkU3RhdGUgPT09IFwidW5kZWZpbmVkXCIpIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gdW5kZWZpbmVkO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgdHJ5IHtcbiAgICAgICAgICAgICAgICByZXR1cm4gSlNPTi5wYXJzZShjYWNoZWRTdGF0ZSwgcmV2aXZlcik7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBjYXRjaCAoZXJyKSB7XG4gICAgICAgICAgICAgICAgLy8gdGhlIGRhdGEgZ290IGNvcnJ1cHRlZCBzb21laG93XG4gICAgICAgICAgICAgICAgY29uc29sZS53YXJuKFwiVGhlIGNhY2hlZCBkYXRhIGlzIGNvcnJ1cHRlZFwiLCBlcnIpO1xuICAgICAgICAgICAgICAgIHJldHVybiBpbml0aWFsVmFsdWVSZWYuY3VycmVudDtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgICBlbHNlIHtcbiAgICAgICAgICAgIHJldHVybiBpbml0aWFsVmFsdWVSZWYuY3VycmVudDtcbiAgICAgICAgfVxuICAgIH0sIFtjYWNoZWRTdGF0ZSwgaW5pdGlhbFZhbHVlUmVmXSk7XG4gICAgY29uc3Qgc3RhdGVSZWYgPSAoMCwgdXNlTGF0ZXN0XzEudXNlTGF0ZXN0KShzdGF0ZSk7XG4gICAgY29uc3Qgc2V0U3RhdGVBbmRDYWNoZSA9ICgwLCByZWFjdF8xLnVzZUNhbGxiYWNrKSgodXBkYXRlcikgPT4ge1xuICAgICAgICAvLyBAdHMtZXhwZWN0LWVycm9yIFRTIHN0cnVnZ2xlcyB0byBpbmZlciB0aGUgdHlwZXMgYXMgVCBjb3VsZCBwb3RlbnRpYWxseSBiZSBhIGZ1bmN0aW9uXG4gICAgICAgIGNvbnN0IG5ld1ZhbHVlID0gdHlwZW9mIHVwZGF0ZXIgPT09IFwiZnVuY3Rpb25cIiA/IHVwZGF0ZXIoc3RhdGVSZWYuY3VycmVudCkgOiB1cGRhdGVyO1xuICAgICAgICBpZiAodHlwZW9mIG5ld1ZhbHVlID09PSBcInVuZGVmaW5lZFwiKSB7XG4gICAgICAgICAgICBjYWNoZS5zZXQoa2V5UmVmLmN1cnJlbnQsIFwidW5kZWZpbmVkXCIpO1xuICAgICAgICB9XG4gICAgICAgIGVsc2Uge1xuICAgICAgICAgICAgY29uc3Qgc3RyaW5naWZpZWRWYWx1ZSA9IEpTT04uc3RyaW5naWZ5KG5ld1ZhbHVlLCByZXBsYWNlcik7XG4gICAgICAgICAgICBjYWNoZS5zZXQoa2V5UmVmLmN1cnJlbnQsIHN0cmluZ2lmaWVkVmFsdWUpO1xuICAgICAgICB9XG4gICAgICAgIHJldHVybiBuZXdWYWx1ZTtcbiAgICB9LCBbY2FjaGUsIGtleVJlZiwgc3RhdGVSZWZdKTtcbiAgICByZXR1cm4gW3N0YXRlLCBzZXRTdGF0ZUFuZENhY2hlXTtcbn1cbmV4cG9ydHMudXNlQ2FjaGVkU3RhdGUgPSB1c2VDYWNoZWRTdGF0ZTtcbiIsICIndXNlIHN0cmljdCc7XG5cbnZhciBjcnlwdG8gPSByZXF1aXJlKCdjcnlwdG8nKTtcblxuLyoqXG4gKiBFeHBvcnRlZCBmdW5jdGlvblxuICpcbiAqIE9wdGlvbnM6XG4gKlxuICogIC0gYGFsZ29yaXRobWAgaGFzaCBhbGdvIHRvIGJlIHVzZWQgYnkgdGhpcyBpbnN0YW5jZTogKidzaGExJywgJ21kNSdcbiAqICAtIGBleGNsdWRlVmFsdWVzYCB7dHJ1ZXwqZmFsc2V9IGhhc2ggb2JqZWN0IGtleXMsIHZhbHVlcyBpZ25vcmVkXG4gKiAgLSBgZW5jb2RpbmdgIGhhc2ggZW5jb2RpbmcsIHN1cHBvcnRzICdidWZmZXInLCAnKmhleCcsICdiaW5hcnknLCAnYmFzZTY0J1xuICogIC0gYGlnbm9yZVVua25vd25gIHt0cnVlfCpmYWxzZX0gaWdub3JlIHVua25vd24gb2JqZWN0IHR5cGVzXG4gKiAgLSBgcmVwbGFjZXJgIG9wdGlvbmFsIGZ1bmN0aW9uIHRoYXQgcmVwbGFjZXMgdmFsdWVzIGJlZm9yZSBoYXNoaW5nXG4gKiAgLSBgcmVzcGVjdEZ1bmN0aW9uUHJvcGVydGllc2Ageyp0cnVlfGZhbHNlfSBjb25zaWRlciBmdW5jdGlvbiBwcm9wZXJ0aWVzIHdoZW4gaGFzaGluZ1xuICogIC0gYHJlc3BlY3RGdW5jdGlvbk5hbWVzYCB7KnRydWV8ZmFsc2V9IGNvbnNpZGVyICduYW1lJyBwcm9wZXJ0eSBvZiBmdW5jdGlvbnMgZm9yIGhhc2hpbmdcbiAqICAtIGByZXNwZWN0VHlwZWAgeyp0cnVlfGZhbHNlfSBSZXNwZWN0IHNwZWNpYWwgcHJvcGVydGllcyAocHJvdG90eXBlLCBjb25zdHJ1Y3RvcilcbiAqICAgIHdoZW4gaGFzaGluZyB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHR5cGVzXG4gKiAgLSBgdW5vcmRlcmVkQXJyYXlzYCB7dHJ1ZXwqZmFsc2V9IFNvcnQgYWxsIGFycmF5cyBiZWZvcmUgaGFzaGluZ1xuICogIC0gYHVub3JkZXJlZFNldHNgIHsqdHJ1ZXxmYWxzZX0gU29ydCBgU2V0YCBhbmQgYE1hcGAgaW5zdGFuY2VzIGJlZm9yZSBoYXNoaW5nXG4gKiAgKiA9IGRlZmF1bHRcbiAqXG4gKiBAcGFyYW0ge29iamVjdH0gb2JqZWN0IHZhbHVlIHRvIGhhc2hcbiAqIEBwYXJhbSB7b2JqZWN0fSBvcHRpb25zIGhhc2hpbmcgb3B0aW9uc1xuICogQHJldHVybiB7c3RyaW5nfSBoYXNoIHZhbHVlXG4gKiBAYXBpIHB1YmxpY1xuICovXG5leHBvcnRzID0gbW9kdWxlLmV4cG9ydHMgPSBvYmplY3RIYXNoO1xuXG5mdW5jdGlvbiBvYmplY3RIYXNoKG9iamVjdCwgb3B0aW9ucyl7XG4gIG9wdGlvbnMgPSBhcHBseURlZmF1bHRzKG9iamVjdCwgb3B0aW9ucyk7XG5cbiAgcmV0dXJuIGhhc2gob2JqZWN0LCBvcHRpb25zKTtcbn1cblxuLyoqXG4gKiBFeHBvcnRlZCBzdWdhciBtZXRob2RzXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IG9iamVjdCB2YWx1ZSB0byBoYXNoXG4gKiBAcmV0dXJuIHtzdHJpbmd9IGhhc2ggdmFsdWVcbiAqIEBhcGkgcHVibGljXG4gKi9cbmV4cG9ydHMuc2hhMSA9IGZ1bmN0aW9uKG9iamVjdCl7XG4gIHJldHVybiBvYmplY3RIYXNoKG9iamVjdCk7XG59O1xuZXhwb3J0cy5rZXlzID0gZnVuY3Rpb24ob2JqZWN0KXtcbiAgcmV0dXJuIG9iamVjdEhhc2gob2JqZWN0LCB7ZXhjbHVkZVZhbHVlczogdHJ1ZSwgYWxnb3JpdGhtOiAnc2hhMScsIGVuY29kaW5nOiAnaGV4J30pO1xufTtcbmV4cG9ydHMuTUQ1ID0gZnVuY3Rpb24ob2JqZWN0KXtcbiAgcmV0dXJuIG9iamVjdEhhc2gob2JqZWN0LCB7YWxnb3JpdGhtOiAnbWQ1JywgZW5jb2Rpbmc6ICdoZXgnfSk7XG59O1xuZXhwb3J0cy5rZXlzTUQ1ID0gZnVuY3Rpb24ob2JqZWN0KXtcbiAgcmV0dXJuIG9iamVjdEhhc2gob2JqZWN0LCB7YWxnb3JpdGhtOiAnbWQ1JywgZW5jb2Rpbmc6ICdoZXgnLCBleGNsdWRlVmFsdWVzOiB0cnVlfSk7XG59O1xuXG4vLyBJbnRlcm5hbHNcbnZhciBoYXNoZXMgPSBjcnlwdG8uZ2V0SGFzaGVzID8gY3J5cHRvLmdldEhhc2hlcygpLnNsaWNlKCkgOiBbJ3NoYTEnLCAnbWQ1J107XG5oYXNoZXMucHVzaCgncGFzc3Rocm91Z2gnKTtcbnZhciBlbmNvZGluZ3MgPSBbJ2J1ZmZlcicsICdoZXgnLCAnYmluYXJ5JywgJ2Jhc2U2NCddO1xuXG5mdW5jdGlvbiBhcHBseURlZmF1bHRzKG9iamVjdCwgc291cmNlT3B0aW9ucyl7XG4gIHNvdXJjZU9wdGlvbnMgPSBzb3VyY2VPcHRpb25zIHx8IHt9O1xuXG4gIC8vIGNyZWF0ZSBhIGNvcHkgcmF0aGVyIHRoYW4gbXV0YXRpbmdcbiAgdmFyIG9wdGlvbnMgPSB7fTtcbiAgb3B0aW9ucy5hbGdvcml0aG0gPSBzb3VyY2VPcHRpb25zLmFsZ29yaXRobSB8fCAnc2hhMSc7XG4gIG9wdGlvbnMuZW5jb2RpbmcgPSBzb3VyY2VPcHRpb25zLmVuY29kaW5nIHx8ICdoZXgnO1xuICBvcHRpb25zLmV4Y2x1ZGVWYWx1ZXMgPSBzb3VyY2VPcHRpb25zLmV4Y2x1ZGVWYWx1ZXMgPyB0cnVlIDogZmFsc2U7XG4gIG9wdGlvbnMuYWxnb3JpdGhtID0gb3B0aW9ucy5hbGdvcml0aG0udG9Mb3dlckNhc2UoKTtcbiAgb3B0aW9ucy5lbmNvZGluZyA9IG9wdGlvbnMuZW5jb2RpbmcudG9Mb3dlckNhc2UoKTtcbiAgb3B0aW9ucy5pZ25vcmVVbmtub3duID0gc291cmNlT3B0aW9ucy5pZ25vcmVVbmtub3duICE9PSB0cnVlID8gZmFsc2UgOiB0cnVlOyAvLyBkZWZhdWx0IHRvIGZhbHNlXG4gIG9wdGlvbnMucmVzcGVjdFR5cGUgPSBzb3VyY2VPcHRpb25zLnJlc3BlY3RUeXBlID09PSBmYWxzZSA/IGZhbHNlIDogdHJ1ZTsgLy8gZGVmYXVsdCB0byB0cnVlXG4gIG9wdGlvbnMucmVzcGVjdEZ1bmN0aW9uTmFtZXMgPSBzb3VyY2VPcHRpb25zLnJlc3BlY3RGdW5jdGlvbk5hbWVzID09PSBmYWxzZSA/IGZhbHNlIDogdHJ1ZTtcbiAgb3B0aW9ucy5yZXNwZWN0RnVuY3Rpb25Qcm9wZXJ0aWVzID0gc291cmNlT3B0aW9ucy5yZXNwZWN0RnVuY3Rpb25Qcm9wZXJ0aWVzID09PSBmYWxzZSA/IGZhbHNlIDogdHJ1ZTtcbiAgb3B0aW9ucy51bm9yZGVyZWRBcnJheXMgPSBzb3VyY2VPcHRpb25zLnVub3JkZXJlZEFycmF5cyAhPT0gdHJ1ZSA/IGZhbHNlIDogdHJ1ZTsgLy8gZGVmYXVsdCB0byBmYWxzZVxuICBvcHRpb25zLnVub3JkZXJlZFNldHMgPSBzb3VyY2VPcHRpb25zLnVub3JkZXJlZFNldHMgPT09IGZhbHNlID8gZmFsc2UgOiB0cnVlOyAvLyBkZWZhdWx0IHRvIGZhbHNlXG4gIG9wdGlvbnMudW5vcmRlcmVkT2JqZWN0cyA9IHNvdXJjZU9wdGlvbnMudW5vcmRlcmVkT2JqZWN0cyA9PT0gZmFsc2UgPyBmYWxzZSA6IHRydWU7IC8vIGRlZmF1bHQgdG8gdHJ1ZVxuICBvcHRpb25zLnJlcGxhY2VyID0gc291cmNlT3B0aW9ucy5yZXBsYWNlciB8fCB1bmRlZmluZWQ7XG4gIG9wdGlvbnMuZXhjbHVkZUtleXMgPSBzb3VyY2VPcHRpb25zLmV4Y2x1ZGVLZXlzIHx8IHVuZGVmaW5lZDtcblxuICBpZih0eXBlb2Ygb2JqZWN0ID09PSAndW5kZWZpbmVkJykge1xuICAgIHRocm93IG5ldyBFcnJvcignT2JqZWN0IGFyZ3VtZW50IHJlcXVpcmVkLicpO1xuICB9XG5cbiAgLy8gaWYgdGhlcmUgaXMgYSBjYXNlLWluc2Vuc2l0aXZlIG1hdGNoIGluIHRoZSBoYXNoZXMgbGlzdCwgYWNjZXB0IGl0XG4gIC8vIChpLmUuIFNIQTI1NiBmb3Igc2hhMjU2KVxuICBmb3IgKHZhciBpID0gMDsgaSA8IGhhc2hlcy5sZW5ndGg7ICsraSkge1xuICAgIGlmIChoYXNoZXNbaV0udG9Mb3dlckNhc2UoKSA9PT0gb3B0aW9ucy5hbGdvcml0aG0udG9Mb3dlckNhc2UoKSkge1xuICAgICAgb3B0aW9ucy5hbGdvcml0aG0gPSBoYXNoZXNbaV07XG4gICAgfVxuICB9XG5cbiAgaWYoaGFzaGVzLmluZGV4T2Yob3B0aW9ucy5hbGdvcml0aG0pID09PSAtMSl7XG4gICAgdGhyb3cgbmV3IEVycm9yKCdBbGdvcml0aG0gXCInICsgb3B0aW9ucy5hbGdvcml0aG0gKyAnXCIgIG5vdCBzdXBwb3J0ZWQuICcgK1xuICAgICAgJ3N1cHBvcnRlZCB2YWx1ZXM6ICcgKyBoYXNoZXMuam9pbignLCAnKSk7XG4gIH1cblxuICBpZihlbmNvZGluZ3MuaW5kZXhPZihvcHRpb25zLmVuY29kaW5nKSA9PT0gLTEgJiZcbiAgICAgb3B0aW9ucy5hbGdvcml0aG0gIT09ICdwYXNzdGhyb3VnaCcpe1xuICAgIHRocm93IG5ldyBFcnJvcignRW5jb2RpbmcgXCInICsgb3B0aW9ucy5lbmNvZGluZyArICdcIiAgbm90IHN1cHBvcnRlZC4gJyArXG4gICAgICAnc3VwcG9ydGVkIHZhbHVlczogJyArIGVuY29kaW5ncy5qb2luKCcsICcpKTtcbiAgfVxuXG4gIHJldHVybiBvcHRpb25zO1xufVxuXG4vKiogQ2hlY2sgaWYgdGhlIGdpdmVuIGZ1bmN0aW9uIGlzIGEgbmF0aXZlIGZ1bmN0aW9uICovXG5mdW5jdGlvbiBpc05hdGl2ZUZ1bmN0aW9uKGYpIHtcbiAgaWYgKCh0eXBlb2YgZikgIT09ICdmdW5jdGlvbicpIHtcbiAgICByZXR1cm4gZmFsc2U7XG4gIH1cbiAgdmFyIGV4cCA9IC9eZnVuY3Rpb25cXHMrXFx3KlxccypcXChcXHMqXFwpXFxzKntcXHMrXFxbbmF0aXZlIGNvZGVcXF1cXHMrfSQvaTtcbiAgcmV0dXJuIGV4cC5leGVjKEZ1bmN0aW9uLnByb3RvdHlwZS50b1N0cmluZy5jYWxsKGYpKSAhPSBudWxsO1xufVxuXG5mdW5jdGlvbiBoYXNoKG9iamVjdCwgb3B0aW9ucykge1xuICB2YXIgaGFzaGluZ1N0cmVhbTtcblxuICBpZiAob3B0aW9ucy5hbGdvcml0aG0gIT09ICdwYXNzdGhyb3VnaCcpIHtcbiAgICBoYXNoaW5nU3RyZWFtID0gY3J5cHRvLmNyZWF0ZUhhc2gob3B0aW9ucy5hbGdvcml0aG0pO1xuICB9IGVsc2Uge1xuICAgIGhhc2hpbmdTdHJlYW0gPSBuZXcgUGFzc1Rocm91Z2goKTtcbiAgfVxuXG4gIGlmICh0eXBlb2YgaGFzaGluZ1N0cmVhbS53cml0ZSA9PT0gJ3VuZGVmaW5lZCcpIHtcbiAgICBoYXNoaW5nU3RyZWFtLndyaXRlID0gaGFzaGluZ1N0cmVhbS51cGRhdGU7XG4gICAgaGFzaGluZ1N0cmVhbS5lbmQgICA9IGhhc2hpbmdTdHJlYW0udXBkYXRlO1xuICB9XG5cbiAgdmFyIGhhc2hlciA9IHR5cGVIYXNoZXIob3B0aW9ucywgaGFzaGluZ1N0cmVhbSk7XG4gIGhhc2hlci5kaXNwYXRjaChvYmplY3QpO1xuICBpZiAoIWhhc2hpbmdTdHJlYW0udXBkYXRlKSB7XG4gICAgaGFzaGluZ1N0cmVhbS5lbmQoJycpO1xuICB9XG5cbiAgaWYgKGhhc2hpbmdTdHJlYW0uZGlnZXN0KSB7XG4gICAgcmV0dXJuIGhhc2hpbmdTdHJlYW0uZGlnZXN0KG9wdGlvbnMuZW5jb2RpbmcgPT09ICdidWZmZXInID8gdW5kZWZpbmVkIDogb3B0aW9ucy5lbmNvZGluZyk7XG4gIH1cblxuICB2YXIgYnVmID0gaGFzaGluZ1N0cmVhbS5yZWFkKCk7XG4gIGlmIChvcHRpb25zLmVuY29kaW5nID09PSAnYnVmZmVyJykge1xuICAgIHJldHVybiBidWY7XG4gIH1cblxuICByZXR1cm4gYnVmLnRvU3RyaW5nKG9wdGlvbnMuZW5jb2RpbmcpO1xufVxuXG4vKipcbiAqIEV4cG9zZSBzdHJlYW1pbmcgQVBJXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IG9iamVjdCAgVmFsdWUgdG8gc2VyaWFsaXplXG4gKiBAcGFyYW0ge29iamVjdH0gb3B0aW9ucyAgT3B0aW9ucywgYXMgZm9yIGhhc2goKVxuICogQHBhcmFtIHtvYmplY3R9IHN0cmVhbSAgQSBzdHJlYW0gdG8gd3JpdGUgdGhlIHNlcmlhbGl6aWF0aW9uIHRvXG4gKiBAYXBpIHB1YmxpY1xuICovXG5leHBvcnRzLndyaXRlVG9TdHJlYW0gPSBmdW5jdGlvbihvYmplY3QsIG9wdGlvbnMsIHN0cmVhbSkge1xuICBpZiAodHlwZW9mIHN0cmVhbSA9PT0gJ3VuZGVmaW5lZCcpIHtcbiAgICBzdHJlYW0gPSBvcHRpb25zO1xuICAgIG9wdGlvbnMgPSB7fTtcbiAgfVxuXG4gIG9wdGlvbnMgPSBhcHBseURlZmF1bHRzKG9iamVjdCwgb3B0aW9ucyk7XG5cbiAgcmV0dXJuIHR5cGVIYXNoZXIob3B0aW9ucywgc3RyZWFtKS5kaXNwYXRjaChvYmplY3QpO1xufTtcblxuZnVuY3Rpb24gdHlwZUhhc2hlcihvcHRpb25zLCB3cml0ZVRvLCBjb250ZXh0KXtcbiAgY29udGV4dCA9IGNvbnRleHQgfHwgW107XG4gIHZhciB3cml0ZSA9IGZ1bmN0aW9uKHN0cikge1xuICAgIGlmICh3cml0ZVRvLnVwZGF0ZSkge1xuICAgICAgcmV0dXJuIHdyaXRlVG8udXBkYXRlKHN0ciwgJ3V0ZjgnKTtcbiAgICB9IGVsc2Uge1xuICAgICAgcmV0dXJuIHdyaXRlVG8ud3JpdGUoc3RyLCAndXRmOCcpO1xuICAgIH1cbiAgfTtcblxuICByZXR1cm4ge1xuICAgIGRpc3BhdGNoOiBmdW5jdGlvbih2YWx1ZSl7XG4gICAgICBpZiAob3B0aW9ucy5yZXBsYWNlcikge1xuICAgICAgICB2YWx1ZSA9IG9wdGlvbnMucmVwbGFjZXIodmFsdWUpO1xuICAgICAgfVxuXG4gICAgICB2YXIgdHlwZSA9IHR5cGVvZiB2YWx1ZTtcbiAgICAgIGlmICh2YWx1ZSA9PT0gbnVsbCkge1xuICAgICAgICB0eXBlID0gJ251bGwnO1xuICAgICAgfVxuXG4gICAgICAvL2NvbnNvbGUubG9nKFwiW0RFQlVHXSBEaXNwYXRjaDogXCIsIHZhbHVlLCBcIi0+XCIsIHR5cGUsIFwiIC0+IFwiLCBcIl9cIiArIHR5cGUpO1xuXG4gICAgICByZXR1cm4gdGhpc1snXycgKyB0eXBlXSh2YWx1ZSk7XG4gICAgfSxcbiAgICBfb2JqZWN0OiBmdW5jdGlvbihvYmplY3QpIHtcbiAgICAgIHZhciBwYXR0ZXJuID0gKC9cXFtvYmplY3QgKC4qKVxcXS9pKTtcbiAgICAgIHZhciBvYmpTdHJpbmcgPSBPYmplY3QucHJvdG90eXBlLnRvU3RyaW5nLmNhbGwob2JqZWN0KTtcbiAgICAgIHZhciBvYmpUeXBlID0gcGF0dGVybi5leGVjKG9ialN0cmluZyk7XG4gICAgICBpZiAoIW9ialR5cGUpIHsgLy8gb2JqZWN0IHR5cGUgZGlkIG5vdCBtYXRjaCBbb2JqZWN0IC4uLl1cbiAgICAgICAgb2JqVHlwZSA9ICd1bmtub3duOlsnICsgb2JqU3RyaW5nICsgJ10nO1xuICAgICAgfSBlbHNlIHtcbiAgICAgICAgb2JqVHlwZSA9IG9ialR5cGVbMV07IC8vIHRha2Ugb25seSB0aGUgY2xhc3MgbmFtZVxuICAgICAgfVxuXG4gICAgICBvYmpUeXBlID0gb2JqVHlwZS50b0xvd2VyQ2FzZSgpO1xuXG4gICAgICB2YXIgb2JqZWN0TnVtYmVyID0gbnVsbDtcblxuICAgICAgaWYgKChvYmplY3ROdW1iZXIgPSBjb250ZXh0LmluZGV4T2Yob2JqZWN0KSkgPj0gMCkge1xuICAgICAgICByZXR1cm4gdGhpcy5kaXNwYXRjaCgnW0NJUkNVTEFSOicgKyBvYmplY3ROdW1iZXIgKyAnXScpO1xuICAgICAgfSBlbHNlIHtcbiAgICAgICAgY29udGV4dC5wdXNoKG9iamVjdCk7XG4gICAgICB9XG5cbiAgICAgIGlmICh0eXBlb2YgQnVmZmVyICE9PSAndW5kZWZpbmVkJyAmJiBCdWZmZXIuaXNCdWZmZXIgJiYgQnVmZmVyLmlzQnVmZmVyKG9iamVjdCkpIHtcbiAgICAgICAgd3JpdGUoJ2J1ZmZlcjonKTtcbiAgICAgICAgcmV0dXJuIHdyaXRlKG9iamVjdCk7XG4gICAgICB9XG5cbiAgICAgIGlmKG9ialR5cGUgIT09ICdvYmplY3QnICYmIG9ialR5cGUgIT09ICdmdW5jdGlvbicgJiYgb2JqVHlwZSAhPT0gJ2FzeW5jZnVuY3Rpb24nKSB7XG4gICAgICAgIGlmKHRoaXNbJ18nICsgb2JqVHlwZV0pIHtcbiAgICAgICAgICB0aGlzWydfJyArIG9ialR5cGVdKG9iamVjdCk7XG4gICAgICAgIH0gZWxzZSBpZiAob3B0aW9ucy5pZ25vcmVVbmtub3duKSB7XG4gICAgICAgICAgcmV0dXJuIHdyaXRlKCdbJyArIG9ialR5cGUgKyAnXScpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIHRocm93IG5ldyBFcnJvcignVW5rbm93biBvYmplY3QgdHlwZSBcIicgKyBvYmpUeXBlICsgJ1wiJyk7XG4gICAgICAgIH1cbiAgICAgIH1lbHNle1xuICAgICAgICB2YXIga2V5cyA9IE9iamVjdC5rZXlzKG9iamVjdCk7XG4gICAgICAgIGlmIChvcHRpb25zLnVub3JkZXJlZE9iamVjdHMpIHtcbiAgICAgICAgICBrZXlzID0ga2V5cy5zb3J0KCk7XG4gICAgICAgIH1cbiAgICAgICAgLy8gTWFrZSBzdXJlIHRvIGluY29ycG9yYXRlIHNwZWNpYWwgcHJvcGVydGllcywgc29cbiAgICAgICAgLy8gVHlwZXMgd2l0aCBkaWZmZXJlbnQgcHJvdG90eXBlcyB3aWxsIHByb2R1Y2VcbiAgICAgICAgLy8gYSBkaWZmZXJlbnQgaGFzaCBhbmQgb2JqZWN0cyBkZXJpdmVkIGZyb21cbiAgICAgICAgLy8gZGlmZmVyZW50IGZ1bmN0aW9ucyAoYG5ldyBGb29gLCBgbmV3IEJhcmApIHdpbGxcbiAgICAgICAgLy8gcHJvZHVjZSBkaWZmZXJlbnQgaGFzaGVzLlxuICAgICAgICAvLyBXZSBuZXZlciBkbyB0aGlzIGZvciBuYXRpdmUgZnVuY3Rpb25zIHNpbmNlIHNvbWVcbiAgICAgICAgLy8gc2VlbSB0byBicmVhayBiZWNhdXNlIG9mIHRoYXQuXG4gICAgICAgIGlmIChvcHRpb25zLnJlc3BlY3RUeXBlICE9PSBmYWxzZSAmJiAhaXNOYXRpdmVGdW5jdGlvbihvYmplY3QpKSB7XG4gICAgICAgICAga2V5cy5zcGxpY2UoMCwgMCwgJ3Byb3RvdHlwZScsICdfX3Byb3RvX18nLCAnY29uc3RydWN0b3InKTtcbiAgICAgICAgfVxuXG4gICAgICAgIGlmIChvcHRpb25zLmV4Y2x1ZGVLZXlzKSB7XG4gICAgICAgICAga2V5cyA9IGtleXMuZmlsdGVyKGZ1bmN0aW9uKGtleSkgeyByZXR1cm4gIW9wdGlvbnMuZXhjbHVkZUtleXMoa2V5KTsgfSk7XG4gICAgICAgIH1cblxuICAgICAgICB3cml0ZSgnb2JqZWN0OicgKyBrZXlzLmxlbmd0aCArICc6Jyk7XG4gICAgICAgIHZhciBzZWxmID0gdGhpcztcbiAgICAgICAgcmV0dXJuIGtleXMuZm9yRWFjaChmdW5jdGlvbihrZXkpe1xuICAgICAgICAgIHNlbGYuZGlzcGF0Y2goa2V5KTtcbiAgICAgICAgICB3cml0ZSgnOicpO1xuICAgICAgICAgIGlmKCFvcHRpb25zLmV4Y2x1ZGVWYWx1ZXMpIHtcbiAgICAgICAgICAgIHNlbGYuZGlzcGF0Y2gob2JqZWN0W2tleV0pO1xuICAgICAgICAgIH1cbiAgICAgICAgICB3cml0ZSgnLCcpO1xuICAgICAgICB9KTtcbiAgICAgIH1cbiAgICB9LFxuICAgIF9hcnJheTogZnVuY3Rpb24oYXJyLCB1bm9yZGVyZWQpe1xuICAgICAgdW5vcmRlcmVkID0gdHlwZW9mIHVub3JkZXJlZCAhPT0gJ3VuZGVmaW5lZCcgPyB1bm9yZGVyZWQgOlxuICAgICAgICBvcHRpb25zLnVub3JkZXJlZEFycmF5cyAhPT0gZmFsc2U7IC8vIGRlZmF1bHQgdG8gb3B0aW9ucy51bm9yZGVyZWRBcnJheXNcblxuICAgICAgdmFyIHNlbGYgPSB0aGlzO1xuICAgICAgd3JpdGUoJ2FycmF5OicgKyBhcnIubGVuZ3RoICsgJzonKTtcbiAgICAgIGlmICghdW5vcmRlcmVkIHx8IGFyci5sZW5ndGggPD0gMSkge1xuICAgICAgICByZXR1cm4gYXJyLmZvckVhY2goZnVuY3Rpb24oZW50cnkpIHtcbiAgICAgICAgICByZXR1cm4gc2VsZi5kaXNwYXRjaChlbnRyeSk7XG4gICAgICAgIH0pO1xuICAgICAgfVxuXG4gICAgICAvLyB0aGUgdW5vcmRlcmVkIGNhc2UgaXMgYSBsaXR0bGUgbW9yZSBjb21wbGljYXRlZDpcbiAgICAgIC8vIHNpbmNlIHRoZXJlIGlzIG5vIGNhbm9uaWNhbCBvcmRlcmluZyBvbiBvYmplY3RzLFxuICAgICAgLy8gaS5lLiB7YToxfSA8IHthOjJ9IGFuZCB7YToxfSA+IHthOjJ9IGFyZSBib3RoIGZhbHNlLFxuICAgICAgLy8gd2UgZmlyc3Qgc2VyaWFsaXplIGVhY2ggZW50cnkgdXNpbmcgYSBQYXNzVGhyb3VnaCBzdHJlYW1cbiAgICAgIC8vIGJlZm9yZSBzb3J0aW5nLlxuICAgICAgLy8gYWxzbzogd2UgY2FuXHUyMDE5dCB1c2UgdGhlIHNhbWUgY29udGV4dCBhcnJheSBmb3IgYWxsIGVudHJpZXNcbiAgICAgIC8vIHNpbmNlIHRoZSBvcmRlciBvZiBoYXNoaW5nIHNob3VsZCAqbm90KiBtYXR0ZXIuIGluc3RlYWQsXG4gICAgICAvLyB3ZSBrZWVwIHRyYWNrIG9mIHRoZSBhZGRpdGlvbnMgdG8gYSBjb3B5IG9mIHRoZSBjb250ZXh0IGFycmF5XG4gICAgICAvLyBhbmQgYWRkIGFsbCBvZiB0aGVtIHRvIHRoZSBnbG9iYWwgY29udGV4dCBhcnJheSB3aGVuIHdlXHUyMDE5cmUgZG9uZVxuICAgICAgdmFyIGNvbnRleHRBZGRpdGlvbnMgPSBbXTtcbiAgICAgIHZhciBlbnRyaWVzID0gYXJyLm1hcChmdW5jdGlvbihlbnRyeSkge1xuICAgICAgICB2YXIgc3RybSA9IG5ldyBQYXNzVGhyb3VnaCgpO1xuICAgICAgICB2YXIgbG9jYWxDb250ZXh0ID0gY29udGV4dC5zbGljZSgpOyAvLyBtYWtlIGNvcHlcbiAgICAgICAgdmFyIGhhc2hlciA9IHR5cGVIYXNoZXIob3B0aW9ucywgc3RybSwgbG9jYWxDb250ZXh0KTtcbiAgICAgICAgaGFzaGVyLmRpc3BhdGNoKGVudHJ5KTtcbiAgICAgICAgLy8gdGFrZSBvbmx5IHdoYXQgd2FzIGFkZGVkIHRvIGxvY2FsQ29udGV4dCBhbmQgYXBwZW5kIGl0IHRvIGNvbnRleHRBZGRpdGlvbnNcbiAgICAgICAgY29udGV4dEFkZGl0aW9ucyA9IGNvbnRleHRBZGRpdGlvbnMuY29uY2F0KGxvY2FsQ29udGV4dC5zbGljZShjb250ZXh0Lmxlbmd0aCkpO1xuICAgICAgICByZXR1cm4gc3RybS5yZWFkKCkudG9TdHJpbmcoKTtcbiAgICAgIH0pO1xuICAgICAgY29udGV4dCA9IGNvbnRleHQuY29uY2F0KGNvbnRleHRBZGRpdGlvbnMpO1xuICAgICAgZW50cmllcy5zb3J0KCk7XG4gICAgICByZXR1cm4gdGhpcy5fYXJyYXkoZW50cmllcywgZmFsc2UpO1xuICAgIH0sXG4gICAgX2RhdGU6IGZ1bmN0aW9uKGRhdGUpe1xuICAgICAgcmV0dXJuIHdyaXRlKCdkYXRlOicgKyBkYXRlLnRvSlNPTigpKTtcbiAgICB9LFxuICAgIF9zeW1ib2w6IGZ1bmN0aW9uKHN5bSl7XG4gICAgICByZXR1cm4gd3JpdGUoJ3N5bWJvbDonICsgc3ltLnRvU3RyaW5nKCkpO1xuICAgIH0sXG4gICAgX2Vycm9yOiBmdW5jdGlvbihlcnIpe1xuICAgICAgcmV0dXJuIHdyaXRlKCdlcnJvcjonICsgZXJyLnRvU3RyaW5nKCkpO1xuICAgIH0sXG4gICAgX2Jvb2xlYW46IGZ1bmN0aW9uKGJvb2wpe1xuICAgICAgcmV0dXJuIHdyaXRlKCdib29sOicgKyBib29sLnRvU3RyaW5nKCkpO1xuICAgIH0sXG4gICAgX3N0cmluZzogZnVuY3Rpb24oc3RyaW5nKXtcbiAgICAgIHdyaXRlKCdzdHJpbmc6JyArIHN0cmluZy5sZW5ndGggKyAnOicpO1xuICAgICAgd3JpdGUoc3RyaW5nLnRvU3RyaW5nKCkpO1xuICAgIH0sXG4gICAgX2Z1bmN0aW9uOiBmdW5jdGlvbihmbil7XG4gICAgICB3cml0ZSgnZm46Jyk7XG4gICAgICBpZiAoaXNOYXRpdmVGdW5jdGlvbihmbikpIHtcbiAgICAgICAgdGhpcy5kaXNwYXRjaCgnW25hdGl2ZV0nKTtcbiAgICAgIH0gZWxzZSB7XG4gICAgICAgIHRoaXMuZGlzcGF0Y2goZm4udG9TdHJpbmcoKSk7XG4gICAgICB9XG5cbiAgICAgIGlmIChvcHRpb25zLnJlc3BlY3RGdW5jdGlvbk5hbWVzICE9PSBmYWxzZSkge1xuICAgICAgICAvLyBNYWtlIHN1cmUgd2UgY2FuIHN0aWxsIGRpc3Rpbmd1aXNoIG5hdGl2ZSBmdW5jdGlvbnNcbiAgICAgICAgLy8gYnkgdGhlaXIgbmFtZSwgb3RoZXJ3aXNlIFN0cmluZyBhbmQgRnVuY3Rpb24gd2lsbFxuICAgICAgICAvLyBoYXZlIHRoZSBzYW1lIGhhc2hcbiAgICAgICAgdGhpcy5kaXNwYXRjaChcImZ1bmN0aW9uLW5hbWU6XCIgKyBTdHJpbmcoZm4ubmFtZSkpO1xuICAgICAgfVxuXG4gICAgICBpZiAob3B0aW9ucy5yZXNwZWN0RnVuY3Rpb25Qcm9wZXJ0aWVzKSB7XG4gICAgICAgIHRoaXMuX29iamVjdChmbik7XG4gICAgICB9XG4gICAgfSxcbiAgICBfbnVtYmVyOiBmdW5jdGlvbihudW1iZXIpe1xuICAgICAgcmV0dXJuIHdyaXRlKCdudW1iZXI6JyArIG51bWJlci50b1N0cmluZygpKTtcbiAgICB9LFxuICAgIF94bWw6IGZ1bmN0aW9uKHhtbCl7XG4gICAgICByZXR1cm4gd3JpdGUoJ3htbDonICsgeG1sLnRvU3RyaW5nKCkpO1xuICAgIH0sXG4gICAgX251bGw6IGZ1bmN0aW9uKCkge1xuICAgICAgcmV0dXJuIHdyaXRlKCdOdWxsJyk7XG4gICAgfSxcbiAgICBfdW5kZWZpbmVkOiBmdW5jdGlvbigpIHtcbiAgICAgIHJldHVybiB3cml0ZSgnVW5kZWZpbmVkJyk7XG4gICAgfSxcbiAgICBfcmVnZXhwOiBmdW5jdGlvbihyZWdleCl7XG4gICAgICByZXR1cm4gd3JpdGUoJ3JlZ2V4OicgKyByZWdleC50b1N0cmluZygpKTtcbiAgICB9LFxuICAgIF91aW50OGFycmF5OiBmdW5jdGlvbihhcnIpe1xuICAgICAgd3JpdGUoJ3VpbnQ4YXJyYXk6Jyk7XG4gICAgICByZXR1cm4gdGhpcy5kaXNwYXRjaChBcnJheS5wcm90b3R5cGUuc2xpY2UuY2FsbChhcnIpKTtcbiAgICB9LFxuICAgIF91aW50OGNsYW1wZWRhcnJheTogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCd1aW50OGNsYW1wZWRhcnJheTonKTtcbiAgICAgIHJldHVybiB0aGlzLmRpc3BhdGNoKEFycmF5LnByb3RvdHlwZS5zbGljZS5jYWxsKGFycikpO1xuICAgIH0sXG4gICAgX2ludDhhcnJheTogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCdpbnQ4YXJyYXk6Jyk7XG4gICAgICByZXR1cm4gdGhpcy5kaXNwYXRjaChBcnJheS5wcm90b3R5cGUuc2xpY2UuY2FsbChhcnIpKTtcbiAgICB9LFxuICAgIF91aW50MTZhcnJheTogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCd1aW50MTZhcnJheTonKTtcbiAgICAgIHJldHVybiB0aGlzLmRpc3BhdGNoKEFycmF5LnByb3RvdHlwZS5zbGljZS5jYWxsKGFycikpO1xuICAgIH0sXG4gICAgX2ludDE2YXJyYXk6IGZ1bmN0aW9uKGFycil7XG4gICAgICB3cml0ZSgnaW50MTZhcnJheTonKTtcbiAgICAgIHJldHVybiB0aGlzLmRpc3BhdGNoKEFycmF5LnByb3RvdHlwZS5zbGljZS5jYWxsKGFycikpO1xuICAgIH0sXG4gICAgX3VpbnQzMmFycmF5OiBmdW5jdGlvbihhcnIpe1xuICAgICAgd3JpdGUoJ3VpbnQzMmFycmF5OicpO1xuICAgICAgcmV0dXJuIHRoaXMuZGlzcGF0Y2goQXJyYXkucHJvdG90eXBlLnNsaWNlLmNhbGwoYXJyKSk7XG4gICAgfSxcbiAgICBfaW50MzJhcnJheTogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCdpbnQzMmFycmF5OicpO1xuICAgICAgcmV0dXJuIHRoaXMuZGlzcGF0Y2goQXJyYXkucHJvdG90eXBlLnNsaWNlLmNhbGwoYXJyKSk7XG4gICAgfSxcbiAgICBfZmxvYXQzMmFycmF5OiBmdW5jdGlvbihhcnIpe1xuICAgICAgd3JpdGUoJ2Zsb2F0MzJhcnJheTonKTtcbiAgICAgIHJldHVybiB0aGlzLmRpc3BhdGNoKEFycmF5LnByb3RvdHlwZS5zbGljZS5jYWxsKGFycikpO1xuICAgIH0sXG4gICAgX2Zsb2F0NjRhcnJheTogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCdmbG9hdDY0YXJyYXk6Jyk7XG4gICAgICByZXR1cm4gdGhpcy5kaXNwYXRjaChBcnJheS5wcm90b3R5cGUuc2xpY2UuY2FsbChhcnIpKTtcbiAgICB9LFxuICAgIF9hcnJheWJ1ZmZlcjogZnVuY3Rpb24oYXJyKXtcbiAgICAgIHdyaXRlKCdhcnJheWJ1ZmZlcjonKTtcbiAgICAgIHJldHVybiB0aGlzLmRpc3BhdGNoKG5ldyBVaW50OEFycmF5KGFycikpO1xuICAgIH0sXG4gICAgX3VybDogZnVuY3Rpb24odXJsKSB7XG4gICAgICByZXR1cm4gd3JpdGUoJ3VybDonICsgdXJsLnRvU3RyaW5nKCksICd1dGY4Jyk7XG4gICAgfSxcbiAgICBfbWFwOiBmdW5jdGlvbihtYXApIHtcbiAgICAgIHdyaXRlKCdtYXA6Jyk7XG4gICAgICB2YXIgYXJyID0gQXJyYXkuZnJvbShtYXApO1xuICAgICAgcmV0dXJuIHRoaXMuX2FycmF5KGFyciwgb3B0aW9ucy51bm9yZGVyZWRTZXRzICE9PSBmYWxzZSk7XG4gICAgfSxcbiAgICBfc2V0OiBmdW5jdGlvbihzZXQpIHtcbiAgICAgIHdyaXRlKCdzZXQ6Jyk7XG4gICAgICB2YXIgYXJyID0gQXJyYXkuZnJvbShzZXQpO1xuICAgICAgcmV0dXJuIHRoaXMuX2FycmF5KGFyciwgb3B0aW9ucy51bm9yZGVyZWRTZXRzICE9PSBmYWxzZSk7XG4gICAgfSxcbiAgICBfZmlsZTogZnVuY3Rpb24oZmlsZSkge1xuICAgICAgd3JpdGUoJ2ZpbGU6Jyk7XG4gICAgICByZXR1cm4gdGhpcy5kaXNwYXRjaChbZmlsZS5uYW1lLCBmaWxlLnNpemUsIGZpbGUudHlwZSwgZmlsZS5sYXN0TW9kZmllZF0pO1xuICAgIH0sXG4gICAgX2Jsb2I6IGZ1bmN0aW9uKCkge1xuICAgICAgaWYgKG9wdGlvbnMuaWdub3JlVW5rbm93bikge1xuICAgICAgICByZXR1cm4gd3JpdGUoJ1tibG9iXScpO1xuICAgICAgfVxuXG4gICAgICB0aHJvdyBFcnJvcignSGFzaGluZyBCbG9iIG9iamVjdHMgaXMgY3VycmVudGx5IG5vdCBzdXBwb3J0ZWRcXG4nICtcbiAgICAgICAgJyhzZWUgaHR0cHM6Ly9naXRodWIuY29tL3B1bGVvcy9vYmplY3QtaGFzaC9pc3N1ZXMvMjYpXFxuJyArXG4gICAgICAgICdVc2UgXCJvcHRpb25zLnJlcGxhY2VyXCIgb3IgXCJvcHRpb25zLmlnbm9yZVVua25vd25cIlxcbicpO1xuICAgIH0sXG4gICAgX2RvbXdpbmRvdzogZnVuY3Rpb24oKSB7IHJldHVybiB3cml0ZSgnZG9td2luZG93Jyk7IH0sXG4gICAgX2JpZ2ludDogZnVuY3Rpb24obnVtYmVyKXtcbiAgICAgIHJldHVybiB3cml0ZSgnYmlnaW50OicgKyBudW1iZXIudG9TdHJpbmcoKSk7XG4gICAgfSxcbiAgICAvKiBOb2RlLmpzIHN0YW5kYXJkIG5hdGl2ZSBvYmplY3RzICovXG4gICAgX3Byb2Nlc3M6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3Byb2Nlc3MnKTsgfSxcbiAgICBfdGltZXI6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3RpbWVyJyk7IH0sXG4gICAgX3BpcGU6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3BpcGUnKTsgfSxcbiAgICBfdGNwOiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCd0Y3AnKTsgfSxcbiAgICBfdWRwOiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCd1ZHAnKTsgfSxcbiAgICBfdHR5OiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCd0dHknKTsgfSxcbiAgICBfc3RhdHdhdGNoZXI6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3N0YXR3YXRjaGVyJyk7IH0sXG4gICAgX3NlY3VyZWNvbnRleHQ6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3NlY3VyZWNvbnRleHQnKTsgfSxcbiAgICBfY29ubmVjdGlvbjogZnVuY3Rpb24oKSB7IHJldHVybiB3cml0ZSgnY29ubmVjdGlvbicpOyB9LFxuICAgIF96bGliOiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCd6bGliJyk7IH0sXG4gICAgX2NvbnRleHQ6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ2NvbnRleHQnKTsgfSxcbiAgICBfbm9kZXNjcmlwdDogZnVuY3Rpb24oKSB7IHJldHVybiB3cml0ZSgnbm9kZXNjcmlwdCcpOyB9LFxuICAgIF9odHRwcGFyc2VyOiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCdodHRwcGFyc2VyJyk7IH0sXG4gICAgX2RhdGF2aWV3OiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCdkYXRhdmlldycpOyB9LFxuICAgIF9zaWduYWw6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3NpZ25hbCcpOyB9LFxuICAgIF9mc2V2ZW50OiBmdW5jdGlvbigpIHsgcmV0dXJuIHdyaXRlKCdmc2V2ZW50Jyk7IH0sXG4gICAgX3Rsc3dyYXA6IGZ1bmN0aW9uKCkgeyByZXR1cm4gd3JpdGUoJ3Rsc3dyYXAnKTsgfSxcbiAgfTtcbn1cblxuLy8gTWluaS1pbXBsZW1lbnRhdGlvbiBvZiBzdHJlYW0uUGFzc1Rocm91Z2hcbi8vIFdlIGFyZSBmYXIgZnJvbSBoYXZpbmcgbmVlZCBmb3IgdGhlIGZ1bGwgaW1wbGVtZW50YXRpb24sIGFuZCB3ZSBjYW5cbi8vIG1ha2UgYXNzdW1wdGlvbnMgbGlrZSBcIm1hbnkgd3JpdGVzLCB0aGVuIG9ubHkgb25lIGZpbmFsIHJlYWRcIlxuLy8gYW5kIHdlIGNhbiBpZ25vcmUgZW5jb2Rpbmcgc3BlY2lmaWNzXG5mdW5jdGlvbiBQYXNzVGhyb3VnaCgpIHtcbiAgcmV0dXJuIHtcbiAgICBidWY6ICcnLFxuXG4gICAgd3JpdGU6IGZ1bmN0aW9uKGIpIHtcbiAgICAgIHRoaXMuYnVmICs9IGI7XG4gICAgfSxcblxuICAgIGVuZDogZnVuY3Rpb24oYikge1xuICAgICAgdGhpcy5idWYgKz0gYjtcbiAgICB9LFxuXG4gICAgcmVhZDogZnVuY3Rpb24oKSB7XG4gICAgICByZXR1cm4gdGhpcy5idWY7XG4gICAgfVxuICB9O1xufVxuIiwgIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy51c2VDYWNoZWRQcm9taXNlID0gdm9pZCAwO1xuY29uc3QgcmVhY3RfMSA9IHJlcXVpcmUoXCJyZWFjdFwiKTtcbmNvbnN0IG9iamVjdF9oYXNoXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm9iamVjdC1oYXNoXCIpKTtcbmNvbnN0IHVzZUNhY2hlZFN0YXRlXzEgPSByZXF1aXJlKFwiLi91c2VDYWNoZWRTdGF0ZVwiKTtcbmNvbnN0IHVzZVByb21pc2VfMSA9IHJlcXVpcmUoXCIuL3VzZVByb21pc2VcIik7XG5jb25zdCB1c2VMYXRlc3RfMSA9IHJlcXVpcmUoXCIuL3VzZUxhdGVzdFwiKTtcbi8vIFN5bWJvbCB0byBkaWZmZXJlbnRpYXRlIGFuIGVtcHR5IGNhY2hlIGZyb20gYHVuZGVmaW5lZGBcbmNvbnN0IGVtcHR5Q2FjaGUgPSBTeW1ib2woKTtcbmZ1bmN0aW9uIHVzZUNhY2hlZFByb21pc2UoZm4sIGFyZ3MsIG9wdGlvbnMpIHtcbiAgICBjb25zdCB7IGluaXRpYWxEYXRhLCBrZWVwUHJldmlvdXNEYXRhLCAuLi51c2VQcm9taXNlT3B0aW9ucyB9ID0gb3B0aW9ucyB8fCB7fTtcbiAgICBjb25zdCBsYXN0VXBkYXRlRnJvbSA9ICgwLCByZWFjdF8xLnVzZVJlZikoKTtcbiAgICBjb25zdCBbY2FjaGVkRGF0YSwgbXV0YXRlQ2FjaGVdID0gKDAsIHVzZUNhY2hlZFN0YXRlXzEudXNlQ2FjaGVkU3RhdGUpKCgwLCBvYmplY3RfaGFzaF8xLmRlZmF1bHQpKGFyZ3MgfHwgW10pLCBlbXB0eUNhY2hlLCB7XG4gICAgICAgIGNhY2hlTmFtZXNwYWNlOiAoMCwgb2JqZWN0X2hhc2hfMS5kZWZhdWx0KShmbiksXG4gICAgfSk7XG4gICAgLy8gVXNlIGEgcmVmIHRvIHN0b3JlIHByZXZpb3VzIHJldHVybmVkIGRhdGEuIFVzZSB0aGUgaW5pdGFsIGRhdGEgYXMgaXRzIGluaXRhbCB2YWx1ZSBmcm9tIHRoZSBjYWNoZS5cbiAgICBjb25zdCBsYWdneURhdGFSZWYgPSAoMCwgcmVhY3RfMS51c2VSZWYpKGNhY2hlZERhdGEgIT09IGVtcHR5Q2FjaGUgPyBjYWNoZWREYXRhIDogaW5pdGlhbERhdGEpO1xuICAgIGNvbnN0IHsgbXV0YXRlOiBfbXV0YXRlLCByZXZhbGlkYXRlLCAuLi5zdGF0ZVxuICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAdHlwZXNjcmlwdC1lc2xpbnQvbm8tZXhwbGljaXQtYW55XG4gICAgIH0gPSAoMCwgdXNlUHJvbWlzZV8xLnVzZVByb21pc2UpKGZuLCBhcmdzIHx8IFtdLCB7XG4gICAgICAgIC4uLnVzZVByb21pc2VPcHRpb25zLFxuICAgICAgICBvbkRhdGEoZGF0YSkge1xuICAgICAgICAgICAgaWYgKHVzZVByb21pc2VPcHRpb25zLm9uRGF0YSkge1xuICAgICAgICAgICAgICAgIHVzZVByb21pc2VPcHRpb25zLm9uRGF0YShkYXRhKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIC8vIHVwZGF0ZSB0aGUgY2FjaGUgd2hlbiB3ZSBmZXRjaCBuZXcgdmFsdWVzXG4gICAgICAgICAgICBsYXN0VXBkYXRlRnJvbS5jdXJyZW50ID0gXCJwcm9taXNlXCI7XG4gICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudCA9IGRhdGE7XG4gICAgICAgICAgICBtdXRhdGVDYWNoZShkYXRhKTtcbiAgICAgICAgfSxcbiAgICB9KTtcbiAgICAvLyBkYXRhIHJldHVybmVkIGlmIHRoZXJlIGFyZSBubyBzcGVjaWFsIGNhc2VzXG4gICAgY29uc3QgZGF0YSA9IGNhY2hlZERhdGEgIT09IGVtcHR5Q2FjaGUgPyBjYWNoZWREYXRhIDogaW5pdGlhbERhdGE7XG4gICAgY29uc3QgcmV0dXJuZWREYXRhID0gXG4gICAgLy8gaWYgdGhlIGxhdGVzdCB1cGRhdGUgaWYgZnJvbSB0aGUgUHJvbWlzZSwgd2Uga2VlcCBpdFxuICAgIGxhc3RVcGRhdGVGcm9tLmN1cnJlbnQgPT09IFwicHJvbWlzZVwiXG4gICAgICAgID8gbGFnZ3lEYXRhUmVmLmN1cnJlbnRcbiAgICAgICAgOiAvLyBpZiB3ZSB3YW50IHRvIGtlZXAgdGhlIGxhdGVzdCBkYXRhLCB3ZSBwaWNrIHRoZSBjYWNoZSBidXQgb25seSBpZiBpdCdzIG5vdCBlbXB0eVxuICAgICAgICAgICAga2VlcFByZXZpb3VzRGF0YVxuICAgICAgICAgICAgICAgID8gY2FjaGVkRGF0YSAhPT0gZW1wdHlDYWNoZVxuICAgICAgICAgICAgICAgICAgICA/IGNhY2hlZERhdGFcbiAgICAgICAgICAgICAgICAgICAgOiAvLyBpZiB0aGUgY2FjaGUgaXMgZW1wdHksIHdlIHdpbGwgcmV0dXJuIHRoZSBwcmV2aW91cyBkYXRhXG4gICAgICAgICAgICAgICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudFxuICAgICAgICAgICAgICAgIDogZGF0YTtcbiAgICBjb25zdCBsYXRlc3REYXRhID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkocmV0dXJuZWREYXRhKTtcbiAgICAvLyB3ZSByZXdyaXRlIHRoZSBtdXRhdGUgZnVuY3Rpb24gdG8gdXBkYXRlIHRoZSBjYWNoZSBpbnN0ZWFkXG4gICAgY29uc3QgbXV0YXRlID0gKDAsIHJlYWN0XzEudXNlQ2FsbGJhY2spKGFzeW5jIChhc3luY1VwZGF0ZSwgb3B0aW9ucykgPT4ge1xuICAgICAgICBsZXQgZGF0YUJlZm9yZU9wdGltaXN0aWNVcGRhdGU7XG4gICAgICAgIHRyeSB7XG4gICAgICAgICAgICBpZiAob3B0aW9ucz8ub3B0aW1pc3RpY1VwZGF0ZSkge1xuICAgICAgICAgICAgICAgIGlmICh0eXBlb2Ygb3B0aW9ucz8ucm9sbGJhY2tPbkVycm9yICE9PSBcImZ1bmN0aW9uXCIgJiYgb3B0aW9ucz8ucm9sbGJhY2tPbkVycm9yICE9PSBmYWxzZSkge1xuICAgICAgICAgICAgICAgICAgICAvLyBrZWVwIHRyYWNrIG9mIHRoZSBkYXRhIGJlZm9yZSB0aGUgb3B0aW1pc3RpYyB1cGRhdGUsXG4gICAgICAgICAgICAgICAgICAgIC8vIGJ1dCBvbmx5IGlmIHdlIG5lZWQgaXQgKGVnLiBvbmx5IHdoZW4gd2Ugd2FudCB0byBhdXRvbWF0aWNhbGx5IHJvbGxiYWNrIGFmdGVyKVxuICAgICAgICAgICAgICAgICAgICBkYXRhQmVmb3JlT3B0aW1pc3RpY1VwZGF0ZSA9IHN0cnVjdHVyZWRDbG9uZShsYXRlc3REYXRhLmN1cnJlbnQpO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBjb25zdCBkYXRhID0gb3B0aW9ucy5vcHRpbWlzdGljVXBkYXRlKGxhdGVzdERhdGEuY3VycmVudCk7XG4gICAgICAgICAgICAgICAgbGFzdFVwZGF0ZUZyb20uY3VycmVudCA9IFwiY2FjaGVcIjtcbiAgICAgICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudCA9IGRhdGE7XG4gICAgICAgICAgICAgICAgbXV0YXRlQ2FjaGUoZGF0YSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICByZXR1cm4gYXdhaXQgX211dGF0ZShhc3luY1VwZGF0ZSwgeyBzaG91bGRSZXZhbGlkYXRlQWZ0ZXI6IG9wdGlvbnM/LnNob3VsZFJldmFsaWRhdGVBZnRlciB9KTtcbiAgICAgICAgfVxuICAgICAgICBjYXRjaCAoZXJyKSB7XG4gICAgICAgICAgICBpZiAodHlwZW9mIG9wdGlvbnM/LnJvbGxiYWNrT25FcnJvciA9PT0gXCJmdW5jdGlvblwiKSB7XG4gICAgICAgICAgICAgICAgY29uc3QgZGF0YSA9IG9wdGlvbnMucm9sbGJhY2tPbkVycm9yKGxhdGVzdERhdGEuY3VycmVudCk7XG4gICAgICAgICAgICAgICAgbGFzdFVwZGF0ZUZyb20uY3VycmVudCA9IFwiY2FjaGVcIjtcbiAgICAgICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudCA9IGRhdGE7XG4gICAgICAgICAgICAgICAgbXV0YXRlQ2FjaGUoZGF0YSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBlbHNlIGlmIChvcHRpb25zPy5vcHRpbWlzdGljVXBkYXRlICYmIG9wdGlvbnM/LnJvbGxiYWNrT25FcnJvciAhPT0gZmFsc2UpIHtcbiAgICAgICAgICAgICAgICBsYXN0VXBkYXRlRnJvbS5jdXJyZW50ID0gXCJjYWNoZVwiO1xuICAgICAgICAgICAgICAgIC8vIEB0cy1leHBlY3QtZXJyb3Igd2hlbiB1bmRlZmluZWQsIGl0J3MgZXhwZWN0ZWRcbiAgICAgICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudCA9IGRhdGFCZWZvcmVPcHRpbWlzdGljVXBkYXRlO1xuICAgICAgICAgICAgICAgIC8vIEB0cy1leHBlY3QtZXJyb3Igd2hlbiB1bmRlZmluZWQsIGl0J3MgZXhwZWN0ZWRcbiAgICAgICAgICAgICAgICBtdXRhdGVDYWNoZShkYXRhQmVmb3JlT3B0aW1pc3RpY1VwZGF0ZSk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICB0aHJvdyBlcnI7XG4gICAgICAgIH1cbiAgICB9LCBbbXV0YXRlQ2FjaGUsIF9tdXRhdGUsIGxhdGVzdERhdGEsIGxhZ2d5RGF0YVJlZiwgbGFzdFVwZGF0ZUZyb21dKTtcbiAgICAoMCwgcmVhY3RfMS51c2VFZmZlY3QpKCgpID0+IHtcbiAgICAgICAgaWYgKGNhY2hlZERhdGEgIT09IGVtcHR5Q2FjaGUpIHtcbiAgICAgICAgICAgIGxhc3RVcGRhdGVGcm9tLmN1cnJlbnQgPSBcImNhY2hlXCI7XG4gICAgICAgICAgICBsYWdneURhdGFSZWYuY3VycmVudCA9IGNhY2hlZERhdGE7XG4gICAgICAgIH1cbiAgICB9LCBbY2FjaGVkRGF0YV0pO1xuICAgIHJldHVybiB7XG4gICAgICAgIGRhdGE6IHJldHVybmVkRGF0YSxcbiAgICAgICAgaXNMb2FkaW5nOiBzdGF0ZS5pc0xvYWRpbmcsXG4gICAgICAgIGVycm9yOiBzdGF0ZS5lcnJvcixcbiAgICAgICAgbXV0YXRlLFxuICAgICAgICByZXZhbGlkYXRlLFxuICAgIH07XG59XG5leHBvcnRzLnVzZUNhY2hlZFByb21pc2UgPSB1c2VDYWNoZWRQcm9taXNlO1xuIiwgIi8qIVxuICogbWVkaWEtdHlwZXJcbiAqIENvcHlyaWdodChjKSAyMDE0LTIwMTcgRG91Z2xhcyBDaHJpc3RvcGhlciBXaWxzb25cbiAqIE1JVCBMaWNlbnNlZFxuICovXG5cbid1c2Ugc3RyaWN0J1xuXG4vKipcbiAqIFJlZ0V4cCB0byBtYXRjaCB0eXBlIGluIFJGQyA2ODM4XG4gKlxuICogdHlwZS1uYW1lID0gcmVzdHJpY3RlZC1uYW1lXG4gKiBzdWJ0eXBlLW5hbWUgPSByZXN0cmljdGVkLW5hbWVcbiAqIHJlc3RyaWN0ZWQtbmFtZSA9IHJlc3RyaWN0ZWQtbmFtZS1maXJzdCAqMTI2cmVzdHJpY3RlZC1uYW1lLWNoYXJzXG4gKiByZXN0cmljdGVkLW5hbWUtZmlyc3QgID0gQUxQSEEgLyBESUdJVFxuICogcmVzdHJpY3RlZC1uYW1lLWNoYXJzICA9IEFMUEhBIC8gRElHSVQgLyBcIiFcIiAvIFwiI1wiIC9cbiAqICAgICAgICAgICAgICAgICAgICAgICAgICBcIiRcIiAvIFwiJlwiIC8gXCItXCIgLyBcIl5cIiAvIFwiX1wiXG4gKiByZXN0cmljdGVkLW5hbWUtY2hhcnMgPS8gXCIuXCIgOyBDaGFyYWN0ZXJzIGJlZm9yZSBmaXJzdCBkb3QgYWx3YXlzXG4gKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDsgc3BlY2lmeSBhIGZhY2V0IG5hbWVcbiAqIHJlc3RyaWN0ZWQtbmFtZS1jaGFycyA9LyBcIitcIiA7IENoYXJhY3RlcnMgYWZ0ZXIgbGFzdCBwbHVzIGFsd2F5c1xuICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7IHNwZWNpZnkgYSBzdHJ1Y3R1cmVkIHN5bnRheCBzdWZmaXhcbiAqIEFMUEhBID0gICV4NDEtNUEgLyAleDYxLTdBICAgOyBBLVogLyBhLXpcbiAqIERJR0lUID0gICV4MzAtMzkgICAgICAgICAgICAgOyAwLTlcbiAqL1xudmFyIFNVQlRZUEVfTkFNRV9SRUdFWFAgPSAvXltBLVphLXowLTldW0EtWmEtejAtOSEjJCZeXy4tXXswLDEyNn0kL1xudmFyIFRZUEVfTkFNRV9SRUdFWFAgPSAvXltBLVphLXowLTldW0EtWmEtejAtOSEjJCZeXy1dezAsMTI2fSQvXG52YXIgVFlQRV9SRUdFWFAgPSAvXiAqKFtBLVphLXowLTldW0EtWmEtejAtOSEjJCZeXy1dezAsMTI2fSlcXC8oW0EtWmEtejAtOV1bQS1aYS16MC05ISMkJl5fListXXswLDEyNn0pICokL1xuXG4vKipcbiAqIE1vZHVsZSBleHBvcnRzLlxuICovXG5cbmV4cG9ydHMuZm9ybWF0ID0gZm9ybWF0XG5leHBvcnRzLnBhcnNlID0gcGFyc2VcbmV4cG9ydHMudGVzdCA9IHRlc3RcblxuLyoqXG4gKiBGb3JtYXQgb2JqZWN0IHRvIG1lZGlhIHR5cGUuXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IG9ialxuICogQHJldHVybiB7c3RyaW5nfVxuICogQHB1YmxpY1xuICovXG5cbmZ1bmN0aW9uIGZvcm1hdCAob2JqKSB7XG4gIGlmICghb2JqIHx8IHR5cGVvZiBvYmogIT09ICdvYmplY3QnKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignYXJndW1lbnQgb2JqIGlzIHJlcXVpcmVkJylcbiAgfVxuXG4gIHZhciBzdWJ0eXBlID0gb2JqLnN1YnR5cGVcbiAgdmFyIHN1ZmZpeCA9IG9iai5zdWZmaXhcbiAgdmFyIHR5cGUgPSBvYmoudHlwZVxuXG4gIGlmICghdHlwZSB8fCAhVFlQRV9OQU1FX1JFR0VYUC50ZXN0KHR5cGUpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignaW52YWxpZCB0eXBlJylcbiAgfVxuXG4gIGlmICghc3VidHlwZSB8fCAhU1VCVFlQRV9OQU1FX1JFR0VYUC50ZXN0KHN1YnR5cGUpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignaW52YWxpZCBzdWJ0eXBlJylcbiAgfVxuXG4gIC8vIGZvcm1hdCBhcyB0eXBlL3N1YnR5cGVcbiAgdmFyIHN0cmluZyA9IHR5cGUgKyAnLycgKyBzdWJ0eXBlXG5cbiAgLy8gYXBwZW5kICtzdWZmaXhcbiAgaWYgKHN1ZmZpeCkge1xuICAgIGlmICghVFlQRV9OQU1FX1JFR0VYUC50ZXN0KHN1ZmZpeCkpIHtcbiAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoJ2ludmFsaWQgc3VmZml4JylcbiAgICB9XG5cbiAgICBzdHJpbmcgKz0gJysnICsgc3VmZml4XG4gIH1cblxuICByZXR1cm4gc3RyaW5nXG59XG5cbi8qKlxuICogVGVzdCBtZWRpYSB0eXBlLlxuICpcbiAqIEBwYXJhbSB7c3RyaW5nfSBzdHJpbmdcbiAqIEByZXR1cm4ge29iamVjdH1cbiAqIEBwdWJsaWNcbiAqL1xuXG5mdW5jdGlvbiB0ZXN0IChzdHJpbmcpIHtcbiAgaWYgKCFzdHJpbmcpIHtcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKCdhcmd1bWVudCBzdHJpbmcgaXMgcmVxdWlyZWQnKVxuICB9XG5cbiAgaWYgKHR5cGVvZiBzdHJpbmcgIT09ICdzdHJpbmcnKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignYXJndW1lbnQgc3RyaW5nIGlzIHJlcXVpcmVkIHRvIGJlIGEgc3RyaW5nJylcbiAgfVxuXG4gIHJldHVybiBUWVBFX1JFR0VYUC50ZXN0KHN0cmluZy50b0xvd2VyQ2FzZSgpKVxufVxuXG4vKipcbiAqIFBhcnNlIG1lZGlhIHR5cGUgdG8gb2JqZWN0LlxuICpcbiAqIEBwYXJhbSB7c3RyaW5nfSBzdHJpbmdcbiAqIEByZXR1cm4ge29iamVjdH1cbiAqIEBwdWJsaWNcbiAqL1xuXG5mdW5jdGlvbiBwYXJzZSAoc3RyaW5nKSB7XG4gIGlmICghc3RyaW5nKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignYXJndW1lbnQgc3RyaW5nIGlzIHJlcXVpcmVkJylcbiAgfVxuXG4gIGlmICh0eXBlb2Ygc3RyaW5nICE9PSAnc3RyaW5nJykge1xuICAgIHRocm93IG5ldyBUeXBlRXJyb3IoJ2FyZ3VtZW50IHN0cmluZyBpcyByZXF1aXJlZCB0byBiZSBhIHN0cmluZycpXG4gIH1cblxuICB2YXIgbWF0Y2ggPSBUWVBFX1JFR0VYUC5leGVjKHN0cmluZy50b0xvd2VyQ2FzZSgpKVxuXG4gIGlmICghbWF0Y2gpIHtcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKCdpbnZhbGlkIG1lZGlhIHR5cGUnKVxuICB9XG5cbiAgdmFyIHR5cGUgPSBtYXRjaFsxXVxuICB2YXIgc3VidHlwZSA9IG1hdGNoWzJdXG4gIHZhciBzdWZmaXhcblxuICAvLyBzdWZmaXggYWZ0ZXIgbGFzdCArXG4gIHZhciBpbmRleCA9IHN1YnR5cGUubGFzdEluZGV4T2YoJysnKVxuICBpZiAoaW5kZXggIT09IC0xKSB7XG4gICAgc3VmZml4ID0gc3VidHlwZS5zdWJzdHIoaW5kZXggKyAxKVxuICAgIHN1YnR5cGUgPSBzdWJ0eXBlLnN1YnN0cigwLCBpbmRleClcbiAgfVxuXG4gIHJldHVybiBuZXcgTWVkaWFUeXBlKHR5cGUsIHN1YnR5cGUsIHN1ZmZpeClcbn1cblxuLyoqXG4gKiBDbGFzcyBmb3IgTWVkaWFUeXBlIG9iamVjdC5cbiAqIEBwdWJsaWNcbiAqL1xuXG5mdW5jdGlvbiBNZWRpYVR5cGUgKHR5cGUsIHN1YnR5cGUsIHN1ZmZpeCkge1xuICB0aGlzLnR5cGUgPSB0eXBlXG4gIHRoaXMuc3VidHlwZSA9IHN1YnR5cGVcbiAgdGhpcy5zdWZmaXggPSBzdWZmaXhcbn1cbiIsICIvKiFcbiAqIGNvbnRlbnQtdHlwZVxuICogQ29weXJpZ2h0KGMpIDIwMTUgRG91Z2xhcyBDaHJpc3RvcGhlciBXaWxzb25cbiAqIE1JVCBMaWNlbnNlZFxuICovXG5cbid1c2Ugc3RyaWN0J1xuXG4vKipcbiAqIFJlZ0V4cCB0byBtYXRjaCAqKCBcIjtcIiBwYXJhbWV0ZXIgKSBpbiBSRkMgNzIzMSBzZWMgMy4xLjEuMVxuICpcbiAqIHBhcmFtZXRlciAgICAgPSB0b2tlbiBcIj1cIiAoIHRva2VuIC8gcXVvdGVkLXN0cmluZyApXG4gKiB0b2tlbiAgICAgICAgID0gMSp0Y2hhclxuICogdGNoYXIgICAgICAgICA9IFwiIVwiIC8gXCIjXCIgLyBcIiRcIiAvIFwiJVwiIC8gXCImXCIgLyBcIidcIiAvIFwiKlwiXG4gKiAgICAgICAgICAgICAgIC8gXCIrXCIgLyBcIi1cIiAvIFwiLlwiIC8gXCJeXCIgLyBcIl9cIiAvIFwiYFwiIC8gXCJ8XCIgLyBcIn5cIlxuICogICAgICAgICAgICAgICAvIERJR0lUIC8gQUxQSEFcbiAqICAgICAgICAgICAgICAgOyBhbnkgVkNIQVIsIGV4Y2VwdCBkZWxpbWl0ZXJzXG4gKiBxdW90ZWQtc3RyaW5nID0gRFFVT1RFICooIHFkdGV4dCAvIHF1b3RlZC1wYWlyICkgRFFVT1RFXG4gKiBxZHRleHQgICAgICAgID0gSFRBQiAvIFNQIC8gJXgyMSAvICV4MjMtNUIgLyAleDVELTdFIC8gb2JzLXRleHRcbiAqIG9icy10ZXh0ICAgICAgPSAleDgwLUZGXG4gKiBxdW90ZWQtcGFpciAgID0gXCJcXFwiICggSFRBQiAvIFNQIC8gVkNIQVIgLyBvYnMtdGV4dCApXG4gKi9cbnZhciBQQVJBTV9SRUdFWFAgPSAvOyAqKFshIyQlJicqKy5eX2B8fjAtOUEtWmEtei1dKykgKj0gKihcIig/OltcXHUwMDBiXFx1MDAyMFxcdTAwMjFcXHUwMDIzLVxcdTAwNWJcXHUwMDVkLVxcdTAwN2VcXHUwMDgwLVxcdTAwZmZdfFxcXFxbXFx1MDAwYlxcdTAwMjAtXFx1MDBmZl0pKlwifFshIyQlJicqKy5eX2B8fjAtOUEtWmEtei1dKykgKi9nIC8vIGVzbGludC1kaXNhYmxlLWxpbmUgbm8tY29udHJvbC1yZWdleFxudmFyIFRFWFRfUkVHRVhQID0gL15bXFx1MDAwYlxcdTAwMjAtXFx1MDA3ZVxcdTAwODAtXFx1MDBmZl0rJC8gLy8gZXNsaW50LWRpc2FibGUtbGluZSBuby1jb250cm9sLXJlZ2V4XG52YXIgVE9LRU5fUkVHRVhQID0gL15bISMkJSYnKisuXl9gfH4wLTlBLVphLXotXSskL1xuXG4vKipcbiAqIFJlZ0V4cCB0byBtYXRjaCBxdW90ZWQtcGFpciBpbiBSRkMgNzIzMCBzZWMgMy4yLjZcbiAqXG4gKiBxdW90ZWQtcGFpciA9IFwiXFxcIiAoIEhUQUIgLyBTUCAvIFZDSEFSIC8gb2JzLXRleHQgKVxuICogb2JzLXRleHQgICAgPSAleDgwLUZGXG4gKi9cbnZhciBRRVNDX1JFR0VYUCA9IC9cXFxcKFtcXHUwMDBiXFx1MDAyMC1cXHUwMGZmXSkvZyAvLyBlc2xpbnQtZGlzYWJsZS1saW5lIG5vLWNvbnRyb2wtcmVnZXhcblxuLyoqXG4gKiBSZWdFeHAgdG8gbWF0Y2ggY2hhcnMgdGhhdCBtdXN0IGJlIHF1b3RlZC1wYWlyIGluIFJGQyA3MjMwIHNlYyAzLjIuNlxuICovXG52YXIgUVVPVEVfUkVHRVhQID0gLyhbXFxcXFwiXSkvZ1xuXG4vKipcbiAqIFJlZ0V4cCB0byBtYXRjaCB0eXBlIGluIFJGQyA3MjMxIHNlYyAzLjEuMS4xXG4gKlxuICogbWVkaWEtdHlwZSA9IHR5cGUgXCIvXCIgc3VidHlwZVxuICogdHlwZSAgICAgICA9IHRva2VuXG4gKiBzdWJ0eXBlICAgID0gdG9rZW5cbiAqL1xudmFyIFRZUEVfUkVHRVhQID0gL15bISMkJSYnKisuXl9gfH4wLTlBLVphLXotXStcXC9bISMkJSYnKisuXl9gfH4wLTlBLVphLXotXSskL1xuXG4vKipcbiAqIE1vZHVsZSBleHBvcnRzLlxuICogQHB1YmxpY1xuICovXG5cbmV4cG9ydHMuZm9ybWF0ID0gZm9ybWF0XG5leHBvcnRzLnBhcnNlID0gcGFyc2VcblxuLyoqXG4gKiBGb3JtYXQgb2JqZWN0IHRvIG1lZGlhIHR5cGUuXG4gKlxuICogQHBhcmFtIHtvYmplY3R9IG9ialxuICogQHJldHVybiB7c3RyaW5nfVxuICogQHB1YmxpY1xuICovXG5cbmZ1bmN0aW9uIGZvcm1hdCAob2JqKSB7XG4gIGlmICghb2JqIHx8IHR5cGVvZiBvYmogIT09ICdvYmplY3QnKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignYXJndW1lbnQgb2JqIGlzIHJlcXVpcmVkJylcbiAgfVxuXG4gIHZhciBwYXJhbWV0ZXJzID0gb2JqLnBhcmFtZXRlcnNcbiAgdmFyIHR5cGUgPSBvYmoudHlwZVxuXG4gIGlmICghdHlwZSB8fCAhVFlQRV9SRUdFWFAudGVzdCh0eXBlKSkge1xuICAgIHRocm93IG5ldyBUeXBlRXJyb3IoJ2ludmFsaWQgdHlwZScpXG4gIH1cblxuICB2YXIgc3RyaW5nID0gdHlwZVxuXG4gIC8vIGFwcGVuZCBwYXJhbWV0ZXJzXG4gIGlmIChwYXJhbWV0ZXJzICYmIHR5cGVvZiBwYXJhbWV0ZXJzID09PSAnb2JqZWN0Jykge1xuICAgIHZhciBwYXJhbVxuICAgIHZhciBwYXJhbXMgPSBPYmplY3Qua2V5cyhwYXJhbWV0ZXJzKS5zb3J0KClcblxuICAgIGZvciAodmFyIGkgPSAwOyBpIDwgcGFyYW1zLmxlbmd0aDsgaSsrKSB7XG4gICAgICBwYXJhbSA9IHBhcmFtc1tpXVxuXG4gICAgICBpZiAoIVRPS0VOX1JFR0VYUC50ZXN0KHBhcmFtKSkge1xuICAgICAgICB0aHJvdyBuZXcgVHlwZUVycm9yKCdpbnZhbGlkIHBhcmFtZXRlciBuYW1lJylcbiAgICAgIH1cblxuICAgICAgc3RyaW5nICs9ICc7ICcgKyBwYXJhbSArICc9JyArIHFzdHJpbmcocGFyYW1ldGVyc1twYXJhbV0pXG4gICAgfVxuICB9XG5cbiAgcmV0dXJuIHN0cmluZ1xufVxuXG4vKipcbiAqIFBhcnNlIG1lZGlhIHR5cGUgdG8gb2JqZWN0LlxuICpcbiAqIEBwYXJhbSB7c3RyaW5nfG9iamVjdH0gc3RyaW5nXG4gKiBAcmV0dXJuIHtPYmplY3R9XG4gKiBAcHVibGljXG4gKi9cblxuZnVuY3Rpb24gcGFyc2UgKHN0cmluZykge1xuICBpZiAoIXN0cmluZykge1xuICAgIHRocm93IG5ldyBUeXBlRXJyb3IoJ2FyZ3VtZW50IHN0cmluZyBpcyByZXF1aXJlZCcpXG4gIH1cblxuICAvLyBzdXBwb3J0IHJlcS9yZXMtbGlrZSBvYmplY3RzIGFzIGFyZ3VtZW50XG4gIHZhciBoZWFkZXIgPSB0eXBlb2Ygc3RyaW5nID09PSAnb2JqZWN0J1xuICAgID8gZ2V0Y29udGVudHR5cGUoc3RyaW5nKVxuICAgIDogc3RyaW5nXG5cbiAgaWYgKHR5cGVvZiBoZWFkZXIgIT09ICdzdHJpbmcnKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignYXJndW1lbnQgc3RyaW5nIGlzIHJlcXVpcmVkIHRvIGJlIGEgc3RyaW5nJylcbiAgfVxuXG4gIHZhciBpbmRleCA9IGhlYWRlci5pbmRleE9mKCc7JylcbiAgdmFyIHR5cGUgPSBpbmRleCAhPT0gLTFcbiAgICA/IGhlYWRlci5zbGljZSgwLCBpbmRleCkudHJpbSgpXG4gICAgOiBoZWFkZXIudHJpbSgpXG5cbiAgaWYgKCFUWVBFX1JFR0VYUC50ZXN0KHR5cGUpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignaW52YWxpZCBtZWRpYSB0eXBlJylcbiAgfVxuXG4gIHZhciBvYmogPSBuZXcgQ29udGVudFR5cGUodHlwZS50b0xvd2VyQ2FzZSgpKVxuXG4gIC8vIHBhcnNlIHBhcmFtZXRlcnNcbiAgaWYgKGluZGV4ICE9PSAtMSkge1xuICAgIHZhciBrZXlcbiAgICB2YXIgbWF0Y2hcbiAgICB2YXIgdmFsdWVcblxuICAgIFBBUkFNX1JFR0VYUC5sYXN0SW5kZXggPSBpbmRleFxuXG4gICAgd2hpbGUgKChtYXRjaCA9IFBBUkFNX1JFR0VYUC5leGVjKGhlYWRlcikpKSB7XG4gICAgICBpZiAobWF0Y2guaW5kZXggIT09IGluZGV4KSB7XG4gICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoJ2ludmFsaWQgcGFyYW1ldGVyIGZvcm1hdCcpXG4gICAgICB9XG5cbiAgICAgIGluZGV4ICs9IG1hdGNoWzBdLmxlbmd0aFxuICAgICAga2V5ID0gbWF0Y2hbMV0udG9Mb3dlckNhc2UoKVxuICAgICAgdmFsdWUgPSBtYXRjaFsyXVxuXG4gICAgICBpZiAodmFsdWUuY2hhckNvZGVBdCgwKSA9PT0gMHgyMiAvKiBcIiAqLykge1xuICAgICAgICAvLyByZW1vdmUgcXVvdGVzXG4gICAgICAgIHZhbHVlID0gdmFsdWUuc2xpY2UoMSwgLTEpXG5cbiAgICAgICAgLy8gcmVtb3ZlIGVzY2FwZXNcbiAgICAgICAgaWYgKHZhbHVlLmluZGV4T2YoJ1xcXFwnKSAhPT0gLTEpIHtcbiAgICAgICAgICB2YWx1ZSA9IHZhbHVlLnJlcGxhY2UoUUVTQ19SRUdFWFAsICckMScpXG4gICAgICAgIH1cbiAgICAgIH1cblxuICAgICAgb2JqLnBhcmFtZXRlcnNba2V5XSA9IHZhbHVlXG4gICAgfVxuXG4gICAgaWYgKGluZGV4ICE9PSBoZWFkZXIubGVuZ3RoKSB7XG4gICAgICB0aHJvdyBuZXcgVHlwZUVycm9yKCdpbnZhbGlkIHBhcmFtZXRlciBmb3JtYXQnKVxuICAgIH1cbiAgfVxuXG4gIHJldHVybiBvYmpcbn1cblxuLyoqXG4gKiBHZXQgY29udGVudC10eXBlIGZyb20gcmVxL3JlcyBvYmplY3RzLlxuICpcbiAqIEBwYXJhbSB7b2JqZWN0fVxuICogQHJldHVybiB7T2JqZWN0fVxuICogQHByaXZhdGVcbiAqL1xuXG5mdW5jdGlvbiBnZXRjb250ZW50dHlwZSAob2JqKSB7XG4gIHZhciBoZWFkZXJcblxuICBpZiAodHlwZW9mIG9iai5nZXRIZWFkZXIgPT09ICdmdW5jdGlvbicpIHtcbiAgICAvLyByZXMtbGlrZVxuICAgIGhlYWRlciA9IG9iai5nZXRIZWFkZXIoJ2NvbnRlbnQtdHlwZScpXG4gIH0gZWxzZSBpZiAodHlwZW9mIG9iai5oZWFkZXJzID09PSAnb2JqZWN0Jykge1xuICAgIC8vIHJlcS1saWtlXG4gICAgaGVhZGVyID0gb2JqLmhlYWRlcnMgJiYgb2JqLmhlYWRlcnNbJ2NvbnRlbnQtdHlwZSddXG4gIH1cblxuICBpZiAodHlwZW9mIGhlYWRlciAhPT0gJ3N0cmluZycpIHtcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKCdjb250ZW50LXR5cGUgaGVhZGVyIGlzIG1pc3NpbmcgZnJvbSBvYmplY3QnKVxuICB9XG5cbiAgcmV0dXJuIGhlYWRlclxufVxuXG4vKipcbiAqIFF1b3RlIGEgc3RyaW5nIGlmIG5lY2Vzc2FyeS5cbiAqXG4gKiBAcGFyYW0ge3N0cmluZ30gdmFsXG4gKiBAcmV0dXJuIHtzdHJpbmd9XG4gKiBAcHJpdmF0ZVxuICovXG5cbmZ1bmN0aW9uIHFzdHJpbmcgKHZhbCkge1xuICB2YXIgc3RyID0gU3RyaW5nKHZhbClcblxuICAvLyBubyBuZWVkIHRvIHF1b3RlIHRva2Vuc1xuICBpZiAoVE9LRU5fUkVHRVhQLnRlc3Qoc3RyKSkge1xuICAgIHJldHVybiBzdHJcbiAgfVxuXG4gIGlmIChzdHIubGVuZ3RoID4gMCAmJiAhVEVYVF9SRUdFWFAudGVzdChzdHIpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcignaW52YWxpZCBwYXJhbWV0ZXIgdmFsdWUnKVxuICB9XG5cbiAgcmV0dXJuICdcIicgKyBzdHIucmVwbGFjZShRVU9URV9SRUdFWFAsICdcXFxcJDEnKSArICdcIidcbn1cblxuLyoqXG4gKiBDbGFzcyB0byByZXByZXNlbnQgYSBjb250ZW50IHR5cGUuXG4gKiBAcHJpdmF0ZVxuICovXG5mdW5jdGlvbiBDb250ZW50VHlwZSAodHlwZSkge1xuICB0aGlzLnBhcmFtZXRlcnMgPSBPYmplY3QuY3JlYXRlKG51bGwpXG4gIHRoaXMudHlwZSA9IHR5cGVcbn1cbiIsICJcInVzZSBzdHJpY3RcIjtcblxudmFyIGNvbnZlcnNpb25zID0ge307XG5tb2R1bGUuZXhwb3J0cyA9IGNvbnZlcnNpb25zO1xuXG5mdW5jdGlvbiBzaWduKHgpIHtcbiAgICByZXR1cm4geCA8IDAgPyAtMSA6IDE7XG59XG5cbmZ1bmN0aW9uIGV2ZW5Sb3VuZCh4KSB7XG4gICAgLy8gUm91bmQgeCB0byB0aGUgbmVhcmVzdCBpbnRlZ2VyLCBjaG9vc2luZyB0aGUgZXZlbiBpbnRlZ2VyIGlmIGl0IGxpZXMgaGFsZndheSBiZXR3ZWVuIHR3by5cbiAgICBpZiAoKHggJSAxKSA9PT0gMC41ICYmICh4ICYgMSkgPT09IDApIHsgLy8gW2V2ZW4gbnVtYmVyXS41OyByb3VuZCBkb3duIChpLmUuIGZsb29yKVxuICAgICAgICByZXR1cm4gTWF0aC5mbG9vcih4KTtcbiAgICB9IGVsc2Uge1xuICAgICAgICByZXR1cm4gTWF0aC5yb3VuZCh4KTtcbiAgICB9XG59XG5cbmZ1bmN0aW9uIGNyZWF0ZU51bWJlckNvbnZlcnNpb24oYml0TGVuZ3RoLCB0eXBlT3B0cykge1xuICAgIGlmICghdHlwZU9wdHMudW5zaWduZWQpIHtcbiAgICAgICAgLS1iaXRMZW5ndGg7XG4gICAgfVxuICAgIGNvbnN0IGxvd2VyQm91bmQgPSB0eXBlT3B0cy51bnNpZ25lZCA/IDAgOiAtTWF0aC5wb3coMiwgYml0TGVuZ3RoKTtcbiAgICBjb25zdCB1cHBlckJvdW5kID0gTWF0aC5wb3coMiwgYml0TGVuZ3RoKSAtIDE7XG5cbiAgICBjb25zdCBtb2R1bG9WYWwgPSB0eXBlT3B0cy5tb2R1bG9CaXRMZW5ndGggPyBNYXRoLnBvdygyLCB0eXBlT3B0cy5tb2R1bG9CaXRMZW5ndGgpIDogTWF0aC5wb3coMiwgYml0TGVuZ3RoKTtcbiAgICBjb25zdCBtb2R1bG9Cb3VuZCA9IHR5cGVPcHRzLm1vZHVsb0JpdExlbmd0aCA/IE1hdGgucG93KDIsIHR5cGVPcHRzLm1vZHVsb0JpdExlbmd0aCAtIDEpIDogTWF0aC5wb3coMiwgYml0TGVuZ3RoIC0gMSk7XG5cbiAgICByZXR1cm4gZnVuY3Rpb24oViwgb3B0cykge1xuICAgICAgICBpZiAoIW9wdHMpIG9wdHMgPSB7fTtcblxuICAgICAgICBsZXQgeCA9ICtWO1xuXG4gICAgICAgIGlmIChvcHRzLmVuZm9yY2VSYW5nZSkge1xuICAgICAgICAgICAgaWYgKCFOdW1iZXIuaXNGaW5pdGUoeCkpIHtcbiAgICAgICAgICAgICAgICB0aHJvdyBuZXcgVHlwZUVycm9yKFwiQXJndW1lbnQgaXMgbm90IGEgZmluaXRlIG51bWJlclwiKTtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgeCA9IHNpZ24oeCkgKiBNYXRoLmZsb29yKE1hdGguYWJzKHgpKTtcbiAgICAgICAgICAgIGlmICh4IDwgbG93ZXJCb3VuZCB8fCB4ID4gdXBwZXJCb3VuZCkge1xuICAgICAgICAgICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXCJBcmd1bWVudCBpcyBub3QgaW4gYnl0ZSByYW5nZVwiKTtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgcmV0dXJuIHg7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIWlzTmFOKHgpICYmIG9wdHMuY2xhbXApIHtcbiAgICAgICAgICAgIHggPSBldmVuUm91bmQoeCk7XG5cbiAgICAgICAgICAgIGlmICh4IDwgbG93ZXJCb3VuZCkgeCA9IGxvd2VyQm91bmQ7XG4gICAgICAgICAgICBpZiAoeCA+IHVwcGVyQm91bmQpIHggPSB1cHBlckJvdW5kO1xuICAgICAgICAgICAgcmV0dXJuIHg7XG4gICAgICAgIH1cblxuICAgICAgICBpZiAoIU51bWJlci5pc0Zpbml0ZSh4KSB8fCB4ID09PSAwKSB7XG4gICAgICAgICAgICByZXR1cm4gMDtcbiAgICAgICAgfVxuXG4gICAgICAgIHggPSBzaWduKHgpICogTWF0aC5mbG9vcihNYXRoLmFicyh4KSk7XG4gICAgICAgIHggPSB4ICUgbW9kdWxvVmFsO1xuXG4gICAgICAgIGlmICghdHlwZU9wdHMudW5zaWduZWQgJiYgeCA+PSBtb2R1bG9Cb3VuZCkge1xuICAgICAgICAgICAgcmV0dXJuIHggLSBtb2R1bG9WYWw7XG4gICAgICAgIH0gZWxzZSBpZiAodHlwZU9wdHMudW5zaWduZWQpIHtcbiAgICAgICAgICAgIGlmICh4IDwgMCkge1xuICAgICAgICAgICAgICB4ICs9IG1vZHVsb1ZhbDtcbiAgICAgICAgICAgIH0gZWxzZSBpZiAoeCA9PT0gLTApIHsgLy8gZG9uJ3QgcmV0dXJuIG5lZ2F0aXZlIHplcm9cbiAgICAgICAgICAgICAgcmV0dXJuIDA7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cblxuICAgICAgICByZXR1cm4geDtcbiAgICB9XG59XG5cbmNvbnZlcnNpb25zW1widm9pZFwiXSA9IGZ1bmN0aW9uICgpIHtcbiAgICByZXR1cm4gdW5kZWZpbmVkO1xufTtcblxuY29udmVyc2lvbnNbXCJib29sZWFuXCJdID0gZnVuY3Rpb24gKHZhbCkge1xuICAgIHJldHVybiAhIXZhbDtcbn07XG5cbmNvbnZlcnNpb25zW1wiYnl0ZVwiXSA9IGNyZWF0ZU51bWJlckNvbnZlcnNpb24oOCwgeyB1bnNpZ25lZDogZmFsc2UgfSk7XG5jb252ZXJzaW9uc1tcIm9jdGV0XCJdID0gY3JlYXRlTnVtYmVyQ29udmVyc2lvbig4LCB7IHVuc2lnbmVkOiB0cnVlIH0pO1xuXG5jb252ZXJzaW9uc1tcInNob3J0XCJdID0gY3JlYXRlTnVtYmVyQ29udmVyc2lvbigxNiwgeyB1bnNpZ25lZDogZmFsc2UgfSk7XG5jb252ZXJzaW9uc1tcInVuc2lnbmVkIHNob3J0XCJdID0gY3JlYXRlTnVtYmVyQ29udmVyc2lvbigxNiwgeyB1bnNpZ25lZDogdHJ1ZSB9KTtcblxuY29udmVyc2lvbnNbXCJsb25nXCJdID0gY3JlYXRlTnVtYmVyQ29udmVyc2lvbigzMiwgeyB1bnNpZ25lZDogZmFsc2UgfSk7XG5jb252ZXJzaW9uc1tcInVuc2lnbmVkIGxvbmdcIl0gPSBjcmVhdGVOdW1iZXJDb252ZXJzaW9uKDMyLCB7IHVuc2lnbmVkOiB0cnVlIH0pO1xuXG5jb252ZXJzaW9uc1tcImxvbmcgbG9uZ1wiXSA9IGNyZWF0ZU51bWJlckNvbnZlcnNpb24oMzIsIHsgdW5zaWduZWQ6IGZhbHNlLCBtb2R1bG9CaXRMZW5ndGg6IDY0IH0pO1xuY29udmVyc2lvbnNbXCJ1bnNpZ25lZCBsb25nIGxvbmdcIl0gPSBjcmVhdGVOdW1iZXJDb252ZXJzaW9uKDMyLCB7IHVuc2lnbmVkOiB0cnVlLCBtb2R1bG9CaXRMZW5ndGg6IDY0IH0pO1xuXG5jb252ZXJzaW9uc1tcImRvdWJsZVwiXSA9IGZ1bmN0aW9uIChWKSB7XG4gICAgY29uc3QgeCA9ICtWO1xuXG4gICAgaWYgKCFOdW1iZXIuaXNGaW5pdGUoeCkpIHtcbiAgICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcIkFyZ3VtZW50IGlzIG5vdCBhIGZpbml0ZSBmbG9hdGluZy1wb2ludCB2YWx1ZVwiKTtcbiAgICB9XG5cbiAgICByZXR1cm4geDtcbn07XG5cbmNvbnZlcnNpb25zW1widW5yZXN0cmljdGVkIGRvdWJsZVwiXSA9IGZ1bmN0aW9uIChWKSB7XG4gICAgY29uc3QgeCA9ICtWO1xuXG4gICAgaWYgKGlzTmFOKHgpKSB7XG4gICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXCJBcmd1bWVudCBpcyBOYU5cIik7XG4gICAgfVxuXG4gICAgcmV0dXJuIHg7XG59O1xuXG4vLyBub3QgcXVpdGUgdmFsaWQsIGJ1dCBnb29kIGVub3VnaCBmb3IgSlNcbmNvbnZlcnNpb25zW1wiZmxvYXRcIl0gPSBjb252ZXJzaW9uc1tcImRvdWJsZVwiXTtcbmNvbnZlcnNpb25zW1widW5yZXN0cmljdGVkIGZsb2F0XCJdID0gY29udmVyc2lvbnNbXCJ1bnJlc3RyaWN0ZWQgZG91YmxlXCJdO1xuXG5jb252ZXJzaW9uc1tcIkRPTVN0cmluZ1wiXSA9IGZ1bmN0aW9uIChWLCBvcHRzKSB7XG4gICAgaWYgKCFvcHRzKSBvcHRzID0ge307XG5cbiAgICBpZiAob3B0cy50cmVhdE51bGxBc0VtcHR5U3RyaW5nICYmIFYgPT09IG51bGwpIHtcbiAgICAgICAgcmV0dXJuIFwiXCI7XG4gICAgfVxuXG4gICAgcmV0dXJuIFN0cmluZyhWKTtcbn07XG5cbmNvbnZlcnNpb25zW1wiQnl0ZVN0cmluZ1wiXSA9IGZ1bmN0aW9uIChWLCBvcHRzKSB7XG4gICAgY29uc3QgeCA9IFN0cmluZyhWKTtcbiAgICBsZXQgYyA9IHVuZGVmaW5lZDtcbiAgICBmb3IgKGxldCBpID0gMDsgKGMgPSB4LmNvZGVQb2ludEF0KGkpKSAhPT0gdW5kZWZpbmVkOyArK2kpIHtcbiAgICAgICAgaWYgKGMgPiAyNTUpIHtcbiAgICAgICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXCJBcmd1bWVudCBpcyBub3QgYSB2YWxpZCBieXRlc3RyaW5nXCIpO1xuICAgICAgICB9XG4gICAgfVxuXG4gICAgcmV0dXJuIHg7XG59O1xuXG5jb252ZXJzaW9uc1tcIlVTVlN0cmluZ1wiXSA9IGZ1bmN0aW9uIChWKSB7XG4gICAgY29uc3QgUyA9IFN0cmluZyhWKTtcbiAgICBjb25zdCBuID0gUy5sZW5ndGg7XG4gICAgY29uc3QgVSA9IFtdO1xuICAgIGZvciAobGV0IGkgPSAwOyBpIDwgbjsgKytpKSB7XG4gICAgICAgIGNvbnN0IGMgPSBTLmNoYXJDb2RlQXQoaSk7XG4gICAgICAgIGlmIChjIDwgMHhEODAwIHx8IGMgPiAweERGRkYpIHtcbiAgICAgICAgICAgIFUucHVzaChTdHJpbmcuZnJvbUNvZGVQb2ludChjKSk7XG4gICAgICAgIH0gZWxzZSBpZiAoMHhEQzAwIDw9IGMgJiYgYyA8PSAweERGRkYpIHtcbiAgICAgICAgICAgIFUucHVzaChTdHJpbmcuZnJvbUNvZGVQb2ludCgweEZGRkQpKTtcbiAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgIGlmIChpID09PSBuIC0gMSkge1xuICAgICAgICAgICAgICAgIFUucHVzaChTdHJpbmcuZnJvbUNvZGVQb2ludCgweEZGRkQpKTtcbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgY29uc3QgZCA9IFMuY2hhckNvZGVBdChpICsgMSk7XG4gICAgICAgICAgICAgICAgaWYgKDB4REMwMCA8PSBkICYmIGQgPD0gMHhERkZGKSB7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGEgPSBjICYgMHgzRkY7XG4gICAgICAgICAgICAgICAgICAgIGNvbnN0IGIgPSBkICYgMHgzRkY7XG4gICAgICAgICAgICAgICAgICAgIFUucHVzaChTdHJpbmcuZnJvbUNvZGVQb2ludCgoMiA8PCAxNSkgKyAoMiA8PCA5KSAqIGEgKyBiKSk7XG4gICAgICAgICAgICAgICAgICAgICsraTtcbiAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICBVLnB1c2goU3RyaW5nLmZyb21Db2RlUG9pbnQoMHhGRkZEKSk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgfVxuXG4gICAgcmV0dXJuIFUuam9pbignJyk7XG59O1xuXG5jb252ZXJzaW9uc1tcIkRhdGVcIl0gPSBmdW5jdGlvbiAoViwgb3B0cykge1xuICAgIGlmICghKFYgaW5zdGFuY2VvZiBEYXRlKSkge1xuICAgICAgICB0aHJvdyBuZXcgVHlwZUVycm9yKFwiQXJndW1lbnQgaXMgbm90IGEgRGF0ZSBvYmplY3RcIik7XG4gICAgfVxuICAgIGlmIChpc05hTihWKSkge1xuICAgICAgICByZXR1cm4gdW5kZWZpbmVkO1xuICAgIH1cblxuICAgIHJldHVybiBWO1xufTtcblxuY29udmVyc2lvbnNbXCJSZWdFeHBcIl0gPSBmdW5jdGlvbiAoViwgb3B0cykge1xuICAgIGlmICghKFYgaW5zdGFuY2VvZiBSZWdFeHApKSB7XG4gICAgICAgIFYgPSBuZXcgUmVnRXhwKFYpO1xuICAgIH1cblxuICAgIHJldHVybiBWO1xufTtcbiIsICJcInVzZSBzdHJpY3RcIjtcblxubW9kdWxlLmV4cG9ydHMubWl4aW4gPSBmdW5jdGlvbiBtaXhpbih0YXJnZXQsIHNvdXJjZSkge1xuICBjb25zdCBrZXlzID0gT2JqZWN0LmdldE93blByb3BlcnR5TmFtZXMoc291cmNlKTtcbiAgZm9yIChsZXQgaSA9IDA7IGkgPCBrZXlzLmxlbmd0aDsgKytpKSB7XG4gICAgT2JqZWN0LmRlZmluZVByb3BlcnR5KHRhcmdldCwga2V5c1tpXSwgT2JqZWN0LmdldE93blByb3BlcnR5RGVzY3JpcHRvcihzb3VyY2UsIGtleXNbaV0pKTtcbiAgfVxufTtcblxubW9kdWxlLmV4cG9ydHMud3JhcHBlclN5bWJvbCA9IFN5bWJvbChcIndyYXBwZXJcIik7XG5tb2R1bGUuZXhwb3J0cy5pbXBsU3ltYm9sID0gU3ltYm9sKFwiaW1wbFwiKTtcblxubW9kdWxlLmV4cG9ydHMud3JhcHBlckZvckltcGwgPSBmdW5jdGlvbiAoaW1wbCkge1xuICByZXR1cm4gaW1wbFttb2R1bGUuZXhwb3J0cy53cmFwcGVyU3ltYm9sXTtcbn07XG5cbm1vZHVsZS5leHBvcnRzLmltcGxGb3JXcmFwcGVyID0gZnVuY3Rpb24gKHdyYXBwZXIpIHtcbiAgcmV0dXJuIHdyYXBwZXJbbW9kdWxlLmV4cG9ydHMuaW1wbFN5bWJvbF07XG59O1xuXG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG5cbnZhciBwdW55Y29kZSA9IHJlcXVpcmUoXCJwdW55Y29kZVwiKTtcbnZhciBtYXBwaW5nVGFibGUgPSByZXF1aXJlKFwiLi9saWIvbWFwcGluZ1RhYmxlLmpzb25cIik7XG5cbnZhciBQUk9DRVNTSU5HX09QVElPTlMgPSB7XG4gIFRSQU5TSVRJT05BTDogMCxcbiAgTk9OVFJBTlNJVElPTkFMOiAxXG59O1xuXG5mdW5jdGlvbiBub3JtYWxpemUoc3RyKSB7IC8vIGZpeCBidWcgaW4gdjhcbiAgcmV0dXJuIHN0ci5zcGxpdCgnXFx1MDAwMCcpLm1hcChmdW5jdGlvbiAocykgeyByZXR1cm4gcy5ub3JtYWxpemUoJ05GQycpOyB9KS5qb2luKCdcXHUwMDAwJyk7XG59XG5cbmZ1bmN0aW9uIGZpbmRTdGF0dXModmFsKSB7XG4gIHZhciBzdGFydCA9IDA7XG4gIHZhciBlbmQgPSBtYXBwaW5nVGFibGUubGVuZ3RoIC0gMTtcblxuICB3aGlsZSAoc3RhcnQgPD0gZW5kKSB7XG4gICAgdmFyIG1pZCA9IE1hdGguZmxvb3IoKHN0YXJ0ICsgZW5kKSAvIDIpO1xuXG4gICAgdmFyIHRhcmdldCA9IG1hcHBpbmdUYWJsZVttaWRdO1xuICAgIGlmICh0YXJnZXRbMF1bMF0gPD0gdmFsICYmIHRhcmdldFswXVsxXSA+PSB2YWwpIHtcbiAgICAgIHJldHVybiB0YXJnZXQ7XG4gICAgfSBlbHNlIGlmICh0YXJnZXRbMF1bMF0gPiB2YWwpIHtcbiAgICAgIGVuZCA9IG1pZCAtIDE7XG4gICAgfSBlbHNlIHtcbiAgICAgIHN0YXJ0ID0gbWlkICsgMTtcbiAgICB9XG4gIH1cblxuICByZXR1cm4gbnVsbDtcbn1cblxudmFyIHJlZ2V4QXN0cmFsU3ltYm9scyA9IC9bXFx1RDgwMC1cXHVEQkZGXVtcXHVEQzAwLVxcdURGRkZdL2c7XG5cbmZ1bmN0aW9uIGNvdW50U3ltYm9scyhzdHJpbmcpIHtcbiAgcmV0dXJuIHN0cmluZ1xuICAgIC8vIHJlcGxhY2UgZXZlcnkgc3Vycm9nYXRlIHBhaXIgd2l0aCBhIEJNUCBzeW1ib2xcbiAgICAucmVwbGFjZShyZWdleEFzdHJhbFN5bWJvbHMsICdfJylcbiAgICAvLyB0aGVuIGdldCB0aGUgbGVuZ3RoXG4gICAgLmxlbmd0aDtcbn1cblxuZnVuY3Rpb24gbWFwQ2hhcnMoZG9tYWluX25hbWUsIHVzZVNURDMsIHByb2Nlc3Npbmdfb3B0aW9uKSB7XG4gIHZhciBoYXNFcnJvciA9IGZhbHNlO1xuICB2YXIgcHJvY2Vzc2VkID0gXCJcIjtcblxuICB2YXIgbGVuID0gY291bnRTeW1ib2xzKGRvbWFpbl9uYW1lKTtcbiAgZm9yICh2YXIgaSA9IDA7IGkgPCBsZW47ICsraSkge1xuICAgIHZhciBjb2RlUG9pbnQgPSBkb21haW5fbmFtZS5jb2RlUG9pbnRBdChpKTtcbiAgICB2YXIgc3RhdHVzID0gZmluZFN0YXR1cyhjb2RlUG9pbnQpO1xuXG4gICAgc3dpdGNoIChzdGF0dXNbMV0pIHtcbiAgICAgIGNhc2UgXCJkaXNhbGxvd2VkXCI6XG4gICAgICAgIGhhc0Vycm9yID0gdHJ1ZTtcbiAgICAgICAgcHJvY2Vzc2VkICs9IFN0cmluZy5mcm9tQ29kZVBvaW50KGNvZGVQb2ludCk7XG4gICAgICAgIGJyZWFrO1xuICAgICAgY2FzZSBcImlnbm9yZWRcIjpcbiAgICAgICAgYnJlYWs7XG4gICAgICBjYXNlIFwibWFwcGVkXCI6XG4gICAgICAgIHByb2Nlc3NlZCArPSBTdHJpbmcuZnJvbUNvZGVQb2ludC5hcHBseShTdHJpbmcsIHN0YXR1c1syXSk7XG4gICAgICAgIGJyZWFrO1xuICAgICAgY2FzZSBcImRldmlhdGlvblwiOlxuICAgICAgICBpZiAocHJvY2Vzc2luZ19vcHRpb24gPT09IFBST0NFU1NJTkdfT1BUSU9OUy5UUkFOU0lUSU9OQUwpIHtcbiAgICAgICAgICBwcm9jZXNzZWQgKz0gU3RyaW5nLmZyb21Db2RlUG9pbnQuYXBwbHkoU3RyaW5nLCBzdGF0dXNbMl0pO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIHByb2Nlc3NlZCArPSBTdHJpbmcuZnJvbUNvZGVQb2ludChjb2RlUG9pbnQpO1xuICAgICAgICB9XG4gICAgICAgIGJyZWFrO1xuICAgICAgY2FzZSBcInZhbGlkXCI6XG4gICAgICAgIHByb2Nlc3NlZCArPSBTdHJpbmcuZnJvbUNvZGVQb2ludChjb2RlUG9pbnQpO1xuICAgICAgICBicmVhaztcbiAgICAgIGNhc2UgXCJkaXNhbGxvd2VkX1NURDNfbWFwcGVkXCI6XG4gICAgICAgIGlmICh1c2VTVEQzKSB7XG4gICAgICAgICAgaGFzRXJyb3IgPSB0cnVlO1xuICAgICAgICAgIHByb2Nlc3NlZCArPSBTdHJpbmcuZnJvbUNvZGVQb2ludChjb2RlUG9pbnQpO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIHByb2Nlc3NlZCArPSBTdHJpbmcuZnJvbUNvZGVQb2ludC5hcHBseShTdHJpbmcsIHN0YXR1c1syXSk7XG4gICAgICAgIH1cbiAgICAgICAgYnJlYWs7XG4gICAgICBjYXNlIFwiZGlzYWxsb3dlZF9TVEQzX3ZhbGlkXCI6XG4gICAgICAgIGlmICh1c2VTVEQzKSB7XG4gICAgICAgICAgaGFzRXJyb3IgPSB0cnVlO1xuICAgICAgICB9XG5cbiAgICAgICAgcHJvY2Vzc2VkICs9IFN0cmluZy5mcm9tQ29kZVBvaW50KGNvZGVQb2ludCk7XG4gICAgICAgIGJyZWFrO1xuICAgIH1cbiAgfVxuXG4gIHJldHVybiB7XG4gICAgc3RyaW5nOiBwcm9jZXNzZWQsXG4gICAgZXJyb3I6IGhhc0Vycm9yXG4gIH07XG59XG5cbnZhciBjb21iaW5pbmdNYXJrc1JlZ2V4ID0gL1tcXHUwMzAwLVxcdTAzNkZcXHUwNDgzLVxcdTA0ODlcXHUwNTkxLVxcdTA1QkRcXHUwNUJGXFx1MDVDMVxcdTA1QzJcXHUwNUM0XFx1MDVDNVxcdTA1QzdcXHUwNjEwLVxcdTA2MUFcXHUwNjRCLVxcdTA2NUZcXHUwNjcwXFx1MDZENi1cXHUwNkRDXFx1MDZERi1cXHUwNkU0XFx1MDZFN1xcdTA2RThcXHUwNkVBLVxcdTA2RURcXHUwNzExXFx1MDczMC1cXHUwNzRBXFx1MDdBNi1cXHUwN0IwXFx1MDdFQi1cXHUwN0YzXFx1MDgxNi1cXHUwODE5XFx1MDgxQi1cXHUwODIzXFx1MDgyNS1cXHUwODI3XFx1MDgyOS1cXHUwODJEXFx1MDg1OS1cXHUwODVCXFx1MDhFNC1cXHUwOTAzXFx1MDkzQS1cXHUwOTNDXFx1MDkzRS1cXHUwOTRGXFx1MDk1MS1cXHUwOTU3XFx1MDk2MlxcdTA5NjNcXHUwOTgxLVxcdTA5ODNcXHUwOUJDXFx1MDlCRS1cXHUwOUM0XFx1MDlDN1xcdTA5QzhcXHUwOUNCLVxcdTA5Q0RcXHUwOUQ3XFx1MDlFMlxcdTA5RTNcXHUwQTAxLVxcdTBBMDNcXHUwQTNDXFx1MEEzRS1cXHUwQTQyXFx1MEE0N1xcdTBBNDhcXHUwQTRCLVxcdTBBNERcXHUwQTUxXFx1MEE3MFxcdTBBNzFcXHUwQTc1XFx1MEE4MS1cXHUwQTgzXFx1MEFCQ1xcdTBBQkUtXFx1MEFDNVxcdTBBQzctXFx1MEFDOVxcdTBBQ0ItXFx1MEFDRFxcdTBBRTJcXHUwQUUzXFx1MEIwMS1cXHUwQjAzXFx1MEIzQ1xcdTBCM0UtXFx1MEI0NFxcdTBCNDdcXHUwQjQ4XFx1MEI0Qi1cXHUwQjREXFx1MEI1NlxcdTBCNTdcXHUwQjYyXFx1MEI2M1xcdTBCODJcXHUwQkJFLVxcdTBCQzJcXHUwQkM2LVxcdTBCQzhcXHUwQkNBLVxcdTBCQ0RcXHUwQkQ3XFx1MEMwMC1cXHUwQzAzXFx1MEMzRS1cXHUwQzQ0XFx1MEM0Ni1cXHUwQzQ4XFx1MEM0QS1cXHUwQzREXFx1MEM1NVxcdTBDNTZcXHUwQzYyXFx1MEM2M1xcdTBDODEtXFx1MEM4M1xcdTBDQkNcXHUwQ0JFLVxcdTBDQzRcXHUwQ0M2LVxcdTBDQzhcXHUwQ0NBLVxcdTBDQ0RcXHUwQ0Q1XFx1MENENlxcdTBDRTJcXHUwQ0UzXFx1MEQwMS1cXHUwRDAzXFx1MEQzRS1cXHUwRDQ0XFx1MEQ0Ni1cXHUwRDQ4XFx1MEQ0QS1cXHUwRDREXFx1MEQ1N1xcdTBENjJcXHUwRDYzXFx1MEQ4MlxcdTBEODNcXHUwRENBXFx1MERDRi1cXHUwREQ0XFx1MERENlxcdTBERDgtXFx1MERERlxcdTBERjJcXHUwREYzXFx1MEUzMVxcdTBFMzQtXFx1MEUzQVxcdTBFNDctXFx1MEU0RVxcdTBFQjFcXHUwRUI0LVxcdTBFQjlcXHUwRUJCXFx1MEVCQ1xcdTBFQzgtXFx1MEVDRFxcdTBGMThcXHUwRjE5XFx1MEYzNVxcdTBGMzdcXHUwRjM5XFx1MEYzRVxcdTBGM0ZcXHUwRjcxLVxcdTBGODRcXHUwRjg2XFx1MEY4N1xcdTBGOEQtXFx1MEY5N1xcdTBGOTktXFx1MEZCQ1xcdTBGQzZcXHUxMDJCLVxcdTEwM0VcXHUxMDU2LVxcdTEwNTlcXHUxMDVFLVxcdTEwNjBcXHUxMDYyLVxcdTEwNjRcXHUxMDY3LVxcdTEwNkRcXHUxMDcxLVxcdTEwNzRcXHUxMDgyLVxcdTEwOERcXHUxMDhGXFx1MTA5QS1cXHUxMDlEXFx1MTM1RC1cXHUxMzVGXFx1MTcxMi1cXHUxNzE0XFx1MTczMi1cXHUxNzM0XFx1MTc1MlxcdTE3NTNcXHUxNzcyXFx1MTc3M1xcdTE3QjQtXFx1MTdEM1xcdTE3RERcXHUxODBCLVxcdTE4MERcXHUxOEE5XFx1MTkyMC1cXHUxOTJCXFx1MTkzMC1cXHUxOTNCXFx1MTlCMC1cXHUxOUMwXFx1MTlDOFxcdTE5QzlcXHUxQTE3LVxcdTFBMUJcXHUxQTU1LVxcdTFBNUVcXHUxQTYwLVxcdTFBN0NcXHUxQTdGXFx1MUFCMC1cXHUxQUJFXFx1MUIwMC1cXHUxQjA0XFx1MUIzNC1cXHUxQjQ0XFx1MUI2Qi1cXHUxQjczXFx1MUI4MC1cXHUxQjgyXFx1MUJBMS1cXHUxQkFEXFx1MUJFNi1cXHUxQkYzXFx1MUMyNC1cXHUxQzM3XFx1MUNEMC1cXHUxQ0QyXFx1MUNENC1cXHUxQ0U4XFx1MUNFRFxcdTFDRjItXFx1MUNGNFxcdTFDRjhcXHUxQ0Y5XFx1MURDMC1cXHUxREY1XFx1MURGQy1cXHUxREZGXFx1MjBEMC1cXHUyMEYwXFx1MkNFRi1cXHUyQ0YxXFx1MkQ3RlxcdTJERTAtXFx1MkRGRlxcdTMwMkEtXFx1MzAyRlxcdTMwOTlcXHUzMDlBXFx1QTY2Ri1cXHVBNjcyXFx1QTY3NC1cXHVBNjdEXFx1QTY5RlxcdUE2RjBcXHVBNkYxXFx1QTgwMlxcdUE4MDZcXHVBODBCXFx1QTgyMy1cXHVBODI3XFx1QTg4MFxcdUE4ODFcXHVBOEI0LVxcdUE4QzRcXHVBOEUwLVxcdUE4RjFcXHVBOTI2LVxcdUE5MkRcXHVBOTQ3LVxcdUE5NTNcXHVBOTgwLVxcdUE5ODNcXHVBOUIzLVxcdUE5QzBcXHVBOUU1XFx1QUEyOS1cXHVBQTM2XFx1QUE0M1xcdUFBNENcXHVBQTREXFx1QUE3Qi1cXHVBQTdEXFx1QUFCMFxcdUFBQjItXFx1QUFCNFxcdUFBQjdcXHVBQUI4XFx1QUFCRVxcdUFBQkZcXHVBQUMxXFx1QUFFQi1cXHVBQUVGXFx1QUFGNVxcdUFBRjZcXHVBQkUzLVxcdUFCRUFcXHVBQkVDXFx1QUJFRFxcdUZCMUVcXHVGRTAwLVxcdUZFMEZcXHVGRTIwLVxcdUZFMkRdfFxcdUQ4MDBbXFx1RERGRFxcdURFRTBcXHVERjc2LVxcdURGN0FdfFxcdUQ4MDJbXFx1REUwMS1cXHVERTAzXFx1REUwNVxcdURFMDZcXHVERTBDLVxcdURFMEZcXHVERTM4LVxcdURFM0FcXHVERTNGXFx1REVFNVxcdURFRTZdfFxcdUQ4MDRbXFx1REMwMC1cXHVEQzAyXFx1REMzOC1cXHVEQzQ2XFx1REM3Ri1cXHVEQzgyXFx1RENCMC1cXHVEQ0JBXFx1REQwMC1cXHVERDAyXFx1REQyNy1cXHVERDM0XFx1REQ3M1xcdUREODAtXFx1REQ4MlxcdUREQjMtXFx1RERDMFxcdURFMkMtXFx1REUzN1xcdURFREYtXFx1REVFQVxcdURGMDEtXFx1REYwM1xcdURGM0NcXHVERjNFLVxcdURGNDRcXHVERjQ3XFx1REY0OFxcdURGNEItXFx1REY0RFxcdURGNTdcXHVERjYyXFx1REY2M1xcdURGNjYtXFx1REY2Q1xcdURGNzAtXFx1REY3NF18XFx1RDgwNVtcXHVEQ0IwLVxcdURDQzNcXHVEREFGLVxcdUREQjVcXHVEREI4LVxcdUREQzBcXHVERTMwLVxcdURFNDBcXHVERUFCLVxcdURFQjddfFxcdUQ4MUFbXFx1REVGMC1cXHVERUY0XFx1REYzMC1cXHVERjM2XXxcXHVEODFCW1xcdURGNTEtXFx1REY3RVxcdURGOEYtXFx1REY5Ml18XFx1RDgyRltcXHVEQzlEXFx1REM5RV18XFx1RDgzNFtcXHVERDY1LVxcdURENjlcXHVERDZELVxcdURENzJcXHVERDdCLVxcdUREODJcXHVERDg1LVxcdUREOEJcXHVEREFBLVxcdUREQURcXHVERTQyLVxcdURFNDRdfFxcdUQ4M0FbXFx1RENEMC1cXHVEQ0Q2XXxcXHVEQjQwW1xcdUREMDAtXFx1RERFRl0vO1xuXG5mdW5jdGlvbiB2YWxpZGF0ZUxhYmVsKGxhYmVsLCBwcm9jZXNzaW5nX29wdGlvbikge1xuICBpZiAobGFiZWwuc3Vic3RyKDAsIDQpID09PSBcInhuLS1cIikge1xuICAgIGxhYmVsID0gcHVueWNvZGUudG9Vbmljb2RlKGxhYmVsKTtcbiAgICBwcm9jZXNzaW5nX29wdGlvbiA9IFBST0NFU1NJTkdfT1BUSU9OUy5OT05UUkFOU0lUSU9OQUw7XG4gIH1cblxuICB2YXIgZXJyb3IgPSBmYWxzZTtcblxuICBpZiAobm9ybWFsaXplKGxhYmVsKSAhPT0gbGFiZWwgfHxcbiAgICAgIChsYWJlbFszXSA9PT0gXCItXCIgJiYgbGFiZWxbNF0gPT09IFwiLVwiKSB8fFxuICAgICAgbGFiZWxbMF0gPT09IFwiLVwiIHx8IGxhYmVsW2xhYmVsLmxlbmd0aCAtIDFdID09PSBcIi1cIiB8fFxuICAgICAgbGFiZWwuaW5kZXhPZihcIi5cIikgIT09IC0xIHx8XG4gICAgICBsYWJlbC5zZWFyY2goY29tYmluaW5nTWFya3NSZWdleCkgPT09IDApIHtcbiAgICBlcnJvciA9IHRydWU7XG4gIH1cblxuICB2YXIgbGVuID0gY291bnRTeW1ib2xzKGxhYmVsKTtcbiAgZm9yICh2YXIgaSA9IDA7IGkgPCBsZW47ICsraSkge1xuICAgIHZhciBzdGF0dXMgPSBmaW5kU3RhdHVzKGxhYmVsLmNvZGVQb2ludEF0KGkpKTtcbiAgICBpZiAoKHByb2Nlc3NpbmcgPT09IFBST0NFU1NJTkdfT1BUSU9OUy5UUkFOU0lUSU9OQUwgJiYgc3RhdHVzWzFdICE9PSBcInZhbGlkXCIpIHx8XG4gICAgICAgIChwcm9jZXNzaW5nID09PSBQUk9DRVNTSU5HX09QVElPTlMuTk9OVFJBTlNJVElPTkFMICYmXG4gICAgICAgICBzdGF0dXNbMV0gIT09IFwidmFsaWRcIiAmJiBzdGF0dXNbMV0gIT09IFwiZGV2aWF0aW9uXCIpKSB7XG4gICAgICBlcnJvciA9IHRydWU7XG4gICAgICBicmVhaztcbiAgICB9XG4gIH1cblxuICByZXR1cm4ge1xuICAgIGxhYmVsOiBsYWJlbCxcbiAgICBlcnJvcjogZXJyb3JcbiAgfTtcbn1cblxuZnVuY3Rpb24gcHJvY2Vzc2luZyhkb21haW5fbmFtZSwgdXNlU1REMywgcHJvY2Vzc2luZ19vcHRpb24pIHtcbiAgdmFyIHJlc3VsdCA9IG1hcENoYXJzKGRvbWFpbl9uYW1lLCB1c2VTVEQzLCBwcm9jZXNzaW5nX29wdGlvbik7XG4gIHJlc3VsdC5zdHJpbmcgPSBub3JtYWxpemUocmVzdWx0LnN0cmluZyk7XG5cbiAgdmFyIGxhYmVscyA9IHJlc3VsdC5zdHJpbmcuc3BsaXQoXCIuXCIpO1xuICBmb3IgKHZhciBpID0gMDsgaSA8IGxhYmVscy5sZW5ndGg7ICsraSkge1xuICAgIHRyeSB7XG4gICAgICB2YXIgdmFsaWRhdGlvbiA9IHZhbGlkYXRlTGFiZWwobGFiZWxzW2ldKTtcbiAgICAgIGxhYmVsc1tpXSA9IHZhbGlkYXRpb24ubGFiZWw7XG4gICAgICByZXN1bHQuZXJyb3IgPSByZXN1bHQuZXJyb3IgfHwgdmFsaWRhdGlvbi5lcnJvcjtcbiAgICB9IGNhdGNoKGUpIHtcbiAgICAgIHJlc3VsdC5lcnJvciA9IHRydWU7XG4gICAgfVxuICB9XG5cbiAgcmV0dXJuIHtcbiAgICBzdHJpbmc6IGxhYmVscy5qb2luKFwiLlwiKSxcbiAgICBlcnJvcjogcmVzdWx0LmVycm9yXG4gIH07XG59XG5cbm1vZHVsZS5leHBvcnRzLnRvQVNDSUkgPSBmdW5jdGlvbihkb21haW5fbmFtZSwgdXNlU1REMywgcHJvY2Vzc2luZ19vcHRpb24sIHZlcmlmeURuc0xlbmd0aCkge1xuICB2YXIgcmVzdWx0ID0gcHJvY2Vzc2luZyhkb21haW5fbmFtZSwgdXNlU1REMywgcHJvY2Vzc2luZ19vcHRpb24pO1xuICB2YXIgbGFiZWxzID0gcmVzdWx0LnN0cmluZy5zcGxpdChcIi5cIik7XG4gIGxhYmVscyA9IGxhYmVscy5tYXAoZnVuY3Rpb24obCkge1xuICAgIHRyeSB7XG4gICAgICByZXR1cm4gcHVueWNvZGUudG9BU0NJSShsKTtcbiAgICB9IGNhdGNoKGUpIHtcbiAgICAgIHJlc3VsdC5lcnJvciA9IHRydWU7XG4gICAgICByZXR1cm4gbDtcbiAgICB9XG4gIH0pO1xuXG4gIGlmICh2ZXJpZnlEbnNMZW5ndGgpIHtcbiAgICB2YXIgdG90YWwgPSBsYWJlbHMuc2xpY2UoMCwgbGFiZWxzLmxlbmd0aCAtIDEpLmpvaW4oXCIuXCIpLmxlbmd0aDtcbiAgICBpZiAodG90YWwubGVuZ3RoID4gMjUzIHx8IHRvdGFsLmxlbmd0aCA9PT0gMCkge1xuICAgICAgcmVzdWx0LmVycm9yID0gdHJ1ZTtcbiAgICB9XG5cbiAgICBmb3IgKHZhciBpPTA7IGkgPCBsYWJlbHMubGVuZ3RoOyArK2kpIHtcbiAgICAgIGlmIChsYWJlbHMubGVuZ3RoID4gNjMgfHwgbGFiZWxzLmxlbmd0aCA9PT0gMCkge1xuICAgICAgICByZXN1bHQuZXJyb3IgPSB0cnVlO1xuICAgICAgICBicmVhaztcbiAgICAgIH1cbiAgICB9XG4gIH1cblxuICBpZiAocmVzdWx0LmVycm9yKSByZXR1cm4gbnVsbDtcbiAgcmV0dXJuIGxhYmVscy5qb2luKFwiLlwiKTtcbn07XG5cbm1vZHVsZS5leHBvcnRzLnRvVW5pY29kZSA9IGZ1bmN0aW9uKGRvbWFpbl9uYW1lLCB1c2VTVEQzKSB7XG4gIHZhciByZXN1bHQgPSBwcm9jZXNzaW5nKGRvbWFpbl9uYW1lLCB1c2VTVEQzLCBQUk9DRVNTSU5HX09QVElPTlMuTk9OVFJBTlNJVElPTkFMKTtcblxuICByZXR1cm4ge1xuICAgIGRvbWFpbjogcmVzdWx0LnN0cmluZyxcbiAgICBlcnJvcjogcmVzdWx0LmVycm9yXG4gIH07XG59O1xuXG5tb2R1bGUuZXhwb3J0cy5QUk9DRVNTSU5HX09QVElPTlMgPSBQUk9DRVNTSU5HX09QVElPTlM7XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XHJcbmNvbnN0IHB1bnljb2RlID0gcmVxdWlyZShcInB1bnljb2RlXCIpO1xyXG5jb25zdCB0cjQ2ID0gcmVxdWlyZShcInRyNDZcIik7XHJcblxyXG5jb25zdCBzcGVjaWFsU2NoZW1lcyA9IHtcclxuICBmdHA6IDIxLFxyXG4gIGZpbGU6IG51bGwsXHJcbiAgZ29waGVyOiA3MCxcclxuICBodHRwOiA4MCxcclxuICBodHRwczogNDQzLFxyXG4gIHdzOiA4MCxcclxuICB3c3M6IDQ0M1xyXG59O1xyXG5cclxuY29uc3QgZmFpbHVyZSA9IFN5bWJvbChcImZhaWx1cmVcIik7XHJcblxyXG5mdW5jdGlvbiBjb3VudFN5bWJvbHMoc3RyKSB7XHJcbiAgcmV0dXJuIHB1bnljb2RlLnVjczIuZGVjb2RlKHN0cikubGVuZ3RoO1xyXG59XHJcblxyXG5mdW5jdGlvbiBhdChpbnB1dCwgaWR4KSB7XHJcbiAgY29uc3QgYyA9IGlucHV0W2lkeF07XHJcbiAgcmV0dXJuIGlzTmFOKGMpID8gdW5kZWZpbmVkIDogU3RyaW5nLmZyb21Db2RlUG9pbnQoYyk7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzQVNDSUlEaWdpdChjKSB7XHJcbiAgcmV0dXJuIGMgPj0gMHgzMCAmJiBjIDw9IDB4Mzk7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzQVNDSUlBbHBoYShjKSB7XHJcbiAgcmV0dXJuIChjID49IDB4NDEgJiYgYyA8PSAweDVBKSB8fCAoYyA+PSAweDYxICYmIGMgPD0gMHg3QSk7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzQVNDSUlBbHBoYW51bWVyaWMoYykge1xyXG4gIHJldHVybiBpc0FTQ0lJQWxwaGEoYykgfHwgaXNBU0NJSURpZ2l0KGMpO1xyXG59XHJcblxyXG5mdW5jdGlvbiBpc0FTQ0lJSGV4KGMpIHtcclxuICByZXR1cm4gaXNBU0NJSURpZ2l0KGMpIHx8IChjID49IDB4NDEgJiYgYyA8PSAweDQ2KSB8fCAoYyA+PSAweDYxICYmIGMgPD0gMHg2Nik7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzU2luZ2xlRG90KGJ1ZmZlcikge1xyXG4gIHJldHVybiBidWZmZXIgPT09IFwiLlwiIHx8IGJ1ZmZlci50b0xvd2VyQ2FzZSgpID09PSBcIiUyZVwiO1xyXG59XHJcblxyXG5mdW5jdGlvbiBpc0RvdWJsZURvdChidWZmZXIpIHtcclxuICBidWZmZXIgPSBidWZmZXIudG9Mb3dlckNhc2UoKTtcclxuICByZXR1cm4gYnVmZmVyID09PSBcIi4uXCIgfHwgYnVmZmVyID09PSBcIiUyZS5cIiB8fCBidWZmZXIgPT09IFwiLiUyZVwiIHx8IGJ1ZmZlciA9PT0gXCIlMmUlMmVcIjtcclxufVxyXG5cclxuZnVuY3Rpb24gaXNXaW5kb3dzRHJpdmVMZXR0ZXJDb2RlUG9pbnRzKGNwMSwgY3AyKSB7XHJcbiAgcmV0dXJuIGlzQVNDSUlBbHBoYShjcDEpICYmIChjcDIgPT09IDU4IHx8IGNwMiA9PT0gMTI0KTtcclxufVxyXG5cclxuZnVuY3Rpb24gaXNXaW5kb3dzRHJpdmVMZXR0ZXJTdHJpbmcoc3RyaW5nKSB7XHJcbiAgcmV0dXJuIHN0cmluZy5sZW5ndGggPT09IDIgJiYgaXNBU0NJSUFscGhhKHN0cmluZy5jb2RlUG9pbnRBdCgwKSkgJiYgKHN0cmluZ1sxXSA9PT0gXCI6XCIgfHwgc3RyaW5nWzFdID09PSBcInxcIik7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzTm9ybWFsaXplZFdpbmRvd3NEcml2ZUxldHRlclN0cmluZyhzdHJpbmcpIHtcclxuICByZXR1cm4gc3RyaW5nLmxlbmd0aCA9PT0gMiAmJiBpc0FTQ0lJQWxwaGEoc3RyaW5nLmNvZGVQb2ludEF0KDApKSAmJiBzdHJpbmdbMV0gPT09IFwiOlwiO1xyXG59XHJcblxyXG5mdW5jdGlvbiBjb250YWluc0ZvcmJpZGRlbkhvc3RDb2RlUG9pbnQoc3RyaW5nKSB7XHJcbiAgcmV0dXJuIHN0cmluZy5zZWFyY2goL1xcdTAwMDB8XFx1MDAwOXxcXHUwMDBBfFxcdTAwMER8XFx1MDAyMHwjfCV8XFwvfDp8XFw/fEB8XFxbfFxcXFx8XFxdLykgIT09IC0xO1xyXG59XHJcblxyXG5mdW5jdGlvbiBjb250YWluc0ZvcmJpZGRlbkhvc3RDb2RlUG9pbnRFeGNsdWRpbmdQZXJjZW50KHN0cmluZykge1xyXG4gIHJldHVybiBzdHJpbmcuc2VhcmNoKC9cXHUwMDAwfFxcdTAwMDl8XFx1MDAwQXxcXHUwMDBEfFxcdTAwMjB8I3xcXC98OnxcXD98QHxcXFt8XFxcXHxcXF0vKSAhPT0gLTE7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIGlzU3BlY2lhbFNjaGVtZShzY2hlbWUpIHtcclxuICByZXR1cm4gc3BlY2lhbFNjaGVtZXNbc2NoZW1lXSAhPT0gdW5kZWZpbmVkO1xyXG59XHJcblxyXG5mdW5jdGlvbiBpc1NwZWNpYWwodXJsKSB7XHJcbiAgcmV0dXJuIGlzU3BlY2lhbFNjaGVtZSh1cmwuc2NoZW1lKTtcclxufVxyXG5cclxuZnVuY3Rpb24gZGVmYXVsdFBvcnQoc2NoZW1lKSB7XHJcbiAgcmV0dXJuIHNwZWNpYWxTY2hlbWVzW3NjaGVtZV07XHJcbn1cclxuXHJcbmZ1bmN0aW9uIHBlcmNlbnRFbmNvZGUoYykge1xyXG4gIGxldCBoZXggPSBjLnRvU3RyaW5nKDE2KS50b1VwcGVyQ2FzZSgpO1xyXG4gIGlmIChoZXgubGVuZ3RoID09PSAxKSB7XHJcbiAgICBoZXggPSBcIjBcIiArIGhleDtcclxuICB9XHJcblxyXG4gIHJldHVybiBcIiVcIiArIGhleDtcclxufVxyXG5cclxuZnVuY3Rpb24gdXRmOFBlcmNlbnRFbmNvZGUoYykge1xyXG4gIGNvbnN0IGJ1ZiA9IG5ldyBCdWZmZXIoYyk7XHJcblxyXG4gIGxldCBzdHIgPSBcIlwiO1xyXG5cclxuICBmb3IgKGxldCBpID0gMDsgaSA8IGJ1Zi5sZW5ndGg7ICsraSkge1xyXG4gICAgc3RyICs9IHBlcmNlbnRFbmNvZGUoYnVmW2ldKTtcclxuICB9XHJcblxyXG4gIHJldHVybiBzdHI7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIHV0ZjhQZXJjZW50RGVjb2RlKHN0cikge1xyXG4gIGNvbnN0IGlucHV0ID0gbmV3IEJ1ZmZlcihzdHIpO1xyXG4gIGNvbnN0IG91dHB1dCA9IFtdO1xyXG4gIGZvciAobGV0IGkgPSAwOyBpIDwgaW5wdXQubGVuZ3RoOyArK2kpIHtcclxuICAgIGlmIChpbnB1dFtpXSAhPT0gMzcpIHtcclxuICAgICAgb3V0cHV0LnB1c2goaW5wdXRbaV0pO1xyXG4gICAgfSBlbHNlIGlmIChpbnB1dFtpXSA9PT0gMzcgJiYgaXNBU0NJSUhleChpbnB1dFtpICsgMV0pICYmIGlzQVNDSUlIZXgoaW5wdXRbaSArIDJdKSkge1xyXG4gICAgICBvdXRwdXQucHVzaChwYXJzZUludChpbnB1dC5zbGljZShpICsgMSwgaSArIDMpLnRvU3RyaW5nKCksIDE2KSk7XHJcbiAgICAgIGkgKz0gMjtcclxuICAgIH0gZWxzZSB7XHJcbiAgICAgIG91dHB1dC5wdXNoKGlucHV0W2ldKTtcclxuICAgIH1cclxuICB9XHJcbiAgcmV0dXJuIG5ldyBCdWZmZXIob3V0cHV0KS50b1N0cmluZygpO1xyXG59XHJcblxyXG5mdW5jdGlvbiBpc0MwQ29udHJvbFBlcmNlbnRFbmNvZGUoYykge1xyXG4gIHJldHVybiBjIDw9IDB4MUYgfHwgYyA+IDB4N0U7XHJcbn1cclxuXHJcbmNvbnN0IGV4dHJhUGF0aFBlcmNlbnRFbmNvZGVTZXQgPSBuZXcgU2V0KFszMiwgMzQsIDM1LCA2MCwgNjIsIDYzLCA5NiwgMTIzLCAxMjVdKTtcclxuZnVuY3Rpb24gaXNQYXRoUGVyY2VudEVuY29kZShjKSB7XHJcbiAgcmV0dXJuIGlzQzBDb250cm9sUGVyY2VudEVuY29kZShjKSB8fCBleHRyYVBhdGhQZXJjZW50RW5jb2RlU2V0LmhhcyhjKTtcclxufVxyXG5cclxuY29uc3QgZXh0cmFVc2VyaW5mb1BlcmNlbnRFbmNvZGVTZXQgPVxyXG4gIG5ldyBTZXQoWzQ3LCA1OCwgNTksIDYxLCA2NCwgOTEsIDkyLCA5MywgOTQsIDEyNF0pO1xyXG5mdW5jdGlvbiBpc1VzZXJpbmZvUGVyY2VudEVuY29kZShjKSB7XHJcbiAgcmV0dXJuIGlzUGF0aFBlcmNlbnRFbmNvZGUoYykgfHwgZXh0cmFVc2VyaW5mb1BlcmNlbnRFbmNvZGVTZXQuaGFzKGMpO1xyXG59XHJcblxyXG5mdW5jdGlvbiBwZXJjZW50RW5jb2RlQ2hhcihjLCBlbmNvZGVTZXRQcmVkaWNhdGUpIHtcclxuICBjb25zdCBjU3RyID0gU3RyaW5nLmZyb21Db2RlUG9pbnQoYyk7XHJcblxyXG4gIGlmIChlbmNvZGVTZXRQcmVkaWNhdGUoYykpIHtcclxuICAgIHJldHVybiB1dGY4UGVyY2VudEVuY29kZShjU3RyKTtcclxuICB9XHJcblxyXG4gIHJldHVybiBjU3RyO1xyXG59XHJcblxyXG5mdW5jdGlvbiBwYXJzZUlQdjROdW1iZXIoaW5wdXQpIHtcclxuICBsZXQgUiA9IDEwO1xyXG5cclxuICBpZiAoaW5wdXQubGVuZ3RoID49IDIgJiYgaW5wdXQuY2hhckF0KDApID09PSBcIjBcIiAmJiBpbnB1dC5jaGFyQXQoMSkudG9Mb3dlckNhc2UoKSA9PT0gXCJ4XCIpIHtcclxuICAgIGlucHV0ID0gaW5wdXQuc3Vic3RyaW5nKDIpO1xyXG4gICAgUiA9IDE2O1xyXG4gIH0gZWxzZSBpZiAoaW5wdXQubGVuZ3RoID49IDIgJiYgaW5wdXQuY2hhckF0KDApID09PSBcIjBcIikge1xyXG4gICAgaW5wdXQgPSBpbnB1dC5zdWJzdHJpbmcoMSk7XHJcbiAgICBSID0gODtcclxuICB9XHJcblxyXG4gIGlmIChpbnB1dCA9PT0gXCJcIikge1xyXG4gICAgcmV0dXJuIDA7XHJcbiAgfVxyXG5cclxuICBjb25zdCByZWdleCA9IFIgPT09IDEwID8gL1teMC05XS8gOiAoUiA9PT0gMTYgPyAvW14wLTlBLUZhLWZdLyA6IC9bXjAtN10vKTtcclxuICBpZiAocmVnZXgudGVzdChpbnB1dCkpIHtcclxuICAgIHJldHVybiBmYWlsdXJlO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHBhcnNlSW50KGlucHV0LCBSKTtcclxufVxyXG5cclxuZnVuY3Rpb24gcGFyc2VJUHY0KGlucHV0KSB7XHJcbiAgY29uc3QgcGFydHMgPSBpbnB1dC5zcGxpdChcIi5cIik7XHJcbiAgaWYgKHBhcnRzW3BhcnRzLmxlbmd0aCAtIDFdID09PSBcIlwiKSB7XHJcbiAgICBpZiAocGFydHMubGVuZ3RoID4gMSkge1xyXG4gICAgICBwYXJ0cy5wb3AoKTtcclxuICAgIH1cclxuICB9XHJcblxyXG4gIGlmIChwYXJ0cy5sZW5ndGggPiA0KSB7XHJcbiAgICByZXR1cm4gaW5wdXQ7XHJcbiAgfVxyXG5cclxuICBjb25zdCBudW1iZXJzID0gW107XHJcbiAgZm9yIChjb25zdCBwYXJ0IG9mIHBhcnRzKSB7XHJcbiAgICBpZiAocGFydCA9PT0gXCJcIikge1xyXG4gICAgICByZXR1cm4gaW5wdXQ7XHJcbiAgICB9XHJcbiAgICBjb25zdCBuID0gcGFyc2VJUHY0TnVtYmVyKHBhcnQpO1xyXG4gICAgaWYgKG4gPT09IGZhaWx1cmUpIHtcclxuICAgICAgcmV0dXJuIGlucHV0O1xyXG4gICAgfVxyXG5cclxuICAgIG51bWJlcnMucHVzaChuKTtcclxuICB9XHJcblxyXG4gIGZvciAobGV0IGkgPSAwOyBpIDwgbnVtYmVycy5sZW5ndGggLSAxOyArK2kpIHtcclxuICAgIGlmIChudW1iZXJzW2ldID4gMjU1KSB7XHJcbiAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgfVxyXG4gIH1cclxuICBpZiAobnVtYmVyc1tudW1iZXJzLmxlbmd0aCAtIDFdID49IE1hdGgucG93KDI1NiwgNSAtIG51bWJlcnMubGVuZ3RoKSkge1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfVxyXG5cclxuICBsZXQgaXB2NCA9IG51bWJlcnMucG9wKCk7XHJcbiAgbGV0IGNvdW50ZXIgPSAwO1xyXG5cclxuICBmb3IgKGNvbnN0IG4gb2YgbnVtYmVycykge1xyXG4gICAgaXB2NCArPSBuICogTWF0aC5wb3coMjU2LCAzIC0gY291bnRlcik7XHJcbiAgICArK2NvdW50ZXI7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gaXB2NDtcclxufVxyXG5cclxuZnVuY3Rpb24gc2VyaWFsaXplSVB2NChhZGRyZXNzKSB7XHJcbiAgbGV0IG91dHB1dCA9IFwiXCI7XHJcbiAgbGV0IG4gPSBhZGRyZXNzO1xyXG5cclxuICBmb3IgKGxldCBpID0gMTsgaSA8PSA0OyArK2kpIHtcclxuICAgIG91dHB1dCA9IFN0cmluZyhuICUgMjU2KSArIG91dHB1dDtcclxuICAgIGlmIChpICE9PSA0KSB7XHJcbiAgICAgIG91dHB1dCA9IFwiLlwiICsgb3V0cHV0O1xyXG4gICAgfVxyXG4gICAgbiA9IE1hdGguZmxvb3IobiAvIDI1Nik7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gb3V0cHV0O1xyXG59XHJcblxyXG5mdW5jdGlvbiBwYXJzZUlQdjYoaW5wdXQpIHtcclxuICBjb25zdCBhZGRyZXNzID0gWzAsIDAsIDAsIDAsIDAsIDAsIDAsIDBdO1xyXG4gIGxldCBwaWVjZUluZGV4ID0gMDtcclxuICBsZXQgY29tcHJlc3MgPSBudWxsO1xyXG4gIGxldCBwb2ludGVyID0gMDtcclxuXHJcbiAgaW5wdXQgPSBwdW55Y29kZS51Y3MyLmRlY29kZShpbnB1dCk7XHJcblxyXG4gIGlmIChpbnB1dFtwb2ludGVyXSA9PT0gNTgpIHtcclxuICAgIGlmIChpbnB1dFtwb2ludGVyICsgMV0gIT09IDU4KSB7XHJcbiAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgfVxyXG5cclxuICAgIHBvaW50ZXIgKz0gMjtcclxuICAgICsrcGllY2VJbmRleDtcclxuICAgIGNvbXByZXNzID0gcGllY2VJbmRleDtcclxuICB9XHJcblxyXG4gIHdoaWxlIChwb2ludGVyIDwgaW5wdXQubGVuZ3RoKSB7XHJcbiAgICBpZiAocGllY2VJbmRleCA9PT0gOCkge1xyXG4gICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgIH1cclxuXHJcbiAgICBpZiAoaW5wdXRbcG9pbnRlcl0gPT09IDU4KSB7XHJcbiAgICAgIGlmIChjb21wcmVzcyAhPT0gbnVsbCkge1xyXG4gICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICB9XHJcbiAgICAgICsrcG9pbnRlcjtcclxuICAgICAgKytwaWVjZUluZGV4O1xyXG4gICAgICBjb21wcmVzcyA9IHBpZWNlSW5kZXg7XHJcbiAgICAgIGNvbnRpbnVlO1xyXG4gICAgfVxyXG5cclxuICAgIGxldCB2YWx1ZSA9IDA7XHJcbiAgICBsZXQgbGVuZ3RoID0gMDtcclxuXHJcbiAgICB3aGlsZSAobGVuZ3RoIDwgNCAmJiBpc0FTQ0lJSGV4KGlucHV0W3BvaW50ZXJdKSkge1xyXG4gICAgICB2YWx1ZSA9IHZhbHVlICogMHgxMCArIHBhcnNlSW50KGF0KGlucHV0LCBwb2ludGVyKSwgMTYpO1xyXG4gICAgICArK3BvaW50ZXI7XHJcbiAgICAgICsrbGVuZ3RoO1xyXG4gICAgfVxyXG5cclxuICAgIGlmIChpbnB1dFtwb2ludGVyXSA9PT0gNDYpIHtcclxuICAgICAgaWYgKGxlbmd0aCA9PT0gMCkge1xyXG4gICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICB9XHJcblxyXG4gICAgICBwb2ludGVyIC09IGxlbmd0aDtcclxuXHJcbiAgICAgIGlmIChwaWVjZUluZGV4ID4gNikge1xyXG4gICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICB9XHJcblxyXG4gICAgICBsZXQgbnVtYmVyc1NlZW4gPSAwO1xyXG5cclxuICAgICAgd2hpbGUgKGlucHV0W3BvaW50ZXJdICE9PSB1bmRlZmluZWQpIHtcclxuICAgICAgICBsZXQgaXB2NFBpZWNlID0gbnVsbDtcclxuXHJcbiAgICAgICAgaWYgKG51bWJlcnNTZWVuID4gMCkge1xyXG4gICAgICAgICAgaWYgKGlucHV0W3BvaW50ZXJdID09PSA0NiAmJiBudW1iZXJzU2VlbiA8IDQpIHtcclxuICAgICAgICAgICAgKytwb2ludGVyO1xyXG4gICAgICAgICAgfSBlbHNlIHtcclxuICAgICAgICAgICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgICAgICAgICB9XHJcbiAgICAgICAgfVxyXG5cclxuICAgICAgICBpZiAoIWlzQVNDSUlEaWdpdChpbnB1dFtwb2ludGVyXSkpIHtcclxuICAgICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICAgIH1cclxuXHJcbiAgICAgICAgd2hpbGUgKGlzQVNDSUlEaWdpdChpbnB1dFtwb2ludGVyXSkpIHtcclxuICAgICAgICAgIGNvbnN0IG51bWJlciA9IHBhcnNlSW50KGF0KGlucHV0LCBwb2ludGVyKSk7XHJcbiAgICAgICAgICBpZiAoaXB2NFBpZWNlID09PSBudWxsKSB7XHJcbiAgICAgICAgICAgIGlwdjRQaWVjZSA9IG51bWJlcjtcclxuICAgICAgICAgIH0gZWxzZSBpZiAoaXB2NFBpZWNlID09PSAwKSB7XHJcbiAgICAgICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICAgICAgfSBlbHNlIHtcclxuICAgICAgICAgICAgaXB2NFBpZWNlID0gaXB2NFBpZWNlICogMTAgKyBudW1iZXI7XHJcbiAgICAgICAgICB9XHJcbiAgICAgICAgICBpZiAoaXB2NFBpZWNlID4gMjU1KSB7XHJcbiAgICAgICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICAgICAgfVxyXG4gICAgICAgICAgKytwb2ludGVyO1xyXG4gICAgICAgIH1cclxuXHJcbiAgICAgICAgYWRkcmVzc1twaWVjZUluZGV4XSA9IGFkZHJlc3NbcGllY2VJbmRleF0gKiAweDEwMCArIGlwdjRQaWVjZTtcclxuXHJcbiAgICAgICAgKytudW1iZXJzU2VlbjtcclxuXHJcbiAgICAgICAgaWYgKG51bWJlcnNTZWVuID09PSAyIHx8IG51bWJlcnNTZWVuID09PSA0KSB7XHJcbiAgICAgICAgICArK3BpZWNlSW5kZXg7XHJcbiAgICAgICAgfVxyXG4gICAgICB9XHJcblxyXG4gICAgICBpZiAobnVtYmVyc1NlZW4gIT09IDQpIHtcclxuICAgICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgICAgfVxyXG5cclxuICAgICAgYnJlYWs7XHJcbiAgICB9IGVsc2UgaWYgKGlucHV0W3BvaW50ZXJdID09PSA1OCkge1xyXG4gICAgICArK3BvaW50ZXI7XHJcbiAgICAgIGlmIChpbnB1dFtwb2ludGVyXSA9PT0gdW5kZWZpbmVkKSB7XHJcbiAgICAgICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgICAgIH1cclxuICAgIH0gZWxzZSBpZiAoaW5wdXRbcG9pbnRlcl0gIT09IHVuZGVmaW5lZCkge1xyXG4gICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgIH1cclxuXHJcbiAgICBhZGRyZXNzW3BpZWNlSW5kZXhdID0gdmFsdWU7XHJcbiAgICArK3BpZWNlSW5kZXg7XHJcbiAgfVxyXG5cclxuICBpZiAoY29tcHJlc3MgIT09IG51bGwpIHtcclxuICAgIGxldCBzd2FwcyA9IHBpZWNlSW5kZXggLSBjb21wcmVzcztcclxuICAgIHBpZWNlSW5kZXggPSA3O1xyXG4gICAgd2hpbGUgKHBpZWNlSW5kZXggIT09IDAgJiYgc3dhcHMgPiAwKSB7XHJcbiAgICAgIGNvbnN0IHRlbXAgPSBhZGRyZXNzW2NvbXByZXNzICsgc3dhcHMgLSAxXTtcclxuICAgICAgYWRkcmVzc1tjb21wcmVzcyArIHN3YXBzIC0gMV0gPSBhZGRyZXNzW3BpZWNlSW5kZXhdO1xyXG4gICAgICBhZGRyZXNzW3BpZWNlSW5kZXhdID0gdGVtcDtcclxuICAgICAgLS1waWVjZUluZGV4O1xyXG4gICAgICAtLXN3YXBzO1xyXG4gICAgfVxyXG4gIH0gZWxzZSBpZiAoY29tcHJlc3MgPT09IG51bGwgJiYgcGllY2VJbmRleCAhPT0gOCkge1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gYWRkcmVzcztcclxufVxyXG5cclxuZnVuY3Rpb24gc2VyaWFsaXplSVB2NihhZGRyZXNzKSB7XHJcbiAgbGV0IG91dHB1dCA9IFwiXCI7XHJcbiAgY29uc3Qgc2VxUmVzdWx0ID0gZmluZExvbmdlc3RaZXJvU2VxdWVuY2UoYWRkcmVzcyk7XHJcbiAgY29uc3QgY29tcHJlc3MgPSBzZXFSZXN1bHQuaWR4O1xyXG4gIGxldCBpZ25vcmUwID0gZmFsc2U7XHJcblxyXG4gIGZvciAobGV0IHBpZWNlSW5kZXggPSAwOyBwaWVjZUluZGV4IDw9IDc7ICsrcGllY2VJbmRleCkge1xyXG4gICAgaWYgKGlnbm9yZTAgJiYgYWRkcmVzc1twaWVjZUluZGV4XSA9PT0gMCkge1xyXG4gICAgICBjb250aW51ZTtcclxuICAgIH0gZWxzZSBpZiAoaWdub3JlMCkge1xyXG4gICAgICBpZ25vcmUwID0gZmFsc2U7XHJcbiAgICB9XHJcblxyXG4gICAgaWYgKGNvbXByZXNzID09PSBwaWVjZUluZGV4KSB7XHJcbiAgICAgIGNvbnN0IHNlcGFyYXRvciA9IHBpZWNlSW5kZXggPT09IDAgPyBcIjo6XCIgOiBcIjpcIjtcclxuICAgICAgb3V0cHV0ICs9IHNlcGFyYXRvcjtcclxuICAgICAgaWdub3JlMCA9IHRydWU7XHJcbiAgICAgIGNvbnRpbnVlO1xyXG4gICAgfVxyXG5cclxuICAgIG91dHB1dCArPSBhZGRyZXNzW3BpZWNlSW5kZXhdLnRvU3RyaW5nKDE2KTtcclxuXHJcbiAgICBpZiAocGllY2VJbmRleCAhPT0gNykge1xyXG4gICAgICBvdXRwdXQgKz0gXCI6XCI7XHJcbiAgICB9XHJcbiAgfVxyXG5cclxuICByZXR1cm4gb3V0cHV0O1xyXG59XHJcblxyXG5mdW5jdGlvbiBwYXJzZUhvc3QoaW5wdXQsIGlzU3BlY2lhbEFyZykge1xyXG4gIGlmIChpbnB1dFswXSA9PT0gXCJbXCIpIHtcclxuICAgIGlmIChpbnB1dFtpbnB1dC5sZW5ndGggLSAxXSAhPT0gXCJdXCIpIHtcclxuICAgICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgICB9XHJcblxyXG4gICAgcmV0dXJuIHBhcnNlSVB2NihpbnB1dC5zdWJzdHJpbmcoMSwgaW5wdXQubGVuZ3RoIC0gMSkpO1xyXG4gIH1cclxuXHJcbiAgaWYgKCFpc1NwZWNpYWxBcmcpIHtcclxuICAgIHJldHVybiBwYXJzZU9wYXF1ZUhvc3QoaW5wdXQpO1xyXG4gIH1cclxuXHJcbiAgY29uc3QgZG9tYWluID0gdXRmOFBlcmNlbnREZWNvZGUoaW5wdXQpO1xyXG4gIGNvbnN0IGFzY2lpRG9tYWluID0gdHI0Ni50b0FTQ0lJKGRvbWFpbiwgZmFsc2UsIHRyNDYuUFJPQ0VTU0lOR19PUFRJT05TLk5PTlRSQU5TSVRJT05BTCwgZmFsc2UpO1xyXG4gIGlmIChhc2NpaURvbWFpbiA9PT0gbnVsbCkge1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfVxyXG5cclxuICBpZiAoY29udGFpbnNGb3JiaWRkZW5Ib3N0Q29kZVBvaW50KGFzY2lpRG9tYWluKSkge1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfVxyXG5cclxuICBjb25zdCBpcHY0SG9zdCA9IHBhcnNlSVB2NChhc2NpaURvbWFpbik7XHJcbiAgaWYgKHR5cGVvZiBpcHY0SG9zdCA9PT0gXCJudW1iZXJcIiB8fCBpcHY0SG9zdCA9PT0gZmFpbHVyZSkge1xyXG4gICAgcmV0dXJuIGlwdjRIb3N0O1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIGFzY2lpRG9tYWluO1xyXG59XHJcblxyXG5mdW5jdGlvbiBwYXJzZU9wYXF1ZUhvc3QoaW5wdXQpIHtcclxuICBpZiAoY29udGFpbnNGb3JiaWRkZW5Ib3N0Q29kZVBvaW50RXhjbHVkaW5nUGVyY2VudChpbnB1dCkpIHtcclxuICAgIHJldHVybiBmYWlsdXJlO1xyXG4gIH1cclxuXHJcbiAgbGV0IG91dHB1dCA9IFwiXCI7XHJcbiAgY29uc3QgZGVjb2RlZCA9IHB1bnljb2RlLnVjczIuZGVjb2RlKGlucHV0KTtcclxuICBmb3IgKGxldCBpID0gMDsgaSA8IGRlY29kZWQubGVuZ3RoOyArK2kpIHtcclxuICAgIG91dHB1dCArPSBwZXJjZW50RW5jb2RlQ2hhcihkZWNvZGVkW2ldLCBpc0MwQ29udHJvbFBlcmNlbnRFbmNvZGUpO1xyXG4gIH1cclxuICByZXR1cm4gb3V0cHV0O1xyXG59XHJcblxyXG5mdW5jdGlvbiBmaW5kTG9uZ2VzdFplcm9TZXF1ZW5jZShhcnIpIHtcclxuICBsZXQgbWF4SWR4ID0gbnVsbDtcclxuICBsZXQgbWF4TGVuID0gMTsgLy8gb25seSBmaW5kIGVsZW1lbnRzID4gMVxyXG4gIGxldCBjdXJyU3RhcnQgPSBudWxsO1xyXG4gIGxldCBjdXJyTGVuID0gMDtcclxuXHJcbiAgZm9yIChsZXQgaSA9IDA7IGkgPCBhcnIubGVuZ3RoOyArK2kpIHtcclxuICAgIGlmIChhcnJbaV0gIT09IDApIHtcclxuICAgICAgaWYgKGN1cnJMZW4gPiBtYXhMZW4pIHtcclxuICAgICAgICBtYXhJZHggPSBjdXJyU3RhcnQ7XHJcbiAgICAgICAgbWF4TGVuID0gY3VyckxlbjtcclxuICAgICAgfVxyXG5cclxuICAgICAgY3VyclN0YXJ0ID0gbnVsbDtcclxuICAgICAgY3VyckxlbiA9IDA7XHJcbiAgICB9IGVsc2Uge1xyXG4gICAgICBpZiAoY3VyclN0YXJ0ID09PSBudWxsKSB7XHJcbiAgICAgICAgY3VyclN0YXJ0ID0gaTtcclxuICAgICAgfVxyXG4gICAgICArK2N1cnJMZW47XHJcbiAgICB9XHJcbiAgfVxyXG5cclxuICAvLyBpZiB0cmFpbGluZyB6ZXJvc1xyXG4gIGlmIChjdXJyTGVuID4gbWF4TGVuKSB7XHJcbiAgICBtYXhJZHggPSBjdXJyU3RhcnQ7XHJcbiAgICBtYXhMZW4gPSBjdXJyTGVuO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHtcclxuICAgIGlkeDogbWF4SWR4LFxyXG4gICAgbGVuOiBtYXhMZW5cclxuICB9O1xyXG59XHJcblxyXG5mdW5jdGlvbiBzZXJpYWxpemVIb3N0KGhvc3QpIHtcclxuICBpZiAodHlwZW9mIGhvc3QgPT09IFwibnVtYmVyXCIpIHtcclxuICAgIHJldHVybiBzZXJpYWxpemVJUHY0KGhvc3QpO1xyXG4gIH1cclxuXHJcbiAgLy8gSVB2NiBzZXJpYWxpemVyXHJcbiAgaWYgKGhvc3QgaW5zdGFuY2VvZiBBcnJheSkge1xyXG4gICAgcmV0dXJuIFwiW1wiICsgc2VyaWFsaXplSVB2Nihob3N0KSArIFwiXVwiO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIGhvc3Q7XHJcbn1cclxuXHJcbmZ1bmN0aW9uIHRyaW1Db250cm9sQ2hhcnModXJsKSB7XHJcbiAgcmV0dXJuIHVybC5yZXBsYWNlKC9eW1xcdTAwMDAtXFx1MDAxRlxcdTAwMjBdK3xbXFx1MDAwMC1cXHUwMDFGXFx1MDAyMF0rJC9nLCBcIlwiKTtcclxufVxyXG5cclxuZnVuY3Rpb24gdHJpbVRhYkFuZE5ld2xpbmUodXJsKSB7XHJcbiAgcmV0dXJuIHVybC5yZXBsYWNlKC9cXHUwMDA5fFxcdTAwMEF8XFx1MDAwRC9nLCBcIlwiKTtcclxufVxyXG5cclxuZnVuY3Rpb24gc2hvcnRlblBhdGgodXJsKSB7XHJcbiAgY29uc3QgcGF0aCA9IHVybC5wYXRoO1xyXG4gIGlmIChwYXRoLmxlbmd0aCA9PT0gMCkge1xyXG4gICAgcmV0dXJuO1xyXG4gIH1cclxuICBpZiAodXJsLnNjaGVtZSA9PT0gXCJmaWxlXCIgJiYgcGF0aC5sZW5ndGggPT09IDEgJiYgaXNOb3JtYWxpemVkV2luZG93c0RyaXZlTGV0dGVyKHBhdGhbMF0pKSB7XHJcbiAgICByZXR1cm47XHJcbiAgfVxyXG5cclxuICBwYXRoLnBvcCgpO1xyXG59XHJcblxyXG5mdW5jdGlvbiBpbmNsdWRlc0NyZWRlbnRpYWxzKHVybCkge1xyXG4gIHJldHVybiB1cmwudXNlcm5hbWUgIT09IFwiXCIgfHwgdXJsLnBhc3N3b3JkICE9PSBcIlwiO1xyXG59XHJcblxyXG5mdW5jdGlvbiBjYW5ub3RIYXZlQVVzZXJuYW1lUGFzc3dvcmRQb3J0KHVybCkge1xyXG4gIHJldHVybiB1cmwuaG9zdCA9PT0gbnVsbCB8fCB1cmwuaG9zdCA9PT0gXCJcIiB8fCB1cmwuY2Fubm90QmVBQmFzZVVSTCB8fCB1cmwuc2NoZW1lID09PSBcImZpbGVcIjtcclxufVxyXG5cclxuZnVuY3Rpb24gaXNOb3JtYWxpemVkV2luZG93c0RyaXZlTGV0dGVyKHN0cmluZykge1xyXG4gIHJldHVybiAvXltBLVphLXpdOiQvLnRlc3Qoc3RyaW5nKTtcclxufVxyXG5cclxuZnVuY3Rpb24gVVJMU3RhdGVNYWNoaW5lKGlucHV0LCBiYXNlLCBlbmNvZGluZ092ZXJyaWRlLCB1cmwsIHN0YXRlT3ZlcnJpZGUpIHtcclxuICB0aGlzLnBvaW50ZXIgPSAwO1xyXG4gIHRoaXMuaW5wdXQgPSBpbnB1dDtcclxuICB0aGlzLmJhc2UgPSBiYXNlIHx8IG51bGw7XHJcbiAgdGhpcy5lbmNvZGluZ092ZXJyaWRlID0gZW5jb2RpbmdPdmVycmlkZSB8fCBcInV0Zi04XCI7XHJcbiAgdGhpcy5zdGF0ZU92ZXJyaWRlID0gc3RhdGVPdmVycmlkZTtcclxuICB0aGlzLnVybCA9IHVybDtcclxuICB0aGlzLmZhaWx1cmUgPSBmYWxzZTtcclxuICB0aGlzLnBhcnNlRXJyb3IgPSBmYWxzZTtcclxuXHJcbiAgaWYgKCF0aGlzLnVybCkge1xyXG4gICAgdGhpcy51cmwgPSB7XHJcbiAgICAgIHNjaGVtZTogXCJcIixcclxuICAgICAgdXNlcm5hbWU6IFwiXCIsXHJcbiAgICAgIHBhc3N3b3JkOiBcIlwiLFxyXG4gICAgICBob3N0OiBudWxsLFxyXG4gICAgICBwb3J0OiBudWxsLFxyXG4gICAgICBwYXRoOiBbXSxcclxuICAgICAgcXVlcnk6IG51bGwsXHJcbiAgICAgIGZyYWdtZW50OiBudWxsLFxyXG5cclxuICAgICAgY2Fubm90QmVBQmFzZVVSTDogZmFsc2VcclxuICAgIH07XHJcblxyXG4gICAgY29uc3QgcmVzID0gdHJpbUNvbnRyb2xDaGFycyh0aGlzLmlucHV0KTtcclxuICAgIGlmIChyZXMgIT09IHRoaXMuaW5wdXQpIHtcclxuICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIH1cclxuICAgIHRoaXMuaW5wdXQgPSByZXM7XHJcbiAgfVxyXG5cclxuICBjb25zdCByZXMgPSB0cmltVGFiQW5kTmV3bGluZSh0aGlzLmlucHV0KTtcclxuICBpZiAocmVzICE9PSB0aGlzLmlucHV0KSB7XHJcbiAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gIH1cclxuICB0aGlzLmlucHV0ID0gcmVzO1xyXG5cclxuICB0aGlzLnN0YXRlID0gc3RhdGVPdmVycmlkZSB8fCBcInNjaGVtZSBzdGFydFwiO1xyXG5cclxuICB0aGlzLmJ1ZmZlciA9IFwiXCI7XHJcbiAgdGhpcy5hdEZsYWcgPSBmYWxzZTtcclxuICB0aGlzLmFyckZsYWcgPSBmYWxzZTtcclxuICB0aGlzLnBhc3N3b3JkVG9rZW5TZWVuRmxhZyA9IGZhbHNlO1xyXG5cclxuICB0aGlzLmlucHV0ID0gcHVueWNvZGUudWNzMi5kZWNvZGUodGhpcy5pbnB1dCk7XHJcblxyXG4gIGZvciAoOyB0aGlzLnBvaW50ZXIgPD0gdGhpcy5pbnB1dC5sZW5ndGg7ICsrdGhpcy5wb2ludGVyKSB7XHJcbiAgICBjb25zdCBjID0gdGhpcy5pbnB1dFt0aGlzLnBvaW50ZXJdO1xyXG4gICAgY29uc3QgY1N0ciA9IGlzTmFOKGMpID8gdW5kZWZpbmVkIDogU3RyaW5nLmZyb21Db2RlUG9pbnQoYyk7XHJcblxyXG4gICAgLy8gZXhlYyBzdGF0ZSBtYWNoaW5lXHJcbiAgICBjb25zdCByZXQgPSB0aGlzW1wicGFyc2UgXCIgKyB0aGlzLnN0YXRlXShjLCBjU3RyKTtcclxuICAgIGlmICghcmV0KSB7XHJcbiAgICAgIGJyZWFrOyAvLyB0ZXJtaW5hdGUgYWxnb3JpdGhtXHJcbiAgICB9IGVsc2UgaWYgKHJldCA9PT0gZmFpbHVyZSkge1xyXG4gICAgICB0aGlzLmZhaWx1cmUgPSB0cnVlO1xyXG4gICAgICBicmVhaztcclxuICAgIH1cclxuICB9XHJcbn1cclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBzY2hlbWUgc3RhcnRcIl0gPSBmdW5jdGlvbiBwYXJzZVNjaGVtZVN0YXJ0KGMsIGNTdHIpIHtcclxuICBpZiAoaXNBU0NJSUFscGhhKGMpKSB7XHJcbiAgICB0aGlzLmJ1ZmZlciArPSBjU3RyLnRvTG93ZXJDYXNlKCk7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJzY2hlbWVcIjtcclxuICB9IGVsc2UgaWYgKCF0aGlzLnN0YXRlT3ZlcnJpZGUpIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcIm5vIHNjaGVtZVwiO1xyXG4gICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICByZXR1cm4gZmFpbHVyZTtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHNjaGVtZVwiXSA9IGZ1bmN0aW9uIHBhcnNlU2NoZW1lKGMsIGNTdHIpIHtcclxuICBpZiAoaXNBU0NJSUFscGhhbnVtZXJpYyhjKSB8fCBjID09PSA0MyB8fCBjID09PSA0NSB8fCBjID09PSA0Nikge1xyXG4gICAgdGhpcy5idWZmZXIgKz0gY1N0ci50b0xvd2VyQ2FzZSgpO1xyXG4gIH0gZWxzZSBpZiAoYyA9PT0gNTgpIHtcclxuICAgIGlmICh0aGlzLnN0YXRlT3ZlcnJpZGUpIHtcclxuICAgICAgaWYgKGlzU3BlY2lhbCh0aGlzLnVybCkgJiYgIWlzU3BlY2lhbFNjaGVtZSh0aGlzLmJ1ZmZlcikpIHtcclxuICAgICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICAgIH1cclxuXHJcbiAgICAgIGlmICghaXNTcGVjaWFsKHRoaXMudXJsKSAmJiBpc1NwZWNpYWxTY2hlbWUodGhpcy5idWZmZXIpKSB7XHJcbiAgICAgICAgcmV0dXJuIGZhbHNlO1xyXG4gICAgICB9XHJcblxyXG4gICAgICBpZiAoKGluY2x1ZGVzQ3JlZGVudGlhbHModGhpcy51cmwpIHx8IHRoaXMudXJsLnBvcnQgIT09IG51bGwpICYmIHRoaXMuYnVmZmVyID09PSBcImZpbGVcIikge1xyXG4gICAgICAgIHJldHVybiBmYWxzZTtcclxuICAgICAgfVxyXG5cclxuICAgICAgaWYgKHRoaXMudXJsLnNjaGVtZSA9PT0gXCJmaWxlXCIgJiYgKHRoaXMudXJsLmhvc3QgPT09IFwiXCIgfHwgdGhpcy51cmwuaG9zdCA9PT0gbnVsbCkpIHtcclxuICAgICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICAgIH1cclxuICAgIH1cclxuICAgIHRoaXMudXJsLnNjaGVtZSA9IHRoaXMuYnVmZmVyO1xyXG4gICAgdGhpcy5idWZmZXIgPSBcIlwiO1xyXG4gICAgaWYgKHRoaXMuc3RhdGVPdmVycmlkZSkge1xyXG4gICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICB9XHJcbiAgICBpZiAodGhpcy51cmwuc2NoZW1lID09PSBcImZpbGVcIikge1xyXG4gICAgICBpZiAodGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAxXSAhPT0gNDcgfHwgdGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAyXSAhPT0gNDcpIHtcclxuICAgICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgICB9XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcImZpbGVcIjtcclxuICAgIH0gZWxzZSBpZiAoaXNTcGVjaWFsKHRoaXMudXJsKSAmJiB0aGlzLmJhc2UgIT09IG51bGwgJiYgdGhpcy5iYXNlLnNjaGVtZSA9PT0gdGhpcy51cmwuc2NoZW1lKSB7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcInNwZWNpYWwgcmVsYXRpdmUgb3IgYXV0aG9yaXR5XCI7XHJcbiAgICB9IGVsc2UgaWYgKGlzU3BlY2lhbCh0aGlzLnVybCkpIHtcclxuICAgICAgdGhpcy5zdGF0ZSA9IFwic3BlY2lhbCBhdXRob3JpdHkgc2xhc2hlc1wiO1xyXG4gICAgfSBlbHNlIGlmICh0aGlzLmlucHV0W3RoaXMucG9pbnRlciArIDFdID09PSA0Nykge1xyXG4gICAgICB0aGlzLnN0YXRlID0gXCJwYXRoIG9yIGF1dGhvcml0eVwiO1xyXG4gICAgICArK3RoaXMucG9pbnRlcjtcclxuICAgIH0gZWxzZSB7XHJcbiAgICAgIHRoaXMudXJsLmNhbm5vdEJlQUJhc2VVUkwgPSB0cnVlO1xyXG4gICAgICB0aGlzLnVybC5wYXRoLnB1c2goXCJcIik7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcImNhbm5vdC1iZS1hLWJhc2UtVVJMIHBhdGhcIjtcclxuICAgIH1cclxuICB9IGVsc2UgaWYgKCF0aGlzLnN0YXRlT3ZlcnJpZGUpIHtcclxuICAgIHRoaXMuYnVmZmVyID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcIm5vIHNjaGVtZVwiO1xyXG4gICAgdGhpcy5wb2ludGVyID0gLTE7XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICByZXR1cm4gZmFpbHVyZTtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIG5vIHNjaGVtZVwiXSA9IGZ1bmN0aW9uIHBhcnNlTm9TY2hlbWUoYykge1xyXG4gIGlmICh0aGlzLmJhc2UgPT09IG51bGwgfHwgKHRoaXMuYmFzZS5jYW5ub3RCZUFCYXNlVVJMICYmIGMgIT09IDM1KSkge1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfSBlbHNlIGlmICh0aGlzLmJhc2UuY2Fubm90QmVBQmFzZVVSTCAmJiBjID09PSAzNSkge1xyXG4gICAgdGhpcy51cmwuc2NoZW1lID0gdGhpcy5iYXNlLnNjaGVtZTtcclxuICAgIHRoaXMudXJsLnBhdGggPSB0aGlzLmJhc2UucGF0aC5zbGljZSgpO1xyXG4gICAgdGhpcy51cmwucXVlcnkgPSB0aGlzLmJhc2UucXVlcnk7XHJcbiAgICB0aGlzLnVybC5mcmFnbWVudCA9IFwiXCI7XHJcbiAgICB0aGlzLnVybC5jYW5ub3RCZUFCYXNlVVJMID0gdHJ1ZTtcclxuICAgIHRoaXMuc3RhdGUgPSBcImZyYWdtZW50XCI7XHJcbiAgfSBlbHNlIGlmICh0aGlzLmJhc2Uuc2NoZW1lID09PSBcImZpbGVcIikge1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwiZmlsZVwiO1xyXG4gICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcInJlbGF0aXZlXCI7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHNwZWNpYWwgcmVsYXRpdmUgb3IgYXV0aG9yaXR5XCJdID0gZnVuY3Rpb24gcGFyc2VTcGVjaWFsUmVsYXRpdmVPckF1dGhvcml0eShjKSB7XHJcbiAgaWYgKGMgPT09IDQ3ICYmIHRoaXMuaW5wdXRbdGhpcy5wb2ludGVyICsgMV0gPT09IDQ3KSB7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJzcGVjaWFsIGF1dGhvcml0eSBpZ25vcmUgc2xhc2hlc1wiO1xyXG4gICAgKyt0aGlzLnBvaW50ZXI7XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJyZWxhdGl2ZVwiO1xyXG4gICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBwYXRoIG9yIGF1dGhvcml0eVwiXSA9IGZ1bmN0aW9uIHBhcnNlUGF0aE9yQXV0aG9yaXR5KGMpIHtcclxuICBpZiAoYyA9PT0gNDcpIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcImF1dGhvcml0eVwiO1xyXG4gIH0gZWxzZSB7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJwYXRoXCI7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHJlbGF0aXZlXCJdID0gZnVuY3Rpb24gcGFyc2VSZWxhdGl2ZShjKSB7XHJcbiAgdGhpcy51cmwuc2NoZW1lID0gdGhpcy5iYXNlLnNjaGVtZTtcclxuICBpZiAoaXNOYU4oYykpIHtcclxuICAgIHRoaXMudXJsLnVzZXJuYW1lID0gdGhpcy5iYXNlLnVzZXJuYW1lO1xyXG4gICAgdGhpcy51cmwucGFzc3dvcmQgPSB0aGlzLmJhc2UucGFzc3dvcmQ7XHJcbiAgICB0aGlzLnVybC5ob3N0ID0gdGhpcy5iYXNlLmhvc3Q7XHJcbiAgICB0aGlzLnVybC5wb3J0ID0gdGhpcy5iYXNlLnBvcnQ7XHJcbiAgICB0aGlzLnVybC5wYXRoID0gdGhpcy5iYXNlLnBhdGguc2xpY2UoKTtcclxuICAgIHRoaXMudXJsLnF1ZXJ5ID0gdGhpcy5iYXNlLnF1ZXJ5O1xyXG4gIH0gZWxzZSBpZiAoYyA9PT0gNDcpIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcInJlbGF0aXZlIHNsYXNoXCI7XHJcbiAgfSBlbHNlIGlmIChjID09PSA2Mykge1xyXG4gICAgdGhpcy51cmwudXNlcm5hbWUgPSB0aGlzLmJhc2UudXNlcm5hbWU7XHJcbiAgICB0aGlzLnVybC5wYXNzd29yZCA9IHRoaXMuYmFzZS5wYXNzd29yZDtcclxuICAgIHRoaXMudXJsLmhvc3QgPSB0aGlzLmJhc2UuaG9zdDtcclxuICAgIHRoaXMudXJsLnBvcnQgPSB0aGlzLmJhc2UucG9ydDtcclxuICAgIHRoaXMudXJsLnBhdGggPSB0aGlzLmJhc2UucGF0aC5zbGljZSgpO1xyXG4gICAgdGhpcy51cmwucXVlcnkgPSBcIlwiO1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwicXVlcnlcIjtcclxuICB9IGVsc2UgaWYgKGMgPT09IDM1KSB7XHJcbiAgICB0aGlzLnVybC51c2VybmFtZSA9IHRoaXMuYmFzZS51c2VybmFtZTtcclxuICAgIHRoaXMudXJsLnBhc3N3b3JkID0gdGhpcy5iYXNlLnBhc3N3b3JkO1xyXG4gICAgdGhpcy51cmwuaG9zdCA9IHRoaXMuYmFzZS5ob3N0O1xyXG4gICAgdGhpcy51cmwucG9ydCA9IHRoaXMuYmFzZS5wb3J0O1xyXG4gICAgdGhpcy51cmwucGF0aCA9IHRoaXMuYmFzZS5wYXRoLnNsaWNlKCk7XHJcbiAgICB0aGlzLnVybC5xdWVyeSA9IHRoaXMuYmFzZS5xdWVyeTtcclxuICAgIHRoaXMudXJsLmZyYWdtZW50ID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcImZyYWdtZW50XCI7XHJcbiAgfSBlbHNlIGlmIChpc1NwZWNpYWwodGhpcy51cmwpICYmIGMgPT09IDkyKSB7XHJcbiAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwicmVsYXRpdmUgc2xhc2hcIjtcclxuICB9IGVsc2Uge1xyXG4gICAgdGhpcy51cmwudXNlcm5hbWUgPSB0aGlzLmJhc2UudXNlcm5hbWU7XHJcbiAgICB0aGlzLnVybC5wYXNzd29yZCA9IHRoaXMuYmFzZS5wYXNzd29yZDtcclxuICAgIHRoaXMudXJsLmhvc3QgPSB0aGlzLmJhc2UuaG9zdDtcclxuICAgIHRoaXMudXJsLnBvcnQgPSB0aGlzLmJhc2UucG9ydDtcclxuICAgIHRoaXMudXJsLnBhdGggPSB0aGlzLmJhc2UucGF0aC5zbGljZSgwLCB0aGlzLmJhc2UucGF0aC5sZW5ndGggLSAxKTtcclxuXHJcbiAgICB0aGlzLnN0YXRlID0gXCJwYXRoXCI7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHJlbGF0aXZlIHNsYXNoXCJdID0gZnVuY3Rpb24gcGFyc2VSZWxhdGl2ZVNsYXNoKGMpIHtcclxuICBpZiAoaXNTcGVjaWFsKHRoaXMudXJsKSAmJiAoYyA9PT0gNDcgfHwgYyA9PT0gOTIpKSB7XHJcbiAgICBpZiAoYyA9PT0gOTIpIHtcclxuICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIH1cclxuICAgIHRoaXMuc3RhdGUgPSBcInNwZWNpYWwgYXV0aG9yaXR5IGlnbm9yZSBzbGFzaGVzXCI7XHJcbiAgfSBlbHNlIGlmIChjID09PSA0Nykge1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwiYXV0aG9yaXR5XCI7XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMudXJsLnVzZXJuYW1lID0gdGhpcy5iYXNlLnVzZXJuYW1lO1xyXG4gICAgdGhpcy51cmwucGFzc3dvcmQgPSB0aGlzLmJhc2UucGFzc3dvcmQ7XHJcbiAgICB0aGlzLnVybC5ob3N0ID0gdGhpcy5iYXNlLmhvc3Q7XHJcbiAgICB0aGlzLnVybC5wb3J0ID0gdGhpcy5iYXNlLnBvcnQ7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJwYXRoXCI7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHNwZWNpYWwgYXV0aG9yaXR5IHNsYXNoZXNcIl0gPSBmdW5jdGlvbiBwYXJzZVNwZWNpYWxBdXRob3JpdHlTbGFzaGVzKGMpIHtcclxuICBpZiAoYyA9PT0gNDcgJiYgdGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAxXSA9PT0gNDcpIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcInNwZWNpYWwgYXV0aG9yaXR5IGlnbm9yZSBzbGFzaGVzXCI7XHJcbiAgICArK3RoaXMucG9pbnRlcjtcclxuICB9IGVsc2Uge1xyXG4gICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIHRoaXMuc3RhdGUgPSBcInNwZWNpYWwgYXV0aG9yaXR5IGlnbm9yZSBzbGFzaGVzXCI7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHNwZWNpYWwgYXV0aG9yaXR5IGlnbm9yZSBzbGFzaGVzXCJdID0gZnVuY3Rpb24gcGFyc2VTcGVjaWFsQXV0aG9yaXR5SWdub3JlU2xhc2hlcyhjKSB7XHJcbiAgaWYgKGMgIT09IDQ3ICYmIGMgIT09IDkyKSB7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJhdXRob3JpdHlcIjtcclxuICAgIC0tdGhpcy5wb2ludGVyO1xyXG4gIH0gZWxzZSB7XHJcbiAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHRydWU7XHJcbn07XHJcblxyXG5VUkxTdGF0ZU1hY2hpbmUucHJvdG90eXBlW1wicGFyc2UgYXV0aG9yaXR5XCJdID0gZnVuY3Rpb24gcGFyc2VBdXRob3JpdHkoYywgY1N0cikge1xyXG4gIGlmIChjID09PSA2NCkge1xyXG4gICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIGlmICh0aGlzLmF0RmxhZykge1xyXG4gICAgICB0aGlzLmJ1ZmZlciA9IFwiJTQwXCIgKyB0aGlzLmJ1ZmZlcjtcclxuICAgIH1cclxuICAgIHRoaXMuYXRGbGFnID0gdHJ1ZTtcclxuXHJcbiAgICAvLyBjYXJlZnVsLCB0aGlzIGlzIGJhc2VkIG9uIGJ1ZmZlciBhbmQgaGFzIGl0cyBvd24gcG9pbnRlciAodGhpcy5wb2ludGVyICE9IHBvaW50ZXIpIGFuZCBpbm5lciBjaGFyc1xyXG4gICAgY29uc3QgbGVuID0gY291bnRTeW1ib2xzKHRoaXMuYnVmZmVyKTtcclxuICAgIGZvciAobGV0IHBvaW50ZXIgPSAwOyBwb2ludGVyIDwgbGVuOyArK3BvaW50ZXIpIHtcclxuICAgICAgY29uc3QgY29kZVBvaW50ID0gdGhpcy5idWZmZXIuY29kZVBvaW50QXQocG9pbnRlcik7XHJcblxyXG4gICAgICBpZiAoY29kZVBvaW50ID09PSA1OCAmJiAhdGhpcy5wYXNzd29yZFRva2VuU2VlbkZsYWcpIHtcclxuICAgICAgICB0aGlzLnBhc3N3b3JkVG9rZW5TZWVuRmxhZyA9IHRydWU7XHJcbiAgICAgICAgY29udGludWU7XHJcbiAgICAgIH1cclxuICAgICAgY29uc3QgZW5jb2RlZENvZGVQb2ludHMgPSBwZXJjZW50RW5jb2RlQ2hhcihjb2RlUG9pbnQsIGlzVXNlcmluZm9QZXJjZW50RW5jb2RlKTtcclxuICAgICAgaWYgKHRoaXMucGFzc3dvcmRUb2tlblNlZW5GbGFnKSB7XHJcbiAgICAgICAgdGhpcy51cmwucGFzc3dvcmQgKz0gZW5jb2RlZENvZGVQb2ludHM7XHJcbiAgICAgIH0gZWxzZSB7XHJcbiAgICAgICAgdGhpcy51cmwudXNlcm5hbWUgKz0gZW5jb2RlZENvZGVQb2ludHM7XHJcbiAgICAgIH1cclxuICAgIH1cclxuICAgIHRoaXMuYnVmZmVyID0gXCJcIjtcclxuICB9IGVsc2UgaWYgKGlzTmFOKGMpIHx8IGMgPT09IDQ3IHx8IGMgPT09IDYzIHx8IGMgPT09IDM1IHx8XHJcbiAgICAgICAgICAgICAoaXNTcGVjaWFsKHRoaXMudXJsKSAmJiBjID09PSA5MikpIHtcclxuICAgIGlmICh0aGlzLmF0RmxhZyAmJiB0aGlzLmJ1ZmZlciA9PT0gXCJcIikge1xyXG4gICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgIH1cclxuICAgIHRoaXMucG9pbnRlciAtPSBjb3VudFN5bWJvbHModGhpcy5idWZmZXIpICsgMTtcclxuICAgIHRoaXMuYnVmZmVyID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcImhvc3RcIjtcclxuICB9IGVsc2Uge1xyXG4gICAgdGhpcy5idWZmZXIgKz0gY1N0cjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIGhvc3RuYW1lXCJdID1cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIGhvc3RcIl0gPSBmdW5jdGlvbiBwYXJzZUhvc3ROYW1lKGMsIGNTdHIpIHtcclxuICBpZiAodGhpcy5zdGF0ZU92ZXJyaWRlICYmIHRoaXMudXJsLnNjaGVtZSA9PT0gXCJmaWxlXCIpIHtcclxuICAgIC0tdGhpcy5wb2ludGVyO1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwiZmlsZSBob3N0XCI7XHJcbiAgfSBlbHNlIGlmIChjID09PSA1OCAmJiAhdGhpcy5hcnJGbGFnKSB7XHJcbiAgICBpZiAodGhpcy5idWZmZXIgPT09IFwiXCIpIHtcclxuICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgICB9XHJcblxyXG4gICAgY29uc3QgaG9zdCA9IHBhcnNlSG9zdCh0aGlzLmJ1ZmZlciwgaXNTcGVjaWFsKHRoaXMudXJsKSk7XHJcbiAgICBpZiAoaG9zdCA9PT0gZmFpbHVyZSkge1xyXG4gICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgIH1cclxuXHJcbiAgICB0aGlzLnVybC5ob3N0ID0gaG9zdDtcclxuICAgIHRoaXMuYnVmZmVyID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcInBvcnRcIjtcclxuICAgIGlmICh0aGlzLnN0YXRlT3ZlcnJpZGUgPT09IFwiaG9zdG5hbWVcIikge1xyXG4gICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICB9XHJcbiAgfSBlbHNlIGlmIChpc05hTihjKSB8fCBjID09PSA0NyB8fCBjID09PSA2MyB8fCBjID09PSAzNSB8fFxyXG4gICAgICAgICAgICAgKGlzU3BlY2lhbCh0aGlzLnVybCkgJiYgYyA9PT0gOTIpKSB7XHJcbiAgICAtLXRoaXMucG9pbnRlcjtcclxuICAgIGlmIChpc1NwZWNpYWwodGhpcy51cmwpICYmIHRoaXMuYnVmZmVyID09PSBcIlwiKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgfSBlbHNlIGlmICh0aGlzLnN0YXRlT3ZlcnJpZGUgJiYgdGhpcy5idWZmZXIgPT09IFwiXCIgJiZcclxuICAgICAgICAgICAgICAgKGluY2x1ZGVzQ3JlZGVudGlhbHModGhpcy51cmwpIHx8IHRoaXMudXJsLnBvcnQgIT09IG51bGwpKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICAgIHJldHVybiBmYWxzZTtcclxuICAgIH1cclxuXHJcbiAgICBjb25zdCBob3N0ID0gcGFyc2VIb3N0KHRoaXMuYnVmZmVyLCBpc1NwZWNpYWwodGhpcy51cmwpKTtcclxuICAgIGlmIChob3N0ID09PSBmYWlsdXJlKSB7XHJcbiAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgfVxyXG5cclxuICAgIHRoaXMudXJsLmhvc3QgPSBob3N0O1xyXG4gICAgdGhpcy5idWZmZXIgPSBcIlwiO1xyXG4gICAgdGhpcy5zdGF0ZSA9IFwicGF0aCBzdGFydFwiO1xyXG4gICAgaWYgKHRoaXMuc3RhdGVPdmVycmlkZSkge1xyXG4gICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICB9XHJcbiAgfSBlbHNlIHtcclxuICAgIGlmIChjID09PSA5MSkge1xyXG4gICAgICB0aGlzLmFyckZsYWcgPSB0cnVlO1xyXG4gICAgfSBlbHNlIGlmIChjID09PSA5Mykge1xyXG4gICAgICB0aGlzLmFyckZsYWcgPSBmYWxzZTtcclxuICAgIH1cclxuICAgIHRoaXMuYnVmZmVyICs9IGNTdHI7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBwb3J0XCJdID0gZnVuY3Rpb24gcGFyc2VQb3J0KGMsIGNTdHIpIHtcclxuICBpZiAoaXNBU0NJSURpZ2l0KGMpKSB7XHJcbiAgICB0aGlzLmJ1ZmZlciArPSBjU3RyO1xyXG4gIH0gZWxzZSBpZiAoaXNOYU4oYykgfHwgYyA9PT0gNDcgfHwgYyA9PT0gNjMgfHwgYyA9PT0gMzUgfHxcclxuICAgICAgICAgICAgIChpc1NwZWNpYWwodGhpcy51cmwpICYmIGMgPT09IDkyKSB8fFxyXG4gICAgICAgICAgICAgdGhpcy5zdGF0ZU92ZXJyaWRlKSB7XHJcbiAgICBpZiAodGhpcy5idWZmZXIgIT09IFwiXCIpIHtcclxuICAgICAgY29uc3QgcG9ydCA9IHBhcnNlSW50KHRoaXMuYnVmZmVyKTtcclxuICAgICAgaWYgKHBvcnQgPiBNYXRoLnBvdygyLCAxNikgLSAxKSB7XHJcbiAgICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgICAgICByZXR1cm4gZmFpbHVyZTtcclxuICAgICAgfVxyXG4gICAgICB0aGlzLnVybC5wb3J0ID0gcG9ydCA9PT0gZGVmYXVsdFBvcnQodGhpcy51cmwuc2NoZW1lKSA/IG51bGwgOiBwb3J0O1xyXG4gICAgICB0aGlzLmJ1ZmZlciA9IFwiXCI7XHJcbiAgICB9XHJcbiAgICBpZiAodGhpcy5zdGF0ZU92ZXJyaWRlKSB7XHJcbiAgICAgIHJldHVybiBmYWxzZTtcclxuICAgIH1cclxuICAgIHRoaXMuc3RhdGUgPSBcInBhdGggc3RhcnRcIjtcclxuICAgIC0tdGhpcy5wb2ludGVyO1xyXG4gIH0gZWxzZSB7XHJcbiAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgcmV0dXJuIGZhaWx1cmU7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcbmNvbnN0IGZpbGVPdGhlcndpc2VDb2RlUG9pbnRzID0gbmV3IFNldChbNDcsIDkyLCA2MywgMzVdKTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBmaWxlXCJdID0gZnVuY3Rpb24gcGFyc2VGaWxlKGMpIHtcclxuICB0aGlzLnVybC5zY2hlbWUgPSBcImZpbGVcIjtcclxuXHJcbiAgaWYgKGMgPT09IDQ3IHx8IGMgPT09IDkyKSB7XHJcbiAgICBpZiAoYyA9PT0gOTIpIHtcclxuICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIH1cclxuICAgIHRoaXMuc3RhdGUgPSBcImZpbGUgc2xhc2hcIjtcclxuICB9IGVsc2UgaWYgKHRoaXMuYmFzZSAhPT0gbnVsbCAmJiB0aGlzLmJhc2Uuc2NoZW1lID09PSBcImZpbGVcIikge1xyXG4gICAgaWYgKGlzTmFOKGMpKSB7XHJcbiAgICAgIHRoaXMudXJsLmhvc3QgPSB0aGlzLmJhc2UuaG9zdDtcclxuICAgICAgdGhpcy51cmwucGF0aCA9IHRoaXMuYmFzZS5wYXRoLnNsaWNlKCk7XHJcbiAgICAgIHRoaXMudXJsLnF1ZXJ5ID0gdGhpcy5iYXNlLnF1ZXJ5O1xyXG4gICAgfSBlbHNlIGlmIChjID09PSA2Mykge1xyXG4gICAgICB0aGlzLnVybC5ob3N0ID0gdGhpcy5iYXNlLmhvc3Q7XHJcbiAgICAgIHRoaXMudXJsLnBhdGggPSB0aGlzLmJhc2UucGF0aC5zbGljZSgpO1xyXG4gICAgICB0aGlzLnVybC5xdWVyeSA9IFwiXCI7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcInF1ZXJ5XCI7XHJcbiAgICB9IGVsc2UgaWYgKGMgPT09IDM1KSB7XHJcbiAgICAgIHRoaXMudXJsLmhvc3QgPSB0aGlzLmJhc2UuaG9zdDtcclxuICAgICAgdGhpcy51cmwucGF0aCA9IHRoaXMuYmFzZS5wYXRoLnNsaWNlKCk7XHJcbiAgICAgIHRoaXMudXJsLnF1ZXJ5ID0gdGhpcy5iYXNlLnF1ZXJ5O1xyXG4gICAgICB0aGlzLnVybC5mcmFnbWVudCA9IFwiXCI7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcImZyYWdtZW50XCI7XHJcbiAgICB9IGVsc2Uge1xyXG4gICAgICBpZiAodGhpcy5pbnB1dC5sZW5ndGggLSB0aGlzLnBvaW50ZXIgLSAxID09PSAwIHx8IC8vIHJlbWFpbmluZyBjb25zaXN0cyBvZiAwIGNvZGUgcG9pbnRzXHJcbiAgICAgICAgICAhaXNXaW5kb3dzRHJpdmVMZXR0ZXJDb2RlUG9pbnRzKGMsIHRoaXMuaW5wdXRbdGhpcy5wb2ludGVyICsgMV0pIHx8XHJcbiAgICAgICAgICAodGhpcy5pbnB1dC5sZW5ndGggLSB0aGlzLnBvaW50ZXIgLSAxID49IDIgJiYgLy8gcmVtYWluaW5nIGhhcyBhdCBsZWFzdCAyIGNvZGUgcG9pbnRzXHJcbiAgICAgICAgICAgIWZpbGVPdGhlcndpc2VDb2RlUG9pbnRzLmhhcyh0aGlzLmlucHV0W3RoaXMucG9pbnRlciArIDJdKSkpIHtcclxuICAgICAgICB0aGlzLnVybC5ob3N0ID0gdGhpcy5iYXNlLmhvc3Q7XHJcbiAgICAgICAgdGhpcy51cmwucGF0aCA9IHRoaXMuYmFzZS5wYXRoLnNsaWNlKCk7XHJcbiAgICAgICAgc2hvcnRlblBhdGgodGhpcy51cmwpO1xyXG4gICAgICB9IGVsc2Uge1xyXG4gICAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICAgIH1cclxuXHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcInBhdGhcIjtcclxuICAgICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgICB9XHJcbiAgfSBlbHNlIHtcclxuICAgIHRoaXMuc3RhdGUgPSBcInBhdGhcIjtcclxuICAgIC0tdGhpcy5wb2ludGVyO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHRydWU7XHJcbn07XHJcblxyXG5VUkxTdGF0ZU1hY2hpbmUucHJvdG90eXBlW1wicGFyc2UgZmlsZSBzbGFzaFwiXSA9IGZ1bmN0aW9uIHBhcnNlRmlsZVNsYXNoKGMpIHtcclxuICBpZiAoYyA9PT0gNDcgfHwgYyA9PT0gOTIpIHtcclxuICAgIGlmIChjID09PSA5Mikge1xyXG4gICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgfVxyXG4gICAgdGhpcy5zdGF0ZSA9IFwiZmlsZSBob3N0XCI7XHJcbiAgfSBlbHNlIHtcclxuICAgIGlmICh0aGlzLmJhc2UgIT09IG51bGwgJiYgdGhpcy5iYXNlLnNjaGVtZSA9PT0gXCJmaWxlXCIpIHtcclxuICAgICAgaWYgKGlzTm9ybWFsaXplZFdpbmRvd3NEcml2ZUxldHRlclN0cmluZyh0aGlzLmJhc2UucGF0aFswXSkpIHtcclxuICAgICAgICB0aGlzLnVybC5wYXRoLnB1c2godGhpcy5iYXNlLnBhdGhbMF0pO1xyXG4gICAgICB9IGVsc2Uge1xyXG4gICAgICAgIHRoaXMudXJsLmhvc3QgPSB0aGlzLmJhc2UuaG9zdDtcclxuICAgICAgfVxyXG4gICAgfVxyXG4gICAgdGhpcy5zdGF0ZSA9IFwicGF0aFwiO1xyXG4gICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBmaWxlIGhvc3RcIl0gPSBmdW5jdGlvbiBwYXJzZUZpbGVIb3N0KGMsIGNTdHIpIHtcclxuICBpZiAoaXNOYU4oYykgfHwgYyA9PT0gNDcgfHwgYyA9PT0gOTIgfHwgYyA9PT0gNjMgfHwgYyA9PT0gMzUpIHtcclxuICAgIC0tdGhpcy5wb2ludGVyO1xyXG4gICAgaWYgKCF0aGlzLnN0YXRlT3ZlcnJpZGUgJiYgaXNXaW5kb3dzRHJpdmVMZXR0ZXJTdHJpbmcodGhpcy5idWZmZXIpKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcInBhdGhcIjtcclxuICAgIH0gZWxzZSBpZiAodGhpcy5idWZmZXIgPT09IFwiXCIpIHtcclxuICAgICAgdGhpcy51cmwuaG9zdCA9IFwiXCI7XHJcbiAgICAgIGlmICh0aGlzLnN0YXRlT3ZlcnJpZGUpIHtcclxuICAgICAgICByZXR1cm4gZmFsc2U7XHJcbiAgICAgIH1cclxuICAgICAgdGhpcy5zdGF0ZSA9IFwicGF0aCBzdGFydFwiO1xyXG4gICAgfSBlbHNlIHtcclxuICAgICAgbGV0IGhvc3QgPSBwYXJzZUhvc3QodGhpcy5idWZmZXIsIGlzU3BlY2lhbCh0aGlzLnVybCkpO1xyXG4gICAgICBpZiAoaG9zdCA9PT0gZmFpbHVyZSkge1xyXG4gICAgICAgIHJldHVybiBmYWlsdXJlO1xyXG4gICAgICB9XHJcbiAgICAgIGlmIChob3N0ID09PSBcImxvY2FsaG9zdFwiKSB7XHJcbiAgICAgICAgaG9zdCA9IFwiXCI7XHJcbiAgICAgIH1cclxuICAgICAgdGhpcy51cmwuaG9zdCA9IGhvc3Q7XHJcblxyXG4gICAgICBpZiAodGhpcy5zdGF0ZU92ZXJyaWRlKSB7XHJcbiAgICAgICAgcmV0dXJuIGZhbHNlO1xyXG4gICAgICB9XHJcblxyXG4gICAgICB0aGlzLmJ1ZmZlciA9IFwiXCI7XHJcbiAgICAgIHRoaXMuc3RhdGUgPSBcInBhdGggc3RhcnRcIjtcclxuICAgIH1cclxuICB9IGVsc2Uge1xyXG4gICAgdGhpcy5idWZmZXIgKz0gY1N0cjtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuVVJMU3RhdGVNYWNoaW5lLnByb3RvdHlwZVtcInBhcnNlIHBhdGggc3RhcnRcIl0gPSBmdW5jdGlvbiBwYXJzZVBhdGhTdGFydChjKSB7XHJcbiAgaWYgKGlzU3BlY2lhbCh0aGlzLnVybCkpIHtcclxuICAgIGlmIChjID09PSA5Mikge1xyXG4gICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgfVxyXG4gICAgdGhpcy5zdGF0ZSA9IFwicGF0aFwiO1xyXG5cclxuICAgIGlmIChjICE9PSA0NyAmJiBjICE9PSA5Mikge1xyXG4gICAgICAtLXRoaXMucG9pbnRlcjtcclxuICAgIH1cclxuICB9IGVsc2UgaWYgKCF0aGlzLnN0YXRlT3ZlcnJpZGUgJiYgYyA9PT0gNjMpIHtcclxuICAgIHRoaXMudXJsLnF1ZXJ5ID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcInF1ZXJ5XCI7XHJcbiAgfSBlbHNlIGlmICghdGhpcy5zdGF0ZU92ZXJyaWRlICYmIGMgPT09IDM1KSB7XHJcbiAgICB0aGlzLnVybC5mcmFnbWVudCA9IFwiXCI7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJmcmFnbWVudFwiO1xyXG4gIH0gZWxzZSBpZiAoYyAhPT0gdW5kZWZpbmVkKSB7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJwYXRoXCI7XHJcbiAgICBpZiAoYyAhPT0gNDcpIHtcclxuICAgICAgLS10aGlzLnBvaW50ZXI7XHJcbiAgICB9XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBwYXRoXCJdID0gZnVuY3Rpb24gcGFyc2VQYXRoKGMpIHtcclxuICBpZiAoaXNOYU4oYykgfHwgYyA9PT0gNDcgfHwgKGlzU3BlY2lhbCh0aGlzLnVybCkgJiYgYyA9PT0gOTIpIHx8XHJcbiAgICAgICghdGhpcy5zdGF0ZU92ZXJyaWRlICYmIChjID09PSA2MyB8fCBjID09PSAzNSkpKSB7XHJcbiAgICBpZiAoaXNTcGVjaWFsKHRoaXMudXJsKSAmJiBjID09PSA5Mikge1xyXG4gICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgfVxyXG5cclxuICAgIGlmIChpc0RvdWJsZURvdCh0aGlzLmJ1ZmZlcikpIHtcclxuICAgICAgc2hvcnRlblBhdGgodGhpcy51cmwpO1xyXG4gICAgICBpZiAoYyAhPT0gNDcgJiYgIShpc1NwZWNpYWwodGhpcy51cmwpICYmIGMgPT09IDkyKSkge1xyXG4gICAgICAgIHRoaXMudXJsLnBhdGgucHVzaChcIlwiKTtcclxuICAgICAgfVxyXG4gICAgfSBlbHNlIGlmIChpc1NpbmdsZURvdCh0aGlzLmJ1ZmZlcikgJiYgYyAhPT0gNDcgJiZcclxuICAgICAgICAgICAgICAgIShpc1NwZWNpYWwodGhpcy51cmwpICYmIGMgPT09IDkyKSkge1xyXG4gICAgICB0aGlzLnVybC5wYXRoLnB1c2goXCJcIik7XHJcbiAgICB9IGVsc2UgaWYgKCFpc1NpbmdsZURvdCh0aGlzLmJ1ZmZlcikpIHtcclxuICAgICAgaWYgKHRoaXMudXJsLnNjaGVtZSA9PT0gXCJmaWxlXCIgJiYgdGhpcy51cmwucGF0aC5sZW5ndGggPT09IDAgJiYgaXNXaW5kb3dzRHJpdmVMZXR0ZXJTdHJpbmcodGhpcy5idWZmZXIpKSB7XHJcbiAgICAgICAgaWYgKHRoaXMudXJsLmhvc3QgIT09IFwiXCIgJiYgdGhpcy51cmwuaG9zdCAhPT0gbnVsbCkge1xyXG4gICAgICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgICAgICAgIHRoaXMudXJsLmhvc3QgPSBcIlwiO1xyXG4gICAgICAgIH1cclxuICAgICAgICB0aGlzLmJ1ZmZlciA9IHRoaXMuYnVmZmVyWzBdICsgXCI6XCI7XHJcbiAgICAgIH1cclxuICAgICAgdGhpcy51cmwucGF0aC5wdXNoKHRoaXMuYnVmZmVyKTtcclxuICAgIH1cclxuICAgIHRoaXMuYnVmZmVyID0gXCJcIjtcclxuICAgIGlmICh0aGlzLnVybC5zY2hlbWUgPT09IFwiZmlsZVwiICYmIChjID09PSB1bmRlZmluZWQgfHwgYyA9PT0gNjMgfHwgYyA9PT0gMzUpKSB7XHJcbiAgICAgIHdoaWxlICh0aGlzLnVybC5wYXRoLmxlbmd0aCA+IDEgJiYgdGhpcy51cmwucGF0aFswXSA9PT0gXCJcIikge1xyXG4gICAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICAgICAgdGhpcy51cmwucGF0aC5zaGlmdCgpO1xyXG4gICAgICB9XHJcbiAgICB9XHJcbiAgICBpZiAoYyA9PT0gNjMpIHtcclxuICAgICAgdGhpcy51cmwucXVlcnkgPSBcIlwiO1xyXG4gICAgICB0aGlzLnN0YXRlID0gXCJxdWVyeVwiO1xyXG4gICAgfVxyXG4gICAgaWYgKGMgPT09IDM1KSB7XHJcbiAgICAgIHRoaXMudXJsLmZyYWdtZW50ID0gXCJcIjtcclxuICAgICAgdGhpcy5zdGF0ZSA9IFwiZnJhZ21lbnRcIjtcclxuICAgIH1cclxuICB9IGVsc2Uge1xyXG4gICAgLy8gVE9ETzogSWYgYyBpcyBub3QgYSBVUkwgY29kZSBwb2ludCBhbmQgbm90IFwiJVwiLCBwYXJzZSBlcnJvci5cclxuXHJcbiAgICBpZiAoYyA9PT0gMzcgJiZcclxuICAgICAgKCFpc0FTQ0lJSGV4KHRoaXMuaW5wdXRbdGhpcy5wb2ludGVyICsgMV0pIHx8XHJcbiAgICAgICAgIWlzQVNDSUlIZXgodGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAyXSkpKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICB9XHJcblxyXG4gICAgdGhpcy5idWZmZXIgKz0gcGVyY2VudEVuY29kZUNoYXIoYywgaXNQYXRoUGVyY2VudEVuY29kZSk7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBjYW5ub3QtYmUtYS1iYXNlLVVSTCBwYXRoXCJdID0gZnVuY3Rpb24gcGFyc2VDYW5ub3RCZUFCYXNlVVJMUGF0aChjKSB7XHJcbiAgaWYgKGMgPT09IDYzKSB7XHJcbiAgICB0aGlzLnVybC5xdWVyeSA9IFwiXCI7XHJcbiAgICB0aGlzLnN0YXRlID0gXCJxdWVyeVwiO1xyXG4gIH0gZWxzZSBpZiAoYyA9PT0gMzUpIHtcclxuICAgIHRoaXMudXJsLmZyYWdtZW50ID0gXCJcIjtcclxuICAgIHRoaXMuc3RhdGUgPSBcImZyYWdtZW50XCI7XHJcbiAgfSBlbHNlIHtcclxuICAgIC8vIFRPRE86IEFkZDogbm90IGEgVVJMIGNvZGUgcG9pbnRcclxuICAgIGlmICghaXNOYU4oYykgJiYgYyAhPT0gMzcpIHtcclxuICAgICAgdGhpcy5wYXJzZUVycm9yID0gdHJ1ZTtcclxuICAgIH1cclxuXHJcbiAgICBpZiAoYyA9PT0gMzcgJiZcclxuICAgICAgICAoIWlzQVNDSUlIZXgodGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAxXSkgfHxcclxuICAgICAgICAgIWlzQVNDSUlIZXgodGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAyXSkpKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICB9XHJcblxyXG4gICAgaWYgKCFpc05hTihjKSkge1xyXG4gICAgICB0aGlzLnVybC5wYXRoWzBdID0gdGhpcy51cmwucGF0aFswXSArIHBlcmNlbnRFbmNvZGVDaGFyKGMsIGlzQzBDb250cm9sUGVyY2VudEVuY29kZSk7XHJcbiAgICB9XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBxdWVyeVwiXSA9IGZ1bmN0aW9uIHBhcnNlUXVlcnkoYywgY1N0cikge1xyXG4gIGlmIChpc05hTihjKSB8fCAoIXRoaXMuc3RhdGVPdmVycmlkZSAmJiBjID09PSAzNSkpIHtcclxuICAgIGlmICghaXNTcGVjaWFsKHRoaXMudXJsKSB8fCB0aGlzLnVybC5zY2hlbWUgPT09IFwid3NcIiB8fCB0aGlzLnVybC5zY2hlbWUgPT09IFwid3NzXCIpIHtcclxuICAgICAgdGhpcy5lbmNvZGluZ092ZXJyaWRlID0gXCJ1dGYtOFwiO1xyXG4gICAgfVxyXG5cclxuICAgIGNvbnN0IGJ1ZmZlciA9IG5ldyBCdWZmZXIodGhpcy5idWZmZXIpOyAvLyBUT0RPOiBVc2UgZW5jb2Rpbmcgb3ZlcnJpZGUgaW5zdGVhZFxyXG4gICAgZm9yIChsZXQgaSA9IDA7IGkgPCBidWZmZXIubGVuZ3RoOyArK2kpIHtcclxuICAgICAgaWYgKGJ1ZmZlcltpXSA8IDB4MjEgfHwgYnVmZmVyW2ldID4gMHg3RSB8fCBidWZmZXJbaV0gPT09IDB4MjIgfHwgYnVmZmVyW2ldID09PSAweDIzIHx8XHJcbiAgICAgICAgICBidWZmZXJbaV0gPT09IDB4M0MgfHwgYnVmZmVyW2ldID09PSAweDNFKSB7XHJcbiAgICAgICAgdGhpcy51cmwucXVlcnkgKz0gcGVyY2VudEVuY29kZShidWZmZXJbaV0pO1xyXG4gICAgICB9IGVsc2Uge1xyXG4gICAgICAgIHRoaXMudXJsLnF1ZXJ5ICs9IFN0cmluZy5mcm9tQ29kZVBvaW50KGJ1ZmZlcltpXSk7XHJcbiAgICAgIH1cclxuICAgIH1cclxuXHJcbiAgICB0aGlzLmJ1ZmZlciA9IFwiXCI7XHJcbiAgICBpZiAoYyA9PT0gMzUpIHtcclxuICAgICAgdGhpcy51cmwuZnJhZ21lbnQgPSBcIlwiO1xyXG4gICAgICB0aGlzLnN0YXRlID0gXCJmcmFnbWVudFwiO1xyXG4gICAgfVxyXG4gIH0gZWxzZSB7XHJcbiAgICAvLyBUT0RPOiBJZiBjIGlzIG5vdCBhIFVSTCBjb2RlIHBvaW50IGFuZCBub3QgXCIlXCIsIHBhcnNlIGVycm9yLlxyXG4gICAgaWYgKGMgPT09IDM3ICYmXHJcbiAgICAgICghaXNBU0NJSUhleCh0aGlzLmlucHV0W3RoaXMucG9pbnRlciArIDFdKSB8fFxyXG4gICAgICAgICFpc0FTQ0lJSGV4KHRoaXMuaW5wdXRbdGhpcy5wb2ludGVyICsgMl0pKSkge1xyXG4gICAgICB0aGlzLnBhcnNlRXJyb3IgPSB0cnVlO1xyXG4gICAgfVxyXG5cclxuICAgIHRoaXMuYnVmZmVyICs9IGNTdHI7XHJcbiAgfVxyXG5cclxuICByZXR1cm4gdHJ1ZTtcclxufTtcclxuXHJcblVSTFN0YXRlTWFjaGluZS5wcm90b3R5cGVbXCJwYXJzZSBmcmFnbWVudFwiXSA9IGZ1bmN0aW9uIHBhcnNlRnJhZ21lbnQoYykge1xyXG4gIGlmIChpc05hTihjKSkgeyAvLyBkbyBub3RoaW5nXHJcbiAgfSBlbHNlIGlmIChjID09PSAweDApIHtcclxuICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgfSBlbHNlIHtcclxuICAgIC8vIFRPRE86IElmIGMgaXMgbm90IGEgVVJMIGNvZGUgcG9pbnQgYW5kIG5vdCBcIiVcIiwgcGFyc2UgZXJyb3IuXHJcbiAgICBpZiAoYyA9PT0gMzcgJiZcclxuICAgICAgKCFpc0FTQ0lJSGV4KHRoaXMuaW5wdXRbdGhpcy5wb2ludGVyICsgMV0pIHx8XHJcbiAgICAgICAgIWlzQVNDSUlIZXgodGhpcy5pbnB1dFt0aGlzLnBvaW50ZXIgKyAyXSkpKSB7XHJcbiAgICAgIHRoaXMucGFyc2VFcnJvciA9IHRydWU7XHJcbiAgICB9XHJcblxyXG4gICAgdGhpcy51cmwuZnJhZ21lbnQgKz0gcGVyY2VudEVuY29kZUNoYXIoYywgaXNDMENvbnRyb2xQZXJjZW50RW5jb2RlKTtcclxuICB9XHJcblxyXG4gIHJldHVybiB0cnVlO1xyXG59O1xyXG5cclxuZnVuY3Rpb24gc2VyaWFsaXplVVJMKHVybCwgZXhjbHVkZUZyYWdtZW50KSB7XHJcbiAgbGV0IG91dHB1dCA9IHVybC5zY2hlbWUgKyBcIjpcIjtcclxuICBpZiAodXJsLmhvc3QgIT09IG51bGwpIHtcclxuICAgIG91dHB1dCArPSBcIi8vXCI7XHJcblxyXG4gICAgaWYgKHVybC51c2VybmFtZSAhPT0gXCJcIiB8fCB1cmwucGFzc3dvcmQgIT09IFwiXCIpIHtcclxuICAgICAgb3V0cHV0ICs9IHVybC51c2VybmFtZTtcclxuICAgICAgaWYgKHVybC5wYXNzd29yZCAhPT0gXCJcIikge1xyXG4gICAgICAgIG91dHB1dCArPSBcIjpcIiArIHVybC5wYXNzd29yZDtcclxuICAgICAgfVxyXG4gICAgICBvdXRwdXQgKz0gXCJAXCI7XHJcbiAgICB9XHJcblxyXG4gICAgb3V0cHV0ICs9IHNlcmlhbGl6ZUhvc3QodXJsLmhvc3QpO1xyXG5cclxuICAgIGlmICh1cmwucG9ydCAhPT0gbnVsbCkge1xyXG4gICAgICBvdXRwdXQgKz0gXCI6XCIgKyB1cmwucG9ydDtcclxuICAgIH1cclxuICB9IGVsc2UgaWYgKHVybC5ob3N0ID09PSBudWxsICYmIHVybC5zY2hlbWUgPT09IFwiZmlsZVwiKSB7XHJcbiAgICBvdXRwdXQgKz0gXCIvL1wiO1xyXG4gIH1cclxuXHJcbiAgaWYgKHVybC5jYW5ub3RCZUFCYXNlVVJMKSB7XHJcbiAgICBvdXRwdXQgKz0gdXJsLnBhdGhbMF07XHJcbiAgfSBlbHNlIHtcclxuICAgIGZvciAoY29uc3Qgc3RyaW5nIG9mIHVybC5wYXRoKSB7XHJcbiAgICAgIG91dHB1dCArPSBcIi9cIiArIHN0cmluZztcclxuICAgIH1cclxuICB9XHJcblxyXG4gIGlmICh1cmwucXVlcnkgIT09IG51bGwpIHtcclxuICAgIG91dHB1dCArPSBcIj9cIiArIHVybC5xdWVyeTtcclxuICB9XHJcblxyXG4gIGlmICghZXhjbHVkZUZyYWdtZW50ICYmIHVybC5mcmFnbWVudCAhPT0gbnVsbCkge1xyXG4gICAgb3V0cHV0ICs9IFwiI1wiICsgdXJsLmZyYWdtZW50O1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIG91dHB1dDtcclxufVxyXG5cclxuZnVuY3Rpb24gc2VyaWFsaXplT3JpZ2luKHR1cGxlKSB7XHJcbiAgbGV0IHJlc3VsdCA9IHR1cGxlLnNjaGVtZSArIFwiOi8vXCI7XHJcbiAgcmVzdWx0ICs9IHNlcmlhbGl6ZUhvc3QodHVwbGUuaG9zdCk7XHJcblxyXG4gIGlmICh0dXBsZS5wb3J0ICE9PSBudWxsKSB7XHJcbiAgICByZXN1bHQgKz0gXCI6XCIgKyB0dXBsZS5wb3J0O1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHJlc3VsdDtcclxufVxyXG5cclxubW9kdWxlLmV4cG9ydHMuc2VyaWFsaXplVVJMID0gc2VyaWFsaXplVVJMO1xyXG5cclxubW9kdWxlLmV4cG9ydHMuc2VyaWFsaXplVVJMT3JpZ2luID0gZnVuY3Rpb24gKHVybCkge1xyXG4gIC8vIGh0dHBzOi8vdXJsLnNwZWMud2hhdHdnLm9yZy8jY29uY2VwdC11cmwtb3JpZ2luXHJcbiAgc3dpdGNoICh1cmwuc2NoZW1lKSB7XHJcbiAgICBjYXNlIFwiYmxvYlwiOlxyXG4gICAgICB0cnkge1xyXG4gICAgICAgIHJldHVybiBtb2R1bGUuZXhwb3J0cy5zZXJpYWxpemVVUkxPcmlnaW4obW9kdWxlLmV4cG9ydHMucGFyc2VVUkwodXJsLnBhdGhbMF0pKTtcclxuICAgICAgfSBjYXRjaCAoZSkge1xyXG4gICAgICAgIC8vIHNlcmlhbGl6aW5nIGFuIG9wYXF1ZSBvcmlnaW4gcmV0dXJucyBcIm51bGxcIlxyXG4gICAgICAgIHJldHVybiBcIm51bGxcIjtcclxuICAgICAgfVxyXG4gICAgY2FzZSBcImZ0cFwiOlxyXG4gICAgY2FzZSBcImdvcGhlclwiOlxyXG4gICAgY2FzZSBcImh0dHBcIjpcclxuICAgIGNhc2UgXCJodHRwc1wiOlxyXG4gICAgY2FzZSBcIndzXCI6XHJcbiAgICBjYXNlIFwid3NzXCI6XHJcbiAgICAgIHJldHVybiBzZXJpYWxpemVPcmlnaW4oe1xyXG4gICAgICAgIHNjaGVtZTogdXJsLnNjaGVtZSxcclxuICAgICAgICBob3N0OiB1cmwuaG9zdCxcclxuICAgICAgICBwb3J0OiB1cmwucG9ydFxyXG4gICAgICB9KTtcclxuICAgIGNhc2UgXCJmaWxlXCI6XHJcbiAgICAgIC8vIHNwZWMgc2F5cyBcImV4ZXJjaXNlIHRvIHRoZSByZWFkZXJcIiwgY2hyb21lIHNheXMgXCJmaWxlOi8vXCJcclxuICAgICAgcmV0dXJuIFwiZmlsZTovL1wiO1xyXG4gICAgZGVmYXVsdDpcclxuICAgICAgLy8gc2VyaWFsaXppbmcgYW4gb3BhcXVlIG9yaWdpbiByZXR1cm5zIFwibnVsbFwiXHJcbiAgICAgIHJldHVybiBcIm51bGxcIjtcclxuICB9XHJcbn07XHJcblxyXG5tb2R1bGUuZXhwb3J0cy5iYXNpY1VSTFBhcnNlID0gZnVuY3Rpb24gKGlucHV0LCBvcHRpb25zKSB7XHJcbiAgaWYgKG9wdGlvbnMgPT09IHVuZGVmaW5lZCkge1xyXG4gICAgb3B0aW9ucyA9IHt9O1xyXG4gIH1cclxuXHJcbiAgY29uc3QgdXNtID0gbmV3IFVSTFN0YXRlTWFjaGluZShpbnB1dCwgb3B0aW9ucy5iYXNlVVJMLCBvcHRpb25zLmVuY29kaW5nT3ZlcnJpZGUsIG9wdGlvbnMudXJsLCBvcHRpb25zLnN0YXRlT3ZlcnJpZGUpO1xyXG4gIGlmICh1c20uZmFpbHVyZSkge1xyXG4gICAgcmV0dXJuIFwiZmFpbHVyZVwiO1xyXG4gIH1cclxuXHJcbiAgcmV0dXJuIHVzbS51cmw7XHJcbn07XHJcblxyXG5tb2R1bGUuZXhwb3J0cy5zZXRUaGVVc2VybmFtZSA9IGZ1bmN0aW9uICh1cmwsIHVzZXJuYW1lKSB7XHJcbiAgdXJsLnVzZXJuYW1lID0gXCJcIjtcclxuICBjb25zdCBkZWNvZGVkID0gcHVueWNvZGUudWNzMi5kZWNvZGUodXNlcm5hbWUpO1xyXG4gIGZvciAobGV0IGkgPSAwOyBpIDwgZGVjb2RlZC5sZW5ndGg7ICsraSkge1xyXG4gICAgdXJsLnVzZXJuYW1lICs9IHBlcmNlbnRFbmNvZGVDaGFyKGRlY29kZWRbaV0sIGlzVXNlcmluZm9QZXJjZW50RW5jb2RlKTtcclxuICB9XHJcbn07XHJcblxyXG5tb2R1bGUuZXhwb3J0cy5zZXRUaGVQYXNzd29yZCA9IGZ1bmN0aW9uICh1cmwsIHBhc3N3b3JkKSB7XHJcbiAgdXJsLnBhc3N3b3JkID0gXCJcIjtcclxuICBjb25zdCBkZWNvZGVkID0gcHVueWNvZGUudWNzMi5kZWNvZGUocGFzc3dvcmQpO1xyXG4gIGZvciAobGV0IGkgPSAwOyBpIDwgZGVjb2RlZC5sZW5ndGg7ICsraSkge1xyXG4gICAgdXJsLnBhc3N3b3JkICs9IHBlcmNlbnRFbmNvZGVDaGFyKGRlY29kZWRbaV0sIGlzVXNlcmluZm9QZXJjZW50RW5jb2RlKTtcclxuICB9XHJcbn07XHJcblxyXG5tb2R1bGUuZXhwb3J0cy5zZXJpYWxpemVIb3N0ID0gc2VyaWFsaXplSG9zdDtcclxuXHJcbm1vZHVsZS5leHBvcnRzLmNhbm5vdEhhdmVBVXNlcm5hbWVQYXNzd29yZFBvcnQgPSBjYW5ub3RIYXZlQVVzZXJuYW1lUGFzc3dvcmRQb3J0O1xyXG5cclxubW9kdWxlLmV4cG9ydHMuc2VyaWFsaXplSW50ZWdlciA9IGZ1bmN0aW9uIChpbnRlZ2VyKSB7XHJcbiAgcmV0dXJuIFN0cmluZyhpbnRlZ2VyKTtcclxufTtcclxuXHJcbm1vZHVsZS5leHBvcnRzLnBhcnNlVVJMID0gZnVuY3Rpb24gKGlucHV0LCBvcHRpb25zKSB7XHJcbiAgaWYgKG9wdGlvbnMgPT09IHVuZGVmaW5lZCkge1xyXG4gICAgb3B0aW9ucyA9IHt9O1xyXG4gIH1cclxuXHJcbiAgLy8gV2UgZG9uJ3QgaGFuZGxlIGJsb2JzLCBzbyB0aGlzIGp1c3QgZGVsZWdhdGVzOlxyXG4gIHJldHVybiBtb2R1bGUuZXhwb3J0cy5iYXNpY1VSTFBhcnNlKGlucHV0LCB7IGJhc2VVUkw6IG9wdGlvbnMuYmFzZVVSTCwgZW5jb2RpbmdPdmVycmlkZTogb3B0aW9ucy5lbmNvZGluZ092ZXJyaWRlIH0pO1xyXG59O1xyXG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG5jb25zdCB1c20gPSByZXF1aXJlKFwiLi91cmwtc3RhdGUtbWFjaGluZVwiKTtcblxuZXhwb3J0cy5pbXBsZW1lbnRhdGlvbiA9IGNsYXNzIFVSTEltcGwge1xuICBjb25zdHJ1Y3Rvcihjb25zdHJ1Y3RvckFyZ3MpIHtcbiAgICBjb25zdCB1cmwgPSBjb25zdHJ1Y3RvckFyZ3NbMF07XG4gICAgY29uc3QgYmFzZSA9IGNvbnN0cnVjdG9yQXJnc1sxXTtcblxuICAgIGxldCBwYXJzZWRCYXNlID0gbnVsbDtcbiAgICBpZiAoYmFzZSAhPT0gdW5kZWZpbmVkKSB7XG4gICAgICBwYXJzZWRCYXNlID0gdXNtLmJhc2ljVVJMUGFyc2UoYmFzZSk7XG4gICAgICBpZiAocGFyc2VkQmFzZSA9PT0gXCJmYWlsdXJlXCIpIHtcbiAgICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcIkludmFsaWQgYmFzZSBVUkxcIik7XG4gICAgICB9XG4gICAgfVxuXG4gICAgY29uc3QgcGFyc2VkVVJMID0gdXNtLmJhc2ljVVJMUGFyc2UodXJsLCB7IGJhc2VVUkw6IHBhcnNlZEJhc2UgfSk7XG4gICAgaWYgKHBhcnNlZFVSTCA9PT0gXCJmYWlsdXJlXCIpIHtcbiAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXCJJbnZhbGlkIFVSTFwiKTtcbiAgICB9XG5cbiAgICB0aGlzLl91cmwgPSBwYXJzZWRVUkw7XG5cbiAgICAvLyBUT0RPOiBxdWVyeSBzdHVmZlxuICB9XG5cbiAgZ2V0IGhyZWYoKSB7XG4gICAgcmV0dXJuIHVzbS5zZXJpYWxpemVVUkwodGhpcy5fdXJsKTtcbiAgfVxuXG4gIHNldCBocmVmKHYpIHtcbiAgICBjb25zdCBwYXJzZWRVUkwgPSB1c20uYmFzaWNVUkxQYXJzZSh2KTtcbiAgICBpZiAocGFyc2VkVVJMID09PSBcImZhaWx1cmVcIikge1xuICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcIkludmFsaWQgVVJMXCIpO1xuICAgIH1cblxuICAgIHRoaXMuX3VybCA9IHBhcnNlZFVSTDtcbiAgfVxuXG4gIGdldCBvcmlnaW4oKSB7XG4gICAgcmV0dXJuIHVzbS5zZXJpYWxpemVVUkxPcmlnaW4odGhpcy5fdXJsKTtcbiAgfVxuXG4gIGdldCBwcm90b2NvbCgpIHtcbiAgICByZXR1cm4gdGhpcy5fdXJsLnNjaGVtZSArIFwiOlwiO1xuICB9XG5cbiAgc2V0IHByb3RvY29sKHYpIHtcbiAgICB1c20uYmFzaWNVUkxQYXJzZSh2ICsgXCI6XCIsIHsgdXJsOiB0aGlzLl91cmwsIHN0YXRlT3ZlcnJpZGU6IFwic2NoZW1lIHN0YXJ0XCIgfSk7XG4gIH1cblxuICBnZXQgdXNlcm5hbWUoKSB7XG4gICAgcmV0dXJuIHRoaXMuX3VybC51c2VybmFtZTtcbiAgfVxuXG4gIHNldCB1c2VybmFtZSh2KSB7XG4gICAgaWYgKHVzbS5jYW5ub3RIYXZlQVVzZXJuYW1lUGFzc3dvcmRQb3J0KHRoaXMuX3VybCkpIHtcbiAgICAgIHJldHVybjtcbiAgICB9XG5cbiAgICB1c20uc2V0VGhlVXNlcm5hbWUodGhpcy5fdXJsLCB2KTtcbiAgfVxuXG4gIGdldCBwYXNzd29yZCgpIHtcbiAgICByZXR1cm4gdGhpcy5fdXJsLnBhc3N3b3JkO1xuICB9XG5cbiAgc2V0IHBhc3N3b3JkKHYpIHtcbiAgICBpZiAodXNtLmNhbm5vdEhhdmVBVXNlcm5hbWVQYXNzd29yZFBvcnQodGhpcy5fdXJsKSkge1xuICAgICAgcmV0dXJuO1xuICAgIH1cblxuICAgIHVzbS5zZXRUaGVQYXNzd29yZCh0aGlzLl91cmwsIHYpO1xuICB9XG5cbiAgZ2V0IGhvc3QoKSB7XG4gICAgY29uc3QgdXJsID0gdGhpcy5fdXJsO1xuXG4gICAgaWYgKHVybC5ob3N0ID09PSBudWxsKSB7XG4gICAgICByZXR1cm4gXCJcIjtcbiAgICB9XG5cbiAgICBpZiAodXJsLnBvcnQgPT09IG51bGwpIHtcbiAgICAgIHJldHVybiB1c20uc2VyaWFsaXplSG9zdCh1cmwuaG9zdCk7XG4gICAgfVxuXG4gICAgcmV0dXJuIHVzbS5zZXJpYWxpemVIb3N0KHVybC5ob3N0KSArIFwiOlwiICsgdXNtLnNlcmlhbGl6ZUludGVnZXIodXJsLnBvcnQpO1xuICB9XG5cbiAgc2V0IGhvc3Qodikge1xuICAgIGlmICh0aGlzLl91cmwuY2Fubm90QmVBQmFzZVVSTCkge1xuICAgICAgcmV0dXJuO1xuICAgIH1cblxuICAgIHVzbS5iYXNpY1VSTFBhcnNlKHYsIHsgdXJsOiB0aGlzLl91cmwsIHN0YXRlT3ZlcnJpZGU6IFwiaG9zdFwiIH0pO1xuICB9XG5cbiAgZ2V0IGhvc3RuYW1lKCkge1xuICAgIGlmICh0aGlzLl91cmwuaG9zdCA9PT0gbnVsbCkge1xuICAgICAgcmV0dXJuIFwiXCI7XG4gICAgfVxuXG4gICAgcmV0dXJuIHVzbS5zZXJpYWxpemVIb3N0KHRoaXMuX3VybC5ob3N0KTtcbiAgfVxuXG4gIHNldCBob3N0bmFtZSh2KSB7XG4gICAgaWYgKHRoaXMuX3VybC5jYW5ub3RCZUFCYXNlVVJMKSB7XG4gICAgICByZXR1cm47XG4gICAgfVxuXG4gICAgdXNtLmJhc2ljVVJMUGFyc2UodiwgeyB1cmw6IHRoaXMuX3VybCwgc3RhdGVPdmVycmlkZTogXCJob3N0bmFtZVwiIH0pO1xuICB9XG5cbiAgZ2V0IHBvcnQoKSB7XG4gICAgaWYgKHRoaXMuX3VybC5wb3J0ID09PSBudWxsKSB7XG4gICAgICByZXR1cm4gXCJcIjtcbiAgICB9XG5cbiAgICByZXR1cm4gdXNtLnNlcmlhbGl6ZUludGVnZXIodGhpcy5fdXJsLnBvcnQpO1xuICB9XG5cbiAgc2V0IHBvcnQodikge1xuICAgIGlmICh1c20uY2Fubm90SGF2ZUFVc2VybmFtZVBhc3N3b3JkUG9ydCh0aGlzLl91cmwpKSB7XG4gICAgICByZXR1cm47XG4gICAgfVxuXG4gICAgaWYgKHYgPT09IFwiXCIpIHtcbiAgICAgIHRoaXMuX3VybC5wb3J0ID0gbnVsbDtcbiAgICB9IGVsc2Uge1xuICAgICAgdXNtLmJhc2ljVVJMUGFyc2UodiwgeyB1cmw6IHRoaXMuX3VybCwgc3RhdGVPdmVycmlkZTogXCJwb3J0XCIgfSk7XG4gICAgfVxuICB9XG5cbiAgZ2V0IHBhdGhuYW1lKCkge1xuICAgIGlmICh0aGlzLl91cmwuY2Fubm90QmVBQmFzZVVSTCkge1xuICAgICAgcmV0dXJuIHRoaXMuX3VybC5wYXRoWzBdO1xuICAgIH1cblxuICAgIGlmICh0aGlzLl91cmwucGF0aC5sZW5ndGggPT09IDApIHtcbiAgICAgIHJldHVybiBcIlwiO1xuICAgIH1cblxuICAgIHJldHVybiBcIi9cIiArIHRoaXMuX3VybC5wYXRoLmpvaW4oXCIvXCIpO1xuICB9XG5cbiAgc2V0IHBhdGhuYW1lKHYpIHtcbiAgICBpZiAodGhpcy5fdXJsLmNhbm5vdEJlQUJhc2VVUkwpIHtcbiAgICAgIHJldHVybjtcbiAgICB9XG5cbiAgICB0aGlzLl91cmwucGF0aCA9IFtdO1xuICAgIHVzbS5iYXNpY1VSTFBhcnNlKHYsIHsgdXJsOiB0aGlzLl91cmwsIHN0YXRlT3ZlcnJpZGU6IFwicGF0aCBzdGFydFwiIH0pO1xuICB9XG5cbiAgZ2V0IHNlYXJjaCgpIHtcbiAgICBpZiAodGhpcy5fdXJsLnF1ZXJ5ID09PSBudWxsIHx8IHRoaXMuX3VybC5xdWVyeSA9PT0gXCJcIikge1xuICAgICAgcmV0dXJuIFwiXCI7XG4gICAgfVxuXG4gICAgcmV0dXJuIFwiP1wiICsgdGhpcy5fdXJsLnF1ZXJ5O1xuICB9XG5cbiAgc2V0IHNlYXJjaCh2KSB7XG4gICAgLy8gVE9ETzogcXVlcnkgc3R1ZmZcblxuICAgIGNvbnN0IHVybCA9IHRoaXMuX3VybDtcblxuICAgIGlmICh2ID09PSBcIlwiKSB7XG4gICAgICB1cmwucXVlcnkgPSBudWxsO1xuICAgICAgcmV0dXJuO1xuICAgIH1cblxuICAgIGNvbnN0IGlucHV0ID0gdlswXSA9PT0gXCI/XCIgPyB2LnN1YnN0cmluZygxKSA6IHY7XG4gICAgdXJsLnF1ZXJ5ID0gXCJcIjtcbiAgICB1c20uYmFzaWNVUkxQYXJzZShpbnB1dCwgeyB1cmwsIHN0YXRlT3ZlcnJpZGU6IFwicXVlcnlcIiB9KTtcbiAgfVxuXG4gIGdldCBoYXNoKCkge1xuICAgIGlmICh0aGlzLl91cmwuZnJhZ21lbnQgPT09IG51bGwgfHwgdGhpcy5fdXJsLmZyYWdtZW50ID09PSBcIlwiKSB7XG4gICAgICByZXR1cm4gXCJcIjtcbiAgICB9XG5cbiAgICByZXR1cm4gXCIjXCIgKyB0aGlzLl91cmwuZnJhZ21lbnQ7XG4gIH1cblxuICBzZXQgaGFzaCh2KSB7XG4gICAgaWYgKHYgPT09IFwiXCIpIHtcbiAgICAgIHRoaXMuX3VybC5mcmFnbWVudCA9IG51bGw7XG4gICAgICByZXR1cm47XG4gICAgfVxuXG4gICAgY29uc3QgaW5wdXQgPSB2WzBdID09PSBcIiNcIiA/IHYuc3Vic3RyaW5nKDEpIDogdjtcbiAgICB0aGlzLl91cmwuZnJhZ21lbnQgPSBcIlwiO1xuICAgIHVzbS5iYXNpY1VSTFBhcnNlKGlucHV0LCB7IHVybDogdGhpcy5fdXJsLCBzdGF0ZU92ZXJyaWRlOiBcImZyYWdtZW50XCIgfSk7XG4gIH1cblxuICB0b0pTT04oKSB7XG4gICAgcmV0dXJuIHRoaXMuaHJlZjtcbiAgfVxufTtcbiIsICJcInVzZSBzdHJpY3RcIjtcblxuY29uc3QgY29udmVyc2lvbnMgPSByZXF1aXJlKFwid2ViaWRsLWNvbnZlcnNpb25zXCIpO1xuY29uc3QgdXRpbHMgPSByZXF1aXJlKFwiLi91dGlscy5qc1wiKTtcbmNvbnN0IEltcGwgPSByZXF1aXJlKFwiLi8vVVJMLWltcGwuanNcIik7XG5cbmNvbnN0IGltcGwgPSB1dGlscy5pbXBsU3ltYm9sO1xuXG5mdW5jdGlvbiBVUkwodXJsKSB7XG4gIGlmICghdGhpcyB8fCB0aGlzW2ltcGxdIHx8ICEodGhpcyBpbnN0YW5jZW9mIFVSTCkpIHtcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKFwiRmFpbGVkIHRvIGNvbnN0cnVjdCAnVVJMJzogUGxlYXNlIHVzZSB0aGUgJ25ldycgb3BlcmF0b3IsIHRoaXMgRE9NIG9iamVjdCBjb25zdHJ1Y3RvciBjYW5ub3QgYmUgY2FsbGVkIGFzIGEgZnVuY3Rpb24uXCIpO1xuICB9XG4gIGlmIChhcmd1bWVudHMubGVuZ3RoIDwgMSkge1xuICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXCJGYWlsZWQgdG8gY29uc3RydWN0ICdVUkwnOiAxIGFyZ3VtZW50IHJlcXVpcmVkLCBidXQgb25seSBcIiArIGFyZ3VtZW50cy5sZW5ndGggKyBcIiBwcmVzZW50LlwiKTtcbiAgfVxuICBjb25zdCBhcmdzID0gW107XG4gIGZvciAobGV0IGkgPSAwOyBpIDwgYXJndW1lbnRzLmxlbmd0aCAmJiBpIDwgMjsgKytpKSB7XG4gICAgYXJnc1tpXSA9IGFyZ3VtZW50c1tpXTtcbiAgfVxuICBhcmdzWzBdID0gY29udmVyc2lvbnNbXCJVU1ZTdHJpbmdcIl0oYXJnc1swXSk7XG4gIGlmIChhcmdzWzFdICE9PSB1bmRlZmluZWQpIHtcbiAgYXJnc1sxXSA9IGNvbnZlcnNpb25zW1wiVVNWU3RyaW5nXCJdKGFyZ3NbMV0pO1xuICB9XG5cbiAgbW9kdWxlLmV4cG9ydHMuc2V0dXAodGhpcywgYXJncyk7XG59XG5cblVSTC5wcm90b3R5cGUudG9KU09OID0gZnVuY3Rpb24gdG9KU09OKCkge1xuICBpZiAoIXRoaXMgfHwgIW1vZHVsZS5leHBvcnRzLmlzKHRoaXMpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcIklsbGVnYWwgaW52b2NhdGlvblwiKTtcbiAgfVxuICBjb25zdCBhcmdzID0gW107XG4gIGZvciAobGV0IGkgPSAwOyBpIDwgYXJndW1lbnRzLmxlbmd0aCAmJiBpIDwgMDsgKytpKSB7XG4gICAgYXJnc1tpXSA9IGFyZ3VtZW50c1tpXTtcbiAgfVxuICByZXR1cm4gdGhpc1tpbXBsXS50b0pTT04uYXBwbHkodGhpc1tpbXBsXSwgYXJncyk7XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KFVSTC5wcm90b3R5cGUsIFwiaHJlZlwiLCB7XG4gIGdldCgpIHtcbiAgICByZXR1cm4gdGhpc1tpbXBsXS5ocmVmO1xuICB9LFxuICBzZXQoVikge1xuICAgIFYgPSBjb252ZXJzaW9uc1tcIlVTVlN0cmluZ1wiXShWKTtcbiAgICB0aGlzW2ltcGxdLmhyZWYgPSBWO1xuICB9LFxuICBlbnVtZXJhYmxlOiB0cnVlLFxuICBjb25maWd1cmFibGU6IHRydWVcbn0pO1xuXG5VUkwucHJvdG90eXBlLnRvU3RyaW5nID0gZnVuY3Rpb24gKCkge1xuICBpZiAoIXRoaXMgfHwgIW1vZHVsZS5leHBvcnRzLmlzKHRoaXMpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcIklsbGVnYWwgaW52b2NhdGlvblwiKTtcbiAgfVxuICByZXR1cm4gdGhpcy5ocmVmO1xufTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KFVSTC5wcm90b3R5cGUsIFwib3JpZ2luXCIsIHtcbiAgZ2V0KCkge1xuICAgIHJldHVybiB0aGlzW2ltcGxdLm9yaWdpbjtcbiAgfSxcbiAgZW51bWVyYWJsZTogdHJ1ZSxcbiAgY29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KFVSTC5wcm90b3R5cGUsIFwicHJvdG9jb2xcIiwge1xuICBnZXQoKSB7XG4gICAgcmV0dXJuIHRoaXNbaW1wbF0ucHJvdG9jb2w7XG4gIH0sXG4gIHNldChWKSB7XG4gICAgViA9IGNvbnZlcnNpb25zW1wiVVNWU3RyaW5nXCJdKFYpO1xuICAgIHRoaXNbaW1wbF0ucHJvdG9jb2wgPSBWO1xuICB9LFxuICBlbnVtZXJhYmxlOiB0cnVlLFxuICBjb25maWd1cmFibGU6IHRydWVcbn0pO1xuXG5PYmplY3QuZGVmaW5lUHJvcGVydHkoVVJMLnByb3RvdHlwZSwgXCJ1c2VybmFtZVwiLCB7XG4gIGdldCgpIHtcbiAgICByZXR1cm4gdGhpc1tpbXBsXS51c2VybmFtZTtcbiAgfSxcbiAgc2V0KFYpIHtcbiAgICBWID0gY29udmVyc2lvbnNbXCJVU1ZTdHJpbmdcIl0oVik7XG4gICAgdGhpc1tpbXBsXS51c2VybmFtZSA9IFY7XG4gIH0sXG4gIGVudW1lcmFibGU6IHRydWUsXG4gIGNvbmZpZ3VyYWJsZTogdHJ1ZVxufSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShVUkwucHJvdG90eXBlLCBcInBhc3N3b3JkXCIsIHtcbiAgZ2V0KCkge1xuICAgIHJldHVybiB0aGlzW2ltcGxdLnBhc3N3b3JkO1xuICB9LFxuICBzZXQoVikge1xuICAgIFYgPSBjb252ZXJzaW9uc1tcIlVTVlN0cmluZ1wiXShWKTtcbiAgICB0aGlzW2ltcGxdLnBhc3N3b3JkID0gVjtcbiAgfSxcbiAgZW51bWVyYWJsZTogdHJ1ZSxcbiAgY29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KFVSTC5wcm90b3R5cGUsIFwiaG9zdFwiLCB7XG4gIGdldCgpIHtcbiAgICByZXR1cm4gdGhpc1tpbXBsXS5ob3N0O1xuICB9LFxuICBzZXQoVikge1xuICAgIFYgPSBjb252ZXJzaW9uc1tcIlVTVlN0cmluZ1wiXShWKTtcbiAgICB0aGlzW2ltcGxdLmhvc3QgPSBWO1xuICB9LFxuICBlbnVtZXJhYmxlOiB0cnVlLFxuICBjb25maWd1cmFibGU6IHRydWVcbn0pO1xuXG5PYmplY3QuZGVmaW5lUHJvcGVydHkoVVJMLnByb3RvdHlwZSwgXCJob3N0bmFtZVwiLCB7XG4gIGdldCgpIHtcbiAgICByZXR1cm4gdGhpc1tpbXBsXS5ob3N0bmFtZTtcbiAgfSxcbiAgc2V0KFYpIHtcbiAgICBWID0gY29udmVyc2lvbnNbXCJVU1ZTdHJpbmdcIl0oVik7XG4gICAgdGhpc1tpbXBsXS5ob3N0bmFtZSA9IFY7XG4gIH0sXG4gIGVudW1lcmFibGU6IHRydWUsXG4gIGNvbmZpZ3VyYWJsZTogdHJ1ZVxufSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShVUkwucHJvdG90eXBlLCBcInBvcnRcIiwge1xuICBnZXQoKSB7XG4gICAgcmV0dXJuIHRoaXNbaW1wbF0ucG9ydDtcbiAgfSxcbiAgc2V0KFYpIHtcbiAgICBWID0gY29udmVyc2lvbnNbXCJVU1ZTdHJpbmdcIl0oVik7XG4gICAgdGhpc1tpbXBsXS5wb3J0ID0gVjtcbiAgfSxcbiAgZW51bWVyYWJsZTogdHJ1ZSxcbiAgY29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KFVSTC5wcm90b3R5cGUsIFwicGF0aG5hbWVcIiwge1xuICBnZXQoKSB7XG4gICAgcmV0dXJuIHRoaXNbaW1wbF0ucGF0aG5hbWU7XG4gIH0sXG4gIHNldChWKSB7XG4gICAgViA9IGNvbnZlcnNpb25zW1wiVVNWU3RyaW5nXCJdKFYpO1xuICAgIHRoaXNbaW1wbF0ucGF0aG5hbWUgPSBWO1xuICB9LFxuICBlbnVtZXJhYmxlOiB0cnVlLFxuICBjb25maWd1cmFibGU6IHRydWVcbn0pO1xuXG5PYmplY3QuZGVmaW5lUHJvcGVydHkoVVJMLnByb3RvdHlwZSwgXCJzZWFyY2hcIiwge1xuICBnZXQoKSB7XG4gICAgcmV0dXJuIHRoaXNbaW1wbF0uc2VhcmNoO1xuICB9LFxuICBzZXQoVikge1xuICAgIFYgPSBjb252ZXJzaW9uc1tcIlVTVlN0cmluZ1wiXShWKTtcbiAgICB0aGlzW2ltcGxdLnNlYXJjaCA9IFY7XG4gIH0sXG4gIGVudW1lcmFibGU6IHRydWUsXG4gIGNvbmZpZ3VyYWJsZTogdHJ1ZVxufSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShVUkwucHJvdG90eXBlLCBcImhhc2hcIiwge1xuICBnZXQoKSB7XG4gICAgcmV0dXJuIHRoaXNbaW1wbF0uaGFzaDtcbiAgfSxcbiAgc2V0KFYpIHtcbiAgICBWID0gY29udmVyc2lvbnNbXCJVU1ZTdHJpbmdcIl0oVik7XG4gICAgdGhpc1tpbXBsXS5oYXNoID0gVjtcbiAgfSxcbiAgZW51bWVyYWJsZTogdHJ1ZSxcbiAgY29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuXG5tb2R1bGUuZXhwb3J0cyA9IHtcbiAgaXMob2JqKSB7XG4gICAgcmV0dXJuICEhb2JqICYmIG9ialtpbXBsXSBpbnN0YW5jZW9mIEltcGwuaW1wbGVtZW50YXRpb247XG4gIH0sXG4gIGNyZWF0ZShjb25zdHJ1Y3RvckFyZ3MsIHByaXZhdGVEYXRhKSB7XG4gICAgbGV0IG9iaiA9IE9iamVjdC5jcmVhdGUoVVJMLnByb3RvdHlwZSk7XG4gICAgdGhpcy5zZXR1cChvYmosIGNvbnN0cnVjdG9yQXJncywgcHJpdmF0ZURhdGEpO1xuICAgIHJldHVybiBvYmo7XG4gIH0sXG4gIHNldHVwKG9iaiwgY29uc3RydWN0b3JBcmdzLCBwcml2YXRlRGF0YSkge1xuICAgIGlmICghcHJpdmF0ZURhdGEpIHByaXZhdGVEYXRhID0ge307XG4gICAgcHJpdmF0ZURhdGEud3JhcHBlciA9IG9iajtcblxuICAgIG9ialtpbXBsXSA9IG5ldyBJbXBsLmltcGxlbWVudGF0aW9uKGNvbnN0cnVjdG9yQXJncywgcHJpdmF0ZURhdGEpO1xuICAgIG9ialtpbXBsXVt1dGlscy53cmFwcGVyU3ltYm9sXSA9IG9iajtcbiAgfSxcbiAgaW50ZXJmYWNlOiBVUkwsXG4gIGV4cG9zZToge1xuICAgIFdpbmRvdzogeyBVUkw6IFVSTCB9LFxuICAgIFdvcmtlcjogeyBVUkw6IFVSTCB9XG4gIH1cbn07XG5cbiIsICJcInVzZSBzdHJpY3RcIjtcblxuZXhwb3J0cy5VUkwgPSByZXF1aXJlKFwiLi9VUkxcIikuaW50ZXJmYWNlO1xuZXhwb3J0cy5zZXJpYWxpemVVUkwgPSByZXF1aXJlKFwiLi91cmwtc3RhdGUtbWFjaGluZVwiKS5zZXJpYWxpemVVUkw7XG5leHBvcnRzLnNlcmlhbGl6ZVVSTE9yaWdpbiA9IHJlcXVpcmUoXCIuL3VybC1zdGF0ZS1tYWNoaW5lXCIpLnNlcmlhbGl6ZVVSTE9yaWdpbjtcbmV4cG9ydHMuYmFzaWNVUkxQYXJzZSA9IHJlcXVpcmUoXCIuL3VybC1zdGF0ZS1tYWNoaW5lXCIpLmJhc2ljVVJMUGFyc2U7XG5leHBvcnRzLnNldFRoZVVzZXJuYW1lID0gcmVxdWlyZShcIi4vdXJsLXN0YXRlLW1hY2hpbmVcIikuc2V0VGhlVXNlcm5hbWU7XG5leHBvcnRzLnNldFRoZVBhc3N3b3JkID0gcmVxdWlyZShcIi4vdXJsLXN0YXRlLW1hY2hpbmVcIikuc2V0VGhlUGFzc3dvcmQ7XG5leHBvcnRzLnNlcmlhbGl6ZUhvc3QgPSByZXF1aXJlKFwiLi91cmwtc3RhdGUtbWFjaGluZVwiKS5zZXJpYWxpemVIb3N0O1xuZXhwb3J0cy5zZXJpYWxpemVJbnRlZ2VyID0gcmVxdWlyZShcIi4vdXJsLXN0YXRlLW1hY2hpbmVcIikuc2VyaWFsaXplSW50ZWdlcjtcbmV4cG9ydHMucGFyc2VVUkwgPSByZXF1aXJlKFwiLi91cmwtc3RhdGUtbWFjaGluZVwiKS5wYXJzZVVSTDtcbiIsICIndXNlIHN0cmljdCc7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCAnX19lc01vZHVsZScsIHsgdmFsdWU6IHRydWUgfSk7XG5cbmZ1bmN0aW9uIF9pbnRlcm9wRGVmYXVsdCAoZXgpIHsgcmV0dXJuIChleCAmJiAodHlwZW9mIGV4ID09PSAnb2JqZWN0JykgJiYgJ2RlZmF1bHQnIGluIGV4KSA/IGV4WydkZWZhdWx0J10gOiBleDsgfVxuXG52YXIgU3RyZWFtID0gX2ludGVyb3BEZWZhdWx0KHJlcXVpcmUoJ3N0cmVhbScpKTtcbnZhciBodHRwID0gX2ludGVyb3BEZWZhdWx0KHJlcXVpcmUoJ2h0dHAnKSk7XG52YXIgVXJsID0gX2ludGVyb3BEZWZhdWx0KHJlcXVpcmUoJ3VybCcpKTtcbnZhciB3aGF0d2dVcmwgPSBfaW50ZXJvcERlZmF1bHQocmVxdWlyZSgnd2hhdHdnLXVybCcpKTtcbnZhciBodHRwcyA9IF9pbnRlcm9wRGVmYXVsdChyZXF1aXJlKCdodHRwcycpKTtcbnZhciB6bGliID0gX2ludGVyb3BEZWZhdWx0KHJlcXVpcmUoJ3psaWInKSk7XG5cbi8vIEJhc2VkIG9uIGh0dHBzOi8vZ2l0aHViLmNvbS90bXB2YXIvanNkb20vYmxvYi9hYTg1YjJhYmYwNzc2NmZmN2JmNWMxZjZkYWFmYjM3MjZmMmYyZGI1L2xpYi9qc2RvbS9saXZpbmcvYmxvYi5qc1xuXG4vLyBmaXggZm9yIFwiUmVhZGFibGVcIiBpc24ndCBhIG5hbWVkIGV4cG9ydCBpc3N1ZVxuY29uc3QgUmVhZGFibGUgPSBTdHJlYW0uUmVhZGFibGU7XG5cbmNvbnN0IEJVRkZFUiA9IFN5bWJvbCgnYnVmZmVyJyk7XG5jb25zdCBUWVBFID0gU3ltYm9sKCd0eXBlJyk7XG5cbmNsYXNzIEJsb2Ige1xuXHRjb25zdHJ1Y3RvcigpIHtcblx0XHR0aGlzW1RZUEVdID0gJyc7XG5cblx0XHRjb25zdCBibG9iUGFydHMgPSBhcmd1bWVudHNbMF07XG5cdFx0Y29uc3Qgb3B0aW9ucyA9IGFyZ3VtZW50c1sxXTtcblxuXHRcdGNvbnN0IGJ1ZmZlcnMgPSBbXTtcblx0XHRsZXQgc2l6ZSA9IDA7XG5cblx0XHRpZiAoYmxvYlBhcnRzKSB7XG5cdFx0XHRjb25zdCBhID0gYmxvYlBhcnRzO1xuXHRcdFx0Y29uc3QgbGVuZ3RoID0gTnVtYmVyKGEubGVuZ3RoKTtcblx0XHRcdGZvciAobGV0IGkgPSAwOyBpIDwgbGVuZ3RoOyBpKyspIHtcblx0XHRcdFx0Y29uc3QgZWxlbWVudCA9IGFbaV07XG5cdFx0XHRcdGxldCBidWZmZXI7XG5cdFx0XHRcdGlmIChlbGVtZW50IGluc3RhbmNlb2YgQnVmZmVyKSB7XG5cdFx0XHRcdFx0YnVmZmVyID0gZWxlbWVudDtcblx0XHRcdFx0fSBlbHNlIGlmIChBcnJheUJ1ZmZlci5pc1ZpZXcoZWxlbWVudCkpIHtcblx0XHRcdFx0XHRidWZmZXIgPSBCdWZmZXIuZnJvbShlbGVtZW50LmJ1ZmZlciwgZWxlbWVudC5ieXRlT2Zmc2V0LCBlbGVtZW50LmJ5dGVMZW5ndGgpO1xuXHRcdFx0XHR9IGVsc2UgaWYgKGVsZW1lbnQgaW5zdGFuY2VvZiBBcnJheUJ1ZmZlcikge1xuXHRcdFx0XHRcdGJ1ZmZlciA9IEJ1ZmZlci5mcm9tKGVsZW1lbnQpO1xuXHRcdFx0XHR9IGVsc2UgaWYgKGVsZW1lbnQgaW5zdGFuY2VvZiBCbG9iKSB7XG5cdFx0XHRcdFx0YnVmZmVyID0gZWxlbWVudFtCVUZGRVJdO1xuXHRcdFx0XHR9IGVsc2Uge1xuXHRcdFx0XHRcdGJ1ZmZlciA9IEJ1ZmZlci5mcm9tKHR5cGVvZiBlbGVtZW50ID09PSAnc3RyaW5nJyA/IGVsZW1lbnQgOiBTdHJpbmcoZWxlbWVudCkpO1xuXHRcdFx0XHR9XG5cdFx0XHRcdHNpemUgKz0gYnVmZmVyLmxlbmd0aDtcblx0XHRcdFx0YnVmZmVycy5wdXNoKGJ1ZmZlcik7XG5cdFx0XHR9XG5cdFx0fVxuXG5cdFx0dGhpc1tCVUZGRVJdID0gQnVmZmVyLmNvbmNhdChidWZmZXJzKTtcblxuXHRcdGxldCB0eXBlID0gb3B0aW9ucyAmJiBvcHRpb25zLnR5cGUgIT09IHVuZGVmaW5lZCAmJiBTdHJpbmcob3B0aW9ucy50eXBlKS50b0xvd2VyQ2FzZSgpO1xuXHRcdGlmICh0eXBlICYmICEvW15cXHUwMDIwLVxcdTAwN0VdLy50ZXN0KHR5cGUpKSB7XG5cdFx0XHR0aGlzW1RZUEVdID0gdHlwZTtcblx0XHR9XG5cdH1cblx0Z2V0IHNpemUoKSB7XG5cdFx0cmV0dXJuIHRoaXNbQlVGRkVSXS5sZW5ndGg7XG5cdH1cblx0Z2V0IHR5cGUoKSB7XG5cdFx0cmV0dXJuIHRoaXNbVFlQRV07XG5cdH1cblx0dGV4dCgpIHtcblx0XHRyZXR1cm4gUHJvbWlzZS5yZXNvbHZlKHRoaXNbQlVGRkVSXS50b1N0cmluZygpKTtcblx0fVxuXHRhcnJheUJ1ZmZlcigpIHtcblx0XHRjb25zdCBidWYgPSB0aGlzW0JVRkZFUl07XG5cdFx0Y29uc3QgYWIgPSBidWYuYnVmZmVyLnNsaWNlKGJ1Zi5ieXRlT2Zmc2V0LCBidWYuYnl0ZU9mZnNldCArIGJ1Zi5ieXRlTGVuZ3RoKTtcblx0XHRyZXR1cm4gUHJvbWlzZS5yZXNvbHZlKGFiKTtcblx0fVxuXHRzdHJlYW0oKSB7XG5cdFx0Y29uc3QgcmVhZGFibGUgPSBuZXcgUmVhZGFibGUoKTtcblx0XHRyZWFkYWJsZS5fcmVhZCA9IGZ1bmN0aW9uICgpIHt9O1xuXHRcdHJlYWRhYmxlLnB1c2godGhpc1tCVUZGRVJdKTtcblx0XHRyZWFkYWJsZS5wdXNoKG51bGwpO1xuXHRcdHJldHVybiByZWFkYWJsZTtcblx0fVxuXHR0b1N0cmluZygpIHtcblx0XHRyZXR1cm4gJ1tvYmplY3QgQmxvYl0nO1xuXHR9XG5cdHNsaWNlKCkge1xuXHRcdGNvbnN0IHNpemUgPSB0aGlzLnNpemU7XG5cblx0XHRjb25zdCBzdGFydCA9IGFyZ3VtZW50c1swXTtcblx0XHRjb25zdCBlbmQgPSBhcmd1bWVudHNbMV07XG5cdFx0bGV0IHJlbGF0aXZlU3RhcnQsIHJlbGF0aXZlRW5kO1xuXHRcdGlmIChzdGFydCA9PT0gdW5kZWZpbmVkKSB7XG5cdFx0XHRyZWxhdGl2ZVN0YXJ0ID0gMDtcblx0XHR9IGVsc2UgaWYgKHN0YXJ0IDwgMCkge1xuXHRcdFx0cmVsYXRpdmVTdGFydCA9IE1hdGgubWF4KHNpemUgKyBzdGFydCwgMCk7XG5cdFx0fSBlbHNlIHtcblx0XHRcdHJlbGF0aXZlU3RhcnQgPSBNYXRoLm1pbihzdGFydCwgc2l6ZSk7XG5cdFx0fVxuXHRcdGlmIChlbmQgPT09IHVuZGVmaW5lZCkge1xuXHRcdFx0cmVsYXRpdmVFbmQgPSBzaXplO1xuXHRcdH0gZWxzZSBpZiAoZW5kIDwgMCkge1xuXHRcdFx0cmVsYXRpdmVFbmQgPSBNYXRoLm1heChzaXplICsgZW5kLCAwKTtcblx0XHR9IGVsc2Uge1xuXHRcdFx0cmVsYXRpdmVFbmQgPSBNYXRoLm1pbihlbmQsIHNpemUpO1xuXHRcdH1cblx0XHRjb25zdCBzcGFuID0gTWF0aC5tYXgocmVsYXRpdmVFbmQgLSByZWxhdGl2ZVN0YXJ0LCAwKTtcblxuXHRcdGNvbnN0IGJ1ZmZlciA9IHRoaXNbQlVGRkVSXTtcblx0XHRjb25zdCBzbGljZWRCdWZmZXIgPSBidWZmZXIuc2xpY2UocmVsYXRpdmVTdGFydCwgcmVsYXRpdmVTdGFydCArIHNwYW4pO1xuXHRcdGNvbnN0IGJsb2IgPSBuZXcgQmxvYihbXSwgeyB0eXBlOiBhcmd1bWVudHNbMl0gfSk7XG5cdFx0YmxvYltCVUZGRVJdID0gc2xpY2VkQnVmZmVyO1xuXHRcdHJldHVybiBibG9iO1xuXHR9XG59XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0aWVzKEJsb2IucHJvdG90eXBlLCB7XG5cdHNpemU6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHR0eXBlOiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0c2xpY2U6IHsgZW51bWVyYWJsZTogdHJ1ZSB9XG59KTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KEJsb2IucHJvdG90eXBlLCBTeW1ib2wudG9TdHJpbmdUYWcsIHtcblx0dmFsdWU6ICdCbG9iJyxcblx0d3JpdGFibGU6IGZhbHNlLFxuXHRlbnVtZXJhYmxlOiBmYWxzZSxcblx0Y29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuLyoqXG4gKiBmZXRjaC1lcnJvci5qc1xuICpcbiAqIEZldGNoRXJyb3IgaW50ZXJmYWNlIGZvciBvcGVyYXRpb25hbCBlcnJvcnNcbiAqL1xuXG4vKipcbiAqIENyZWF0ZSBGZXRjaEVycm9yIGluc3RhbmNlXG4gKlxuICogQHBhcmFtICAgU3RyaW5nICAgICAgbWVzc2FnZSAgICAgIEVycm9yIG1lc3NhZ2UgZm9yIGh1bWFuXG4gKiBAcGFyYW0gICBTdHJpbmcgICAgICB0eXBlICAgICAgICAgRXJyb3IgdHlwZSBmb3IgbWFjaGluZVxuICogQHBhcmFtICAgU3RyaW5nICAgICAgc3lzdGVtRXJyb3IgIEZvciBOb2RlLmpzIHN5c3RlbSBlcnJvclxuICogQHJldHVybiAgRmV0Y2hFcnJvclxuICovXG5mdW5jdGlvbiBGZXRjaEVycm9yKG1lc3NhZ2UsIHR5cGUsIHN5c3RlbUVycm9yKSB7XG4gIEVycm9yLmNhbGwodGhpcywgbWVzc2FnZSk7XG5cbiAgdGhpcy5tZXNzYWdlID0gbWVzc2FnZTtcbiAgdGhpcy50eXBlID0gdHlwZTtcblxuICAvLyB3aGVuIGVyci50eXBlIGlzIGBzeXN0ZW1gLCBlcnIuY29kZSBjb250YWlucyBzeXN0ZW0gZXJyb3IgY29kZVxuICBpZiAoc3lzdGVtRXJyb3IpIHtcbiAgICB0aGlzLmNvZGUgPSB0aGlzLmVycm5vID0gc3lzdGVtRXJyb3IuY29kZTtcbiAgfVxuXG4gIC8vIGhpZGUgY3VzdG9tIGVycm9yIGltcGxlbWVudGF0aW9uIGRldGFpbHMgZnJvbSBlbmQtdXNlcnNcbiAgRXJyb3IuY2FwdHVyZVN0YWNrVHJhY2UodGhpcywgdGhpcy5jb25zdHJ1Y3Rvcik7XG59XG5cbkZldGNoRXJyb3IucHJvdG90eXBlID0gT2JqZWN0LmNyZWF0ZShFcnJvci5wcm90b3R5cGUpO1xuRmV0Y2hFcnJvci5wcm90b3R5cGUuY29uc3RydWN0b3IgPSBGZXRjaEVycm9yO1xuRmV0Y2hFcnJvci5wcm90b3R5cGUubmFtZSA9ICdGZXRjaEVycm9yJztcblxubGV0IGNvbnZlcnQ7XG50cnkge1xuXHRjb252ZXJ0ID0gcmVxdWlyZSgnZW5jb2RpbmcnKS5jb252ZXJ0O1xufSBjYXRjaCAoZSkge31cblxuY29uc3QgSU5URVJOQUxTID0gU3ltYm9sKCdCb2R5IGludGVybmFscycpO1xuXG4vLyBmaXggYW4gaXNzdWUgd2hlcmUgXCJQYXNzVGhyb3VnaFwiIGlzbid0IGEgbmFtZWQgZXhwb3J0IGZvciBub2RlIDwxMFxuY29uc3QgUGFzc1Rocm91Z2ggPSBTdHJlYW0uUGFzc1Rocm91Z2g7XG5cbi8qKlxuICogQm9keSBtaXhpblxuICpcbiAqIFJlZjogaHR0cHM6Ly9mZXRjaC5zcGVjLndoYXR3Zy5vcmcvI2JvZHlcbiAqXG4gKiBAcGFyYW0gICBTdHJlYW0gIGJvZHkgIFJlYWRhYmxlIHN0cmVhbVxuICogQHBhcmFtICAgT2JqZWN0ICBvcHRzICBSZXNwb25zZSBvcHRpb25zXG4gKiBAcmV0dXJuICBWb2lkXG4gKi9cbmZ1bmN0aW9uIEJvZHkoYm9keSkge1xuXHR2YXIgX3RoaXMgPSB0aGlzO1xuXG5cdHZhciBfcmVmID0gYXJndW1lbnRzLmxlbmd0aCA+IDEgJiYgYXJndW1lbnRzWzFdICE9PSB1bmRlZmluZWQgPyBhcmd1bWVudHNbMV0gOiB7fSxcblx0ICAgIF9yZWYkc2l6ZSA9IF9yZWYuc2l6ZTtcblxuXHRsZXQgc2l6ZSA9IF9yZWYkc2l6ZSA9PT0gdW5kZWZpbmVkID8gMCA6IF9yZWYkc2l6ZTtcblx0dmFyIF9yZWYkdGltZW91dCA9IF9yZWYudGltZW91dDtcblx0bGV0IHRpbWVvdXQgPSBfcmVmJHRpbWVvdXQgPT09IHVuZGVmaW5lZCA/IDAgOiBfcmVmJHRpbWVvdXQ7XG5cblx0aWYgKGJvZHkgPT0gbnVsbCkge1xuXHRcdC8vIGJvZHkgaXMgdW5kZWZpbmVkIG9yIG51bGxcblx0XHRib2R5ID0gbnVsbDtcblx0fSBlbHNlIGlmIChpc1VSTFNlYXJjaFBhcmFtcyhib2R5KSkge1xuXHRcdC8vIGJvZHkgaXMgYSBVUkxTZWFyY2hQYXJhbXNcblx0XHRib2R5ID0gQnVmZmVyLmZyb20oYm9keS50b1N0cmluZygpKTtcblx0fSBlbHNlIGlmIChpc0Jsb2IoYm9keSkpIDsgZWxzZSBpZiAoQnVmZmVyLmlzQnVmZmVyKGJvZHkpKSA7IGVsc2UgaWYgKE9iamVjdC5wcm90b3R5cGUudG9TdHJpbmcuY2FsbChib2R5KSA9PT0gJ1tvYmplY3QgQXJyYXlCdWZmZXJdJykge1xuXHRcdC8vIGJvZHkgaXMgQXJyYXlCdWZmZXJcblx0XHRib2R5ID0gQnVmZmVyLmZyb20oYm9keSk7XG5cdH0gZWxzZSBpZiAoQXJyYXlCdWZmZXIuaXNWaWV3KGJvZHkpKSB7XG5cdFx0Ly8gYm9keSBpcyBBcnJheUJ1ZmZlclZpZXdcblx0XHRib2R5ID0gQnVmZmVyLmZyb20oYm9keS5idWZmZXIsIGJvZHkuYnl0ZU9mZnNldCwgYm9keS5ieXRlTGVuZ3RoKTtcblx0fSBlbHNlIGlmIChib2R5IGluc3RhbmNlb2YgU3RyZWFtKSA7IGVsc2Uge1xuXHRcdC8vIG5vbmUgb2YgdGhlIGFib3ZlXG5cdFx0Ly8gY29lcmNlIHRvIHN0cmluZyB0aGVuIGJ1ZmZlclxuXHRcdGJvZHkgPSBCdWZmZXIuZnJvbShTdHJpbmcoYm9keSkpO1xuXHR9XG5cdHRoaXNbSU5URVJOQUxTXSA9IHtcblx0XHRib2R5LFxuXHRcdGRpc3R1cmJlZDogZmFsc2UsXG5cdFx0ZXJyb3I6IG51bGxcblx0fTtcblx0dGhpcy5zaXplID0gc2l6ZTtcblx0dGhpcy50aW1lb3V0ID0gdGltZW91dDtcblxuXHRpZiAoYm9keSBpbnN0YW5jZW9mIFN0cmVhbSkge1xuXHRcdGJvZHkub24oJ2Vycm9yJywgZnVuY3Rpb24gKGVycikge1xuXHRcdFx0Y29uc3QgZXJyb3IgPSBlcnIubmFtZSA9PT0gJ0Fib3J0RXJyb3InID8gZXJyIDogbmV3IEZldGNoRXJyb3IoYEludmFsaWQgcmVzcG9uc2UgYm9keSB3aGlsZSB0cnlpbmcgdG8gZmV0Y2ggJHtfdGhpcy51cmx9OiAke2Vyci5tZXNzYWdlfWAsICdzeXN0ZW0nLCBlcnIpO1xuXHRcdFx0X3RoaXNbSU5URVJOQUxTXS5lcnJvciA9IGVycm9yO1xuXHRcdH0pO1xuXHR9XG59XG5cbkJvZHkucHJvdG90eXBlID0ge1xuXHRnZXQgYm9keSgpIHtcblx0XHRyZXR1cm4gdGhpc1tJTlRFUk5BTFNdLmJvZHk7XG5cdH0sXG5cblx0Z2V0IGJvZHlVc2VkKCkge1xuXHRcdHJldHVybiB0aGlzW0lOVEVSTkFMU10uZGlzdHVyYmVkO1xuXHR9LFxuXG5cdC8qKlxuICAqIERlY29kZSByZXNwb25zZSBhcyBBcnJheUJ1ZmZlclxuICAqXG4gICogQHJldHVybiAgUHJvbWlzZVxuICAqL1xuXHRhcnJheUJ1ZmZlcigpIHtcblx0XHRyZXR1cm4gY29uc3VtZUJvZHkuY2FsbCh0aGlzKS50aGVuKGZ1bmN0aW9uIChidWYpIHtcblx0XHRcdHJldHVybiBidWYuYnVmZmVyLnNsaWNlKGJ1Zi5ieXRlT2Zmc2V0LCBidWYuYnl0ZU9mZnNldCArIGJ1Zi5ieXRlTGVuZ3RoKTtcblx0XHR9KTtcblx0fSxcblxuXHQvKipcbiAgKiBSZXR1cm4gcmF3IHJlc3BvbnNlIGFzIEJsb2JcbiAgKlxuICAqIEByZXR1cm4gUHJvbWlzZVxuICAqL1xuXHRibG9iKCkge1xuXHRcdGxldCBjdCA9IHRoaXMuaGVhZGVycyAmJiB0aGlzLmhlYWRlcnMuZ2V0KCdjb250ZW50LXR5cGUnKSB8fCAnJztcblx0XHRyZXR1cm4gY29uc3VtZUJvZHkuY2FsbCh0aGlzKS50aGVuKGZ1bmN0aW9uIChidWYpIHtcblx0XHRcdHJldHVybiBPYmplY3QuYXNzaWduKFxuXHRcdFx0Ly8gUHJldmVudCBjb3B5aW5nXG5cdFx0XHRuZXcgQmxvYihbXSwge1xuXHRcdFx0XHR0eXBlOiBjdC50b0xvd2VyQ2FzZSgpXG5cdFx0XHR9KSwge1xuXHRcdFx0XHRbQlVGRkVSXTogYnVmXG5cdFx0XHR9KTtcblx0XHR9KTtcblx0fSxcblxuXHQvKipcbiAgKiBEZWNvZGUgcmVzcG9uc2UgYXMganNvblxuICAqXG4gICogQHJldHVybiAgUHJvbWlzZVxuICAqL1xuXHRqc29uKCkge1xuXHRcdHZhciBfdGhpczIgPSB0aGlzO1xuXG5cdFx0cmV0dXJuIGNvbnN1bWVCb2R5LmNhbGwodGhpcykudGhlbihmdW5jdGlvbiAoYnVmZmVyKSB7XG5cdFx0XHR0cnkge1xuXHRcdFx0XHRyZXR1cm4gSlNPTi5wYXJzZShidWZmZXIudG9TdHJpbmcoKSk7XG5cdFx0XHR9IGNhdGNoIChlcnIpIHtcblx0XHRcdFx0cmV0dXJuIEJvZHkuUHJvbWlzZS5yZWplY3QobmV3IEZldGNoRXJyb3IoYGludmFsaWQganNvbiByZXNwb25zZSBib2R5IGF0ICR7X3RoaXMyLnVybH0gcmVhc29uOiAke2Vyci5tZXNzYWdlfWAsICdpbnZhbGlkLWpzb24nKSk7XG5cdFx0XHR9XG5cdFx0fSk7XG5cdH0sXG5cblx0LyoqXG4gICogRGVjb2RlIHJlc3BvbnNlIGFzIHRleHRcbiAgKlxuICAqIEByZXR1cm4gIFByb21pc2VcbiAgKi9cblx0dGV4dCgpIHtcblx0XHRyZXR1cm4gY29uc3VtZUJvZHkuY2FsbCh0aGlzKS50aGVuKGZ1bmN0aW9uIChidWZmZXIpIHtcblx0XHRcdHJldHVybiBidWZmZXIudG9TdHJpbmcoKTtcblx0XHR9KTtcblx0fSxcblxuXHQvKipcbiAgKiBEZWNvZGUgcmVzcG9uc2UgYXMgYnVmZmVyIChub24tc3BlYyBhcGkpXG4gICpcbiAgKiBAcmV0dXJuICBQcm9taXNlXG4gICovXG5cdGJ1ZmZlcigpIHtcblx0XHRyZXR1cm4gY29uc3VtZUJvZHkuY2FsbCh0aGlzKTtcblx0fSxcblxuXHQvKipcbiAgKiBEZWNvZGUgcmVzcG9uc2UgYXMgdGV4dCwgd2hpbGUgYXV0b21hdGljYWxseSBkZXRlY3RpbmcgdGhlIGVuY29kaW5nIGFuZFxuICAqIHRyeWluZyB0byBkZWNvZGUgdG8gVVRGLTggKG5vbi1zcGVjIGFwaSlcbiAgKlxuICAqIEByZXR1cm4gIFByb21pc2VcbiAgKi9cblx0dGV4dENvbnZlcnRlZCgpIHtcblx0XHR2YXIgX3RoaXMzID0gdGhpcztcblxuXHRcdHJldHVybiBjb25zdW1lQm9keS5jYWxsKHRoaXMpLnRoZW4oZnVuY3Rpb24gKGJ1ZmZlcikge1xuXHRcdFx0cmV0dXJuIGNvbnZlcnRCb2R5KGJ1ZmZlciwgX3RoaXMzLmhlYWRlcnMpO1xuXHRcdH0pO1xuXHR9XG59O1xuXG4vLyBJbiBicm93c2VycywgYWxsIHByb3BlcnRpZXMgYXJlIGVudW1lcmFibGUuXG5PYmplY3QuZGVmaW5lUHJvcGVydGllcyhCb2R5LnByb3RvdHlwZSwge1xuXHRib2R5OiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0Ym9keVVzZWQ6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRhcnJheUJ1ZmZlcjogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGJsb2I6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRqc29uOiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0dGV4dDogeyBlbnVtZXJhYmxlOiB0cnVlIH1cbn0pO1xuXG5Cb2R5Lm1peEluID0gZnVuY3Rpb24gKHByb3RvKSB7XG5cdGZvciAoY29uc3QgbmFtZSBvZiBPYmplY3QuZ2V0T3duUHJvcGVydHlOYW1lcyhCb2R5LnByb3RvdHlwZSkpIHtcblx0XHQvLyBpc3RhbmJ1bCBpZ25vcmUgZWxzZTogZnV0dXJlIHByb29mXG5cdFx0aWYgKCEobmFtZSBpbiBwcm90bykpIHtcblx0XHRcdGNvbnN0IGRlc2MgPSBPYmplY3QuZ2V0T3duUHJvcGVydHlEZXNjcmlwdG9yKEJvZHkucHJvdG90eXBlLCBuYW1lKTtcblx0XHRcdE9iamVjdC5kZWZpbmVQcm9wZXJ0eShwcm90bywgbmFtZSwgZGVzYyk7XG5cdFx0fVxuXHR9XG59O1xuXG4vKipcbiAqIENvbnN1bWUgYW5kIGNvbnZlcnQgYW4gZW50aXJlIEJvZHkgdG8gYSBCdWZmZXIuXG4gKlxuICogUmVmOiBodHRwczovL2ZldGNoLnNwZWMud2hhdHdnLm9yZy8jY29uY2VwdC1ib2R5LWNvbnN1bWUtYm9keVxuICpcbiAqIEByZXR1cm4gIFByb21pc2VcbiAqL1xuZnVuY3Rpb24gY29uc3VtZUJvZHkoKSB7XG5cdHZhciBfdGhpczQgPSB0aGlzO1xuXG5cdGlmICh0aGlzW0lOVEVSTkFMU10uZGlzdHVyYmVkKSB7XG5cdFx0cmV0dXJuIEJvZHkuUHJvbWlzZS5yZWplY3QobmV3IFR5cGVFcnJvcihgYm9keSB1c2VkIGFscmVhZHkgZm9yOiAke3RoaXMudXJsfWApKTtcblx0fVxuXG5cdHRoaXNbSU5URVJOQUxTXS5kaXN0dXJiZWQgPSB0cnVlO1xuXG5cdGlmICh0aGlzW0lOVEVSTkFMU10uZXJyb3IpIHtcblx0XHRyZXR1cm4gQm9keS5Qcm9taXNlLnJlamVjdCh0aGlzW0lOVEVSTkFMU10uZXJyb3IpO1xuXHR9XG5cblx0bGV0IGJvZHkgPSB0aGlzLmJvZHk7XG5cblx0Ly8gYm9keSBpcyBudWxsXG5cdGlmIChib2R5ID09PSBudWxsKSB7XG5cdFx0cmV0dXJuIEJvZHkuUHJvbWlzZS5yZXNvbHZlKEJ1ZmZlci5hbGxvYygwKSk7XG5cdH1cblxuXHQvLyBib2R5IGlzIGJsb2Jcblx0aWYgKGlzQmxvYihib2R5KSkge1xuXHRcdGJvZHkgPSBib2R5LnN0cmVhbSgpO1xuXHR9XG5cblx0Ly8gYm9keSBpcyBidWZmZXJcblx0aWYgKEJ1ZmZlci5pc0J1ZmZlcihib2R5KSkge1xuXHRcdHJldHVybiBCb2R5LlByb21pc2UucmVzb2x2ZShib2R5KTtcblx0fVxuXG5cdC8vIGlzdGFuYnVsIGlnbm9yZSBpZjogc2hvdWxkIG5ldmVyIGhhcHBlblxuXHRpZiAoIShib2R5IGluc3RhbmNlb2YgU3RyZWFtKSkge1xuXHRcdHJldHVybiBCb2R5LlByb21pc2UucmVzb2x2ZShCdWZmZXIuYWxsb2MoMCkpO1xuXHR9XG5cblx0Ly8gYm9keSBpcyBzdHJlYW1cblx0Ly8gZ2V0IHJlYWR5IHRvIGFjdHVhbGx5IGNvbnN1bWUgdGhlIGJvZHlcblx0bGV0IGFjY3VtID0gW107XG5cdGxldCBhY2N1bUJ5dGVzID0gMDtcblx0bGV0IGFib3J0ID0gZmFsc2U7XG5cblx0cmV0dXJuIG5ldyBCb2R5LlByb21pc2UoZnVuY3Rpb24gKHJlc29sdmUsIHJlamVjdCkge1xuXHRcdGxldCByZXNUaW1lb3V0O1xuXG5cdFx0Ly8gYWxsb3cgdGltZW91dCBvbiBzbG93IHJlc3BvbnNlIGJvZHlcblx0XHRpZiAoX3RoaXM0LnRpbWVvdXQpIHtcblx0XHRcdHJlc1RpbWVvdXQgPSBzZXRUaW1lb3V0KGZ1bmN0aW9uICgpIHtcblx0XHRcdFx0YWJvcnQgPSB0cnVlO1xuXHRcdFx0XHRyZWplY3QobmV3IEZldGNoRXJyb3IoYFJlc3BvbnNlIHRpbWVvdXQgd2hpbGUgdHJ5aW5nIHRvIGZldGNoICR7X3RoaXM0LnVybH0gKG92ZXIgJHtfdGhpczQudGltZW91dH1tcylgLCAnYm9keS10aW1lb3V0JykpO1xuXHRcdFx0fSwgX3RoaXM0LnRpbWVvdXQpO1xuXHRcdH1cblxuXHRcdC8vIGhhbmRsZSBzdHJlYW0gZXJyb3JzXG5cdFx0Ym9keS5vbignZXJyb3InLCBmdW5jdGlvbiAoZXJyKSB7XG5cdFx0XHRpZiAoZXJyLm5hbWUgPT09ICdBYm9ydEVycm9yJykge1xuXHRcdFx0XHQvLyBpZiB0aGUgcmVxdWVzdCB3YXMgYWJvcnRlZCwgcmVqZWN0IHdpdGggdGhpcyBFcnJvclxuXHRcdFx0XHRhYm9ydCA9IHRydWU7XG5cdFx0XHRcdHJlamVjdChlcnIpO1xuXHRcdFx0fSBlbHNlIHtcblx0XHRcdFx0Ly8gb3RoZXIgZXJyb3JzLCBzdWNoIGFzIGluY29ycmVjdCBjb250ZW50LWVuY29kaW5nXG5cdFx0XHRcdHJlamVjdChuZXcgRmV0Y2hFcnJvcihgSW52YWxpZCByZXNwb25zZSBib2R5IHdoaWxlIHRyeWluZyB0byBmZXRjaCAke190aGlzNC51cmx9OiAke2Vyci5tZXNzYWdlfWAsICdzeXN0ZW0nLCBlcnIpKTtcblx0XHRcdH1cblx0XHR9KTtcblxuXHRcdGJvZHkub24oJ2RhdGEnLCBmdW5jdGlvbiAoY2h1bmspIHtcblx0XHRcdGlmIChhYm9ydCB8fCBjaHVuayA9PT0gbnVsbCkge1xuXHRcdFx0XHRyZXR1cm47XG5cdFx0XHR9XG5cblx0XHRcdGlmIChfdGhpczQuc2l6ZSAmJiBhY2N1bUJ5dGVzICsgY2h1bmsubGVuZ3RoID4gX3RoaXM0LnNpemUpIHtcblx0XHRcdFx0YWJvcnQgPSB0cnVlO1xuXHRcdFx0XHRyZWplY3QobmV3IEZldGNoRXJyb3IoYGNvbnRlbnQgc2l6ZSBhdCAke190aGlzNC51cmx9IG92ZXIgbGltaXQ6ICR7X3RoaXM0LnNpemV9YCwgJ21heC1zaXplJykpO1xuXHRcdFx0XHRyZXR1cm47XG5cdFx0XHR9XG5cblx0XHRcdGFjY3VtQnl0ZXMgKz0gY2h1bmsubGVuZ3RoO1xuXHRcdFx0YWNjdW0ucHVzaChjaHVuayk7XG5cdFx0fSk7XG5cblx0XHRib2R5Lm9uKCdlbmQnLCBmdW5jdGlvbiAoKSB7XG5cdFx0XHRpZiAoYWJvcnQpIHtcblx0XHRcdFx0cmV0dXJuO1xuXHRcdFx0fVxuXG5cdFx0XHRjbGVhclRpbWVvdXQocmVzVGltZW91dCk7XG5cblx0XHRcdHRyeSB7XG5cdFx0XHRcdHJlc29sdmUoQnVmZmVyLmNvbmNhdChhY2N1bSwgYWNjdW1CeXRlcykpO1xuXHRcdFx0fSBjYXRjaCAoZXJyKSB7XG5cdFx0XHRcdC8vIGhhbmRsZSBzdHJlYW1zIHRoYXQgaGF2ZSBhY2N1bXVsYXRlZCB0b28gbXVjaCBkYXRhIChpc3N1ZSAjNDE0KVxuXHRcdFx0XHRyZWplY3QobmV3IEZldGNoRXJyb3IoYENvdWxkIG5vdCBjcmVhdGUgQnVmZmVyIGZyb20gcmVzcG9uc2UgYm9keSBmb3IgJHtfdGhpczQudXJsfTogJHtlcnIubWVzc2FnZX1gLCAnc3lzdGVtJywgZXJyKSk7XG5cdFx0XHR9XG5cdFx0fSk7XG5cdH0pO1xufVxuXG4vKipcbiAqIERldGVjdCBidWZmZXIgZW5jb2RpbmcgYW5kIGNvbnZlcnQgdG8gdGFyZ2V0IGVuY29kaW5nXG4gKiByZWY6IGh0dHA6Ly93d3cudzMub3JnL1RSLzIwMTEvV0QtaHRtbDUtMjAxMTAxMTMvcGFyc2luZy5odG1sI2RldGVybWluaW5nLXRoZS1jaGFyYWN0ZXItZW5jb2RpbmdcbiAqXG4gKiBAcGFyYW0gICBCdWZmZXIgIGJ1ZmZlciAgICBJbmNvbWluZyBidWZmZXJcbiAqIEBwYXJhbSAgIFN0cmluZyAgZW5jb2RpbmcgIFRhcmdldCBlbmNvZGluZ1xuICogQHJldHVybiAgU3RyaW5nXG4gKi9cbmZ1bmN0aW9uIGNvbnZlcnRCb2R5KGJ1ZmZlciwgaGVhZGVycykge1xuXHRpZiAodHlwZW9mIGNvbnZlcnQgIT09ICdmdW5jdGlvbicpIHtcblx0XHR0aHJvdyBuZXcgRXJyb3IoJ1RoZSBwYWNrYWdlIGBlbmNvZGluZ2AgbXVzdCBiZSBpbnN0YWxsZWQgdG8gdXNlIHRoZSB0ZXh0Q29udmVydGVkKCkgZnVuY3Rpb24nKTtcblx0fVxuXG5cdGNvbnN0IGN0ID0gaGVhZGVycy5nZXQoJ2NvbnRlbnQtdHlwZScpO1xuXHRsZXQgY2hhcnNldCA9ICd1dGYtOCc7XG5cdGxldCByZXMsIHN0cjtcblxuXHQvLyBoZWFkZXJcblx0aWYgKGN0KSB7XG5cdFx0cmVzID0gL2NoYXJzZXQ9KFteO10qKS9pLmV4ZWMoY3QpO1xuXHR9XG5cblx0Ly8gbm8gY2hhcnNldCBpbiBjb250ZW50IHR5cGUsIHBlZWsgYXQgcmVzcG9uc2UgYm9keSBmb3IgYXQgbW9zdCAxMDI0IGJ5dGVzXG5cdHN0ciA9IGJ1ZmZlci5zbGljZSgwLCAxMDI0KS50b1N0cmluZygpO1xuXG5cdC8vIGh0bWw1XG5cdGlmICghcmVzICYmIHN0cikge1xuXHRcdHJlcyA9IC88bWV0YS4rP2NoYXJzZXQ9KFsnXCJdKSguKz8pXFwxL2kuZXhlYyhzdHIpO1xuXHR9XG5cblx0Ly8gaHRtbDRcblx0aWYgKCFyZXMgJiYgc3RyKSB7XG5cdFx0cmVzID0gLzxtZXRhW1xcc10rP2h0dHAtZXF1aXY9KFsnXCJdKWNvbnRlbnQtdHlwZVxcMVtcXHNdKz9jb250ZW50PShbJ1wiXSkoLis/KVxcMi9pLmV4ZWMoc3RyKTtcblx0XHRpZiAoIXJlcykge1xuXHRcdFx0cmVzID0gLzxtZXRhW1xcc10rP2NvbnRlbnQ9KFsnXCJdKSguKz8pXFwxW1xcc10rP2h0dHAtZXF1aXY9KFsnXCJdKWNvbnRlbnQtdHlwZVxcMy9pLmV4ZWMoc3RyKTtcblx0XHRcdGlmIChyZXMpIHtcblx0XHRcdFx0cmVzLnBvcCgpOyAvLyBkcm9wIGxhc3QgcXVvdGVcblx0XHRcdH1cblx0XHR9XG5cblx0XHRpZiAocmVzKSB7XG5cdFx0XHRyZXMgPSAvY2hhcnNldD0oLiopL2kuZXhlYyhyZXMucG9wKCkpO1xuXHRcdH1cblx0fVxuXG5cdC8vIHhtbFxuXHRpZiAoIXJlcyAmJiBzdHIpIHtcblx0XHRyZXMgPSAvPFxcP3htbC4rP2VuY29kaW5nPShbJ1wiXSkoLis/KVxcMS9pLmV4ZWMoc3RyKTtcblx0fVxuXG5cdC8vIGZvdW5kIGNoYXJzZXRcblx0aWYgKHJlcykge1xuXHRcdGNoYXJzZXQgPSByZXMucG9wKCk7XG5cblx0XHQvLyBwcmV2ZW50IGRlY29kZSBpc3N1ZXMgd2hlbiBzaXRlcyB1c2UgaW5jb3JyZWN0IGVuY29kaW5nXG5cdFx0Ly8gcmVmOiBodHRwczovL2hzaXZvbmVuLmZpL2VuY29kaW5nLW1lbnUvXG5cdFx0aWYgKGNoYXJzZXQgPT09ICdnYjIzMTInIHx8IGNoYXJzZXQgPT09ICdnYmsnKSB7XG5cdFx0XHRjaGFyc2V0ID0gJ2diMTgwMzAnO1xuXHRcdH1cblx0fVxuXG5cdC8vIHR1cm4gcmF3IGJ1ZmZlcnMgaW50byBhIHNpbmdsZSB1dGYtOCBidWZmZXJcblx0cmV0dXJuIGNvbnZlcnQoYnVmZmVyLCAnVVRGLTgnLCBjaGFyc2V0KS50b1N0cmluZygpO1xufVxuXG4vKipcbiAqIERldGVjdCBhIFVSTFNlYXJjaFBhcmFtcyBvYmplY3RcbiAqIHJlZjogaHR0cHM6Ly9naXRodWIuY29tL2JpdGlubi9ub2RlLWZldGNoL2lzc3Vlcy8yOTYjaXNzdWVjb21tZW50LTMwNzU5ODE0M1xuICpcbiAqIEBwYXJhbSAgIE9iamVjdCAgb2JqICAgICBPYmplY3QgdG8gZGV0ZWN0IGJ5IHR5cGUgb3IgYnJhbmRcbiAqIEByZXR1cm4gIFN0cmluZ1xuICovXG5mdW5jdGlvbiBpc1VSTFNlYXJjaFBhcmFtcyhvYmopIHtcblx0Ly8gRHVjay10eXBpbmcgYXMgYSBuZWNlc3NhcnkgY29uZGl0aW9uLlxuXHRpZiAodHlwZW9mIG9iaiAhPT0gJ29iamVjdCcgfHwgdHlwZW9mIG9iai5hcHBlbmQgIT09ICdmdW5jdGlvbicgfHwgdHlwZW9mIG9iai5kZWxldGUgIT09ICdmdW5jdGlvbicgfHwgdHlwZW9mIG9iai5nZXQgIT09ICdmdW5jdGlvbicgfHwgdHlwZW9mIG9iai5nZXRBbGwgIT09ICdmdW5jdGlvbicgfHwgdHlwZW9mIG9iai5oYXMgIT09ICdmdW5jdGlvbicgfHwgdHlwZW9mIG9iai5zZXQgIT09ICdmdW5jdGlvbicpIHtcblx0XHRyZXR1cm4gZmFsc2U7XG5cdH1cblxuXHQvLyBCcmFuZC1jaGVja2luZyBhbmQgbW9yZSBkdWNrLXR5cGluZyBhcyBvcHRpb25hbCBjb25kaXRpb24uXG5cdHJldHVybiBvYmouY29uc3RydWN0b3IubmFtZSA9PT0gJ1VSTFNlYXJjaFBhcmFtcycgfHwgT2JqZWN0LnByb3RvdHlwZS50b1N0cmluZy5jYWxsKG9iaikgPT09ICdbb2JqZWN0IFVSTFNlYXJjaFBhcmFtc10nIHx8IHR5cGVvZiBvYmouc29ydCA9PT0gJ2Z1bmN0aW9uJztcbn1cblxuLyoqXG4gKiBDaGVjayBpZiBgb2JqYCBpcyBhIFczQyBgQmxvYmAgb2JqZWN0ICh3aGljaCBgRmlsZWAgaW5oZXJpdHMgZnJvbSlcbiAqIEBwYXJhbSAgeyp9IG9ialxuICogQHJldHVybiB7Ym9vbGVhbn1cbiAqL1xuZnVuY3Rpb24gaXNCbG9iKG9iaikge1xuXHRyZXR1cm4gdHlwZW9mIG9iaiA9PT0gJ29iamVjdCcgJiYgdHlwZW9mIG9iai5hcnJheUJ1ZmZlciA9PT0gJ2Z1bmN0aW9uJyAmJiB0eXBlb2Ygb2JqLnR5cGUgPT09ICdzdHJpbmcnICYmIHR5cGVvZiBvYmouc3RyZWFtID09PSAnZnVuY3Rpb24nICYmIHR5cGVvZiBvYmouY29uc3RydWN0b3IgPT09ICdmdW5jdGlvbicgJiYgdHlwZW9mIG9iai5jb25zdHJ1Y3Rvci5uYW1lID09PSAnc3RyaW5nJyAmJiAvXihCbG9ifEZpbGUpJC8udGVzdChvYmouY29uc3RydWN0b3IubmFtZSkgJiYgL14oQmxvYnxGaWxlKSQvLnRlc3Qob2JqW1N5bWJvbC50b1N0cmluZ1RhZ10pO1xufVxuXG4vKipcbiAqIENsb25lIGJvZHkgZ2l2ZW4gUmVzL1JlcSBpbnN0YW5jZVxuICpcbiAqIEBwYXJhbSAgIE1peGVkICBpbnN0YW5jZSAgUmVzcG9uc2Ugb3IgUmVxdWVzdCBpbnN0YW5jZVxuICogQHJldHVybiAgTWl4ZWRcbiAqL1xuZnVuY3Rpb24gY2xvbmUoaW5zdGFuY2UpIHtcblx0bGV0IHAxLCBwMjtcblx0bGV0IGJvZHkgPSBpbnN0YW5jZS5ib2R5O1xuXG5cdC8vIGRvbid0IGFsbG93IGNsb25pbmcgYSB1c2VkIGJvZHlcblx0aWYgKGluc3RhbmNlLmJvZHlVc2VkKSB7XG5cdFx0dGhyb3cgbmV3IEVycm9yKCdjYW5ub3QgY2xvbmUgYm9keSBhZnRlciBpdCBpcyB1c2VkJyk7XG5cdH1cblxuXHQvLyBjaGVjayB0aGF0IGJvZHkgaXMgYSBzdHJlYW0gYW5kIG5vdCBmb3JtLWRhdGEgb2JqZWN0XG5cdC8vIG5vdGU6IHdlIGNhbid0IGNsb25lIHRoZSBmb3JtLWRhdGEgb2JqZWN0IHdpdGhvdXQgaGF2aW5nIGl0IGFzIGEgZGVwZW5kZW5jeVxuXHRpZiAoYm9keSBpbnN0YW5jZW9mIFN0cmVhbSAmJiB0eXBlb2YgYm9keS5nZXRCb3VuZGFyeSAhPT0gJ2Z1bmN0aW9uJykge1xuXHRcdC8vIHRlZSBpbnN0YW5jZSBib2R5XG5cdFx0cDEgPSBuZXcgUGFzc1Rocm91Z2goKTtcblx0XHRwMiA9IG5ldyBQYXNzVGhyb3VnaCgpO1xuXHRcdGJvZHkucGlwZShwMSk7XG5cdFx0Ym9keS5waXBlKHAyKTtcblx0XHQvLyBzZXQgaW5zdGFuY2UgYm9keSB0byB0ZWVkIGJvZHkgYW5kIHJldHVybiB0aGUgb3RoZXIgdGVlZCBib2R5XG5cdFx0aW5zdGFuY2VbSU5URVJOQUxTXS5ib2R5ID0gcDE7XG5cdFx0Ym9keSA9IHAyO1xuXHR9XG5cblx0cmV0dXJuIGJvZHk7XG59XG5cbi8qKlxuICogUGVyZm9ybXMgdGhlIG9wZXJhdGlvbiBcImV4dHJhY3QgYSBgQ29udGVudC1UeXBlYCB2YWx1ZSBmcm9tIHxvYmplY3R8XCIgYXNcbiAqIHNwZWNpZmllZCBpbiB0aGUgc3BlY2lmaWNhdGlvbjpcbiAqIGh0dHBzOi8vZmV0Y2guc3BlYy53aGF0d2cub3JnLyNjb25jZXB0LWJvZHlpbml0LWV4dHJhY3RcbiAqXG4gKiBUaGlzIGZ1bmN0aW9uIGFzc3VtZXMgdGhhdCBpbnN0YW5jZS5ib2R5IGlzIHByZXNlbnQuXG4gKlxuICogQHBhcmFtICAgTWl4ZWQgIGluc3RhbmNlICBBbnkgb3B0aW9ucy5ib2R5IGlucHV0XG4gKi9cbmZ1bmN0aW9uIGV4dHJhY3RDb250ZW50VHlwZShib2R5KSB7XG5cdGlmIChib2R5ID09PSBudWxsKSB7XG5cdFx0Ly8gYm9keSBpcyBudWxsXG5cdFx0cmV0dXJuIG51bGw7XG5cdH0gZWxzZSBpZiAodHlwZW9mIGJvZHkgPT09ICdzdHJpbmcnKSB7XG5cdFx0Ly8gYm9keSBpcyBzdHJpbmdcblx0XHRyZXR1cm4gJ3RleHQvcGxhaW47Y2hhcnNldD1VVEYtOCc7XG5cdH0gZWxzZSBpZiAoaXNVUkxTZWFyY2hQYXJhbXMoYm9keSkpIHtcblx0XHQvLyBib2R5IGlzIGEgVVJMU2VhcmNoUGFyYW1zXG5cdFx0cmV0dXJuICdhcHBsaWNhdGlvbi94LXd3dy1mb3JtLXVybGVuY29kZWQ7Y2hhcnNldD1VVEYtOCc7XG5cdH0gZWxzZSBpZiAoaXNCbG9iKGJvZHkpKSB7XG5cdFx0Ly8gYm9keSBpcyBibG9iXG5cdFx0cmV0dXJuIGJvZHkudHlwZSB8fCBudWxsO1xuXHR9IGVsc2UgaWYgKEJ1ZmZlci5pc0J1ZmZlcihib2R5KSkge1xuXHRcdC8vIGJvZHkgaXMgYnVmZmVyXG5cdFx0cmV0dXJuIG51bGw7XG5cdH0gZWxzZSBpZiAoT2JqZWN0LnByb3RvdHlwZS50b1N0cmluZy5jYWxsKGJvZHkpID09PSAnW29iamVjdCBBcnJheUJ1ZmZlcl0nKSB7XG5cdFx0Ly8gYm9keSBpcyBBcnJheUJ1ZmZlclxuXHRcdHJldHVybiBudWxsO1xuXHR9IGVsc2UgaWYgKEFycmF5QnVmZmVyLmlzVmlldyhib2R5KSkge1xuXHRcdC8vIGJvZHkgaXMgQXJyYXlCdWZmZXJWaWV3XG5cdFx0cmV0dXJuIG51bGw7XG5cdH0gZWxzZSBpZiAodHlwZW9mIGJvZHkuZ2V0Qm91bmRhcnkgPT09ICdmdW5jdGlvbicpIHtcblx0XHQvLyBkZXRlY3QgZm9ybSBkYXRhIGlucHV0IGZyb20gZm9ybS1kYXRhIG1vZHVsZVxuXHRcdHJldHVybiBgbXVsdGlwYXJ0L2Zvcm0tZGF0YTtib3VuZGFyeT0ke2JvZHkuZ2V0Qm91bmRhcnkoKX1gO1xuXHR9IGVsc2UgaWYgKGJvZHkgaW5zdGFuY2VvZiBTdHJlYW0pIHtcblx0XHQvLyBib2R5IGlzIHN0cmVhbVxuXHRcdC8vIGNhbid0IHJlYWxseSBkbyBtdWNoIGFib3V0IHRoaXNcblx0XHRyZXR1cm4gbnVsbDtcblx0fSBlbHNlIHtcblx0XHQvLyBCb2R5IGNvbnN0cnVjdG9yIGRlZmF1bHRzIG90aGVyIHRoaW5ncyB0byBzdHJpbmdcblx0XHRyZXR1cm4gJ3RleHQvcGxhaW47Y2hhcnNldD1VVEYtOCc7XG5cdH1cbn1cblxuLyoqXG4gKiBUaGUgRmV0Y2ggU3RhbmRhcmQgdHJlYXRzIHRoaXMgYXMgaWYgXCJ0b3RhbCBieXRlc1wiIGlzIGEgcHJvcGVydHkgb24gdGhlIGJvZHkuXG4gKiBGb3IgdXMsIHdlIGhhdmUgdG8gZXhwbGljaXRseSBnZXQgaXQgd2l0aCBhIGZ1bmN0aW9uLlxuICpcbiAqIHJlZjogaHR0cHM6Ly9mZXRjaC5zcGVjLndoYXR3Zy5vcmcvI2NvbmNlcHQtYm9keS10b3RhbC1ieXRlc1xuICpcbiAqIEBwYXJhbSAgIEJvZHkgICAgaW5zdGFuY2UgICBJbnN0YW5jZSBvZiBCb2R5XG4gKiBAcmV0dXJuICBOdW1iZXI/ICAgICAgICAgICAgTnVtYmVyIG9mIGJ5dGVzLCBvciBudWxsIGlmIG5vdCBwb3NzaWJsZVxuICovXG5mdW5jdGlvbiBnZXRUb3RhbEJ5dGVzKGluc3RhbmNlKSB7XG5cdGNvbnN0IGJvZHkgPSBpbnN0YW5jZS5ib2R5O1xuXG5cblx0aWYgKGJvZHkgPT09IG51bGwpIHtcblx0XHQvLyBib2R5IGlzIG51bGxcblx0XHRyZXR1cm4gMDtcblx0fSBlbHNlIGlmIChpc0Jsb2IoYm9keSkpIHtcblx0XHRyZXR1cm4gYm9keS5zaXplO1xuXHR9IGVsc2UgaWYgKEJ1ZmZlci5pc0J1ZmZlcihib2R5KSkge1xuXHRcdC8vIGJvZHkgaXMgYnVmZmVyXG5cdFx0cmV0dXJuIGJvZHkubGVuZ3RoO1xuXHR9IGVsc2UgaWYgKGJvZHkgJiYgdHlwZW9mIGJvZHkuZ2V0TGVuZ3RoU3luYyA9PT0gJ2Z1bmN0aW9uJykge1xuXHRcdC8vIGRldGVjdCBmb3JtIGRhdGEgaW5wdXQgZnJvbSBmb3JtLWRhdGEgbW9kdWxlXG5cdFx0aWYgKGJvZHkuX2xlbmd0aFJldHJpZXZlcnMgJiYgYm9keS5fbGVuZ3RoUmV0cmlldmVycy5sZW5ndGggPT0gMCB8fCAvLyAxLnhcblx0XHRib2R5Lmhhc0tub3duTGVuZ3RoICYmIGJvZHkuaGFzS25vd25MZW5ndGgoKSkge1xuXHRcdFx0Ly8gMi54XG5cdFx0XHRyZXR1cm4gYm9keS5nZXRMZW5ndGhTeW5jKCk7XG5cdFx0fVxuXHRcdHJldHVybiBudWxsO1xuXHR9IGVsc2Uge1xuXHRcdC8vIGJvZHkgaXMgc3RyZWFtXG5cdFx0cmV0dXJuIG51bGw7XG5cdH1cbn1cblxuLyoqXG4gKiBXcml0ZSBhIEJvZHkgdG8gYSBOb2RlLmpzIFdyaXRhYmxlU3RyZWFtIChlLmcuIGh0dHAuUmVxdWVzdCkgb2JqZWN0LlxuICpcbiAqIEBwYXJhbSAgIEJvZHkgICAgaW5zdGFuY2UgICBJbnN0YW5jZSBvZiBCb2R5XG4gKiBAcmV0dXJuICBWb2lkXG4gKi9cbmZ1bmN0aW9uIHdyaXRlVG9TdHJlYW0oZGVzdCwgaW5zdGFuY2UpIHtcblx0Y29uc3QgYm9keSA9IGluc3RhbmNlLmJvZHk7XG5cblxuXHRpZiAoYm9keSA9PT0gbnVsbCkge1xuXHRcdC8vIGJvZHkgaXMgbnVsbFxuXHRcdGRlc3QuZW5kKCk7XG5cdH0gZWxzZSBpZiAoaXNCbG9iKGJvZHkpKSB7XG5cdFx0Ym9keS5zdHJlYW0oKS5waXBlKGRlc3QpO1xuXHR9IGVsc2UgaWYgKEJ1ZmZlci5pc0J1ZmZlcihib2R5KSkge1xuXHRcdC8vIGJvZHkgaXMgYnVmZmVyXG5cdFx0ZGVzdC53cml0ZShib2R5KTtcblx0XHRkZXN0LmVuZCgpO1xuXHR9IGVsc2Uge1xuXHRcdC8vIGJvZHkgaXMgc3RyZWFtXG5cdFx0Ym9keS5waXBlKGRlc3QpO1xuXHR9XG59XG5cbi8vIGV4cG9zZSBQcm9taXNlXG5Cb2R5LlByb21pc2UgPSBnbG9iYWwuUHJvbWlzZTtcblxuLyoqXG4gKiBoZWFkZXJzLmpzXG4gKlxuICogSGVhZGVycyBjbGFzcyBvZmZlcnMgY29udmVuaWVudCBoZWxwZXJzXG4gKi9cblxuY29uc3QgaW52YWxpZFRva2VuUmVnZXggPSAvW15cXF5fYGEtekEtWlxcLTAtOSEjJCUmJyorLnx+XS87XG5jb25zdCBpbnZhbGlkSGVhZGVyQ2hhclJlZ2V4ID0gL1teXFx0XFx4MjAtXFx4N2VcXHg4MC1cXHhmZl0vO1xuXG5mdW5jdGlvbiB2YWxpZGF0ZU5hbWUobmFtZSkge1xuXHRuYW1lID0gYCR7bmFtZX1gO1xuXHRpZiAoaW52YWxpZFRva2VuUmVnZXgudGVzdChuYW1lKSB8fCBuYW1lID09PSAnJykge1xuXHRcdHRocm93IG5ldyBUeXBlRXJyb3IoYCR7bmFtZX0gaXMgbm90IGEgbGVnYWwgSFRUUCBoZWFkZXIgbmFtZWApO1xuXHR9XG59XG5cbmZ1bmN0aW9uIHZhbGlkYXRlVmFsdWUodmFsdWUpIHtcblx0dmFsdWUgPSBgJHt2YWx1ZX1gO1xuXHRpZiAoaW52YWxpZEhlYWRlckNoYXJSZWdleC50ZXN0KHZhbHVlKSkge1xuXHRcdHRocm93IG5ldyBUeXBlRXJyb3IoYCR7dmFsdWV9IGlzIG5vdCBhIGxlZ2FsIEhUVFAgaGVhZGVyIHZhbHVlYCk7XG5cdH1cbn1cblxuLyoqXG4gKiBGaW5kIHRoZSBrZXkgaW4gdGhlIG1hcCBvYmplY3QgZ2l2ZW4gYSBoZWFkZXIgbmFtZS5cbiAqXG4gKiBSZXR1cm5zIHVuZGVmaW5lZCBpZiBub3QgZm91bmQuXG4gKlxuICogQHBhcmFtICAgU3RyaW5nICBuYW1lICBIZWFkZXIgbmFtZVxuICogQHJldHVybiAgU3RyaW5nfFVuZGVmaW5lZFxuICovXG5mdW5jdGlvbiBmaW5kKG1hcCwgbmFtZSkge1xuXHRuYW1lID0gbmFtZS50b0xvd2VyQ2FzZSgpO1xuXHRmb3IgKGNvbnN0IGtleSBpbiBtYXApIHtcblx0XHRpZiAoa2V5LnRvTG93ZXJDYXNlKCkgPT09IG5hbWUpIHtcblx0XHRcdHJldHVybiBrZXk7XG5cdFx0fVxuXHR9XG5cdHJldHVybiB1bmRlZmluZWQ7XG59XG5cbmNvbnN0IE1BUCA9IFN5bWJvbCgnbWFwJyk7XG5jbGFzcyBIZWFkZXJzIHtcblx0LyoqXG4gICogSGVhZGVycyBjbGFzc1xuICAqXG4gICogQHBhcmFtICAgT2JqZWN0ICBoZWFkZXJzICBSZXNwb25zZSBoZWFkZXJzXG4gICogQHJldHVybiAgVm9pZFxuICAqL1xuXHRjb25zdHJ1Y3RvcigpIHtcblx0XHRsZXQgaW5pdCA9IGFyZ3VtZW50cy5sZW5ndGggPiAwICYmIGFyZ3VtZW50c1swXSAhPT0gdW5kZWZpbmVkID8gYXJndW1lbnRzWzBdIDogdW5kZWZpbmVkO1xuXG5cdFx0dGhpc1tNQVBdID0gT2JqZWN0LmNyZWF0ZShudWxsKTtcblxuXHRcdGlmIChpbml0IGluc3RhbmNlb2YgSGVhZGVycykge1xuXHRcdFx0Y29uc3QgcmF3SGVhZGVycyA9IGluaXQucmF3KCk7XG5cdFx0XHRjb25zdCBoZWFkZXJOYW1lcyA9IE9iamVjdC5rZXlzKHJhd0hlYWRlcnMpO1xuXG5cdFx0XHRmb3IgKGNvbnN0IGhlYWRlck5hbWUgb2YgaGVhZGVyTmFtZXMpIHtcblx0XHRcdFx0Zm9yIChjb25zdCB2YWx1ZSBvZiByYXdIZWFkZXJzW2hlYWRlck5hbWVdKSB7XG5cdFx0XHRcdFx0dGhpcy5hcHBlbmQoaGVhZGVyTmFtZSwgdmFsdWUpO1xuXHRcdFx0XHR9XG5cdFx0XHR9XG5cblx0XHRcdHJldHVybjtcblx0XHR9XG5cblx0XHQvLyBXZSBkb24ndCB3b3JyeSBhYm91dCBjb252ZXJ0aW5nIHByb3AgdG8gQnl0ZVN0cmluZyBoZXJlIGFzIGFwcGVuZCgpXG5cdFx0Ly8gd2lsbCBoYW5kbGUgaXQuXG5cdFx0aWYgKGluaXQgPT0gbnVsbCkgOyBlbHNlIGlmICh0eXBlb2YgaW5pdCA9PT0gJ29iamVjdCcpIHtcblx0XHRcdGNvbnN0IG1ldGhvZCA9IGluaXRbU3ltYm9sLml0ZXJhdG9yXTtcblx0XHRcdGlmIChtZXRob2QgIT0gbnVsbCkge1xuXHRcdFx0XHRpZiAodHlwZW9mIG1ldGhvZCAhPT0gJ2Z1bmN0aW9uJykge1xuXHRcdFx0XHRcdHRocm93IG5ldyBUeXBlRXJyb3IoJ0hlYWRlciBwYWlycyBtdXN0IGJlIGl0ZXJhYmxlJyk7XG5cdFx0XHRcdH1cblxuXHRcdFx0XHQvLyBzZXF1ZW5jZTxzZXF1ZW5jZTxCeXRlU3RyaW5nPj5cblx0XHRcdFx0Ly8gTm90ZTogcGVyIHNwZWMgd2UgaGF2ZSB0byBmaXJzdCBleGhhdXN0IHRoZSBsaXN0cyB0aGVuIHByb2Nlc3MgdGhlbVxuXHRcdFx0XHRjb25zdCBwYWlycyA9IFtdO1xuXHRcdFx0XHRmb3IgKGNvbnN0IHBhaXIgb2YgaW5pdCkge1xuXHRcdFx0XHRcdGlmICh0eXBlb2YgcGFpciAhPT0gJ29iamVjdCcgfHwgdHlwZW9mIHBhaXJbU3ltYm9sLml0ZXJhdG9yXSAhPT0gJ2Z1bmN0aW9uJykge1xuXHRcdFx0XHRcdFx0dGhyb3cgbmV3IFR5cGVFcnJvcignRWFjaCBoZWFkZXIgcGFpciBtdXN0IGJlIGl0ZXJhYmxlJyk7XG5cdFx0XHRcdFx0fVxuXHRcdFx0XHRcdHBhaXJzLnB1c2goQXJyYXkuZnJvbShwYWlyKSk7XG5cdFx0XHRcdH1cblxuXHRcdFx0XHRmb3IgKGNvbnN0IHBhaXIgb2YgcGFpcnMpIHtcblx0XHRcdFx0XHRpZiAocGFpci5sZW5ndGggIT09IDIpIHtcblx0XHRcdFx0XHRcdHRocm93IG5ldyBUeXBlRXJyb3IoJ0VhY2ggaGVhZGVyIHBhaXIgbXVzdCBiZSBhIG5hbWUvdmFsdWUgdHVwbGUnKTtcblx0XHRcdFx0XHR9XG5cdFx0XHRcdFx0dGhpcy5hcHBlbmQocGFpclswXSwgcGFpclsxXSk7XG5cdFx0XHRcdH1cblx0XHRcdH0gZWxzZSB7XG5cdFx0XHRcdC8vIHJlY29yZDxCeXRlU3RyaW5nLCBCeXRlU3RyaW5nPlxuXHRcdFx0XHRmb3IgKGNvbnN0IGtleSBvZiBPYmplY3Qua2V5cyhpbml0KSkge1xuXHRcdFx0XHRcdGNvbnN0IHZhbHVlID0gaW5pdFtrZXldO1xuXHRcdFx0XHRcdHRoaXMuYXBwZW5kKGtleSwgdmFsdWUpO1xuXHRcdFx0XHR9XG5cdFx0XHR9XG5cdFx0fSBlbHNlIHtcblx0XHRcdHRocm93IG5ldyBUeXBlRXJyb3IoJ1Byb3ZpZGVkIGluaXRpYWxpemVyIG11c3QgYmUgYW4gb2JqZWN0Jyk7XG5cdFx0fVxuXHR9XG5cblx0LyoqXG4gICogUmV0dXJuIGNvbWJpbmVkIGhlYWRlciB2YWx1ZSBnaXZlbiBuYW1lXG4gICpcbiAgKiBAcGFyYW0gICBTdHJpbmcgIG5hbWUgIEhlYWRlciBuYW1lXG4gICogQHJldHVybiAgTWl4ZWRcbiAgKi9cblx0Z2V0KG5hbWUpIHtcblx0XHRuYW1lID0gYCR7bmFtZX1gO1xuXHRcdHZhbGlkYXRlTmFtZShuYW1lKTtcblx0XHRjb25zdCBrZXkgPSBmaW5kKHRoaXNbTUFQXSwgbmFtZSk7XG5cdFx0aWYgKGtleSA9PT0gdW5kZWZpbmVkKSB7XG5cdFx0XHRyZXR1cm4gbnVsbDtcblx0XHR9XG5cblx0XHRyZXR1cm4gdGhpc1tNQVBdW2tleV0uam9pbignLCAnKTtcblx0fVxuXG5cdC8qKlxuICAqIEl0ZXJhdGUgb3ZlciBhbGwgaGVhZGVyc1xuICAqXG4gICogQHBhcmFtICAgRnVuY3Rpb24gIGNhbGxiYWNrICBFeGVjdXRlZCBmb3IgZWFjaCBpdGVtIHdpdGggcGFyYW1ldGVycyAodmFsdWUsIG5hbWUsIHRoaXNBcmcpXG4gICogQHBhcmFtICAgQm9vbGVhbiAgIHRoaXNBcmcgICBgdGhpc2AgY29udGV4dCBmb3IgY2FsbGJhY2sgZnVuY3Rpb25cbiAgKiBAcmV0dXJuICBWb2lkXG4gICovXG5cdGZvckVhY2goY2FsbGJhY2spIHtcblx0XHRsZXQgdGhpc0FyZyA9IGFyZ3VtZW50cy5sZW5ndGggPiAxICYmIGFyZ3VtZW50c1sxXSAhPT0gdW5kZWZpbmVkID8gYXJndW1lbnRzWzFdIDogdW5kZWZpbmVkO1xuXG5cdFx0bGV0IHBhaXJzID0gZ2V0SGVhZGVycyh0aGlzKTtcblx0XHRsZXQgaSA9IDA7XG5cdFx0d2hpbGUgKGkgPCBwYWlycy5sZW5ndGgpIHtcblx0XHRcdHZhciBfcGFpcnMkaSA9IHBhaXJzW2ldO1xuXHRcdFx0Y29uc3QgbmFtZSA9IF9wYWlycyRpWzBdLFxuXHRcdFx0ICAgICAgdmFsdWUgPSBfcGFpcnMkaVsxXTtcblxuXHRcdFx0Y2FsbGJhY2suY2FsbCh0aGlzQXJnLCB2YWx1ZSwgbmFtZSwgdGhpcyk7XG5cdFx0XHRwYWlycyA9IGdldEhlYWRlcnModGhpcyk7XG5cdFx0XHRpKys7XG5cdFx0fVxuXHR9XG5cblx0LyoqXG4gICogT3ZlcndyaXRlIGhlYWRlciB2YWx1ZXMgZ2l2ZW4gbmFtZVxuICAqXG4gICogQHBhcmFtICAgU3RyaW5nICBuYW1lICAgSGVhZGVyIG5hbWVcbiAgKiBAcGFyYW0gICBTdHJpbmcgIHZhbHVlICBIZWFkZXIgdmFsdWVcbiAgKiBAcmV0dXJuICBWb2lkXG4gICovXG5cdHNldChuYW1lLCB2YWx1ZSkge1xuXHRcdG5hbWUgPSBgJHtuYW1lfWA7XG5cdFx0dmFsdWUgPSBgJHt2YWx1ZX1gO1xuXHRcdHZhbGlkYXRlTmFtZShuYW1lKTtcblx0XHR2YWxpZGF0ZVZhbHVlKHZhbHVlKTtcblx0XHRjb25zdCBrZXkgPSBmaW5kKHRoaXNbTUFQXSwgbmFtZSk7XG5cdFx0dGhpc1tNQVBdW2tleSAhPT0gdW5kZWZpbmVkID8ga2V5IDogbmFtZV0gPSBbdmFsdWVdO1xuXHR9XG5cblx0LyoqXG4gICogQXBwZW5kIGEgdmFsdWUgb250byBleGlzdGluZyBoZWFkZXJcbiAgKlxuICAqIEBwYXJhbSAgIFN0cmluZyAgbmFtZSAgIEhlYWRlciBuYW1lXG4gICogQHBhcmFtICAgU3RyaW5nICB2YWx1ZSAgSGVhZGVyIHZhbHVlXG4gICogQHJldHVybiAgVm9pZFxuICAqL1xuXHRhcHBlbmQobmFtZSwgdmFsdWUpIHtcblx0XHRuYW1lID0gYCR7bmFtZX1gO1xuXHRcdHZhbHVlID0gYCR7dmFsdWV9YDtcblx0XHR2YWxpZGF0ZU5hbWUobmFtZSk7XG5cdFx0dmFsaWRhdGVWYWx1ZSh2YWx1ZSk7XG5cdFx0Y29uc3Qga2V5ID0gZmluZCh0aGlzW01BUF0sIG5hbWUpO1xuXHRcdGlmIChrZXkgIT09IHVuZGVmaW5lZCkge1xuXHRcdFx0dGhpc1tNQVBdW2tleV0ucHVzaCh2YWx1ZSk7XG5cdFx0fSBlbHNlIHtcblx0XHRcdHRoaXNbTUFQXVtuYW1lXSA9IFt2YWx1ZV07XG5cdFx0fVxuXHR9XG5cblx0LyoqXG4gICogQ2hlY2sgZm9yIGhlYWRlciBuYW1lIGV4aXN0ZW5jZVxuICAqXG4gICogQHBhcmFtICAgU3RyaW5nICAgbmFtZSAgSGVhZGVyIG5hbWVcbiAgKiBAcmV0dXJuICBCb29sZWFuXG4gICovXG5cdGhhcyhuYW1lKSB7XG5cdFx0bmFtZSA9IGAke25hbWV9YDtcblx0XHR2YWxpZGF0ZU5hbWUobmFtZSk7XG5cdFx0cmV0dXJuIGZpbmQodGhpc1tNQVBdLCBuYW1lKSAhPT0gdW5kZWZpbmVkO1xuXHR9XG5cblx0LyoqXG4gICogRGVsZXRlIGFsbCBoZWFkZXIgdmFsdWVzIGdpdmVuIG5hbWVcbiAgKlxuICAqIEBwYXJhbSAgIFN0cmluZyAgbmFtZSAgSGVhZGVyIG5hbWVcbiAgKiBAcmV0dXJuICBWb2lkXG4gICovXG5cdGRlbGV0ZShuYW1lKSB7XG5cdFx0bmFtZSA9IGAke25hbWV9YDtcblx0XHR2YWxpZGF0ZU5hbWUobmFtZSk7XG5cdFx0Y29uc3Qga2V5ID0gZmluZCh0aGlzW01BUF0sIG5hbWUpO1xuXHRcdGlmIChrZXkgIT09IHVuZGVmaW5lZCkge1xuXHRcdFx0ZGVsZXRlIHRoaXNbTUFQXVtrZXldO1xuXHRcdH1cblx0fVxuXG5cdC8qKlxuICAqIFJldHVybiByYXcgaGVhZGVycyAobm9uLXNwZWMgYXBpKVxuICAqXG4gICogQHJldHVybiAgT2JqZWN0XG4gICovXG5cdHJhdygpIHtcblx0XHRyZXR1cm4gdGhpc1tNQVBdO1xuXHR9XG5cblx0LyoqXG4gICogR2V0IGFuIGl0ZXJhdG9yIG9uIGtleXMuXG4gICpcbiAgKiBAcmV0dXJuICBJdGVyYXRvclxuICAqL1xuXHRrZXlzKCkge1xuXHRcdHJldHVybiBjcmVhdGVIZWFkZXJzSXRlcmF0b3IodGhpcywgJ2tleScpO1xuXHR9XG5cblx0LyoqXG4gICogR2V0IGFuIGl0ZXJhdG9yIG9uIHZhbHVlcy5cbiAgKlxuICAqIEByZXR1cm4gIEl0ZXJhdG9yXG4gICovXG5cdHZhbHVlcygpIHtcblx0XHRyZXR1cm4gY3JlYXRlSGVhZGVyc0l0ZXJhdG9yKHRoaXMsICd2YWx1ZScpO1xuXHR9XG5cblx0LyoqXG4gICogR2V0IGFuIGl0ZXJhdG9yIG9uIGVudHJpZXMuXG4gICpcbiAgKiBUaGlzIGlzIHRoZSBkZWZhdWx0IGl0ZXJhdG9yIG9mIHRoZSBIZWFkZXJzIG9iamVjdC5cbiAgKlxuICAqIEByZXR1cm4gIEl0ZXJhdG9yXG4gICovXG5cdFtTeW1ib2wuaXRlcmF0b3JdKCkge1xuXHRcdHJldHVybiBjcmVhdGVIZWFkZXJzSXRlcmF0b3IodGhpcywgJ2tleSt2YWx1ZScpO1xuXHR9XG59XG5IZWFkZXJzLnByb3RvdHlwZS5lbnRyaWVzID0gSGVhZGVycy5wcm90b3R5cGVbU3ltYm9sLml0ZXJhdG9yXTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KEhlYWRlcnMucHJvdG90eXBlLCBTeW1ib2wudG9TdHJpbmdUYWcsIHtcblx0dmFsdWU6ICdIZWFkZXJzJyxcblx0d3JpdGFibGU6IGZhbHNlLFxuXHRlbnVtZXJhYmxlOiBmYWxzZSxcblx0Y29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnRpZXMoSGVhZGVycy5wcm90b3R5cGUsIHtcblx0Z2V0OiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0Zm9yRWFjaDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdHNldDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGFwcGVuZDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGhhczogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGRlbGV0ZTogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGtleXM6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHR2YWx1ZXM6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRlbnRyaWVzOiB7IGVudW1lcmFibGU6IHRydWUgfVxufSk7XG5cbmZ1bmN0aW9uIGdldEhlYWRlcnMoaGVhZGVycykge1xuXHRsZXQga2luZCA9IGFyZ3VtZW50cy5sZW5ndGggPiAxICYmIGFyZ3VtZW50c1sxXSAhPT0gdW5kZWZpbmVkID8gYXJndW1lbnRzWzFdIDogJ2tleSt2YWx1ZSc7XG5cblx0Y29uc3Qga2V5cyA9IE9iamVjdC5rZXlzKGhlYWRlcnNbTUFQXSkuc29ydCgpO1xuXHRyZXR1cm4ga2V5cy5tYXAoa2luZCA9PT0gJ2tleScgPyBmdW5jdGlvbiAoaykge1xuXHRcdHJldHVybiBrLnRvTG93ZXJDYXNlKCk7XG5cdH0gOiBraW5kID09PSAndmFsdWUnID8gZnVuY3Rpb24gKGspIHtcblx0XHRyZXR1cm4gaGVhZGVyc1tNQVBdW2tdLmpvaW4oJywgJyk7XG5cdH0gOiBmdW5jdGlvbiAoaykge1xuXHRcdHJldHVybiBbay50b0xvd2VyQ2FzZSgpLCBoZWFkZXJzW01BUF1ba10uam9pbignLCAnKV07XG5cdH0pO1xufVxuXG5jb25zdCBJTlRFUk5BTCA9IFN5bWJvbCgnaW50ZXJuYWwnKTtcblxuZnVuY3Rpb24gY3JlYXRlSGVhZGVyc0l0ZXJhdG9yKHRhcmdldCwga2luZCkge1xuXHRjb25zdCBpdGVyYXRvciA9IE9iamVjdC5jcmVhdGUoSGVhZGVyc0l0ZXJhdG9yUHJvdG90eXBlKTtcblx0aXRlcmF0b3JbSU5URVJOQUxdID0ge1xuXHRcdHRhcmdldCxcblx0XHRraW5kLFxuXHRcdGluZGV4OiAwXG5cdH07XG5cdHJldHVybiBpdGVyYXRvcjtcbn1cblxuY29uc3QgSGVhZGVyc0l0ZXJhdG9yUHJvdG90eXBlID0gT2JqZWN0LnNldFByb3RvdHlwZU9mKHtcblx0bmV4dCgpIHtcblx0XHQvLyBpc3RhbmJ1bCBpZ25vcmUgaWZcblx0XHRpZiAoIXRoaXMgfHwgT2JqZWN0LmdldFByb3RvdHlwZU9mKHRoaXMpICE9PSBIZWFkZXJzSXRlcmF0b3JQcm90b3R5cGUpIHtcblx0XHRcdHRocm93IG5ldyBUeXBlRXJyb3IoJ1ZhbHVlIG9mIGB0aGlzYCBpcyBub3QgYSBIZWFkZXJzSXRlcmF0b3InKTtcblx0XHR9XG5cblx0XHR2YXIgX0lOVEVSTkFMID0gdGhpc1tJTlRFUk5BTF07XG5cdFx0Y29uc3QgdGFyZ2V0ID0gX0lOVEVSTkFMLnRhcmdldCxcblx0XHQgICAgICBraW5kID0gX0lOVEVSTkFMLmtpbmQsXG5cdFx0ICAgICAgaW5kZXggPSBfSU5URVJOQUwuaW5kZXg7XG5cblx0XHRjb25zdCB2YWx1ZXMgPSBnZXRIZWFkZXJzKHRhcmdldCwga2luZCk7XG5cdFx0Y29uc3QgbGVuID0gdmFsdWVzLmxlbmd0aDtcblx0XHRpZiAoaW5kZXggPj0gbGVuKSB7XG5cdFx0XHRyZXR1cm4ge1xuXHRcdFx0XHR2YWx1ZTogdW5kZWZpbmVkLFxuXHRcdFx0XHRkb25lOiB0cnVlXG5cdFx0XHR9O1xuXHRcdH1cblxuXHRcdHRoaXNbSU5URVJOQUxdLmluZGV4ID0gaW5kZXggKyAxO1xuXG5cdFx0cmV0dXJuIHtcblx0XHRcdHZhbHVlOiB2YWx1ZXNbaW5kZXhdLFxuXHRcdFx0ZG9uZTogZmFsc2Vcblx0XHR9O1xuXHR9XG59LCBPYmplY3QuZ2V0UHJvdG90eXBlT2YoT2JqZWN0LmdldFByb3RvdHlwZU9mKFtdW1N5bWJvbC5pdGVyYXRvcl0oKSkpKTtcblxuT2JqZWN0LmRlZmluZVByb3BlcnR5KEhlYWRlcnNJdGVyYXRvclByb3RvdHlwZSwgU3ltYm9sLnRvU3RyaW5nVGFnLCB7XG5cdHZhbHVlOiAnSGVhZGVyc0l0ZXJhdG9yJyxcblx0d3JpdGFibGU6IGZhbHNlLFxuXHRlbnVtZXJhYmxlOiBmYWxzZSxcblx0Y29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuLyoqXG4gKiBFeHBvcnQgdGhlIEhlYWRlcnMgb2JqZWN0IGluIGEgZm9ybSB0aGF0IE5vZGUuanMgY2FuIGNvbnN1bWUuXG4gKlxuICogQHBhcmFtICAgSGVhZGVycyAgaGVhZGVyc1xuICogQHJldHVybiAgT2JqZWN0XG4gKi9cbmZ1bmN0aW9uIGV4cG9ydE5vZGVDb21wYXRpYmxlSGVhZGVycyhoZWFkZXJzKSB7XG5cdGNvbnN0IG9iaiA9IE9iamVjdC5hc3NpZ24oeyBfX3Byb3RvX186IG51bGwgfSwgaGVhZGVyc1tNQVBdKTtcblxuXHQvLyBodHRwLnJlcXVlc3QoKSBvbmx5IHN1cHBvcnRzIHN0cmluZyBhcyBIb3N0IGhlYWRlci4gVGhpcyBoYWNrIG1ha2VzXG5cdC8vIHNwZWNpZnlpbmcgY3VzdG9tIEhvc3QgaGVhZGVyIHBvc3NpYmxlLlxuXHRjb25zdCBob3N0SGVhZGVyS2V5ID0gZmluZChoZWFkZXJzW01BUF0sICdIb3N0Jyk7XG5cdGlmIChob3N0SGVhZGVyS2V5ICE9PSB1bmRlZmluZWQpIHtcblx0XHRvYmpbaG9zdEhlYWRlcktleV0gPSBvYmpbaG9zdEhlYWRlcktleV1bMF07XG5cdH1cblxuXHRyZXR1cm4gb2JqO1xufVxuXG4vKipcbiAqIENyZWF0ZSBhIEhlYWRlcnMgb2JqZWN0IGZyb20gYW4gb2JqZWN0IG9mIGhlYWRlcnMsIGlnbm9yaW5nIHRob3NlIHRoYXQgZG9cbiAqIG5vdCBjb25mb3JtIHRvIEhUVFAgZ3JhbW1hciBwcm9kdWN0aW9ucy5cbiAqXG4gKiBAcGFyYW0gICBPYmplY3QgIG9iaiAgT2JqZWN0IG9mIGhlYWRlcnNcbiAqIEByZXR1cm4gIEhlYWRlcnNcbiAqL1xuZnVuY3Rpb24gY3JlYXRlSGVhZGVyc0xlbmllbnQob2JqKSB7XG5cdGNvbnN0IGhlYWRlcnMgPSBuZXcgSGVhZGVycygpO1xuXHRmb3IgKGNvbnN0IG5hbWUgb2YgT2JqZWN0LmtleXMob2JqKSkge1xuXHRcdGlmIChpbnZhbGlkVG9rZW5SZWdleC50ZXN0KG5hbWUpKSB7XG5cdFx0XHRjb250aW51ZTtcblx0XHR9XG5cdFx0aWYgKEFycmF5LmlzQXJyYXkob2JqW25hbWVdKSkge1xuXHRcdFx0Zm9yIChjb25zdCB2YWwgb2Ygb2JqW25hbWVdKSB7XG5cdFx0XHRcdGlmIChpbnZhbGlkSGVhZGVyQ2hhclJlZ2V4LnRlc3QodmFsKSkge1xuXHRcdFx0XHRcdGNvbnRpbnVlO1xuXHRcdFx0XHR9XG5cdFx0XHRcdGlmIChoZWFkZXJzW01BUF1bbmFtZV0gPT09IHVuZGVmaW5lZCkge1xuXHRcdFx0XHRcdGhlYWRlcnNbTUFQXVtuYW1lXSA9IFt2YWxdO1xuXHRcdFx0XHR9IGVsc2Uge1xuXHRcdFx0XHRcdGhlYWRlcnNbTUFQXVtuYW1lXS5wdXNoKHZhbCk7XG5cdFx0XHRcdH1cblx0XHRcdH1cblx0XHR9IGVsc2UgaWYgKCFpbnZhbGlkSGVhZGVyQ2hhclJlZ2V4LnRlc3Qob2JqW25hbWVdKSkge1xuXHRcdFx0aGVhZGVyc1tNQVBdW25hbWVdID0gW29ialtuYW1lXV07XG5cdFx0fVxuXHR9XG5cdHJldHVybiBoZWFkZXJzO1xufVxuXG5jb25zdCBJTlRFUk5BTFMkMSA9IFN5bWJvbCgnUmVzcG9uc2UgaW50ZXJuYWxzJyk7XG5cbi8vIGZpeCBhbiBpc3N1ZSB3aGVyZSBcIlNUQVRVU19DT0RFU1wiIGFyZW4ndCBhIG5hbWVkIGV4cG9ydCBmb3Igbm9kZSA8MTBcbmNvbnN0IFNUQVRVU19DT0RFUyA9IGh0dHAuU1RBVFVTX0NPREVTO1xuXG4vKipcbiAqIFJlc3BvbnNlIGNsYXNzXG4gKlxuICogQHBhcmFtICAgU3RyZWFtICBib2R5ICBSZWFkYWJsZSBzdHJlYW1cbiAqIEBwYXJhbSAgIE9iamVjdCAgb3B0cyAgUmVzcG9uc2Ugb3B0aW9uc1xuICogQHJldHVybiAgVm9pZFxuICovXG5jbGFzcyBSZXNwb25zZSB7XG5cdGNvbnN0cnVjdG9yKCkge1xuXHRcdGxldCBib2R5ID0gYXJndW1lbnRzLmxlbmd0aCA+IDAgJiYgYXJndW1lbnRzWzBdICE9PSB1bmRlZmluZWQgPyBhcmd1bWVudHNbMF0gOiBudWxsO1xuXHRcdGxldCBvcHRzID0gYXJndW1lbnRzLmxlbmd0aCA+IDEgJiYgYXJndW1lbnRzWzFdICE9PSB1bmRlZmluZWQgPyBhcmd1bWVudHNbMV0gOiB7fTtcblxuXHRcdEJvZHkuY2FsbCh0aGlzLCBib2R5LCBvcHRzKTtcblxuXHRcdGNvbnN0IHN0YXR1cyA9IG9wdHMuc3RhdHVzIHx8IDIwMDtcblx0XHRjb25zdCBoZWFkZXJzID0gbmV3IEhlYWRlcnMob3B0cy5oZWFkZXJzKTtcblxuXHRcdGlmIChib2R5ICE9IG51bGwgJiYgIWhlYWRlcnMuaGFzKCdDb250ZW50LVR5cGUnKSkge1xuXHRcdFx0Y29uc3QgY29udGVudFR5cGUgPSBleHRyYWN0Q29udGVudFR5cGUoYm9keSk7XG5cdFx0XHRpZiAoY29udGVudFR5cGUpIHtcblx0XHRcdFx0aGVhZGVycy5hcHBlbmQoJ0NvbnRlbnQtVHlwZScsIGNvbnRlbnRUeXBlKTtcblx0XHRcdH1cblx0XHR9XG5cblx0XHR0aGlzW0lOVEVSTkFMUyQxXSA9IHtcblx0XHRcdHVybDogb3B0cy51cmwsXG5cdFx0XHRzdGF0dXMsXG5cdFx0XHRzdGF0dXNUZXh0OiBvcHRzLnN0YXR1c1RleHQgfHwgU1RBVFVTX0NPREVTW3N0YXR1c10sXG5cdFx0XHRoZWFkZXJzLFxuXHRcdFx0Y291bnRlcjogb3B0cy5jb3VudGVyXG5cdFx0fTtcblx0fVxuXG5cdGdldCB1cmwoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDFdLnVybCB8fCAnJztcblx0fVxuXG5cdGdldCBzdGF0dXMoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDFdLnN0YXR1cztcblx0fVxuXG5cdC8qKlxuICAqIENvbnZlbmllbmNlIHByb3BlcnR5IHJlcHJlc2VudGluZyBpZiB0aGUgcmVxdWVzdCBlbmRlZCBub3JtYWxseVxuICAqL1xuXHRnZXQgb2soKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDFdLnN0YXR1cyA+PSAyMDAgJiYgdGhpc1tJTlRFUk5BTFMkMV0uc3RhdHVzIDwgMzAwO1xuXHR9XG5cblx0Z2V0IHJlZGlyZWN0ZWQoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDFdLmNvdW50ZXIgPiAwO1xuXHR9XG5cblx0Z2V0IHN0YXR1c1RleHQoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDFdLnN0YXR1c1RleHQ7XG5cdH1cblxuXHRnZXQgaGVhZGVycygpIHtcblx0XHRyZXR1cm4gdGhpc1tJTlRFUk5BTFMkMV0uaGVhZGVycztcblx0fVxuXG5cdC8qKlxuICAqIENsb25lIHRoaXMgcmVzcG9uc2VcbiAgKlxuICAqIEByZXR1cm4gIFJlc3BvbnNlXG4gICovXG5cdGNsb25lKCkge1xuXHRcdHJldHVybiBuZXcgUmVzcG9uc2UoY2xvbmUodGhpcyksIHtcblx0XHRcdHVybDogdGhpcy51cmwsXG5cdFx0XHRzdGF0dXM6IHRoaXMuc3RhdHVzLFxuXHRcdFx0c3RhdHVzVGV4dDogdGhpcy5zdGF0dXNUZXh0LFxuXHRcdFx0aGVhZGVyczogdGhpcy5oZWFkZXJzLFxuXHRcdFx0b2s6IHRoaXMub2ssXG5cdFx0XHRyZWRpcmVjdGVkOiB0aGlzLnJlZGlyZWN0ZWRcblx0XHR9KTtcblx0fVxufVxuXG5Cb2R5Lm1peEluKFJlc3BvbnNlLnByb3RvdHlwZSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0aWVzKFJlc3BvbnNlLnByb3RvdHlwZSwge1xuXHR1cmw6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRzdGF0dXM6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRvazogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdHJlZGlyZWN0ZWQ6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRzdGF0dXNUZXh0OiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0aGVhZGVyczogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGNsb25lOiB7IGVudW1lcmFibGU6IHRydWUgfVxufSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShSZXNwb25zZS5wcm90b3R5cGUsIFN5bWJvbC50b1N0cmluZ1RhZywge1xuXHR2YWx1ZTogJ1Jlc3BvbnNlJyxcblx0d3JpdGFibGU6IGZhbHNlLFxuXHRlbnVtZXJhYmxlOiBmYWxzZSxcblx0Y29uZmlndXJhYmxlOiB0cnVlXG59KTtcblxuY29uc3QgSU5URVJOQUxTJDIgPSBTeW1ib2woJ1JlcXVlc3QgaW50ZXJuYWxzJyk7XG5jb25zdCBVUkwgPSBVcmwuVVJMIHx8IHdoYXR3Z1VybC5VUkw7XG5cbi8vIGZpeCBhbiBpc3N1ZSB3aGVyZSBcImZvcm1hdFwiLCBcInBhcnNlXCIgYXJlbid0IGEgbmFtZWQgZXhwb3J0IGZvciBub2RlIDwxMFxuY29uc3QgcGFyc2VfdXJsID0gVXJsLnBhcnNlO1xuY29uc3QgZm9ybWF0X3VybCA9IFVybC5mb3JtYXQ7XG5cbi8qKlxuICogV3JhcHBlciBhcm91bmQgYG5ldyBVUkxgIHRvIGhhbmRsZSBhcmJpdHJhcnkgVVJMc1xuICpcbiAqIEBwYXJhbSAge3N0cmluZ30gdXJsU3RyXG4gKiBAcmV0dXJuIHt2b2lkfVxuICovXG5mdW5jdGlvbiBwYXJzZVVSTCh1cmxTdHIpIHtcblx0LypcbiBcdENoZWNrIHdoZXRoZXIgdGhlIFVSTCBpcyBhYnNvbHV0ZSBvciBub3RcbiBcdFx0U2NoZW1lOiBodHRwczovL3Rvb2xzLmlldGYub3JnL2h0bWwvcmZjMzk4NiNzZWN0aW9uLTMuMVxuIFx0QWJzb2x1dGUgVVJMOiBodHRwczovL3Rvb2xzLmlldGYub3JnL2h0bWwvcmZjMzk4NiNzZWN0aW9uLTQuM1xuICovXG5cdGlmICgvXlthLXpBLVpdW2EtekEtWlxcZCtcXC0uXSo6Ly5leGVjKHVybFN0cikpIHtcblx0XHR1cmxTdHIgPSBuZXcgVVJMKHVybFN0cikudG9TdHJpbmcoKTtcblx0fVxuXG5cdC8vIEZhbGxiYWNrIHRvIG9sZCBpbXBsZW1lbnRhdGlvbiBmb3IgYXJiaXRyYXJ5IFVSTHNcblx0cmV0dXJuIHBhcnNlX3VybCh1cmxTdHIpO1xufVxuXG5jb25zdCBzdHJlYW1EZXN0cnVjdGlvblN1cHBvcnRlZCA9ICdkZXN0cm95JyBpbiBTdHJlYW0uUmVhZGFibGUucHJvdG90eXBlO1xuXG4vKipcbiAqIENoZWNrIGlmIGEgdmFsdWUgaXMgYW4gaW5zdGFuY2Ugb2YgUmVxdWVzdC5cbiAqXG4gKiBAcGFyYW0gICBNaXhlZCAgIGlucHV0XG4gKiBAcmV0dXJuICBCb29sZWFuXG4gKi9cbmZ1bmN0aW9uIGlzUmVxdWVzdChpbnB1dCkge1xuXHRyZXR1cm4gdHlwZW9mIGlucHV0ID09PSAnb2JqZWN0JyAmJiB0eXBlb2YgaW5wdXRbSU5URVJOQUxTJDJdID09PSAnb2JqZWN0Jztcbn1cblxuZnVuY3Rpb24gaXNBYm9ydFNpZ25hbChzaWduYWwpIHtcblx0Y29uc3QgcHJvdG8gPSBzaWduYWwgJiYgdHlwZW9mIHNpZ25hbCA9PT0gJ29iamVjdCcgJiYgT2JqZWN0LmdldFByb3RvdHlwZU9mKHNpZ25hbCk7XG5cdHJldHVybiAhIShwcm90byAmJiBwcm90by5jb25zdHJ1Y3Rvci5uYW1lID09PSAnQWJvcnRTaWduYWwnKTtcbn1cblxuLyoqXG4gKiBSZXF1ZXN0IGNsYXNzXG4gKlxuICogQHBhcmFtICAgTWl4ZWQgICBpbnB1dCAgVXJsIG9yIFJlcXVlc3QgaW5zdGFuY2VcbiAqIEBwYXJhbSAgIE9iamVjdCAgaW5pdCAgIEN1c3RvbSBvcHRpb25zXG4gKiBAcmV0dXJuICBWb2lkXG4gKi9cbmNsYXNzIFJlcXVlc3Qge1xuXHRjb25zdHJ1Y3RvcihpbnB1dCkge1xuXHRcdGxldCBpbml0ID0gYXJndW1lbnRzLmxlbmd0aCA+IDEgJiYgYXJndW1lbnRzWzFdICE9PSB1bmRlZmluZWQgPyBhcmd1bWVudHNbMV0gOiB7fTtcblxuXHRcdGxldCBwYXJzZWRVUkw7XG5cblx0XHQvLyBub3JtYWxpemUgaW5wdXRcblx0XHRpZiAoIWlzUmVxdWVzdChpbnB1dCkpIHtcblx0XHRcdGlmIChpbnB1dCAmJiBpbnB1dC5ocmVmKSB7XG5cdFx0XHRcdC8vIGluIG9yZGVyIHRvIHN1cHBvcnQgTm9kZS5qcycgVXJsIG9iamVjdHM7IHRob3VnaCBXSEFUV0cncyBVUkwgb2JqZWN0c1xuXHRcdFx0XHQvLyB3aWxsIGZhbGwgaW50byB0aGlzIGJyYW5jaCBhbHNvIChzaW5jZSB0aGVpciBgdG9TdHJpbmcoKWAgd2lsbCByZXR1cm5cblx0XHRcdFx0Ly8gYGhyZWZgIHByb3BlcnR5IGFueXdheSlcblx0XHRcdFx0cGFyc2VkVVJMID0gcGFyc2VVUkwoaW5wdXQuaHJlZik7XG5cdFx0XHR9IGVsc2Uge1xuXHRcdFx0XHQvLyBjb2VyY2UgaW5wdXQgdG8gYSBzdHJpbmcgYmVmb3JlIGF0dGVtcHRpbmcgdG8gcGFyc2Vcblx0XHRcdFx0cGFyc2VkVVJMID0gcGFyc2VVUkwoYCR7aW5wdXR9YCk7XG5cdFx0XHR9XG5cdFx0XHRpbnB1dCA9IHt9O1xuXHRcdH0gZWxzZSB7XG5cdFx0XHRwYXJzZWRVUkwgPSBwYXJzZVVSTChpbnB1dC51cmwpO1xuXHRcdH1cblxuXHRcdGxldCBtZXRob2QgPSBpbml0Lm1ldGhvZCB8fCBpbnB1dC5tZXRob2QgfHwgJ0dFVCc7XG5cdFx0bWV0aG9kID0gbWV0aG9kLnRvVXBwZXJDYXNlKCk7XG5cblx0XHRpZiAoKGluaXQuYm9keSAhPSBudWxsIHx8IGlzUmVxdWVzdChpbnB1dCkgJiYgaW5wdXQuYm9keSAhPT0gbnVsbCkgJiYgKG1ldGhvZCA9PT0gJ0dFVCcgfHwgbWV0aG9kID09PSAnSEVBRCcpKSB7XG5cdFx0XHR0aHJvdyBuZXcgVHlwZUVycm9yKCdSZXF1ZXN0IHdpdGggR0VUL0hFQUQgbWV0aG9kIGNhbm5vdCBoYXZlIGJvZHknKTtcblx0XHR9XG5cblx0XHRsZXQgaW5wdXRCb2R5ID0gaW5pdC5ib2R5ICE9IG51bGwgPyBpbml0LmJvZHkgOiBpc1JlcXVlc3QoaW5wdXQpICYmIGlucHV0LmJvZHkgIT09IG51bGwgPyBjbG9uZShpbnB1dCkgOiBudWxsO1xuXG5cdFx0Qm9keS5jYWxsKHRoaXMsIGlucHV0Qm9keSwge1xuXHRcdFx0dGltZW91dDogaW5pdC50aW1lb3V0IHx8IGlucHV0LnRpbWVvdXQgfHwgMCxcblx0XHRcdHNpemU6IGluaXQuc2l6ZSB8fCBpbnB1dC5zaXplIHx8IDBcblx0XHR9KTtcblxuXHRcdGNvbnN0IGhlYWRlcnMgPSBuZXcgSGVhZGVycyhpbml0LmhlYWRlcnMgfHwgaW5wdXQuaGVhZGVycyB8fCB7fSk7XG5cblx0XHRpZiAoaW5wdXRCb2R5ICE9IG51bGwgJiYgIWhlYWRlcnMuaGFzKCdDb250ZW50LVR5cGUnKSkge1xuXHRcdFx0Y29uc3QgY29udGVudFR5cGUgPSBleHRyYWN0Q29udGVudFR5cGUoaW5wdXRCb2R5KTtcblx0XHRcdGlmIChjb250ZW50VHlwZSkge1xuXHRcdFx0XHRoZWFkZXJzLmFwcGVuZCgnQ29udGVudC1UeXBlJywgY29udGVudFR5cGUpO1xuXHRcdFx0fVxuXHRcdH1cblxuXHRcdGxldCBzaWduYWwgPSBpc1JlcXVlc3QoaW5wdXQpID8gaW5wdXQuc2lnbmFsIDogbnVsbDtcblx0XHRpZiAoJ3NpZ25hbCcgaW4gaW5pdCkgc2lnbmFsID0gaW5pdC5zaWduYWw7XG5cblx0XHRpZiAoc2lnbmFsICE9IG51bGwgJiYgIWlzQWJvcnRTaWduYWwoc2lnbmFsKSkge1xuXHRcdFx0dGhyb3cgbmV3IFR5cGVFcnJvcignRXhwZWN0ZWQgc2lnbmFsIHRvIGJlIGFuIGluc3RhbmNlb2YgQWJvcnRTaWduYWwnKTtcblx0XHR9XG5cblx0XHR0aGlzW0lOVEVSTkFMUyQyXSA9IHtcblx0XHRcdG1ldGhvZCxcblx0XHRcdHJlZGlyZWN0OiBpbml0LnJlZGlyZWN0IHx8IGlucHV0LnJlZGlyZWN0IHx8ICdmb2xsb3cnLFxuXHRcdFx0aGVhZGVycyxcblx0XHRcdHBhcnNlZFVSTCxcblx0XHRcdHNpZ25hbFxuXHRcdH07XG5cblx0XHQvLyBub2RlLWZldGNoLW9ubHkgb3B0aW9uc1xuXHRcdHRoaXMuZm9sbG93ID0gaW5pdC5mb2xsb3cgIT09IHVuZGVmaW5lZCA/IGluaXQuZm9sbG93IDogaW5wdXQuZm9sbG93ICE9PSB1bmRlZmluZWQgPyBpbnB1dC5mb2xsb3cgOiAyMDtcblx0XHR0aGlzLmNvbXByZXNzID0gaW5pdC5jb21wcmVzcyAhPT0gdW5kZWZpbmVkID8gaW5pdC5jb21wcmVzcyA6IGlucHV0LmNvbXByZXNzICE9PSB1bmRlZmluZWQgPyBpbnB1dC5jb21wcmVzcyA6IHRydWU7XG5cdFx0dGhpcy5jb3VudGVyID0gaW5pdC5jb3VudGVyIHx8IGlucHV0LmNvdW50ZXIgfHwgMDtcblx0XHR0aGlzLmFnZW50ID0gaW5pdC5hZ2VudCB8fCBpbnB1dC5hZ2VudDtcblx0fVxuXG5cdGdldCBtZXRob2QoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDJdLm1ldGhvZDtcblx0fVxuXG5cdGdldCB1cmwoKSB7XG5cdFx0cmV0dXJuIGZvcm1hdF91cmwodGhpc1tJTlRFUk5BTFMkMl0ucGFyc2VkVVJMKTtcblx0fVxuXG5cdGdldCBoZWFkZXJzKCkge1xuXHRcdHJldHVybiB0aGlzW0lOVEVSTkFMUyQyXS5oZWFkZXJzO1xuXHR9XG5cblx0Z2V0IHJlZGlyZWN0KCkge1xuXHRcdHJldHVybiB0aGlzW0lOVEVSTkFMUyQyXS5yZWRpcmVjdDtcblx0fVxuXG5cdGdldCBzaWduYWwoKSB7XG5cdFx0cmV0dXJuIHRoaXNbSU5URVJOQUxTJDJdLnNpZ25hbDtcblx0fVxuXG5cdC8qKlxuICAqIENsb25lIHRoaXMgcmVxdWVzdFxuICAqXG4gICogQHJldHVybiAgUmVxdWVzdFxuICAqL1xuXHRjbG9uZSgpIHtcblx0XHRyZXR1cm4gbmV3IFJlcXVlc3QodGhpcyk7XG5cdH1cbn1cblxuQm9keS5taXhJbihSZXF1ZXN0LnByb3RvdHlwZSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShSZXF1ZXN0LnByb3RvdHlwZSwgU3ltYm9sLnRvU3RyaW5nVGFnLCB7XG5cdHZhbHVlOiAnUmVxdWVzdCcsXG5cdHdyaXRhYmxlOiBmYWxzZSxcblx0ZW51bWVyYWJsZTogZmFsc2UsXG5cdGNvbmZpZ3VyYWJsZTogdHJ1ZVxufSk7XG5cbk9iamVjdC5kZWZpbmVQcm9wZXJ0aWVzKFJlcXVlc3QucHJvdG90eXBlLCB7XG5cdG1ldGhvZDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdHVybDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGhlYWRlcnM6IHsgZW51bWVyYWJsZTogdHJ1ZSB9LFxuXHRyZWRpcmVjdDogeyBlbnVtZXJhYmxlOiB0cnVlIH0sXG5cdGNsb25lOiB7IGVudW1lcmFibGU6IHRydWUgfSxcblx0c2lnbmFsOiB7IGVudW1lcmFibGU6IHRydWUgfVxufSk7XG5cbi8qKlxuICogQ29udmVydCBhIFJlcXVlc3QgdG8gTm9kZS5qcyBodHRwIHJlcXVlc3Qgb3B0aW9ucy5cbiAqXG4gKiBAcGFyYW0gICBSZXF1ZXN0ICBBIFJlcXVlc3QgaW5zdGFuY2VcbiAqIEByZXR1cm4gIE9iamVjdCAgIFRoZSBvcHRpb25zIG9iamVjdCB0byBiZSBwYXNzZWQgdG8gaHR0cC5yZXF1ZXN0XG4gKi9cbmZ1bmN0aW9uIGdldE5vZGVSZXF1ZXN0T3B0aW9ucyhyZXF1ZXN0KSB7XG5cdGNvbnN0IHBhcnNlZFVSTCA9IHJlcXVlc3RbSU5URVJOQUxTJDJdLnBhcnNlZFVSTDtcblx0Y29uc3QgaGVhZGVycyA9IG5ldyBIZWFkZXJzKHJlcXVlc3RbSU5URVJOQUxTJDJdLmhlYWRlcnMpO1xuXG5cdC8vIGZldGNoIHN0ZXAgMS4zXG5cdGlmICghaGVhZGVycy5oYXMoJ0FjY2VwdCcpKSB7XG5cdFx0aGVhZGVycy5zZXQoJ0FjY2VwdCcsICcqLyonKTtcblx0fVxuXG5cdC8vIEJhc2ljIGZldGNoXG5cdGlmICghcGFyc2VkVVJMLnByb3RvY29sIHx8ICFwYXJzZWRVUkwuaG9zdG5hbWUpIHtcblx0XHR0aHJvdyBuZXcgVHlwZUVycm9yKCdPbmx5IGFic29sdXRlIFVSTHMgYXJlIHN1cHBvcnRlZCcpO1xuXHR9XG5cblx0aWYgKCEvXmh0dHBzPzokLy50ZXN0KHBhcnNlZFVSTC5wcm90b2NvbCkpIHtcblx0XHR0aHJvdyBuZXcgVHlwZUVycm9yKCdPbmx5IEhUVFAoUykgcHJvdG9jb2xzIGFyZSBzdXBwb3J0ZWQnKTtcblx0fVxuXG5cdGlmIChyZXF1ZXN0LnNpZ25hbCAmJiByZXF1ZXN0LmJvZHkgaW5zdGFuY2VvZiBTdHJlYW0uUmVhZGFibGUgJiYgIXN0cmVhbURlc3RydWN0aW9uU3VwcG9ydGVkKSB7XG5cdFx0dGhyb3cgbmV3IEVycm9yKCdDYW5jZWxsYXRpb24gb2Ygc3RyZWFtZWQgcmVxdWVzdHMgd2l0aCBBYm9ydFNpZ25hbCBpcyBub3Qgc3VwcG9ydGVkIGluIG5vZGUgPCA4Jyk7XG5cdH1cblxuXHQvLyBIVFRQLW5ldHdvcmstb3ItY2FjaGUgZmV0Y2ggc3RlcHMgMi40LTIuN1xuXHRsZXQgY29udGVudExlbmd0aFZhbHVlID0gbnVsbDtcblx0aWYgKHJlcXVlc3QuYm9keSA9PSBudWxsICYmIC9eKFBPU1R8UFVUKSQvaS50ZXN0KHJlcXVlc3QubWV0aG9kKSkge1xuXHRcdGNvbnRlbnRMZW5ndGhWYWx1ZSA9ICcwJztcblx0fVxuXHRpZiAocmVxdWVzdC5ib2R5ICE9IG51bGwpIHtcblx0XHRjb25zdCB0b3RhbEJ5dGVzID0gZ2V0VG90YWxCeXRlcyhyZXF1ZXN0KTtcblx0XHRpZiAodHlwZW9mIHRvdGFsQnl0ZXMgPT09ICdudW1iZXInKSB7XG5cdFx0XHRjb250ZW50TGVuZ3RoVmFsdWUgPSBTdHJpbmcodG90YWxCeXRlcyk7XG5cdFx0fVxuXHR9XG5cdGlmIChjb250ZW50TGVuZ3RoVmFsdWUpIHtcblx0XHRoZWFkZXJzLnNldCgnQ29udGVudC1MZW5ndGgnLCBjb250ZW50TGVuZ3RoVmFsdWUpO1xuXHR9XG5cblx0Ly8gSFRUUC1uZXR3b3JrLW9yLWNhY2hlIGZldGNoIHN0ZXAgMi4xMVxuXHRpZiAoIWhlYWRlcnMuaGFzKCdVc2VyLUFnZW50JykpIHtcblx0XHRoZWFkZXJzLnNldCgnVXNlci1BZ2VudCcsICdub2RlLWZldGNoLzEuMCAoK2h0dHBzOi8vZ2l0aHViLmNvbS9iaXRpbm4vbm9kZS1mZXRjaCknKTtcblx0fVxuXG5cdC8vIEhUVFAtbmV0d29yay1vci1jYWNoZSBmZXRjaCBzdGVwIDIuMTVcblx0aWYgKHJlcXVlc3QuY29tcHJlc3MgJiYgIWhlYWRlcnMuaGFzKCdBY2NlcHQtRW5jb2RpbmcnKSkge1xuXHRcdGhlYWRlcnMuc2V0KCdBY2NlcHQtRW5jb2RpbmcnLCAnZ3ppcCxkZWZsYXRlJyk7XG5cdH1cblxuXHRsZXQgYWdlbnQgPSByZXF1ZXN0LmFnZW50O1xuXHRpZiAodHlwZW9mIGFnZW50ID09PSAnZnVuY3Rpb24nKSB7XG5cdFx0YWdlbnQgPSBhZ2VudChwYXJzZWRVUkwpO1xuXHR9XG5cblx0aWYgKCFoZWFkZXJzLmhhcygnQ29ubmVjdGlvbicpICYmICFhZ2VudCkge1xuXHRcdGhlYWRlcnMuc2V0KCdDb25uZWN0aW9uJywgJ2Nsb3NlJyk7XG5cdH1cblxuXHQvLyBIVFRQLW5ldHdvcmsgZmV0Y2ggc3RlcCA0LjJcblx0Ly8gY2h1bmtlZCBlbmNvZGluZyBpcyBoYW5kbGVkIGJ5IE5vZGUuanNcblxuXHRyZXR1cm4gT2JqZWN0LmFzc2lnbih7fSwgcGFyc2VkVVJMLCB7XG5cdFx0bWV0aG9kOiByZXF1ZXN0Lm1ldGhvZCxcblx0XHRoZWFkZXJzOiBleHBvcnROb2RlQ29tcGF0aWJsZUhlYWRlcnMoaGVhZGVycyksXG5cdFx0YWdlbnRcblx0fSk7XG59XG5cbi8qKlxuICogYWJvcnQtZXJyb3IuanNcbiAqXG4gKiBBYm9ydEVycm9yIGludGVyZmFjZSBmb3IgY2FuY2VsbGVkIHJlcXVlc3RzXG4gKi9cblxuLyoqXG4gKiBDcmVhdGUgQWJvcnRFcnJvciBpbnN0YW5jZVxuICpcbiAqIEBwYXJhbSAgIFN0cmluZyAgICAgIG1lc3NhZ2UgICAgICBFcnJvciBtZXNzYWdlIGZvciBodW1hblxuICogQHJldHVybiAgQWJvcnRFcnJvclxuICovXG5mdW5jdGlvbiBBYm9ydEVycm9yKG1lc3NhZ2UpIHtcbiAgRXJyb3IuY2FsbCh0aGlzLCBtZXNzYWdlKTtcblxuICB0aGlzLnR5cGUgPSAnYWJvcnRlZCc7XG4gIHRoaXMubWVzc2FnZSA9IG1lc3NhZ2U7XG5cbiAgLy8gaGlkZSBjdXN0b20gZXJyb3IgaW1wbGVtZW50YXRpb24gZGV0YWlscyBmcm9tIGVuZC11c2Vyc1xuICBFcnJvci5jYXB0dXJlU3RhY2tUcmFjZSh0aGlzLCB0aGlzLmNvbnN0cnVjdG9yKTtcbn1cblxuQWJvcnRFcnJvci5wcm90b3R5cGUgPSBPYmplY3QuY3JlYXRlKEVycm9yLnByb3RvdHlwZSk7XG5BYm9ydEVycm9yLnByb3RvdHlwZS5jb25zdHJ1Y3RvciA9IEFib3J0RXJyb3I7XG5BYm9ydEVycm9yLnByb3RvdHlwZS5uYW1lID0gJ0Fib3J0RXJyb3InO1xuXG5jb25zdCBVUkwkMSA9IFVybC5VUkwgfHwgd2hhdHdnVXJsLlVSTDtcblxuLy8gZml4IGFuIGlzc3VlIHdoZXJlIFwiUGFzc1Rocm91Z2hcIiwgXCJyZXNvbHZlXCIgYXJlbid0IGEgbmFtZWQgZXhwb3J0IGZvciBub2RlIDwxMFxuY29uc3QgUGFzc1Rocm91Z2gkMSA9IFN0cmVhbS5QYXNzVGhyb3VnaDtcblxuY29uc3QgaXNEb21haW5PclN1YmRvbWFpbiA9IGZ1bmN0aW9uIGlzRG9tYWluT3JTdWJkb21haW4oZGVzdGluYXRpb24sIG9yaWdpbmFsKSB7XG5cdGNvbnN0IG9yaWcgPSBuZXcgVVJMJDEob3JpZ2luYWwpLmhvc3RuYW1lO1xuXHRjb25zdCBkZXN0ID0gbmV3IFVSTCQxKGRlc3RpbmF0aW9uKS5ob3N0bmFtZTtcblxuXHRyZXR1cm4gb3JpZyA9PT0gZGVzdCB8fCBvcmlnW29yaWcubGVuZ3RoIC0gZGVzdC5sZW5ndGggLSAxXSA9PT0gJy4nICYmIG9yaWcuZW5kc1dpdGgoZGVzdCk7XG59O1xuXG4vKipcbiAqIEZldGNoIGZ1bmN0aW9uXG4gKlxuICogQHBhcmFtICAgTWl4ZWQgICAgdXJsICAgQWJzb2x1dGUgdXJsIG9yIFJlcXVlc3QgaW5zdGFuY2VcbiAqIEBwYXJhbSAgIE9iamVjdCAgIG9wdHMgIEZldGNoIG9wdGlvbnNcbiAqIEByZXR1cm4gIFByb21pc2VcbiAqL1xuZnVuY3Rpb24gZmV0Y2godXJsLCBvcHRzKSB7XG5cblx0Ly8gYWxsb3cgY3VzdG9tIHByb21pc2Vcblx0aWYgKCFmZXRjaC5Qcm9taXNlKSB7XG5cdFx0dGhyb3cgbmV3IEVycm9yKCduYXRpdmUgcHJvbWlzZSBtaXNzaW5nLCBzZXQgZmV0Y2guUHJvbWlzZSB0byB5b3VyIGZhdm9yaXRlIGFsdGVybmF0aXZlJyk7XG5cdH1cblxuXHRCb2R5LlByb21pc2UgPSBmZXRjaC5Qcm9taXNlO1xuXG5cdC8vIHdyYXAgaHR0cC5yZXF1ZXN0IGludG8gZmV0Y2hcblx0cmV0dXJuIG5ldyBmZXRjaC5Qcm9taXNlKGZ1bmN0aW9uIChyZXNvbHZlLCByZWplY3QpIHtcblx0XHQvLyBidWlsZCByZXF1ZXN0IG9iamVjdFxuXHRcdGNvbnN0IHJlcXVlc3QgPSBuZXcgUmVxdWVzdCh1cmwsIG9wdHMpO1xuXHRcdGNvbnN0IG9wdGlvbnMgPSBnZXROb2RlUmVxdWVzdE9wdGlvbnMocmVxdWVzdCk7XG5cblx0XHRjb25zdCBzZW5kID0gKG9wdGlvbnMucHJvdG9jb2wgPT09ICdodHRwczonID8gaHR0cHMgOiBodHRwKS5yZXF1ZXN0O1xuXHRcdGNvbnN0IHNpZ25hbCA9IHJlcXVlc3Quc2lnbmFsO1xuXG5cdFx0bGV0IHJlc3BvbnNlID0gbnVsbDtcblxuXHRcdGNvbnN0IGFib3J0ID0gZnVuY3Rpb24gYWJvcnQoKSB7XG5cdFx0XHRsZXQgZXJyb3IgPSBuZXcgQWJvcnRFcnJvcignVGhlIHVzZXIgYWJvcnRlZCBhIHJlcXVlc3QuJyk7XG5cdFx0XHRyZWplY3QoZXJyb3IpO1xuXHRcdFx0aWYgKHJlcXVlc3QuYm9keSAmJiByZXF1ZXN0LmJvZHkgaW5zdGFuY2VvZiBTdHJlYW0uUmVhZGFibGUpIHtcblx0XHRcdFx0cmVxdWVzdC5ib2R5LmRlc3Ryb3koZXJyb3IpO1xuXHRcdFx0fVxuXHRcdFx0aWYgKCFyZXNwb25zZSB8fCAhcmVzcG9uc2UuYm9keSkgcmV0dXJuO1xuXHRcdFx0cmVzcG9uc2UuYm9keS5lbWl0KCdlcnJvcicsIGVycm9yKTtcblx0XHR9O1xuXG5cdFx0aWYgKHNpZ25hbCAmJiBzaWduYWwuYWJvcnRlZCkge1xuXHRcdFx0YWJvcnQoKTtcblx0XHRcdHJldHVybjtcblx0XHR9XG5cblx0XHRjb25zdCBhYm9ydEFuZEZpbmFsaXplID0gZnVuY3Rpb24gYWJvcnRBbmRGaW5hbGl6ZSgpIHtcblx0XHRcdGFib3J0KCk7XG5cdFx0XHRmaW5hbGl6ZSgpO1xuXHRcdH07XG5cblx0XHQvLyBzZW5kIHJlcXVlc3Rcblx0XHRjb25zdCByZXEgPSBzZW5kKG9wdGlvbnMpO1xuXHRcdGxldCByZXFUaW1lb3V0O1xuXG5cdFx0aWYgKHNpZ25hbCkge1xuXHRcdFx0c2lnbmFsLmFkZEV2ZW50TGlzdGVuZXIoJ2Fib3J0JywgYWJvcnRBbmRGaW5hbGl6ZSk7XG5cdFx0fVxuXG5cdFx0ZnVuY3Rpb24gZmluYWxpemUoKSB7XG5cdFx0XHRyZXEuYWJvcnQoKTtcblx0XHRcdGlmIChzaWduYWwpIHNpZ25hbC5yZW1vdmVFdmVudExpc3RlbmVyKCdhYm9ydCcsIGFib3J0QW5kRmluYWxpemUpO1xuXHRcdFx0Y2xlYXJUaW1lb3V0KHJlcVRpbWVvdXQpO1xuXHRcdH1cblxuXHRcdGlmIChyZXF1ZXN0LnRpbWVvdXQpIHtcblx0XHRcdHJlcS5vbmNlKCdzb2NrZXQnLCBmdW5jdGlvbiAoc29ja2V0KSB7XG5cdFx0XHRcdHJlcVRpbWVvdXQgPSBzZXRUaW1lb3V0KGZ1bmN0aW9uICgpIHtcblx0XHRcdFx0XHRyZWplY3QobmV3IEZldGNoRXJyb3IoYG5ldHdvcmsgdGltZW91dCBhdDogJHtyZXF1ZXN0LnVybH1gLCAncmVxdWVzdC10aW1lb3V0JykpO1xuXHRcdFx0XHRcdGZpbmFsaXplKCk7XG5cdFx0XHRcdH0sIHJlcXVlc3QudGltZW91dCk7XG5cdFx0XHR9KTtcblx0XHR9XG5cblx0XHRyZXEub24oJ2Vycm9yJywgZnVuY3Rpb24gKGVycikge1xuXHRcdFx0cmVqZWN0KG5ldyBGZXRjaEVycm9yKGByZXF1ZXN0IHRvICR7cmVxdWVzdC51cmx9IGZhaWxlZCwgcmVhc29uOiAke2Vyci5tZXNzYWdlfWAsICdzeXN0ZW0nLCBlcnIpKTtcblx0XHRcdGZpbmFsaXplKCk7XG5cdFx0fSk7XG5cblx0XHRyZXEub24oJ3Jlc3BvbnNlJywgZnVuY3Rpb24gKHJlcykge1xuXHRcdFx0Y2xlYXJUaW1lb3V0KHJlcVRpbWVvdXQpO1xuXG5cdFx0XHRjb25zdCBoZWFkZXJzID0gY3JlYXRlSGVhZGVyc0xlbmllbnQocmVzLmhlYWRlcnMpO1xuXG5cdFx0XHQvLyBIVFRQIGZldGNoIHN0ZXAgNVxuXHRcdFx0aWYgKGZldGNoLmlzUmVkaXJlY3QocmVzLnN0YXR1c0NvZGUpKSB7XG5cdFx0XHRcdC8vIEhUVFAgZmV0Y2ggc3RlcCA1LjJcblx0XHRcdFx0Y29uc3QgbG9jYXRpb24gPSBoZWFkZXJzLmdldCgnTG9jYXRpb24nKTtcblxuXHRcdFx0XHQvLyBIVFRQIGZldGNoIHN0ZXAgNS4zXG5cdFx0XHRcdGxldCBsb2NhdGlvblVSTCA9IG51bGw7XG5cdFx0XHRcdHRyeSB7XG5cdFx0XHRcdFx0bG9jYXRpb25VUkwgPSBsb2NhdGlvbiA9PT0gbnVsbCA/IG51bGwgOiBuZXcgVVJMJDEobG9jYXRpb24sIHJlcXVlc3QudXJsKS50b1N0cmluZygpO1xuXHRcdFx0XHR9IGNhdGNoIChlcnIpIHtcblx0XHRcdFx0XHQvLyBlcnJvciBoZXJlIGNhbiBvbmx5IGJlIGludmFsaWQgVVJMIGluIExvY2F0aW9uOiBoZWFkZXJcblx0XHRcdFx0XHQvLyBkbyBub3QgdGhyb3cgd2hlbiBvcHRpb25zLnJlZGlyZWN0ID09IG1hbnVhbFxuXHRcdFx0XHRcdC8vIGxldCB0aGUgdXNlciBleHRyYWN0IHRoZSBlcnJvcm5lb3VzIHJlZGlyZWN0IFVSTFxuXHRcdFx0XHRcdGlmIChyZXF1ZXN0LnJlZGlyZWN0ICE9PSAnbWFudWFsJykge1xuXHRcdFx0XHRcdFx0cmVqZWN0KG5ldyBGZXRjaEVycm9yKGB1cmkgcmVxdWVzdGVkIHJlc3BvbmRzIHdpdGggYW4gaW52YWxpZCByZWRpcmVjdCBVUkw6ICR7bG9jYXRpb259YCwgJ2ludmFsaWQtcmVkaXJlY3QnKSk7XG5cdFx0XHRcdFx0XHRmaW5hbGl6ZSgpO1xuXHRcdFx0XHRcdFx0cmV0dXJuO1xuXHRcdFx0XHRcdH1cblx0XHRcdFx0fVxuXG5cdFx0XHRcdC8vIEhUVFAgZmV0Y2ggc3RlcCA1LjVcblx0XHRcdFx0c3dpdGNoIChyZXF1ZXN0LnJlZGlyZWN0KSB7XG5cdFx0XHRcdFx0Y2FzZSAnZXJyb3InOlxuXHRcdFx0XHRcdFx0cmVqZWN0KG5ldyBGZXRjaEVycm9yKGB1cmkgcmVxdWVzdGVkIHJlc3BvbmRzIHdpdGggYSByZWRpcmVjdCwgcmVkaXJlY3QgbW9kZSBpcyBzZXQgdG8gZXJyb3I6ICR7cmVxdWVzdC51cmx9YCwgJ25vLXJlZGlyZWN0JykpO1xuXHRcdFx0XHRcdFx0ZmluYWxpemUoKTtcblx0XHRcdFx0XHRcdHJldHVybjtcblx0XHRcdFx0XHRjYXNlICdtYW51YWwnOlxuXHRcdFx0XHRcdFx0Ly8gbm9kZS1mZXRjaC1zcGVjaWZpYyBzdGVwOiBtYWtlIG1hbnVhbCByZWRpcmVjdCBhIGJpdCBlYXNpZXIgdG8gdXNlIGJ5IHNldHRpbmcgdGhlIExvY2F0aW9uIGhlYWRlciB2YWx1ZSB0byB0aGUgcmVzb2x2ZWQgVVJMLlxuXHRcdFx0XHRcdFx0aWYgKGxvY2F0aW9uVVJMICE9PSBudWxsKSB7XG5cdFx0XHRcdFx0XHRcdC8vIGhhbmRsZSBjb3JydXB0ZWQgaGVhZGVyXG5cdFx0XHRcdFx0XHRcdHRyeSB7XG5cdFx0XHRcdFx0XHRcdFx0aGVhZGVycy5zZXQoJ0xvY2F0aW9uJywgbG9jYXRpb25VUkwpO1xuXHRcdFx0XHRcdFx0XHR9IGNhdGNoIChlcnIpIHtcblx0XHRcdFx0XHRcdFx0XHQvLyBpc3RhbmJ1bCBpZ25vcmUgbmV4dDogbm9kZWpzIHNlcnZlciBwcmV2ZW50IGludmFsaWQgcmVzcG9uc2UgaGVhZGVycywgd2UgY2FuJ3QgdGVzdCB0aGlzIHRocm91Z2ggbm9ybWFsIHJlcXVlc3Rcblx0XHRcdFx0XHRcdFx0XHRyZWplY3QoZXJyKTtcblx0XHRcdFx0XHRcdFx0fVxuXHRcdFx0XHRcdFx0fVxuXHRcdFx0XHRcdFx0YnJlYWs7XG5cdFx0XHRcdFx0Y2FzZSAnZm9sbG93Jzpcblx0XHRcdFx0XHRcdC8vIEhUVFAtcmVkaXJlY3QgZmV0Y2ggc3RlcCAyXG5cdFx0XHRcdFx0XHRpZiAobG9jYXRpb25VUkwgPT09IG51bGwpIHtcblx0XHRcdFx0XHRcdFx0YnJlYWs7XG5cdFx0XHRcdFx0XHR9XG5cblx0XHRcdFx0XHRcdC8vIEhUVFAtcmVkaXJlY3QgZmV0Y2ggc3RlcCA1XG5cdFx0XHRcdFx0XHRpZiAocmVxdWVzdC5jb3VudGVyID49IHJlcXVlc3QuZm9sbG93KSB7XG5cdFx0XHRcdFx0XHRcdHJlamVjdChuZXcgRmV0Y2hFcnJvcihgbWF4aW11bSByZWRpcmVjdCByZWFjaGVkIGF0OiAke3JlcXVlc3QudXJsfWAsICdtYXgtcmVkaXJlY3QnKSk7XG5cdFx0XHRcdFx0XHRcdGZpbmFsaXplKCk7XG5cdFx0XHRcdFx0XHRcdHJldHVybjtcblx0XHRcdFx0XHRcdH1cblxuXHRcdFx0XHRcdFx0Ly8gSFRUUC1yZWRpcmVjdCBmZXRjaCBzdGVwIDYgKGNvdW50ZXIgaW5jcmVtZW50KVxuXHRcdFx0XHRcdFx0Ly8gQ3JlYXRlIGEgbmV3IFJlcXVlc3Qgb2JqZWN0LlxuXHRcdFx0XHRcdFx0Y29uc3QgcmVxdWVzdE9wdHMgPSB7XG5cdFx0XHRcdFx0XHRcdGhlYWRlcnM6IG5ldyBIZWFkZXJzKHJlcXVlc3QuaGVhZGVycyksXG5cdFx0XHRcdFx0XHRcdGZvbGxvdzogcmVxdWVzdC5mb2xsb3csXG5cdFx0XHRcdFx0XHRcdGNvdW50ZXI6IHJlcXVlc3QuY291bnRlciArIDEsXG5cdFx0XHRcdFx0XHRcdGFnZW50OiByZXF1ZXN0LmFnZW50LFxuXHRcdFx0XHRcdFx0XHRjb21wcmVzczogcmVxdWVzdC5jb21wcmVzcyxcblx0XHRcdFx0XHRcdFx0bWV0aG9kOiByZXF1ZXN0Lm1ldGhvZCxcblx0XHRcdFx0XHRcdFx0Ym9keTogcmVxdWVzdC5ib2R5LFxuXHRcdFx0XHRcdFx0XHRzaWduYWw6IHJlcXVlc3Quc2lnbmFsLFxuXHRcdFx0XHRcdFx0XHR0aW1lb3V0OiByZXF1ZXN0LnRpbWVvdXQsXG5cdFx0XHRcdFx0XHRcdHNpemU6IHJlcXVlc3Quc2l6ZVxuXHRcdFx0XHRcdFx0fTtcblxuXHRcdFx0XHRcdFx0aWYgKCFpc0RvbWFpbk9yU3ViZG9tYWluKHJlcXVlc3QudXJsLCBsb2NhdGlvblVSTCkpIHtcblx0XHRcdFx0XHRcdFx0Zm9yIChjb25zdCBuYW1lIG9mIFsnYXV0aG9yaXphdGlvbicsICd3d3ctYXV0aGVudGljYXRlJywgJ2Nvb2tpZScsICdjb29raWUyJ10pIHtcblx0XHRcdFx0XHRcdFx0XHRyZXF1ZXN0T3B0cy5oZWFkZXJzLmRlbGV0ZShuYW1lKTtcblx0XHRcdFx0XHRcdFx0fVxuXHRcdFx0XHRcdFx0fVxuXG5cdFx0XHRcdFx0XHQvLyBIVFRQLXJlZGlyZWN0IGZldGNoIHN0ZXAgOVxuXHRcdFx0XHRcdFx0aWYgKHJlcy5zdGF0dXNDb2RlICE9PSAzMDMgJiYgcmVxdWVzdC5ib2R5ICYmIGdldFRvdGFsQnl0ZXMocmVxdWVzdCkgPT09IG51bGwpIHtcblx0XHRcdFx0XHRcdFx0cmVqZWN0KG5ldyBGZXRjaEVycm9yKCdDYW5ub3QgZm9sbG93IHJlZGlyZWN0IHdpdGggYm9keSBiZWluZyBhIHJlYWRhYmxlIHN0cmVhbScsICd1bnN1cHBvcnRlZC1yZWRpcmVjdCcpKTtcblx0XHRcdFx0XHRcdFx0ZmluYWxpemUoKTtcblx0XHRcdFx0XHRcdFx0cmV0dXJuO1xuXHRcdFx0XHRcdFx0fVxuXG5cdFx0XHRcdFx0XHQvLyBIVFRQLXJlZGlyZWN0IGZldGNoIHN0ZXAgMTFcblx0XHRcdFx0XHRcdGlmIChyZXMuc3RhdHVzQ29kZSA9PT0gMzAzIHx8IChyZXMuc3RhdHVzQ29kZSA9PT0gMzAxIHx8IHJlcy5zdGF0dXNDb2RlID09PSAzMDIpICYmIHJlcXVlc3QubWV0aG9kID09PSAnUE9TVCcpIHtcblx0XHRcdFx0XHRcdFx0cmVxdWVzdE9wdHMubWV0aG9kID0gJ0dFVCc7XG5cdFx0XHRcdFx0XHRcdHJlcXVlc3RPcHRzLmJvZHkgPSB1bmRlZmluZWQ7XG5cdFx0XHRcdFx0XHRcdHJlcXVlc3RPcHRzLmhlYWRlcnMuZGVsZXRlKCdjb250ZW50LWxlbmd0aCcpO1xuXHRcdFx0XHRcdFx0fVxuXG5cdFx0XHRcdFx0XHQvLyBIVFRQLXJlZGlyZWN0IGZldGNoIHN0ZXAgMTVcblx0XHRcdFx0XHRcdHJlc29sdmUoZmV0Y2gobmV3IFJlcXVlc3QobG9jYXRpb25VUkwsIHJlcXVlc3RPcHRzKSkpO1xuXHRcdFx0XHRcdFx0ZmluYWxpemUoKTtcblx0XHRcdFx0XHRcdHJldHVybjtcblx0XHRcdFx0fVxuXHRcdFx0fVxuXG5cdFx0XHQvLyBwcmVwYXJlIHJlc3BvbnNlXG5cdFx0XHRyZXMub25jZSgnZW5kJywgZnVuY3Rpb24gKCkge1xuXHRcdFx0XHRpZiAoc2lnbmFsKSBzaWduYWwucmVtb3ZlRXZlbnRMaXN0ZW5lcignYWJvcnQnLCBhYm9ydEFuZEZpbmFsaXplKTtcblx0XHRcdH0pO1xuXHRcdFx0bGV0IGJvZHkgPSByZXMucGlwZShuZXcgUGFzc1Rocm91Z2gkMSgpKTtcblxuXHRcdFx0Y29uc3QgcmVzcG9uc2Vfb3B0aW9ucyA9IHtcblx0XHRcdFx0dXJsOiByZXF1ZXN0LnVybCxcblx0XHRcdFx0c3RhdHVzOiByZXMuc3RhdHVzQ29kZSxcblx0XHRcdFx0c3RhdHVzVGV4dDogcmVzLnN0YXR1c01lc3NhZ2UsXG5cdFx0XHRcdGhlYWRlcnM6IGhlYWRlcnMsXG5cdFx0XHRcdHNpemU6IHJlcXVlc3Quc2l6ZSxcblx0XHRcdFx0dGltZW91dDogcmVxdWVzdC50aW1lb3V0LFxuXHRcdFx0XHRjb3VudGVyOiByZXF1ZXN0LmNvdW50ZXJcblx0XHRcdH07XG5cblx0XHRcdC8vIEhUVFAtbmV0d29yayBmZXRjaCBzdGVwIDEyLjEuMS4zXG5cdFx0XHRjb25zdCBjb2RpbmdzID0gaGVhZGVycy5nZXQoJ0NvbnRlbnQtRW5jb2RpbmcnKTtcblxuXHRcdFx0Ly8gSFRUUC1uZXR3b3JrIGZldGNoIHN0ZXAgMTIuMS4xLjQ6IGhhbmRsZSBjb250ZW50IGNvZGluZ3NcblxuXHRcdFx0Ly8gaW4gZm9sbG93aW5nIHNjZW5hcmlvcyB3ZSBpZ25vcmUgY29tcHJlc3Npb24gc3VwcG9ydFxuXHRcdFx0Ly8gMS4gY29tcHJlc3Npb24gc3VwcG9ydCBpcyBkaXNhYmxlZFxuXHRcdFx0Ly8gMi4gSEVBRCByZXF1ZXN0XG5cdFx0XHQvLyAzLiBubyBDb250ZW50LUVuY29kaW5nIGhlYWRlclxuXHRcdFx0Ly8gNC4gbm8gY29udGVudCByZXNwb25zZSAoMjA0KVxuXHRcdFx0Ly8gNS4gY29udGVudCBub3QgbW9kaWZpZWQgcmVzcG9uc2UgKDMwNClcblx0XHRcdGlmICghcmVxdWVzdC5jb21wcmVzcyB8fCByZXF1ZXN0Lm1ldGhvZCA9PT0gJ0hFQUQnIHx8IGNvZGluZ3MgPT09IG51bGwgfHwgcmVzLnN0YXR1c0NvZGUgPT09IDIwNCB8fCByZXMuc3RhdHVzQ29kZSA9PT0gMzA0KSB7XG5cdFx0XHRcdHJlc3BvbnNlID0gbmV3IFJlc3BvbnNlKGJvZHksIHJlc3BvbnNlX29wdGlvbnMpO1xuXHRcdFx0XHRyZXNvbHZlKHJlc3BvbnNlKTtcblx0XHRcdFx0cmV0dXJuO1xuXHRcdFx0fVxuXG5cdFx0XHQvLyBGb3IgTm9kZSB2Nitcblx0XHRcdC8vIEJlIGxlc3Mgc3RyaWN0IHdoZW4gZGVjb2RpbmcgY29tcHJlc3NlZCByZXNwb25zZXMsIHNpbmNlIHNvbWV0aW1lc1xuXHRcdFx0Ly8gc2VydmVycyBzZW5kIHNsaWdodGx5IGludmFsaWQgcmVzcG9uc2VzIHRoYXQgYXJlIHN0aWxsIGFjY2VwdGVkXG5cdFx0XHQvLyBieSBjb21tb24gYnJvd3NlcnMuXG5cdFx0XHQvLyBBbHdheXMgdXNpbmcgWl9TWU5DX0ZMVVNIIGlzIHdoYXQgY1VSTCBkb2VzLlxuXHRcdFx0Y29uc3QgemxpYk9wdGlvbnMgPSB7XG5cdFx0XHRcdGZsdXNoOiB6bGliLlpfU1lOQ19GTFVTSCxcblx0XHRcdFx0ZmluaXNoRmx1c2g6IHpsaWIuWl9TWU5DX0ZMVVNIXG5cdFx0XHR9O1xuXG5cdFx0XHQvLyBmb3IgZ3ppcFxuXHRcdFx0aWYgKGNvZGluZ3MgPT0gJ2d6aXAnIHx8IGNvZGluZ3MgPT0gJ3gtZ3ppcCcpIHtcblx0XHRcdFx0Ym9keSA9IGJvZHkucGlwZSh6bGliLmNyZWF0ZUd1bnppcCh6bGliT3B0aW9ucykpO1xuXHRcdFx0XHRyZXNwb25zZSA9IG5ldyBSZXNwb25zZShib2R5LCByZXNwb25zZV9vcHRpb25zKTtcblx0XHRcdFx0cmVzb2x2ZShyZXNwb25zZSk7XG5cdFx0XHRcdHJldHVybjtcblx0XHRcdH1cblxuXHRcdFx0Ly8gZm9yIGRlZmxhdGVcblx0XHRcdGlmIChjb2RpbmdzID09ICdkZWZsYXRlJyB8fCBjb2RpbmdzID09ICd4LWRlZmxhdGUnKSB7XG5cdFx0XHRcdC8vIGhhbmRsZSB0aGUgaW5mYW1vdXMgcmF3IGRlZmxhdGUgcmVzcG9uc2UgZnJvbSBvbGQgc2VydmVyc1xuXHRcdFx0XHQvLyBhIGhhY2sgZm9yIG9sZCBJSVMgYW5kIEFwYWNoZSBzZXJ2ZXJzXG5cdFx0XHRcdGNvbnN0IHJhdyA9IHJlcy5waXBlKG5ldyBQYXNzVGhyb3VnaCQxKCkpO1xuXHRcdFx0XHRyYXcub25jZSgnZGF0YScsIGZ1bmN0aW9uIChjaHVuaykge1xuXHRcdFx0XHRcdC8vIHNlZSBodHRwOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVlc3Rpb25zLzM3NTE5ODI4XG5cdFx0XHRcdFx0aWYgKChjaHVua1swXSAmIDB4MEYpID09PSAweDA4KSB7XG5cdFx0XHRcdFx0XHRib2R5ID0gYm9keS5waXBlKHpsaWIuY3JlYXRlSW5mbGF0ZSgpKTtcblx0XHRcdFx0XHR9IGVsc2Uge1xuXHRcdFx0XHRcdFx0Ym9keSA9IGJvZHkucGlwZSh6bGliLmNyZWF0ZUluZmxhdGVSYXcoKSk7XG5cdFx0XHRcdFx0fVxuXHRcdFx0XHRcdHJlc3BvbnNlID0gbmV3IFJlc3BvbnNlKGJvZHksIHJlc3BvbnNlX29wdGlvbnMpO1xuXHRcdFx0XHRcdHJlc29sdmUocmVzcG9uc2UpO1xuXHRcdFx0XHR9KTtcblx0XHRcdFx0cmV0dXJuO1xuXHRcdFx0fVxuXG5cdFx0XHQvLyBmb3IgYnJcblx0XHRcdGlmIChjb2RpbmdzID09ICdicicgJiYgdHlwZW9mIHpsaWIuY3JlYXRlQnJvdGxpRGVjb21wcmVzcyA9PT0gJ2Z1bmN0aW9uJykge1xuXHRcdFx0XHRib2R5ID0gYm9keS5waXBlKHpsaWIuY3JlYXRlQnJvdGxpRGVjb21wcmVzcygpKTtcblx0XHRcdFx0cmVzcG9uc2UgPSBuZXcgUmVzcG9uc2UoYm9keSwgcmVzcG9uc2Vfb3B0aW9ucyk7XG5cdFx0XHRcdHJlc29sdmUocmVzcG9uc2UpO1xuXHRcdFx0XHRyZXR1cm47XG5cdFx0XHR9XG5cblx0XHRcdC8vIG90aGVyd2lzZSwgdXNlIHJlc3BvbnNlIGFzLWlzXG5cdFx0XHRyZXNwb25zZSA9IG5ldyBSZXNwb25zZShib2R5LCByZXNwb25zZV9vcHRpb25zKTtcblx0XHRcdHJlc29sdmUocmVzcG9uc2UpO1xuXHRcdH0pO1xuXG5cdFx0d3JpdGVUb1N0cmVhbShyZXEsIHJlcXVlc3QpO1xuXHR9KTtcbn1cbi8qKlxuICogUmVkaXJlY3QgY29kZSBtYXRjaGluZ1xuICpcbiAqIEBwYXJhbSAgIE51bWJlciAgIGNvZGUgIFN0YXR1cyBjb2RlXG4gKiBAcmV0dXJuICBCb29sZWFuXG4gKi9cbmZldGNoLmlzUmVkaXJlY3QgPSBmdW5jdGlvbiAoY29kZSkge1xuXHRyZXR1cm4gY29kZSA9PT0gMzAxIHx8IGNvZGUgPT09IDMwMiB8fCBjb2RlID09PSAzMDMgfHwgY29kZSA9PT0gMzA3IHx8IGNvZGUgPT09IDMwODtcbn07XG5cbi8vIGV4cG9zZSBQcm9taXNlXG5mZXRjaC5Qcm9taXNlID0gZ2xvYmFsLlByb21pc2U7XG5cbm1vZHVsZS5leHBvcnRzID0gZXhwb3J0cyA9IGZldGNoO1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5kZWZhdWx0ID0gZXhwb3J0cztcbmV4cG9ydHMuSGVhZGVycyA9IEhlYWRlcnM7XG5leHBvcnRzLlJlcXVlc3QgPSBSZXF1ZXN0O1xuZXhwb3J0cy5SZXNwb25zZSA9IFJlc3BvbnNlO1xuZXhwb3J0cy5GZXRjaEVycm9yID0gRmV0Y2hFcnJvcjtcbiIsICJjb25zdCBub2RlRmV0Y2ggPSByZXF1aXJlKCdub2RlLWZldGNoJylcbmNvbnN0IHJlYWxGZXRjaCA9IG5vZGVGZXRjaC5kZWZhdWx0IHx8IG5vZGVGZXRjaFxuXG5jb25zdCBmZXRjaCA9IGZ1bmN0aW9uICh1cmwsIG9wdGlvbnMpIHtcbiAgLy8gU3VwcG9ydCBzY2hlbWFsZXNzIFVSSXMgb24gdGhlIHNlcnZlciBmb3IgcGFyaXR5IHdpdGggdGhlIGJyb3dzZXIuXG4gIC8vIEV4OiAvL2dpdGh1Yi5jb20vIC0+IGh0dHBzOi8vZ2l0aHViLmNvbS9cbiAgaWYgKC9eXFwvXFwvLy50ZXN0KHVybCkpIHtcbiAgICB1cmwgPSAnaHR0cHM6JyArIHVybFxuICB9XG4gIHJldHVybiByZWFsRmV0Y2guY2FsbCh0aGlzLCB1cmwsIG9wdGlvbnMpXG59XG5cbmZldGNoLnBvbnlmaWxsID0gdHJ1ZVxuXG5tb2R1bGUuZXhwb3J0cyA9IGV4cG9ydHMgPSBmZXRjaFxuZXhwb3J0cy5mZXRjaCA9IGZldGNoXG5leHBvcnRzLkhlYWRlcnMgPSBub2RlRmV0Y2guSGVhZGVyc1xuZXhwb3J0cy5SZXF1ZXN0ID0gbm9kZUZldGNoLlJlcXVlc3RcbmV4cG9ydHMuUmVzcG9uc2UgPSBub2RlRmV0Y2guUmVzcG9uc2VcblxuLy8gTmVlZGVkIGZvciBUeXBlU2NyaXB0IGNvbnN1bWVycyB3aXRob3V0IGVzTW9kdWxlSW50ZXJvcC5cbmV4cG9ydHMuZGVmYXVsdCA9IGZldGNoXG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG52YXIgX19pbXBvcnREZWZhdWx0ID0gKHRoaXMgJiYgdGhpcy5fX2ltcG9ydERlZmF1bHQpIHx8IGZ1bmN0aW9uIChtb2QpIHtcbiAgICByZXR1cm4gKG1vZCAmJiBtb2QuX19lc01vZHVsZSkgPyBtb2QgOiB7IFwiZGVmYXVsdFwiOiBtb2QgfTtcbn07XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLnVzZUZldGNoID0gdm9pZCAwO1xuY29uc3QgcmVhY3RfMSA9IHJlcXVpcmUoXCJyZWFjdFwiKTtcbmNvbnN0IG1lZGlhX3R5cGVyXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm1lZGlhLXR5cGVyXCIpKTtcbmNvbnN0IGNvbnRlbnRfdHlwZV8xID0gX19pbXBvcnREZWZhdWx0KHJlcXVpcmUoXCJjb250ZW50LXR5cGVcIikpO1xuY29uc3QgdXNlQ2FjaGVkUHJvbWlzZV8xID0gcmVxdWlyZShcIi4vdXNlQ2FjaGVkUHJvbWlzZVwiKTtcbmNvbnN0IHVzZUxhdGVzdF8xID0gcmVxdWlyZShcIi4vdXNlTGF0ZXN0XCIpO1xuY29uc3QgY3Jvc3NfZmV0Y2hfMSA9IHJlcXVpcmUoXCJjcm9zcy1mZXRjaFwiKTtcbmZ1bmN0aW9uIGlzSlNPTihjb250ZW50VHlwZUhlYWRlcikge1xuICAgIGlmIChjb250ZW50VHlwZUhlYWRlcikge1xuICAgICAgICBjb25zdCBjdCA9IGNvbnRlbnRfdHlwZV8xLmRlZmF1bHQucGFyc2UoY29udGVudFR5cGVIZWFkZXIpO1xuICAgICAgICBjb25zdCBtZWRpYVR5cGUgPSBtZWRpYV90eXBlcl8xLmRlZmF1bHQucGFyc2UoY3QudHlwZSk7XG4gICAgICAgIGlmIChtZWRpYVR5cGUuc3VidHlwZSA9PT0gXCJqc29uXCIpIHtcbiAgICAgICAgICAgIHJldHVybiB0cnVlO1xuICAgICAgICB9XG4gICAgICAgIGlmIChtZWRpYVR5cGUuc3VmZml4ID09PSBcImpzb25cIikge1xuICAgICAgICAgICAgcmV0dXJuIHRydWU7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKG1lZGlhVHlwZS5zdWZmaXggJiYgL1xcYmpzb25cXGIvaS50ZXN0KG1lZGlhVHlwZS5zdWZmaXgpKSB7XG4gICAgICAgICAgICByZXR1cm4gdHJ1ZTtcbiAgICAgICAgfVxuICAgICAgICBpZiAobWVkaWFUeXBlLnN1YnR5cGUgJiYgL1xcYmpzb25cXGIvaS50ZXN0KG1lZGlhVHlwZS5zdWJ0eXBlKSkge1xuICAgICAgICAgICAgcmV0dXJuIHRydWU7XG4gICAgICAgIH1cbiAgICB9XG4gICAgcmV0dXJuIGZhbHNlO1xufVxuYXN5bmMgZnVuY3Rpb24gZGVmYXVsdFBhcnNpbmcocmVzcG9uc2UpIHtcbiAgICBpZiAoIXJlc3BvbnNlLm9rKSB7XG4gICAgICAgIHRocm93IG5ldyBFcnJvcihyZXNwb25zZS5zdGF0dXNUZXh0KTtcbiAgICB9XG4gICAgY29uc3QgY29udGVudFR5cGVIZWFkZXIgPSByZXNwb25zZS5oZWFkZXJzLmdldChcImNvbnRlbnQtdHlwZVwiKTtcbiAgICBpZiAoY29udGVudFR5cGVIZWFkZXIgJiYgaXNKU09OKGNvbnRlbnRUeXBlSGVhZGVyKSkge1xuICAgICAgICByZXR1cm4gYXdhaXQgcmVzcG9uc2UuanNvbigpO1xuICAgIH1cbiAgICByZXR1cm4gYXdhaXQgcmVzcG9uc2UudGV4dCgpO1xufVxuLyoqXG4gKiBGZXRjaCB0aGUgVVJMIGFuZCByZXR1cm5zIHRoZSB7QGxpbmsgQXN5bmNTdGF0ZX0gY29ycmVzcG9uZGluZyB0byB0aGUgZXhlY3V0aW9uIG9mIHRoZSBmZXRjaC4gVGhlIGxhc3QgdmFsdWUgd2lsbCBiZSBrZXB0IGJldHdlZW4gY29tbWFuZCBydW5zLlxuICpcbiAqIEBleGFtcGxlXG4gKiBgYGBcbiAqIGltcG9ydCB7IHVzZUZldGNoIH0gZnJvbSAnQHJheWNhc3QvdXRpbHMnO1xuICpcbiAqIGNvbnN0IERlbW8gPSAoKSA9PiB7XG4gKiAgIGNvbnN0IHsgaXNMb2FkaW5nLCBkYXRhLCByZXZhbGlkYXRlIH0gPSB1c2VGZXRjaCgnaHR0cHM6Ly9hcGkuZXhhbXBsZScpO1xuICpcbiAqICAgcmV0dXJuIChcbiAqICAgICA8RGV0YWlsXG4gKiAgICAgICBpc0xvYWRpbmc9e2lzTG9hZGluZ31cbiAqICAgICAgIG1hcmtkb3duPXtkYXRhfVxuICogICAgICAgYWN0aW9ucz17XG4gKiAgICAgICAgIDxBY3Rpb25QYW5lbD5cbiAqICAgICAgICAgICA8QWN0aW9uIHRpdGxlPVwiUmVsb2FkXCIgb25BY3Rpb249eygpID0+IHJldmFsaWRhdGUoKX0gLz5cbiAqICAgICAgICAgPC9BY3Rpb25QYW5lbD5cbiAqICAgICAgIH1cbiAqICAgICAvPlxuICogICApO1xuICogfTtcbiAqIGBgYFxuICovXG5mdW5jdGlvbiB1c2VGZXRjaCh1cmwsIG9wdGlvbnMpIHtcbiAgICBjb25zdCB7IHBhcnNlUmVzcG9uc2UsIGluaXRpYWxEYXRhLCBleGVjdXRlLCBrZWVwUHJldmlvdXNEYXRhLCBvbkVycm9yLCBvbkRhdGEsIG9uV2lsbEV4ZWN1dGUsIC4uLmZldGNoT3B0aW9ucyB9ID0gb3B0aW9ucyB8fCB7fTtcbiAgICBjb25zdCB1c2VDYWNoZWRQcm9taXNlT3B0aW9ucyA9IHtcbiAgICAgICAgaW5pdGlhbERhdGEsXG4gICAgICAgIGV4ZWN1dGUsXG4gICAgICAgIGtlZXBQcmV2aW91c0RhdGEsXG4gICAgICAgIG9uRXJyb3IsXG4gICAgICAgIG9uRGF0YSxcbiAgICAgICAgb25XaWxsRXhlY3V0ZSxcbiAgICB9O1xuICAgIGNvbnN0IHBhcnNlUmVzcG9uc2VSZWYgPSAoMCwgdXNlTGF0ZXN0XzEudXNlTGF0ZXN0KShwYXJzZVJlc3BvbnNlIHx8IGRlZmF1bHRQYXJzaW5nKTtcbiAgICBjb25zdCBhYm9ydGFibGUgPSAoMCwgcmVhY3RfMS51c2VSZWYpKCk7XG4gICAgY29uc3QgZm4gPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoYXN5bmMgKHVybCwgb3B0aW9ucykgPT4ge1xuICAgICAgICBjb25zdCByZXMgPSBhd2FpdCAoMCwgY3Jvc3NfZmV0Y2hfMS5mZXRjaCkodXJsLCB7IHNpZ25hbDogYWJvcnRhYmxlLmN1cnJlbnQ/LnNpZ25hbCwgLi4ub3B0aW9ucyB9KTtcbiAgICAgICAgcmV0dXJuIChhd2FpdCBwYXJzZVJlc3BvbnNlUmVmLmN1cnJlbnQocmVzKSk7XG4gICAgfSwgW3BhcnNlUmVzcG9uc2VSZWZdKTtcbiAgICAvLyBAdHMtZXhwZWN0LWVycm9yIFQgY2FuJ3QgYmUgYSBQcm9taXNlIHNvIGl0J3MgYWN0dWFsbHkgdGhlIHNhbWVcbiAgICByZXR1cm4gKDAsIHVzZUNhY2hlZFByb21pc2VfMS51c2VDYWNoZWRQcm9taXNlKShmbiwgW3VybCwgZmV0Y2hPcHRpb25zXSwgeyAuLi51c2VDYWNoZWRQcm9taXNlT3B0aW9ucywgYWJvcnRhYmxlIH0pO1xufVxuZXhwb3J0cy51c2VGZXRjaCA9IHVzZUZldGNoO1xuIiwgIi8vIFRoaXMgaXMgbm90IHRoZSBzZXQgb2YgYWxsIHBvc3NpYmxlIHNpZ25hbHMuXG4vL1xuLy8gSXQgSVMsIGhvd2V2ZXIsIHRoZSBzZXQgb2YgYWxsIHNpZ25hbHMgdGhhdCB0cmlnZ2VyXG4vLyBhbiBleGl0IG9uIGVpdGhlciBMaW51eCBvciBCU0Qgc3lzdGVtcy4gIExpbnV4IGlzIGFcbi8vIHN1cGVyc2V0IG9mIHRoZSBzaWduYWwgbmFtZXMgc3VwcG9ydGVkIG9uIEJTRCwgYW5kXG4vLyB0aGUgdW5rbm93biBzaWduYWxzIGp1c3QgZmFpbCB0byByZWdpc3Rlciwgc28gd2UgY2FuXG4vLyBjYXRjaCB0aGF0IGVhc2lseSBlbm91Z2guXG4vL1xuLy8gRG9uJ3QgYm90aGVyIHdpdGggU0lHS0lMTC4gIEl0J3MgdW5jYXRjaGFibGUsIHdoaWNoXG4vLyBtZWFucyB0aGF0IHdlIGNhbid0IGZpcmUgYW55IGNhbGxiYWNrcyBhbnl3YXkuXG4vL1xuLy8gSWYgYSB1c2VyIGRvZXMgaGFwcGVuIHRvIHJlZ2lzdGVyIGEgaGFuZGxlciBvbiBhIG5vbi1cbi8vIGZhdGFsIHNpZ25hbCBsaWtlIFNJR1dJTkNIIG9yIHNvbWV0aGluZywgYW5kIHRoZW5cbi8vIGV4aXQsIGl0J2xsIGVuZCB1cCBmaXJpbmcgYHByb2Nlc3MuZW1pdCgnZXhpdCcpYCwgc29cbi8vIHRoZSBoYW5kbGVyIHdpbGwgYmUgZmlyZWQgYW55d2F5LlxuLy9cbi8vIFNJR0JVUywgU0lHRlBFLCBTSUdTRUdWIGFuZCBTSUdJTEwsIHdoZW4gbm90IHJhaXNlZFxuLy8gYXJ0aWZpY2lhbGx5LCBpbmhlcmVudGx5IGxlYXZlIHRoZSBwcm9jZXNzIGluIGFcbi8vIHN0YXRlIGZyb20gd2hpY2ggaXQgaXMgbm90IHNhZmUgdG8gdHJ5IGFuZCBlbnRlciBKU1xuLy8gbGlzdGVuZXJzLlxubW9kdWxlLmV4cG9ydHMgPSBbXG4gICdTSUdBQlJUJyxcbiAgJ1NJR0FMUk0nLFxuICAnU0lHSFVQJyxcbiAgJ1NJR0lOVCcsXG4gICdTSUdURVJNJ1xuXVxuXG5pZiAocHJvY2Vzcy5wbGF0Zm9ybSAhPT0gJ3dpbjMyJykge1xuICBtb2R1bGUuZXhwb3J0cy5wdXNoKFxuICAgICdTSUdWVEFMUk0nLFxuICAgICdTSUdYQ1BVJyxcbiAgICAnU0lHWEZTWicsXG4gICAgJ1NJR1VTUjInLFxuICAgICdTSUdUUkFQJyxcbiAgICAnU0lHU1lTJyxcbiAgICAnU0lHUVVJVCcsXG4gICAgJ1NJR0lPVCdcbiAgICAvLyBzaG91bGQgZGV0ZWN0IHByb2ZpbGVyIGFuZCBlbmFibGUvZGlzYWJsZSBhY2NvcmRpbmdseS5cbiAgICAvLyBzZWUgIzIxXG4gICAgLy8gJ1NJR1BST0YnXG4gIClcbn1cblxuaWYgKHByb2Nlc3MucGxhdGZvcm0gPT09ICdsaW51eCcpIHtcbiAgbW9kdWxlLmV4cG9ydHMucHVzaChcbiAgICAnU0lHSU8nLFxuICAgICdTSUdQT0xMJyxcbiAgICAnU0lHUFdSJyxcbiAgICAnU0lHU1RLRkxUJyxcbiAgICAnU0lHVU5VU0VEJ1xuICApXG59XG4iLCAiLy8gTm90ZTogc2luY2UgbnljIHVzZXMgdGhpcyBtb2R1bGUgdG8gb3V0cHV0IGNvdmVyYWdlLCBhbnkgbGluZXNcbi8vIHRoYXQgYXJlIGluIHRoZSBkaXJlY3Qgc3luYyBmbG93IG9mIG55YydzIG91dHB1dENvdmVyYWdlIGFyZVxuLy8gaWdub3JlZCwgc2luY2Ugd2UgY2FuIG5ldmVyIGdldCBjb3ZlcmFnZSBmb3IgdGhlbS5cbi8vIGdyYWIgYSByZWZlcmVuY2UgdG8gbm9kZSdzIHJlYWwgcHJvY2VzcyBvYmplY3QgcmlnaHQgYXdheVxudmFyIHByb2Nlc3MgPSBnbG9iYWwucHJvY2Vzc1xuXG5jb25zdCBwcm9jZXNzT2sgPSBmdW5jdGlvbiAocHJvY2Vzcykge1xuICByZXR1cm4gcHJvY2VzcyAmJlxuICAgIHR5cGVvZiBwcm9jZXNzID09PSAnb2JqZWN0JyAmJlxuICAgIHR5cGVvZiBwcm9jZXNzLnJlbW92ZUxpc3RlbmVyID09PSAnZnVuY3Rpb24nICYmXG4gICAgdHlwZW9mIHByb2Nlc3MuZW1pdCA9PT0gJ2Z1bmN0aW9uJyAmJlxuICAgIHR5cGVvZiBwcm9jZXNzLnJlYWxseUV4aXQgPT09ICdmdW5jdGlvbicgJiZcbiAgICB0eXBlb2YgcHJvY2Vzcy5saXN0ZW5lcnMgPT09ICdmdW5jdGlvbicgJiZcbiAgICB0eXBlb2YgcHJvY2Vzcy5raWxsID09PSAnZnVuY3Rpb24nICYmXG4gICAgdHlwZW9mIHByb2Nlc3MucGlkID09PSAnbnVtYmVyJyAmJlxuICAgIHR5cGVvZiBwcm9jZXNzLm9uID09PSAnZnVuY3Rpb24nXG59XG5cbi8vIHNvbWUga2luZCBvZiBub24tbm9kZSBlbnZpcm9ubWVudCwganVzdCBuby1vcFxuLyogaXN0YW5idWwgaWdub3JlIGlmICovXG5pZiAoIXByb2Nlc3NPayhwcm9jZXNzKSkge1xuICBtb2R1bGUuZXhwb3J0cyA9IGZ1bmN0aW9uICgpIHtcbiAgICByZXR1cm4gZnVuY3Rpb24gKCkge31cbiAgfVxufSBlbHNlIHtcbiAgdmFyIGFzc2VydCA9IHJlcXVpcmUoJ2Fzc2VydCcpXG4gIHZhciBzaWduYWxzID0gcmVxdWlyZSgnLi9zaWduYWxzLmpzJylcbiAgdmFyIGlzV2luID0gL153aW4vaS50ZXN0KHByb2Nlc3MucGxhdGZvcm0pXG5cbiAgdmFyIEVFID0gcmVxdWlyZSgnZXZlbnRzJylcbiAgLyogaXN0YW5idWwgaWdub3JlIGlmICovXG4gIGlmICh0eXBlb2YgRUUgIT09ICdmdW5jdGlvbicpIHtcbiAgICBFRSA9IEVFLkV2ZW50RW1pdHRlclxuICB9XG5cbiAgdmFyIGVtaXR0ZXJcbiAgaWYgKHByb2Nlc3MuX19zaWduYWxfZXhpdF9lbWl0dGVyX18pIHtcbiAgICBlbWl0dGVyID0gcHJvY2Vzcy5fX3NpZ25hbF9leGl0X2VtaXR0ZXJfX1xuICB9IGVsc2Uge1xuICAgIGVtaXR0ZXIgPSBwcm9jZXNzLl9fc2lnbmFsX2V4aXRfZW1pdHRlcl9fID0gbmV3IEVFKClcbiAgICBlbWl0dGVyLmNvdW50ID0gMFxuICAgIGVtaXR0ZXIuZW1pdHRlZCA9IHt9XG4gIH1cblxuICAvLyBCZWNhdXNlIHRoaXMgZW1pdHRlciBpcyBhIGdsb2JhbCwgd2UgaGF2ZSB0byBjaGVjayB0byBzZWUgaWYgYVxuICAvLyBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgbGlicmFyeSBmYWlsZWQgdG8gZW5hYmxlIGluZmluaXRlIGxpc3RlbmVycy5cbiAgLy8gSSBrbm93IHdoYXQgeW91J3JlIGFib3V0IHRvIHNheS4gIEJ1dCBsaXRlcmFsbHkgZXZlcnl0aGluZyBhYm91dFxuICAvLyBzaWduYWwtZXhpdCBpcyBhIGNvbXByb21pc2Ugd2l0aCBldmlsLiAgR2V0IHVzZWQgdG8gaXQuXG4gIGlmICghZW1pdHRlci5pbmZpbml0ZSkge1xuICAgIGVtaXR0ZXIuc2V0TWF4TGlzdGVuZXJzKEluZmluaXR5KVxuICAgIGVtaXR0ZXIuaW5maW5pdGUgPSB0cnVlXG4gIH1cblxuICBtb2R1bGUuZXhwb3J0cyA9IGZ1bmN0aW9uIChjYiwgb3B0cykge1xuICAgIC8qIGlzdGFuYnVsIGlnbm9yZSBpZiAqL1xuICAgIGlmICghcHJvY2Vzc09rKGdsb2JhbC5wcm9jZXNzKSkge1xuICAgICAgcmV0dXJuIGZ1bmN0aW9uICgpIHt9XG4gICAgfVxuICAgIGFzc2VydC5lcXVhbCh0eXBlb2YgY2IsICdmdW5jdGlvbicsICdhIGNhbGxiYWNrIG11c3QgYmUgcHJvdmlkZWQgZm9yIGV4aXQgaGFuZGxlcicpXG5cbiAgICBpZiAobG9hZGVkID09PSBmYWxzZSkge1xuICAgICAgbG9hZCgpXG4gICAgfVxuXG4gICAgdmFyIGV2ID0gJ2V4aXQnXG4gICAgaWYgKG9wdHMgJiYgb3B0cy5hbHdheXNMYXN0KSB7XG4gICAgICBldiA9ICdhZnRlcmV4aXQnXG4gICAgfVxuXG4gICAgdmFyIHJlbW92ZSA9IGZ1bmN0aW9uICgpIHtcbiAgICAgIGVtaXR0ZXIucmVtb3ZlTGlzdGVuZXIoZXYsIGNiKVxuICAgICAgaWYgKGVtaXR0ZXIubGlzdGVuZXJzKCdleGl0JykubGVuZ3RoID09PSAwICYmXG4gICAgICAgICAgZW1pdHRlci5saXN0ZW5lcnMoJ2FmdGVyZXhpdCcpLmxlbmd0aCA9PT0gMCkge1xuICAgICAgICB1bmxvYWQoKVxuICAgICAgfVxuICAgIH1cbiAgICBlbWl0dGVyLm9uKGV2LCBjYilcblxuICAgIHJldHVybiByZW1vdmVcbiAgfVxuXG4gIHZhciB1bmxvYWQgPSBmdW5jdGlvbiB1bmxvYWQgKCkge1xuICAgIGlmICghbG9hZGVkIHx8ICFwcm9jZXNzT2soZ2xvYmFsLnByb2Nlc3MpKSB7XG4gICAgICByZXR1cm5cbiAgICB9XG4gICAgbG9hZGVkID0gZmFsc2VcblxuICAgIHNpZ25hbHMuZm9yRWFjaChmdW5jdGlvbiAoc2lnKSB7XG4gICAgICB0cnkge1xuICAgICAgICBwcm9jZXNzLnJlbW92ZUxpc3RlbmVyKHNpZywgc2lnTGlzdGVuZXJzW3NpZ10pXG4gICAgICB9IGNhdGNoIChlcikge31cbiAgICB9KVxuICAgIHByb2Nlc3MuZW1pdCA9IG9yaWdpbmFsUHJvY2Vzc0VtaXRcbiAgICBwcm9jZXNzLnJlYWxseUV4aXQgPSBvcmlnaW5hbFByb2Nlc3NSZWFsbHlFeGl0XG4gICAgZW1pdHRlci5jb3VudCAtPSAxXG4gIH1cbiAgbW9kdWxlLmV4cG9ydHMudW5sb2FkID0gdW5sb2FkXG5cbiAgdmFyIGVtaXQgPSBmdW5jdGlvbiBlbWl0IChldmVudCwgY29kZSwgc2lnbmFsKSB7XG4gICAgLyogaXN0YW5idWwgaWdub3JlIGlmICovXG4gICAgaWYgKGVtaXR0ZXIuZW1pdHRlZFtldmVudF0pIHtcbiAgICAgIHJldHVyblxuICAgIH1cbiAgICBlbWl0dGVyLmVtaXR0ZWRbZXZlbnRdID0gdHJ1ZVxuICAgIGVtaXR0ZXIuZW1pdChldmVudCwgY29kZSwgc2lnbmFsKVxuICB9XG5cbiAgLy8geyA8c2lnbmFsPjogPGxpc3RlbmVyIGZuPiwgLi4uIH1cbiAgdmFyIHNpZ0xpc3RlbmVycyA9IHt9XG4gIHNpZ25hbHMuZm9yRWFjaChmdW5jdGlvbiAoc2lnKSB7XG4gICAgc2lnTGlzdGVuZXJzW3NpZ10gPSBmdW5jdGlvbiBsaXN0ZW5lciAoKSB7XG4gICAgICAvKiBpc3RhbmJ1bCBpZ25vcmUgaWYgKi9cbiAgICAgIGlmICghcHJvY2Vzc09rKGdsb2JhbC5wcm9jZXNzKSkge1xuICAgICAgICByZXR1cm5cbiAgICAgIH1cbiAgICAgIC8vIElmIHRoZXJlIGFyZSBubyBvdGhlciBsaXN0ZW5lcnMsIGFuIGV4aXQgaXMgY29taW5nIVxuICAgICAgLy8gU2ltcGxlc3Qgd2F5OiByZW1vdmUgdXMgYW5kIHRoZW4gcmUtc2VuZCB0aGUgc2lnbmFsLlxuICAgICAgLy8gV2Uga25vdyB0aGF0IHRoaXMgd2lsbCBraWxsIHRoZSBwcm9jZXNzLCBzbyB3ZSBjYW5cbiAgICAgIC8vIHNhZmVseSBlbWl0IG5vdy5cbiAgICAgIHZhciBsaXN0ZW5lcnMgPSBwcm9jZXNzLmxpc3RlbmVycyhzaWcpXG4gICAgICBpZiAobGlzdGVuZXJzLmxlbmd0aCA9PT0gZW1pdHRlci5jb3VudCkge1xuICAgICAgICB1bmxvYWQoKVxuICAgICAgICBlbWl0KCdleGl0JywgbnVsbCwgc2lnKVxuICAgICAgICAvKiBpc3RhbmJ1bCBpZ25vcmUgbmV4dCAqL1xuICAgICAgICBlbWl0KCdhZnRlcmV4aXQnLCBudWxsLCBzaWcpXG4gICAgICAgIC8qIGlzdGFuYnVsIGlnbm9yZSBuZXh0ICovXG4gICAgICAgIGlmIChpc1dpbiAmJiBzaWcgPT09ICdTSUdIVVAnKSB7XG4gICAgICAgICAgLy8gXCJTSUdIVVBcIiB0aHJvd3MgYW4gYEVOT1NZU2AgZXJyb3Igb24gV2luZG93cyxcbiAgICAgICAgICAvLyBzbyB1c2UgYSBzdXBwb3J0ZWQgc2lnbmFsIGluc3RlYWRcbiAgICAgICAgICBzaWcgPSAnU0lHSU5UJ1xuICAgICAgICB9XG4gICAgICAgIC8qIGlzdGFuYnVsIGlnbm9yZSBuZXh0ICovXG4gICAgICAgIHByb2Nlc3Mua2lsbChwcm9jZXNzLnBpZCwgc2lnKVxuICAgICAgfVxuICAgIH1cbiAgfSlcblxuICBtb2R1bGUuZXhwb3J0cy5zaWduYWxzID0gZnVuY3Rpb24gKCkge1xuICAgIHJldHVybiBzaWduYWxzXG4gIH1cblxuICB2YXIgbG9hZGVkID0gZmFsc2VcblxuICB2YXIgbG9hZCA9IGZ1bmN0aW9uIGxvYWQgKCkge1xuICAgIGlmIChsb2FkZWQgfHwgIXByb2Nlc3NPayhnbG9iYWwucHJvY2VzcykpIHtcbiAgICAgIHJldHVyblxuICAgIH1cbiAgICBsb2FkZWQgPSB0cnVlXG5cbiAgICAvLyBUaGlzIGlzIHRoZSBudW1iZXIgb2Ygb25TaWduYWxFeGl0J3MgdGhhdCBhcmUgaW4gcGxheS5cbiAgICAvLyBJdCdzIGltcG9ydGFudCBzbyB0aGF0IHdlIGNhbiBjb3VudCB0aGUgY29ycmVjdCBudW1iZXIgb2ZcbiAgICAvLyBsaXN0ZW5lcnMgb24gc2lnbmFscywgYW5kIGRvbid0IHdhaXQgZm9yIHRoZSBvdGhlciBvbmUgdG9cbiAgICAvLyBoYW5kbGUgaXQgaW5zdGVhZCBvZiB1cy5cbiAgICBlbWl0dGVyLmNvdW50ICs9IDFcblxuICAgIHNpZ25hbHMgPSBzaWduYWxzLmZpbHRlcihmdW5jdGlvbiAoc2lnKSB7XG4gICAgICB0cnkge1xuICAgICAgICBwcm9jZXNzLm9uKHNpZywgc2lnTGlzdGVuZXJzW3NpZ10pXG4gICAgICAgIHJldHVybiB0cnVlXG4gICAgICB9IGNhdGNoIChlcikge1xuICAgICAgICByZXR1cm4gZmFsc2VcbiAgICAgIH1cbiAgICB9KVxuXG4gICAgcHJvY2Vzcy5lbWl0ID0gcHJvY2Vzc0VtaXRcbiAgICBwcm9jZXNzLnJlYWxseUV4aXQgPSBwcm9jZXNzUmVhbGx5RXhpdFxuICB9XG4gIG1vZHVsZS5leHBvcnRzLmxvYWQgPSBsb2FkXG5cbiAgdmFyIG9yaWdpbmFsUHJvY2Vzc1JlYWxseUV4aXQgPSBwcm9jZXNzLnJlYWxseUV4aXRcbiAgdmFyIHByb2Nlc3NSZWFsbHlFeGl0ID0gZnVuY3Rpb24gcHJvY2Vzc1JlYWxseUV4aXQgKGNvZGUpIHtcbiAgICAvKiBpc3RhbmJ1bCBpZ25vcmUgaWYgKi9cbiAgICBpZiAoIXByb2Nlc3NPayhnbG9iYWwucHJvY2VzcykpIHtcbiAgICAgIHJldHVyblxuICAgIH1cbiAgICBwcm9jZXNzLmV4aXRDb2RlID0gY29kZSB8fCAvKiBpc3RhbmJ1bCBpZ25vcmUgbmV4dCAqLyAwXG4gICAgZW1pdCgnZXhpdCcsIHByb2Nlc3MuZXhpdENvZGUsIG51bGwpXG4gICAgLyogaXN0YW5idWwgaWdub3JlIG5leHQgKi9cbiAgICBlbWl0KCdhZnRlcmV4aXQnLCBwcm9jZXNzLmV4aXRDb2RlLCBudWxsKVxuICAgIC8qIGlzdGFuYnVsIGlnbm9yZSBuZXh0ICovXG4gICAgb3JpZ2luYWxQcm9jZXNzUmVhbGx5RXhpdC5jYWxsKHByb2Nlc3MsIHByb2Nlc3MuZXhpdENvZGUpXG4gIH1cblxuICB2YXIgb3JpZ2luYWxQcm9jZXNzRW1pdCA9IHByb2Nlc3MuZW1pdFxuICB2YXIgcHJvY2Vzc0VtaXQgPSBmdW5jdGlvbiBwcm9jZXNzRW1pdCAoZXYsIGFyZykge1xuICAgIGlmIChldiA9PT0gJ2V4aXQnICYmIHByb2Nlc3NPayhnbG9iYWwucHJvY2VzcykpIHtcbiAgICAgIC8qIGlzdGFuYnVsIGlnbm9yZSBlbHNlICovXG4gICAgICBpZiAoYXJnICE9PSB1bmRlZmluZWQpIHtcbiAgICAgICAgcHJvY2Vzcy5leGl0Q29kZSA9IGFyZ1xuICAgICAgfVxuICAgICAgdmFyIHJldCA9IG9yaWdpbmFsUHJvY2Vzc0VtaXQuYXBwbHkodGhpcywgYXJndW1lbnRzKVxuICAgICAgLyogaXN0YW5idWwgaWdub3JlIG5leHQgKi9cbiAgICAgIGVtaXQoJ2V4aXQnLCBwcm9jZXNzLmV4aXRDb2RlLCBudWxsKVxuICAgICAgLyogaXN0YW5idWwgaWdub3JlIG5leHQgKi9cbiAgICAgIGVtaXQoJ2FmdGVyZXhpdCcsIHByb2Nlc3MuZXhpdENvZGUsIG51bGwpXG4gICAgICAvKiBpc3RhbmJ1bCBpZ25vcmUgbmV4dCAqL1xuICAgICAgcmV0dXJuIHJldFxuICAgIH0gZWxzZSB7XG4gICAgICByZXR1cm4gb3JpZ2luYWxQcm9jZXNzRW1pdC5hcHBseSh0aGlzLCBhcmd1bWVudHMpXG4gICAgfVxuICB9XG59XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG52YXIgX19pbXBvcnREZWZhdWx0ID0gKHRoaXMgJiYgdGhpcy5fX2ltcG9ydERlZmF1bHQpIHx8IGZ1bmN0aW9uIChtb2QpIHtcbiAgICByZXR1cm4gKG1vZCAmJiBtb2QuX19lc01vZHVsZSkgPyBtb2QgOiB7IFwiZGVmYXVsdFwiOiBtb2QgfTtcbn07XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLmdldFNwYXduZWRSZXN1bHQgPSBleHBvcnRzLmdldFNwYXduZWRQcm9taXNlID0gdm9pZCAwO1xuY29uc3Qgbm9kZV9idWZmZXJfMSA9IHJlcXVpcmUoXCJub2RlOmJ1ZmZlclwiKTtcbmNvbnN0IG5vZGVfc3RyZWFtXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm5vZGU6c3RyZWFtXCIpKTtcbmNvbnN0IG5vZGVfdXRpbF8xID0gcmVxdWlyZShcIm5vZGU6dXRpbFwiKTtcbmNvbnN0IHNpZ25hbF9leGl0XzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcInNpZ25hbC1leGl0XCIpKTtcbmZ1bmN0aW9uIGdldFNwYXduZWRQcm9taXNlKHNwYXduZWQsIHsgdGltZW91dCB9ID0ge30pIHtcbiAgICBjb25zdCBzcGF3bmVkUHJvbWlzZSA9IG5ldyBQcm9taXNlKChyZXNvbHZlLCByZWplY3QpID0+IHtcbiAgICAgICAgc3Bhd25lZC5vbihcImV4aXRcIiwgKGV4aXRDb2RlLCBzaWduYWwpID0+IHtcbiAgICAgICAgICAgIHJlc29sdmUoeyBleGl0Q29kZSwgc2lnbmFsLCB0aW1lZE91dDogZmFsc2UgfSk7XG4gICAgICAgIH0pO1xuICAgICAgICBzcGF3bmVkLm9uKFwiZXJyb3JcIiwgKGVycm9yKSA9PiB7XG4gICAgICAgICAgICByZWplY3QoZXJyb3IpO1xuICAgICAgICB9KTtcbiAgICAgICAgaWYgKHNwYXduZWQuc3RkaW4pIHtcbiAgICAgICAgICAgIHNwYXduZWQuc3RkaW4ub24oXCJlcnJvclwiLCAoZXJyb3IpID0+IHtcbiAgICAgICAgICAgICAgICByZWplY3QoZXJyb3IpO1xuICAgICAgICAgICAgfSk7XG4gICAgICAgIH1cbiAgICB9KTtcbiAgICBpZiAodGltZW91dCA9PT0gMCB8fCB0aW1lb3V0ID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgcmV0dXJuIHNwYXduZWRQcm9taXNlO1xuICAgIH1cbiAgICBsZXQgdGltZW91dElkO1xuICAgIGNvbnN0IHRpbWVvdXRQcm9taXNlID0gbmV3IFByb21pc2UoKF9yZXNvbHZlLCByZWplY3QpID0+IHtcbiAgICAgICAgdGltZW91dElkID0gc2V0VGltZW91dCgoKSA9PiB7XG4gICAgICAgICAgICBzcGF3bmVkLmtpbGwoXCJTSUdURVJNXCIpO1xuICAgICAgICAgICAgcmVqZWN0KE9iamVjdC5hc3NpZ24obmV3IEVycm9yKFwiVGltZWQgb3V0XCIpLCB7IHRpbWVkT3V0OiB0cnVlLCBzaWduYWw6IFwiU0lHVEVSTVwiIH0pKTtcbiAgICAgICAgfSwgdGltZW91dCk7XG4gICAgfSk7XG4gICAgY29uc3Qgc2FmZVNwYXduZWRQcm9taXNlID0gc3Bhd25lZFByb21pc2UuZmluYWxseSgoKSA9PiB7XG4gICAgICAgIGNsZWFyVGltZW91dCh0aW1lb3V0SWQpO1xuICAgIH0pO1xuICAgIGNvbnN0IHJlbW92ZUV4aXRIYW5kbGVyID0gKDAsIHNpZ25hbF9leGl0XzEuZGVmYXVsdCkoKCkgPT4ge1xuICAgICAgICBzcGF3bmVkLmtpbGwoKTtcbiAgICB9KTtcbiAgICByZXR1cm4gUHJvbWlzZS5yYWNlKFt0aW1lb3V0UHJvbWlzZSwgc2FmZVNwYXduZWRQcm9taXNlXSkuZmluYWxseSgoKSA9PiByZW1vdmVFeGl0SGFuZGxlcigpKTtcbn1cbmV4cG9ydHMuZ2V0U3Bhd25lZFByb21pc2UgPSBnZXRTcGF3bmVkUHJvbWlzZTtcbmNsYXNzIE1heEJ1ZmZlckVycm9yIGV4dGVuZHMgRXJyb3Ige1xuICAgIGNvbnN0cnVjdG9yKCkge1xuICAgICAgICBzdXBlcihcIlRoZSBvdXRwdXQgaXMgdG9vIGJpZ1wiKTtcbiAgICAgICAgdGhpcy5uYW1lID0gXCJNYXhCdWZmZXJFcnJvclwiO1xuICAgIH1cbn1cbmNvbnN0IHN0cmVhbVBpcGVsaW5lUHJvbWlzaWZpZWQgPSAoMCwgbm9kZV91dGlsXzEucHJvbWlzaWZ5KShub2RlX3N0cmVhbV8xLmRlZmF1bHQucGlwZWxpbmUpO1xuZnVuY3Rpb24gYnVmZmVyU3RyZWFtKG9wdGlvbnMpIHtcbiAgICBjb25zdCB7IGVuY29kaW5nIH0gPSBvcHRpb25zO1xuICAgIGNvbnN0IGlzQnVmZmVyID0gZW5jb2RpbmcgPT09IFwiYnVmZmVyXCI7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBtaXNzaW5nIHRoZSBtZXRob2RzIHdlIGFyZSBhZGRpbmcgYmVsb3dcbiAgICBjb25zdCBzdHJlYW0gPSBuZXcgbm9kZV9zdHJlYW1fMS5kZWZhdWx0LlBhc3NUaHJvdWdoKHsgb2JqZWN0TW9kZTogZmFsc2UgfSk7XG4gICAgaWYgKGVuY29kaW5nICYmIGVuY29kaW5nICE9PSBcImJ1ZmZlclwiKSB7XG4gICAgICAgIHN0cmVhbS5zZXRFbmNvZGluZyhlbmNvZGluZyk7XG4gICAgfVxuICAgIGxldCBsZW5ndGggPSAwO1xuICAgIGNvbnN0IGNodW5rcyA9IFtdO1xuICAgIHN0cmVhbS5vbihcImRhdGFcIiwgKGNodW5rKSA9PiB7XG4gICAgICAgIGNodW5rcy5wdXNoKGNodW5rKTtcbiAgICAgICAgbGVuZ3RoICs9IGNodW5rLmxlbmd0aDtcbiAgICB9KTtcbiAgICBzdHJlYW0uZ2V0QnVmZmVyZWRWYWx1ZSA9ICgpID0+IHtcbiAgICAgICAgcmV0dXJuIChpc0J1ZmZlciA/IEJ1ZmZlci5jb25jYXQoY2h1bmtzLCBsZW5ndGgpIDogY2h1bmtzLmpvaW4oXCJcIikpO1xuICAgIH07XG4gICAgc3RyZWFtLmdldEJ1ZmZlcmVkTGVuZ3RoID0gKCkgPT4gbGVuZ3RoO1xuICAgIHJldHVybiBzdHJlYW07XG59XG5hc3luYyBmdW5jdGlvbiBnZXRTdHJlYW0oaW5wdXRTdHJlYW0sIG9wdGlvbnMpIHtcbiAgICBjb25zdCBzdHJlYW0gPSBidWZmZXJTdHJlYW0ob3B0aW9ucyk7XG4gICAgYXdhaXQgbmV3IFByb21pc2UoKHJlc29sdmUsIHJlamVjdCkgPT4ge1xuICAgICAgICBjb25zdCByZWplY3RQcm9taXNlID0gKGVycm9yKSA9PiB7XG4gICAgICAgICAgICAvLyBEb24ndCByZXRyaWV2ZSBhbiBvdmVyc2l6ZWQgYnVmZmVyLlxuICAgICAgICAgICAgaWYgKGVycm9yICYmIHN0cmVhbS5nZXRCdWZmZXJlZExlbmd0aCgpIDw9IG5vZGVfYnVmZmVyXzEuY29uc3RhbnRzLk1BWF9MRU5HVEgpIHtcbiAgICAgICAgICAgICAgICBlcnJvci5idWZmZXJlZERhdGEgPSBzdHJlYW0uZ2V0QnVmZmVyZWRWYWx1ZSgpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgcmVqZWN0KGVycm9yKTtcbiAgICAgICAgfTtcbiAgICAgICAgKGFzeW5jICgpID0+IHtcbiAgICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAgICAgYXdhaXQgc3RyZWFtUGlwZWxpbmVQcm9taXNpZmllZChpbnB1dFN0cmVhbSwgc3RyZWFtKTtcbiAgICAgICAgICAgICAgICByZXNvbHZlKCk7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBjYXRjaCAoZXJyb3IpIHtcbiAgICAgICAgICAgICAgICByZWplY3RQcm9taXNlKGVycm9yKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgfSkoKTtcbiAgICAgICAgc3RyZWFtLm9uKFwiZGF0YVwiLCAoKSA9PiB7XG4gICAgICAgICAgICAvLyA4MG1iXG4gICAgICAgICAgICBpZiAoc3RyZWFtLmdldEJ1ZmZlcmVkTGVuZ3RoKCkgPiAxMDAwICogMTAwMCAqIDgwKSB7XG4gICAgICAgICAgICAgICAgcmVqZWN0UHJvbWlzZShuZXcgTWF4QnVmZmVyRXJyb3IoKSk7XG4gICAgICAgICAgICB9XG4gICAgICAgIH0pO1xuICAgIH0pO1xuICAgIHJldHVybiBzdHJlYW0uZ2V0QnVmZmVyZWRWYWx1ZSgpO1xufVxuLy8gT24gZmFpbHVyZSwgYHJlc3VsdC5zdGRvdXR8c3RkZXJyYCBzaG91bGQgY29udGFpbiB0aGUgY3VycmVudGx5IGJ1ZmZlcmVkIHN0cmVhbVxuYXN5bmMgZnVuY3Rpb24gZ2V0QnVmZmVyZWREYXRhKHN0cmVhbSwgc3RyZWFtUHJvbWlzZSkge1xuICAgIHN0cmVhbS5kZXN0cm95KCk7XG4gICAgdHJ5IHtcbiAgICAgICAgcmV0dXJuIGF3YWl0IHN0cmVhbVByb21pc2U7XG4gICAgfVxuICAgIGNhdGNoIChlcnJvcikge1xuICAgICAgICByZXR1cm4gZXJyb3IuYnVmZmVyZWREYXRhO1xuICAgIH1cbn1cbmFzeW5jIGZ1bmN0aW9uIGdldFNwYXduZWRSZXN1bHQoeyBzdGRvdXQsIHN0ZGVyciB9LCB7IGVuY29kaW5nIH0sIHByb2Nlc3NEb25lKSB7XG4gICAgY29uc3Qgc3Rkb3V0UHJvbWlzZSA9IGdldFN0cmVhbShzdGRvdXQsIHsgZW5jb2RpbmcgfSk7XG4gICAgY29uc3Qgc3RkZXJyUHJvbWlzZSA9IGdldFN0cmVhbShzdGRlcnIsIHsgZW5jb2RpbmcgfSk7XG4gICAgdHJ5IHtcbiAgICAgICAgcmV0dXJuIGF3YWl0IFByb21pc2UuYWxsKFtwcm9jZXNzRG9uZSwgc3Rkb3V0UHJvbWlzZSwgc3RkZXJyUHJvbWlzZV0pO1xuICAgIH1cbiAgICBjYXRjaCAoZXJyb3IpIHtcbiAgICAgICAgcmV0dXJuIFByb21pc2UuYWxsKFtcbiAgICAgICAgICAgIHtcbiAgICAgICAgICAgICAgICBlcnJvcjogZXJyb3IsXG4gICAgICAgICAgICAgICAgZXhpdENvZGU6IG51bGwsXG4gICAgICAgICAgICAgICAgc2lnbmFsOiBlcnJvci5zaWduYWwsXG4gICAgICAgICAgICAgICAgdGltZWRPdXQ6IGVycm9yLnRpbWVkT3V0IHx8IGZhbHNlLFxuICAgICAgICAgICAgfSxcbiAgICAgICAgICAgIGdldEJ1ZmZlcmVkRGF0YShzdGRvdXQsIHN0ZG91dFByb21pc2UpLFxuICAgICAgICAgICAgZ2V0QnVmZmVyZWREYXRhKHN0ZGVyciwgc3RkZXJyUHJvbWlzZSksXG4gICAgICAgIF0pO1xuICAgIH1cbn1cbmV4cG9ydHMuZ2V0U3Bhd25lZFJlc3VsdCA9IGdldFNwYXduZWRSZXN1bHQ7XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG4vKlxuICogSW5zcGlyZWQgYnkgRXhlY2FcbiAqL1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy51c2VFeGVjID0gdm9pZCAwO1xuY29uc3Qgbm9kZV9jaGlsZF9wcm9jZXNzXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm5vZGU6Y2hpbGRfcHJvY2Vzc1wiKSk7XG5jb25zdCByZWFjdF8xID0gcmVxdWlyZShcInJlYWN0XCIpO1xuY29uc3QgdXNlQ2FjaGVkUHJvbWlzZV8xID0gcmVxdWlyZShcIi4vdXNlQ2FjaGVkUHJvbWlzZVwiKTtcbmNvbnN0IHVzZUxhdGVzdF8xID0gcmVxdWlyZShcIi4vdXNlTGF0ZXN0XCIpO1xuY29uc3QgZXhlY191dGlsc18xID0gcmVxdWlyZShcIi4vZXhlYy11dGlsc1wiKTtcbmNvbnN0IFNQQUNFU19SRUdFWFAgPSAvICsvZztcbmZ1bmN0aW9uIHBhcnNlQ29tbWFuZChjb21tYW5kLCBhcmdzKSB7XG4gICAgaWYgKGFyZ3MpIHtcbiAgICAgICAgcmV0dXJuIFtjb21tYW5kLCAuLi5hcmdzXTtcbiAgICB9XG4gICAgY29uc3QgdG9rZW5zID0gW107XG4gICAgZm9yIChjb25zdCB0b2tlbiBvZiBjb21tYW5kLnRyaW0oKS5zcGxpdChTUEFDRVNfUkVHRVhQKSkge1xuICAgICAgICAvLyBBbGxvdyBzcGFjZXMgdG8gYmUgZXNjYXBlZCBieSBhIGJhY2tzbGFzaCBpZiBub3QgbWVhbnQgYXMgYSBkZWxpbWl0ZXJcbiAgICAgICAgY29uc3QgcHJldmlvdXNUb2tlbiA9IHRva2Vuc1t0b2tlbnMubGVuZ3RoIC0gMV07XG4gICAgICAgIGlmIChwcmV2aW91c1Rva2VuICYmIHByZXZpb3VzVG9rZW4uZW5kc1dpdGgoXCJcXFxcXCIpKSB7XG4gICAgICAgICAgICAvLyBNZXJnZSBwcmV2aW91cyB0b2tlbiB3aXRoIGN1cnJlbnQgb25lXG4gICAgICAgICAgICB0b2tlbnNbdG9rZW5zLmxlbmd0aCAtIDFdID0gYCR7cHJldmlvdXNUb2tlbi5zbGljZSgwLCAtMSl9ICR7dG9rZW59YDtcbiAgICAgICAgfVxuICAgICAgICBlbHNlIHtcbiAgICAgICAgICAgIHRva2Vucy5wdXNoKHRva2VuKTtcbiAgICAgICAgfVxuICAgIH1cbiAgICByZXR1cm4gdG9rZW5zO1xufVxuZnVuY3Rpb24gc3RyaXBGaW5hbE5ld2xpbmUoaW5wdXQpIHtcbiAgICBjb25zdCBMRiA9IHR5cGVvZiBpbnB1dCA9PT0gXCJzdHJpbmdcIiA/IFwiXFxuXCIgOiBcIlxcblwiLmNoYXJDb2RlQXQoMCk7XG4gICAgY29uc3QgQ1IgPSB0eXBlb2YgaW5wdXQgPT09IFwic3RyaW5nXCIgPyBcIlxcclwiIDogXCJcXHJcIi5jaGFyQ29kZUF0KDApO1xuICAgIGlmIChpbnB1dFtpbnB1dC5sZW5ndGggLSAxXSA9PT0gTEYpIHtcbiAgICAgICAgLy8gQHRzLWV4cGVjdC1lcnJvciB3ZSBhcmUgZG9pbmcgc29tZSBuYXN0eSBzdHVmZiBoZXJlXG4gICAgICAgIGlucHV0ID0gaW5wdXQuc2xpY2UoMCwgLTEpO1xuICAgIH1cbiAgICBpZiAoaW5wdXRbaW5wdXQubGVuZ3RoIC0gMV0gPT09IENSKSB7XG4gICAgICAgIC8vIEB0cy1leHBlY3QtZXJyb3Igd2UgYXJlIGRvaW5nIHNvbWUgbmFzdHkgc3R1ZmYgaGVyZVxuICAgICAgICBpbnB1dCA9IGlucHV0LnNsaWNlKDAsIC0xKTtcbiAgICB9XG4gICAgcmV0dXJuIGlucHV0O1xufVxuZnVuY3Rpb24gaGFuZGxlT3V0cHV0KG9wdGlvbnMsIHZhbHVlKSB7XG4gICAgaWYgKG9wdGlvbnMuc3RyaXBGaW5hbE5ld2xpbmUpIHtcbiAgICAgICAgcmV0dXJuIHN0cmlwRmluYWxOZXdsaW5lKHZhbHVlKTtcbiAgICB9XG4gICAgcmV0dXJuIHZhbHVlO1xufVxuY29uc3QgZ2V0RXJyb3JQcmVmaXggPSAoeyB0aW1lZE91dCwgdGltZW91dCwgc2lnbmFsLCBleGl0Q29kZSwgfSkgPT4ge1xuICAgIGlmICh0aW1lZE91dCkge1xuICAgICAgICByZXR1cm4gYHRpbWVkIG91dCBhZnRlciAke3RpbWVvdXR9IG1pbGxpc2Vjb25kc2A7XG4gICAgfVxuICAgIGlmIChzaWduYWwgIT09IHVuZGVmaW5lZCkge1xuICAgICAgICByZXR1cm4gYHdhcyBraWxsZWQgd2l0aCAke3NpZ25hbH1gO1xuICAgIH1cbiAgICBpZiAoZXhpdENvZGUgIT09IHVuZGVmaW5lZCkge1xuICAgICAgICByZXR1cm4gYGZhaWxlZCB3aXRoIGV4aXQgY29kZSAke2V4aXRDb2RlfWA7XG4gICAgfVxuICAgIHJldHVybiBcImZhaWxlZFwiO1xufTtcbmNvbnN0IG1ha2VFcnJvciA9ICh7IHN0ZG91dCwgc3RkZXJyLCBlcnJvciwgc2lnbmFsLCBleGl0Q29kZSwgY29tbWFuZCwgdGltZWRPdXQsIG9wdGlvbnMsIH0pID0+IHtcbiAgICBjb25zdCBwcmVmaXggPSBnZXRFcnJvclByZWZpeCh7IHRpbWVkT3V0LCB0aW1lb3V0OiBvcHRpb25zPy50aW1lb3V0LCBzaWduYWwsIGV4aXRDb2RlIH0pO1xuICAgIGNvbnN0IGV4ZWNhTWVzc2FnZSA9IGBDb21tYW5kICR7cHJlZml4fTogJHtjb21tYW5kfWA7XG4gICAgY29uc3Qgc2hvcnRNZXNzYWdlID0gZXJyb3IgPyBgJHtleGVjYU1lc3NhZ2V9XFxuJHtlcnJvci5tZXNzYWdlfWAgOiBleGVjYU1lc3NhZ2U7XG4gICAgY29uc3QgbWVzc2FnZSA9IFtzaG9ydE1lc3NhZ2UsIHN0ZGVyciwgc3Rkb3V0XS5maWx0ZXIoQm9vbGVhbikuam9pbihcIlxcblwiKTtcbiAgICBpZiAoZXJyb3IpIHtcbiAgICAgICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICAgICAgZXJyb3Iub3JpZ2luYWxNZXNzYWdlID0gZXJyb3IubWVzc2FnZTtcbiAgICAgICAgZXJyb3IubWVzc2FnZSA9IG1lc3NhZ2U7XG4gICAgfVxuICAgIGVsc2Uge1xuICAgICAgICBlcnJvciA9IG5ldyBFcnJvcihtZXNzYWdlKTtcbiAgICB9XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICBlcnJvci5zaG9ydE1lc3NhZ2UgPSBzaG9ydE1lc3NhZ2U7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICBlcnJvci5jb21tYW5kID0gY29tbWFuZDtcbiAgICAvLyBAdHMtZXhwZWN0LWVycm9yIG5vdCBvbiBFcnJvclxuICAgIGVycm9yLmV4aXRDb2RlID0gZXhpdENvZGU7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICBlcnJvci5zaWduYWwgPSBzaWduYWw7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICBlcnJvci5zdGRvdXQgPSBzdGRvdXQ7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBub3Qgb24gRXJyb3JcbiAgICBlcnJvci5zdGRlcnIgPSBzdGRlcnI7XG4gICAgaWYgKFwiYnVmZmVyZWREYXRhXCIgaW4gZXJyb3IpIHtcbiAgICAgICAgZGVsZXRlIGVycm9yW1wiYnVmZmVyZWREYXRhXCJdO1xuICAgIH1cbiAgICByZXR1cm4gZXJyb3I7XG59O1xuZnVuY3Rpb24gZGVmYXVsdFBhcnNpbmcoeyBzdGRvdXQsIHN0ZGVyciwgZXJyb3IsIGV4aXRDb2RlLCBzaWduYWwsIHRpbWVkT3V0LCBjb21tYW5kLCBvcHRpb25zLCB9KSB7XG4gICAgaWYgKGVycm9yIHx8IGV4aXRDb2RlICE9PSAwIHx8IHNpZ25hbCAhPT0gbnVsbCkge1xuICAgICAgICBjb25zdCByZXR1cm5lZEVycm9yID0gbWFrZUVycm9yKHtcbiAgICAgICAgICAgIGVycm9yLFxuICAgICAgICAgICAgZXhpdENvZGUsXG4gICAgICAgICAgICBzaWduYWwsXG4gICAgICAgICAgICBzdGRvdXQsXG4gICAgICAgICAgICBzdGRlcnIsXG4gICAgICAgICAgICBjb21tYW5kLFxuICAgICAgICAgICAgdGltZWRPdXQsXG4gICAgICAgICAgICBvcHRpb25zLFxuICAgICAgICB9KTtcbiAgICAgICAgdGhyb3cgcmV0dXJuZWRFcnJvcjtcbiAgICB9XG4gICAgcmV0dXJuIHN0ZG91dDtcbn1cbmZ1bmN0aW9uIHVzZUV4ZWMoY29tbWFuZCwgb3B0aW9uc09yQXJncywgb3B0aW9ucykge1xuICAgIGNvbnN0IHsgcGFyc2VPdXRwdXQsIGlucHV0LCBvbkRhdGEsIG9uV2lsbEV4ZWN1dGUsIGluaXRpYWxEYXRhLCBleGVjdXRlLCBrZWVwUHJldmlvdXNEYXRhLCBvbkVycm9yLCAuLi5leGVjT3B0aW9ucyB9ID0gQXJyYXkuaXNBcnJheShvcHRpb25zT3JBcmdzKSA/IG9wdGlvbnMgfHwge30gOiBvcHRpb25zT3JBcmdzIHx8IHt9O1xuICAgIGNvbnN0IHVzZUNhY2hlZFByb21pc2VPcHRpb25zID0ge1xuICAgICAgICBpbml0aWFsRGF0YSxcbiAgICAgICAgZXhlY3V0ZSxcbiAgICAgICAga2VlcFByZXZpb3VzRGF0YSxcbiAgICAgICAgb25FcnJvcixcbiAgICAgICAgb25EYXRhLFxuICAgICAgICBvbldpbGxFeGVjdXRlLFxuICAgIH07XG4gICAgY29uc3QgYWJvcnRhYmxlID0gKDAsIHJlYWN0XzEudXNlUmVmKSgpO1xuICAgIGNvbnN0IHBhcnNlT3V0cHV0UmVmID0gKDAsIHVzZUxhdGVzdF8xLnVzZUxhdGVzdCkocGFyc2VPdXRwdXQgfHwgZGVmYXVsdFBhcnNpbmcpO1xuICAgIGNvbnN0IGZuID0gKDAsIHJlYWN0XzEudXNlQ2FsbGJhY2spKGFzeW5jIChfY29tbWFuZCwgX2FyZ3MsIF9vcHRpb25zLCBpbnB1dCkgPT4ge1xuICAgICAgICBjb25zdCBbZmlsZSwgLi4uYXJnc10gPSBwYXJzZUNvbW1hbmQoX2NvbW1hbmQsIF9hcmdzKTtcbiAgICAgICAgY29uc3QgY29tbWFuZCA9IFtmaWxlLCAuLi5hcmdzXS5qb2luKFwiIFwiKTtcbiAgICAgICAgY29uc3Qgb3B0aW9ucyA9IHtcbiAgICAgICAgICAgIHN0cmlwRmluYWxOZXdsaW5lOiB0cnVlLFxuICAgICAgICAgICAgLi4uX29wdGlvbnMsXG4gICAgICAgICAgICBzaWduYWw6IGFib3J0YWJsZS5jdXJyZW50Py5zaWduYWwsXG4gICAgICAgICAgICBlbmNvZGluZzogX29wdGlvbnM/LmVuY29kaW5nID09PSBudWxsID8gXCJidWZmZXJcIiA6IF9vcHRpb25zPy5lbmNvZGluZyB8fCBcInV0ZjhcIixcbiAgICAgICAgICAgIGVudjogeyAuLi5wcm9jZXNzLmVudiwgLi4uX29wdGlvbnM/LmVudiB9LFxuICAgICAgICB9O1xuICAgICAgICBjb25zdCBzcGF3bmVkID0gbm9kZV9jaGlsZF9wcm9jZXNzXzEuZGVmYXVsdC5zcGF3bihmaWxlLCBhcmdzLCBvcHRpb25zKTtcbiAgICAgICAgY29uc3Qgc3Bhd25lZFByb21pc2UgPSAoMCwgZXhlY191dGlsc18xLmdldFNwYXduZWRQcm9taXNlKShzcGF3bmVkLCBvcHRpb25zKTtcbiAgICAgICAgaWYgKGlucHV0KSB7XG4gICAgICAgICAgICBzcGF3bmVkLnN0ZGluLmVuZChpbnB1dCk7XG4gICAgICAgIH1cbiAgICAgICAgY29uc3QgW3sgZXJyb3IsIGV4aXRDb2RlLCBzaWduYWwsIHRpbWVkT3V0IH0sIHN0ZG91dFJlc3VsdCwgc3RkZXJyUmVzdWx0XSA9IGF3YWl0ICgwLCBleGVjX3V0aWxzXzEuZ2V0U3Bhd25lZFJlc3VsdCkoc3Bhd25lZCwgb3B0aW9ucywgc3Bhd25lZFByb21pc2UpO1xuICAgICAgICBjb25zdCBzdGRvdXQgPSBoYW5kbGVPdXRwdXQob3B0aW9ucywgc3Rkb3V0UmVzdWx0KTtcbiAgICAgICAgY29uc3Qgc3RkZXJyID0gaGFuZGxlT3V0cHV0KG9wdGlvbnMsIHN0ZGVyclJlc3VsdCk7XG4gICAgICAgIHJldHVybiBwYXJzZU91dHB1dFJlZi5jdXJyZW50KHtcbiAgICAgICAgICAgIC8vIEB0cy1leHBlY3QtZXJyb3IgdG9vIG1hbnkgZ2VuZXJpY3MsIEkgZ2l2ZSB1cFxuICAgICAgICAgICAgc3Rkb3V0LFxuICAgICAgICAgICAgLy8gQHRzLWV4cGVjdC1lcnJvciB0b28gbWFueSBnZW5lcmljcywgSSBnaXZlIHVwXG4gICAgICAgICAgICBzdGRlcnIsXG4gICAgICAgICAgICBlcnJvcixcbiAgICAgICAgICAgIGV4aXRDb2RlLFxuICAgICAgICAgICAgc2lnbmFsLFxuICAgICAgICAgICAgdGltZWRPdXQsXG4gICAgICAgICAgICBjb21tYW5kLFxuICAgICAgICAgICAgb3B0aW9ucyxcbiAgICAgICAgfSk7XG4gICAgfSwgW3BhcnNlT3V0cHV0UmVmXSk7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBUIGNhbid0IGJlIGEgUHJvbWlzZSBzbyBpdCdzIGFjdHVhbGx5IHRoZSBzYW1lXG4gICAgcmV0dXJuICgwLCB1c2VDYWNoZWRQcm9taXNlXzEudXNlQ2FjaGVkUHJvbWlzZSkoZm4sIFtjb21tYW5kLCBBcnJheS5pc0FycmF5KG9wdGlvbnNPckFyZ3MpID8gb3B0aW9uc09yQXJncyA6IFtdLCBleGVjT3B0aW9ucywgaW5wdXRdLCB7XG4gICAgICAgIC4uLnVzZUNhY2hlZFByb21pc2VPcHRpb25zLFxuICAgICAgICBhYm9ydGFibGUsXG4gICAgfSk7XG59XG5leHBvcnRzLnVzZUV4ZWMgPSB1c2VFeGVjO1xuIiwgIlwidXNlIHN0cmljdFwiO1xudmFyIF9faW1wb3J0RGVmYXVsdCA9ICh0aGlzICYmIHRoaXMuX19pbXBvcnREZWZhdWx0KSB8fCBmdW5jdGlvbiAobW9kKSB7XG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBcImRlZmF1bHRcIjogbW9kIH07XG59O1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy51c2VTUUwgPSB2b2lkIDA7XG5jb25zdCBqc3hfcnVudGltZV8xID0gcmVxdWlyZShcInJlYWN0L2pzeC1ydW50aW1lXCIpO1xuY29uc3QgYXBpXzEgPSByZXF1aXJlKFwiQHJheWNhc3QvYXBpXCIpO1xuY29uc3Qgbm9kZV9mc18xID0gcmVxdWlyZShcIm5vZGU6ZnNcIik7XG5jb25zdCBwcm9taXNlc18xID0gcmVxdWlyZShcIm5vZGU6ZnMvcHJvbWlzZXNcIik7XG5jb25zdCBub2RlX29zXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm5vZGU6b3NcIikpO1xuY29uc3Qgbm9kZV9jaGlsZF9wcm9jZXNzXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm5vZGU6Y2hpbGRfcHJvY2Vzc1wiKSk7XG5jb25zdCBub2RlX3BhdGhfMSA9IF9faW1wb3J0RGVmYXVsdChyZXF1aXJlKFwibm9kZTpwYXRoXCIpKTtcbmNvbnN0IG9iamVjdF9oYXNoXzEgPSBfX2ltcG9ydERlZmF1bHQocmVxdWlyZShcIm9iamVjdC1oYXNoXCIpKTtcbmNvbnN0IHJlYWN0XzEgPSByZXF1aXJlKFwicmVhY3RcIik7XG5jb25zdCB1c2VQcm9taXNlXzEgPSByZXF1aXJlKFwiLi91c2VQcm9taXNlXCIpO1xuY29uc3QgdXNlTGF0ZXN0XzEgPSByZXF1aXJlKFwiLi91c2VMYXRlc3RcIik7XG5jb25zdCBleGVjX3V0aWxzXzEgPSByZXF1aXJlKFwiLi9leGVjLXV0aWxzXCIpO1xuLyoqXG4gKiBFeGVjdXRlcyBhIHF1ZXJ5IG9uIGEgbG9jYWwgU1FMIGRhdGFiYXNlIGFuZCByZXR1cm5zIHRoZSB7QGxpbmsgQXN5bmNTdGF0ZX0gY29ycmVzcG9uZGluZyB0byB0aGUgcXVlcnkgb2YgdGhlIGNvbW1hbmQuIFRoZSBsYXN0IHZhbHVlIHdpbGwgYmUga2VwdCBiZXR3ZWVuIGNvbW1hbmQgcnVucy5cbiAqXG4gKiBAZXhhbXBsZVxuICogYGBgXG4gKiBpbXBvcnQgeyB1c2VTUUwgfSBmcm9tIFwiQHJheWNhc3QvdXRpbHNcIjtcbiAqIGltcG9ydCB7IHJlc29sdmUgfSBmcm9tIFwicGF0aFwiO1xuICogaW1wb3J0IHsgaG9tZWRpciB9IGZyb20gXCJvc1wiO1xuICpcbiAqIGNvbnN0IE5PVEVTX0RCID0gcmVzb2x2ZShob21lZGlyKCksIFwiTGlicmFyeS9Hcm91cCBDb250YWluZXJzL2dyb3VwLmNvbS5hcHBsZS5ub3Rlcy9Ob3RlU3RvcmUuc3FsaXRlXCIpO1xuICogY29uc3Qgbm90ZXNRdWVyeSA9IGBTRUxFQ1QgaWQsIHRpdGxlIEZST00gLi4uYDtcbiAqIHR5cGUgTm90ZUl0ZW0gPSB7XG4gKiAgIGlkOiBzdHJpbmc7XG4gKiAgIHRpdGxlOiBzdHJpbmc7XG4gKiB9O1xuICpcbiAqIGNvbnN0IERlbW8gPSAoKSA9PiB7XG4gKiAgIGNvbnN0IHsgaXNMb2FkaW5nLCBkYXRhLCBwZXJtaXNzaW9uVmlldyB9ID0gdXNlU1FMPE5vdGVJdGVtPihOT1RFU19EQiwgbm90ZXNRdWVyeSk7XG4gKlxuICogICBpZiAocGVybWlzc2lvblZpZXcpIHtcbiAqICAgICByZXR1cm4gcGVybWlzc2lvblZpZXc7XG4gKiAgIH1cbiAqXG4gKiAgIHJldHVybiAoXG4gKiAgICAgPExpc3QgaXNMb2FkaW5nPXtpc0xvYWRpbmd9PlxuICogICAgICAgeyhkYXRhIHx8IFtdKS5tYXAoKGl0ZW0pID0+IChcbiAqICAgICAgICAgPExpc3QuSXRlbSBrZXk9e2l0ZW0uaWR9IHRpdGxlPXtpdGVtLnRpdGxlfSAvPlxuICogICAgICAgKSl9XG4gKiAgICAgPC9MaXN0PlxuICogICk7XG4gKiB9O1xuICogYGBgXG4gKi9cbmZ1bmN0aW9uIHVzZVNRTChkYXRhYmFzZVBhdGgsIHF1ZXJ5LCBvcHRpb25zKSB7XG4gICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIEB0eXBlc2NyaXB0LWVzbGludC9uby11bnVzZWQtdmFyc1xuICAgIGNvbnN0IHsgcGVybWlzc2lvblByaW1pbmcsIC4uLnVzZVByb21pc2VPcHRpb25zIH0gPSBvcHRpb25zIHx8IHt9O1xuICAgIGNvbnN0IFtwZXJtaXNzaW9uVmlldywgc2V0UGVybWlzc2lvblZpZXddID0gKDAsIHJlYWN0XzEudXNlU3RhdGUpKCk7XG4gICAgY29uc3QgbGF0ZXN0T3B0aW9ucyA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKG9wdGlvbnMgfHwge30pO1xuICAgIGNvbnN0IGFib3J0YWJsZSA9ICgwLCByZWFjdF8xLnVzZVJlZikoKTtcbiAgICBjb25zdCBoYW5kbGVFcnJvciA9ICgwLCByZWFjdF8xLnVzZUNhbGxiYWNrKSgoX2Vycm9yKSA9PiB7XG4gICAgICAgIGNvbnNvbGUuZXJyb3IoX2Vycm9yKTtcbiAgICAgICAgY29uc3QgZXJyb3IgPSBfZXJyb3IgaW5zdGFuY2VvZiBFcnJvciAmJiBfZXJyb3IubWVzc2FnZS5pbmNsdWRlcyhcImF1dGhvcml6YXRpb24gZGVuaWVkXCIpXG4gICAgICAgICAgICA/IG5ldyBQZXJtaXNzaW9uRXJyb3IoXCJZb3UgZG8gbm90IGhhdmUgcGVybWlzc2lvbiB0byBhY2Nlc3MgdGhlIGRhdGFiYXNlLlwiKVxuICAgICAgICAgICAgOiBfZXJyb3I7XG4gICAgICAgIGlmIChpc1Blcm1pc3Npb25FcnJvcihlcnJvcikpIHtcbiAgICAgICAgICAgIHNldFBlcm1pc3Npb25WaWV3KCgwLCBqc3hfcnVudGltZV8xLmpzeCkoUGVybWlzc2lvbkVycm9yU2NyZWVuLCB7IHByaW1pbmc6IGxhdGVzdE9wdGlvbnMuY3VycmVudC5wZXJtaXNzaW9uUHJpbWluZyB9KSk7XG4gICAgICAgIH1cbiAgICAgICAgZWxzZSB7XG4gICAgICAgICAgICBpZiAobGF0ZXN0T3B0aW9ucy5jdXJyZW50Lm9uRXJyb3IpIHtcbiAgICAgICAgICAgICAgICBsYXRlc3RPcHRpb25zLmN1cnJlbnQub25FcnJvcihlcnJvcik7XG4gICAgICAgICAgICB9XG4gICAgICAgICAgICBlbHNlIHtcbiAgICAgICAgICAgICAgICBjb25zb2xlLmVycm9yKGVycm9yKTtcbiAgICAgICAgICAgICAgICBpZiAoYXBpXzEuZW52aXJvbm1lbnQubGF1bmNoVHlwZSAhPT0gYXBpXzEuTGF1bmNoVHlwZS5CYWNrZ3JvdW5kKSB7XG4gICAgICAgICAgICAgICAgICAgICgwLCBhcGlfMS5zaG93VG9hc3QpKHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHN0eWxlOiBhcGlfMS5Ub2FzdC5TdHlsZS5GYWlsdXJlLFxuICAgICAgICAgICAgICAgICAgICAgICAgdGl0bGU6IFwiQ2Fubm90IHF1ZXJ5IHRoZSBkYXRhXCIsXG4gICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiBlcnJvci5tZXNzYWdlLFxuICAgICAgICAgICAgICAgICAgICAgICAgcHJpbWFyeUFjdGlvbjoge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRpdGxlOiBcIkNvcHkgTG9nc1wiLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9uQWN0aW9uKHRvYXN0KSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRvYXN0LmhpZGUoKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXBpXzEuQ2xpcGJvYXJkLmNvcHkoZXJyb3I/LnN0YWNrIHx8IGVycm9yPy5tZXNzYWdlIHx8IFwiXCIpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICB9LCBbbGF0ZXN0T3B0aW9uc10pO1xuICAgIGNvbnN0IGZuID0gKDAsIHJlYWN0XzEudXNlTWVtbykoKCkgPT4ge1xuICAgICAgICBpZiAoISgwLCBub2RlX2ZzXzEuZXhpc3RzU3luYykoZGF0YWJhc2VQYXRoKSkge1xuICAgICAgICAgICAgdGhyb3cgbmV3IEVycm9yKFwiVGhlIGRhdGFiYXNlIGRvZXMgbm90IGV4aXN0XCIpO1xuICAgICAgICB9XG4gICAgICAgIGxldCB3b3JrYXJvdW5kQ29waWVkRGIgPSB1bmRlZmluZWQ7XG4gICAgICAgIHJldHVybiBhc3luYyAocXVlcnkpID0+IHtcbiAgICAgICAgICAgIGNvbnN0IGFib3J0U2lnbmFsID0gYWJvcnRhYmxlLmN1cnJlbnQ/LnNpZ25hbDtcbiAgICAgICAgICAgIGNvbnN0IHNwYXduZWQgPSBub2RlX2NoaWxkX3Byb2Nlc3NfMS5kZWZhdWx0LnNwYXduKFwic3FsaXRlM1wiLCBbXCItLWpzb25cIiwgXCItLXJlYWRvbmx5XCIsIGRhdGFiYXNlUGF0aCwgcXVlcnldLCB7XG4gICAgICAgICAgICAgICAgc2lnbmFsOiBhYm9ydFNpZ25hbCxcbiAgICAgICAgICAgIH0pO1xuICAgICAgICAgICAgY29uc3Qgc3Bhd25lZFByb21pc2UgPSAoMCwgZXhlY191dGlsc18xLmdldFNwYXduZWRQcm9taXNlKShzcGF3bmVkKTtcbiAgICAgICAgICAgIGxldCBbeyBlcnJvciwgZXhpdENvZGUsIHNpZ25hbCB9LCBzdGRvdXRSZXN1bHQsIHN0ZGVyclJlc3VsdF0gPSBhd2FpdCAoMCwgZXhlY191dGlsc18xLmdldFNwYXduZWRSZXN1bHQpKHNwYXduZWQsIHsgZW5jb2Rpbmc6IFwidXRmLThcIiB9LCBzcGF3bmVkUHJvbWlzZSk7XG4gICAgICAgICAgICBjaGVja0Fib3J0ZWQoYWJvcnRTaWduYWwpO1xuICAgICAgICAgICAgaWYgKHN0ZGVyclJlc3VsdC5tYXRjaChcIig1KVwiKSB8fCBzdGRlcnJSZXN1bHQubWF0Y2goXCIoMTQpXCIpKSB7XG4gICAgICAgICAgICAgICAgLy8gVGhhdCBtZWFucyB0aGF0IHRoZSBEQiBpcyBidXN5IGJlY2F1c2Ugb2YgYW5vdGhlciBhcHAgaXMgbG9ja2luZyBpdFxuICAgICAgICAgICAgICAgIC8vIFRoaXMgaGFwcGVucyB3aGVuIENocm9tZSBvciBBcmMgaXMgb3BlbmVkOiB0aGV5IGxvY2sgdGhlIEhpc3RvcnkgZGIuXG4gICAgICAgICAgICAgICAgLy8gQXMgYW4gdWdseSB3b3JrYXJvdW5kLCB3ZSBkdXBsaWNhdGUgdGhlIGZpbGUgYW5kIHJlYWQgdGhhdCBpbnN0ZWFkXG4gICAgICAgICAgICAgICAgLy8gKHdpdGggdmZzIHVuaXggLSBub25lIHRvIGp1c3Qgbm90IGNhcmUgYWJvdXQgbG9ja3MpXG4gICAgICAgICAgICAgICAgaWYgKCF3b3JrYXJvdW5kQ29waWVkRGIpIHtcbiAgICAgICAgICAgICAgICAgICAgY29uc3QgdGVtcEZvbGRlciA9IG5vZGVfcGF0aF8xLmRlZmF1bHQuam9pbihub2RlX29zXzEuZGVmYXVsdC50bXBkaXIoKSwgXCJ1c2VTUUxcIiwgKDAsIG9iamVjdF9oYXNoXzEuZGVmYXVsdCkoZGF0YWJhc2VQYXRoKSk7XG4gICAgICAgICAgICAgICAgICAgIGF3YWl0ICgwLCBwcm9taXNlc18xLm1rZGlyKSh0ZW1wRm9sZGVyLCB7IHJlY3Vyc2l2ZTogdHJ1ZSB9KTtcbiAgICAgICAgICAgICAgICAgICAgY2hlY2tBYm9ydGVkKGFib3J0U2lnbmFsKTtcbiAgICAgICAgICAgICAgICAgICAgd29ya2Fyb3VuZENvcGllZERiID0gbm9kZV9wYXRoXzEuZGVmYXVsdC5qb2luKHRlbXBGb2xkZXIsIFwiZGIuZGJcIik7XG4gICAgICAgICAgICAgICAgICAgIGF3YWl0ICgwLCBwcm9taXNlc18xLmNvcHlGaWxlKShkYXRhYmFzZVBhdGgsIHdvcmthcm91bmRDb3BpZWREYik7XG4gICAgICAgICAgICAgICAgICAgIC8vIG5lZWRlZCBmb3IgY2VydGFpbiBkYlxuICAgICAgICAgICAgICAgICAgICBhd2FpdCAoMCwgcHJvbWlzZXNfMS53cml0ZUZpbGUpKHdvcmthcm91bmRDb3BpZWREYiArIFwiLXNobVwiLCBcIlwiKTtcbiAgICAgICAgICAgICAgICAgICAgYXdhaXQgKDAsIHByb21pc2VzXzEud3JpdGVGaWxlKSh3b3JrYXJvdW5kQ29waWVkRGIgKyBcIi13YWxcIiwgXCJcIik7XG4gICAgICAgICAgICAgICAgICAgIGNoZWNrQWJvcnRlZChhYm9ydFNpZ25hbCk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIGNvbnN0IHNwYXduZWQgPSBub2RlX2NoaWxkX3Byb2Nlc3NfMS5kZWZhdWx0LnNwYXduKFwic3FsaXRlM1wiLCBbXCItLWpzb25cIiwgXCItLXJlYWRvbmx5XCIsIFwiLS12ZnNcIiwgXCJ1bml4LW5vbmVcIiwgd29ya2Fyb3VuZENvcGllZERiLCBxdWVyeV0sIHtcbiAgICAgICAgICAgICAgICAgICAgc2lnbmFsOiBhYm9ydFNpZ25hbCxcbiAgICAgICAgICAgICAgICB9KTtcbiAgICAgICAgICAgICAgICBjb25zdCBzcGF3bmVkUHJvbWlzZSA9ICgwLCBleGVjX3V0aWxzXzEuZ2V0U3Bhd25lZFByb21pc2UpKHNwYXduZWQpO1xuICAgICAgICAgICAgICAgIFt7IGVycm9yLCBleGl0Q29kZSwgc2lnbmFsIH0sIHN0ZG91dFJlc3VsdCwgc3RkZXJyUmVzdWx0XSA9IGF3YWl0ICgwLCBleGVjX3V0aWxzXzEuZ2V0U3Bhd25lZFJlc3VsdCkoc3Bhd25lZCwgeyBlbmNvZGluZzogXCJ1dGYtOFwiIH0sIHNwYXduZWRQcm9taXNlKTtcbiAgICAgICAgICAgICAgICBjaGVja0Fib3J0ZWQoYWJvcnRTaWduYWwpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKGVycm9yIHx8IGV4aXRDb2RlICE9PSAwIHx8IHNpZ25hbCAhPT0gbnVsbCkge1xuICAgICAgICAgICAgICAgIHRocm93IG5ldyBFcnJvcihzdGRlcnJSZXN1bHQpO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgcmV0dXJuIEpTT04ucGFyc2Uoc3Rkb3V0UmVzdWx0LnRyaW0oKSB8fCBcIltdXCIpO1xuICAgICAgICB9O1xuICAgIH0sIFtkYXRhYmFzZVBhdGhdKTtcbiAgICByZXR1cm4ge1xuICAgICAgICAuLi4oMCwgdXNlUHJvbWlzZV8xLnVzZVByb21pc2UpKGZuLCBbcXVlcnldLCB7IC4uLnVzZVByb21pc2VPcHRpb25zLCBvbkVycm9yOiBoYW5kbGVFcnJvciB9KSxcbiAgICAgICAgcGVybWlzc2lvblZpZXcsXG4gICAgfTtcbn1cbmV4cG9ydHMudXNlU1FMID0gdXNlU1FMO1xuY2xhc3MgUGVybWlzc2lvbkVycm9yIGV4dGVuZHMgRXJyb3Ige1xuICAgIGNvbnN0cnVjdG9yKG1lc3NhZ2UpIHtcbiAgICAgICAgc3VwZXIobWVzc2FnZSk7XG4gICAgICAgIHRoaXMubmFtZSA9IFwiUGVybWlzc2lvbkVycm9yXCI7XG4gICAgfVxufVxuZnVuY3Rpb24gaXNQZXJtaXNzaW9uRXJyb3IoZXJyb3IpIHtcbiAgICByZXR1cm4gZXJyb3IgaW5zdGFuY2VvZiBFcnJvciAmJiBlcnJvci5uYW1lID09PSBcIlBlcm1pc3Npb25FcnJvclwiO1xufVxuY29uc3QgbWFjb3NWZW50dXJhQW5kTGF0ZXIgPSBwYXJzZUludChub2RlX29zXzEuZGVmYXVsdC5yZWxlYXNlKCkuc3BsaXQoXCIuXCIpWzBdKSA+PSAyMjtcbmNvbnN0IHByZWZlcmVuY2VzU3RyaW5nID0gbWFjb3NWZW50dXJhQW5kTGF0ZXIgPyBcIlNldHRpbmdzXCIgOiBcIlByZWZlcmVuY2VzXCI7XG5mdW5jdGlvbiBQZXJtaXNzaW9uRXJyb3JTY3JlZW4ocHJvcHMpIHtcbiAgICBjb25zdCBhY3Rpb24gPSBtYWNvc1ZlbnR1cmFBbmRMYXRlclxuICAgICAgICA/IHtcbiAgICAgICAgICAgIHRpdGxlOiBcIk9wZW4gU3lzdGVtIFNldHRpbmdzIC0+IFByaXZhY3lcIixcbiAgICAgICAgICAgIHRhcmdldDogXCJ4LWFwcGxlLnN5c3RlbXByZWZlcmVuY2VzOmNvbS5hcHBsZS5wcmVmZXJlbmNlLnNlY3VyaXR5P1ByaXZhY3lfQWxsRmlsZXNcIixcbiAgICAgICAgfVxuICAgICAgICA6IHtcbiAgICAgICAgICAgIHRpdGxlOiBcIk9wZW4gU3lzdGVtIFByZWZlcmVuY2VzIC0+IFNlY3VyaXR5XCIsXG4gICAgICAgICAgICB0YXJnZXQ6IFwieC1hcHBsZS5zeXN0ZW1wcmVmZXJlbmNlczpjb20uYXBwbGUucHJlZmVyZW5jZS5zZWN1cml0eT9Qcml2YWN5X0FsbEZpbGVzXCIsXG4gICAgICAgIH07XG4gICAgaWYgKGFwaV8xLmVudmlyb25tZW50LmNvbW1hbmRNb2RlID09PSBcIm1lbnUtYmFyXCIpIHtcbiAgICAgICAgcmV0dXJuICgoMCwganN4X3J1bnRpbWVfMS5qc3hzKShhcGlfMS5NZW51QmFyRXh0cmEsIHsgaWNvbjogYXBpXzEuSWNvbi5XYXJuaW5nLCB0aXRsZTogYXBpXzEuZW52aXJvbm1lbnQuY29tbWFuZE5hbWUsIGNoaWxkcmVuOiBbKDAsIGpzeF9ydW50aW1lXzEuanN4KShhcGlfMS5NZW51QmFyRXh0cmEuSXRlbSwgeyB0aXRsZTogXCJSYXljYXN0IG5lZWRzIGZ1bGwgZGlzayBhY2Nlc3NcIiwgdG9vbHRpcDogYFlvdSBjYW4gcmV2ZXJ0IHRoaXMgYWNjZXNzIGluICR7cHJlZmVyZW5jZXNTdHJpbmd9IHdoZW5ldmVyIHlvdSB3YW50YCB9KSwgcHJvcHMucHJpbWluZyA/ICgoMCwganN4X3J1bnRpbWVfMS5qc3gpKGFwaV8xLk1lbnVCYXJFeHRyYS5JdGVtLCB7IHRpdGxlOiBwcm9wcy5wcmltaW5nLCB0b29sdGlwOiBgWW91IGNhbiByZXZlcnQgdGhpcyBhY2Nlc3MgaW4gJHtwcmVmZXJlbmNlc1N0cmluZ30gd2hlbmV2ZXIgeW91IHdhbnRgIH0pKSA6IG51bGwsICgwLCBqc3hfcnVudGltZV8xLmpzeCkoYXBpXzEuTWVudUJhckV4dHJhLlNlcGFyYXRvciwge30pLCAoMCwganN4X3J1bnRpbWVfMS5qc3gpKGFwaV8xLk1lbnVCYXJFeHRyYS5JdGVtLCB7IHRpdGxlOiBhY3Rpb24udGl0bGUsIG9uQWN0aW9uOiAoKSA9PiAoMCwgYXBpXzEub3BlbikoYWN0aW9uLnRhcmdldCkgfSldIH0pKTtcbiAgICB9XG4gICAgcmV0dXJuICgoMCwganN4X3J1bnRpbWVfMS5qc3gpKGFwaV8xLkxpc3QsIHsgY2hpbGRyZW46ICgwLCBqc3hfcnVudGltZV8xLmpzeCkoYXBpXzEuTGlzdC5FbXB0eVZpZXcsIHsgaWNvbjoge1xuICAgICAgICAgICAgICAgIHNvdXJjZToge1xuICAgICAgICAgICAgICAgICAgICBsaWdodDogXCJodHRwczovL3JheWNhc3QuY29tL3VwbG9hZHMvZXh0ZW5zaW9ucy11dGlscy1zZWN1cml0eS1wZXJtaXNzaW9ucy1saWdodC5wbmdcIixcbiAgICAgICAgICAgICAgICAgICAgZGFyazogXCJodHRwczovL3JheWNhc3QuY29tL3VwbG9hZHMvZXh0ZW5zaW9ucy11dGlscy1zZWN1cml0eS1wZXJtaXNzaW9ucy1kYXJrLnBuZ1wiLFxuICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICB9LCB0aXRsZTogXCJSYXljYXN0IG5lZWRzIGZ1bGwgZGlzayBhY2Nlc3MuXCIsIGRlc2NyaXB0aW9uOiBgJHtwcm9wcy5wcmltaW5nID8gcHJvcHMucHJpbWluZyArIFwiXFxuXCIgOiBcIlwifVlvdSBjYW4gcmV2ZXJ0IHRoaXMgYWNjZXNzIGluICR7cHJlZmVyZW5jZXNTdHJpbmd9IHdoZW5ldmVyIHlvdSB3YW50LmAsIGFjdGlvbnM6ICgwLCBqc3hfcnVudGltZV8xLmpzeCkoYXBpXzEuQWN0aW9uUGFuZWwsIHsgY2hpbGRyZW46ICgwLCBqc3hfcnVudGltZV8xLmpzeCkoYXBpXzEuQWN0aW9uLk9wZW4sIHsgLi4uYWN0aW9uIH0pIH0pIH0pIH0pKTtcbn1cbmZ1bmN0aW9uIGNoZWNrQWJvcnRlZChzaWduYWwpIHtcbiAgICBpZiAoc2lnbmFsPy5hYm9ydGVkKSB7XG4gICAgICAgIGNvbnN0IGVycm9yID0gbmV3IEVycm9yKFwiYWJvcnRlZFwiKTtcbiAgICAgICAgZXJyb3IubmFtZSA9IFwiQWJvcnRFcnJvclwiO1xuICAgICAgICB0aHJvdyBlcnJvcjtcbiAgICB9XG59XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLnVzZUZvcm0gPSBleHBvcnRzLkZvcm1WYWxpZGF0aW9uID0gdm9pZCAwO1xuY29uc3QgcmVhY3RfMSA9IHJlcXVpcmUoXCJyZWFjdFwiKTtcbmNvbnN0IHVzZUxhdGVzdF8xID0gcmVxdWlyZShcIi4vdXNlTGF0ZXN0XCIpO1xuLyoqXG4gKiBTaG9ydGhhbmRzIGZvciBjb21tb24gdmFsaWRhdGlvbiBjYXNlc1xuICovXG52YXIgRm9ybVZhbGlkYXRpb247XG4oZnVuY3Rpb24gKEZvcm1WYWxpZGF0aW9uKSB7XG4gICAgLyoqIFNob3cgYW4gZXJyb3Igd2hlbiB0aGUgdmFsdWUgb2YgdGhlIGl0ZW0gaXMgZW1wdHkgKi9cbiAgICBGb3JtVmFsaWRhdGlvbltcIlJlcXVpcmVkXCJdID0gXCJyZXF1aXJlZFwiO1xufSkoRm9ybVZhbGlkYXRpb24gPSBleHBvcnRzLkZvcm1WYWxpZGF0aW9uIHx8IChleHBvcnRzLkZvcm1WYWxpZGF0aW9uID0ge30pKTtcbmZ1bmN0aW9uIHZhbGlkYXRpb25FcnJvcih2YWxpZGF0aW9uLCB2YWx1ZSkge1xuICAgIGlmICh2YWxpZGF0aW9uKSB7XG4gICAgICAgIGlmICh0eXBlb2YgdmFsaWRhdGlvbiA9PT0gXCJmdW5jdGlvblwiKSB7XG4gICAgICAgICAgICByZXR1cm4gdmFsaWRhdGlvbih2YWx1ZSk7XG4gICAgICAgIH1cbiAgICAgICAgZWxzZSBpZiAodmFsaWRhdGlvbiA9PT0gRm9ybVZhbGlkYXRpb24uUmVxdWlyZWQpIHtcbiAgICAgICAgICAgIGxldCB2YWx1ZUlzVmFsaWQgPSB0eXBlb2YgdmFsdWUgIT09IFwidW5kZWZpbmVkXCIgJiYgdmFsdWUgIT09IG51bGw7XG4gICAgICAgICAgICBpZiAodmFsdWVJc1ZhbGlkKSB7XG4gICAgICAgICAgICAgICAgc3dpdGNoICh0eXBlb2YgdmFsdWUpIHtcbiAgICAgICAgICAgICAgICAgICAgY2FzZSBcInN0cmluZ1wiOlxuICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWVJc1ZhbGlkID0gdmFsdWUubGVuZ3RoID4gMDtcbiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgICAgICAgICBjYXNlIFwib2JqZWN0XCI6XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAoQXJyYXkuaXNBcnJheSh2YWx1ZSkpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZUlzVmFsaWQgPSB2YWx1ZS5sZW5ndGggPiAwO1xuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAodmFsdWUgaW5zdGFuY2VvZiBEYXRlKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWVJc1ZhbGlkID0gdmFsdWUuZ2V0VGltZSgpID4gMDtcbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgICAgICAgICBkZWZhdWx0OlxuICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKCF2YWx1ZUlzVmFsaWQpIHtcbiAgICAgICAgICAgICAgICByZXR1cm4gXCJUaGUgaXRlbSBpcyByZXF1aXJlZFwiO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgfVxufVxuLyoqXG4gKiBIb29rIHRoYXQgcHJvdmlkZXMgYSBoaWdoLWxldmVsIGludGVyZmFjZSB0byB3b3JrIHdpdGggRm9ybXMsIGFuZCBtb3JlIHBhcnRpY3VsYXJseSwgd2l0aCBGb3JtIHZhbGlkYXRpb25zLiBJdCBpbmNvcnBvcmF0ZXMgYWxsIHRoZSBnb29kIHByYWN0aWNlcyB0byBwcm92aWRlIGEgZ3JlYXQgVXNlciBFeHBlcmllbmNlIGZvciB5b3VyIEZvcm1zLlxuICpcbiAqIEByZXR1cm5zIGFuIG9iamVjdCB3aGljaCBjb250YWlucyB0aGUgbmVjZXNzYXJ5IG1ldGhvZHMgYW5kIHByb3BzIHRvIHByb3ZpZGUgYSBnb29kIFVzZXIgRXhwZXJpZW5jZSBpbiB5b3VyIEZvcm0uXG4gKlxuICogQGV4YW1wbGVcbiAqIGBgYFxuICogaW1wb3J0IHsgQWN0aW9uLCBBY3Rpb25QYW5lbCwgRm9ybSwgc2hvd1RvYXN0LCBUb2FzdCB9IGZyb20gXCJAcmF5Y2FzdC9hcGlcIjtcbiAqIGltcG9ydCB7IHVzZUZvcm0sIEZvcm1WYWxpZGF0aW9uIH0gZnJvbSBcIkByYXljYXN0L3V0aWxzXCI7XG4gKlxuICogaW50ZXJmYWNlIFNpZ25VcEZvcm1WYWx1ZXMge1xuICogICBuaWNrbmFtZTogc3RyaW5nO1xuICogICBwYXNzd29yZDogc3RyaW5nO1xuICogfVxuICpcbiAqIGV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIE1haW4oKSB7XG4gKiAgIGNvbnN0IHsgaGFuZGxlU3VibWl0LCBpdGVtUHJvcHMgfSA9IHVzZUZvcm08U2lnblVwRm9ybVZhbHVlcz4oe1xuICogICAgIG9uU3VibWl0KHZhbHVlcykge1xuICogICAgICAgc2hvd1RvYXN0KFRvYXN0LlN0eWxlLlN1Y2Nlc3MsIFwiWWF5IVwiLCBgJHt2YWx1ZXMubmlja25hbWV9IGFjY291bnQgY3JlYXRlZGApO1xuICogICAgIH0sXG4gKiAgICAgdmFsaWRhdGlvbjoge1xuICogICAgICAgbmlja25hbWU6IEZvcm1WYWxpZGF0aW9uLlJlcXVpcmVkLFxuICogICAgICAgcGFzc3dvcmQ6ICh2YWx1ZSkgPT4ge1xuICogICAgICAgICBpZiAodmFsdWUgJiYgdmFsdWUubGVuZ3RoIDwgOCkge1xuICogICAgICAgICAgIHJldHVybiBcIlBhc3N3b3JkIG11c3QgYmUgYXQgbGVhc3QgOCBzeW1ib2xzXCI7XG4gKiAgICAgICAgIH0gZWxzZSBpZiAoIXZhbHVlKSB7XG4gKiAgICAgICAgICAgcmV0dXJuIFwiVGhlIGl0ZW0gaXMgcmVxdWlyZWRcIjtcbiAqICAgICAgICAgfVxuICogICAgICAgfSxcbiAqICAgICB9LFxuICogICB9KTtcbiAqXG4gKiAgIHJldHVybiAoXG4gKiAgICAgPEZvcm1cbiAqICAgICAgIGFjdGlvbnM9e1xuICogICAgICAgICA8QWN0aW9uUGFuZWw+XG4gKiAgICAgICAgICAgPEFjdGlvbi5TdWJtaXRGb3JtIHRpdGxlPVwiU3VibWl0XCIgb25TdWJtaXQ9e2hhbmRsZVN1Ym1pdH0gLz5cbiAqICAgICAgICAgPC9BY3Rpb25QYW5lbD5cbiAqICAgICAgIH1cbiAqICAgICA+XG4gKiAgICAgICA8Rm9ybS5UZXh0RmllbGQgdGl0bGU9XCJOaWNrbmFtZVwiIHBsYWNlaG9sZGVyPVwiRW50ZXIgeW91ciBuaWNrbmFtZVwiIHsuLi5pdGVtUHJvcHMubmlja25hbWV9IC8+XG4gKiAgICAgICA8Rm9ybS5QYXNzd29yZEZpZWxkXG4gKiAgICAgICAgIHRpdGxlPVwiUGFzc3dvcmRcIlxuICogICAgICAgICBwbGFjZWhvbGRlcj1cIkVudGVyIHBhc3N3b3JkIGF0IGxlYXN0IDggY2hhcmFjdGVycyBsb25nXCJcbiAqICAgICAgICAgey4uLml0ZW1Qcm9wcy5wYXNzd29yZH1cbiAqICAgICAgIC8+XG4gKiAgICAgPC9Gb3JtPlxuICogICApO1xuICogfVxuICogYGBgXG4gKi9cbmZ1bmN0aW9uIHVzZUZvcm0ocHJvcHMpIHtcbiAgICBjb25zdCB7IG9uU3VibWl0OiBfb25TdWJtaXQsIHZhbGlkYXRpb24sIGluaXRpYWxWYWx1ZXMgPSB7fSB9ID0gcHJvcHM7XG4gICAgLy8gQHRzLWV4cGVjdC1lcnJvciBpdCdzIGZpbmUgaWYgd2UgZG9uJ3Qgc3BlY2lmeSBhbGwgdGhlIHZhbHVlc1xuICAgIGNvbnN0IFt2YWx1ZXMsIHNldFZhbHVlc10gPSAoMCwgcmVhY3RfMS51c2VTdGF0ZSkoaW5pdGlhbFZhbHVlcyk7XG4gICAgY29uc3QgW2Vycm9ycywgc2V0RXJyb3JzXSA9ICgwLCByZWFjdF8xLnVzZVN0YXRlKSh7fSk7XG4gICAgY29uc3QgcmVmcyA9ICgwLCByZWFjdF8xLnVzZVJlZikoe30pO1xuICAgIGNvbnN0IGxhdGVzdFZhbGlkYXRpb24gPSAoMCwgdXNlTGF0ZXN0XzEudXNlTGF0ZXN0KSh2YWxpZGF0aW9uIHx8IHt9KTtcbiAgICBjb25zdCBsYXRlc3RPblN1Ym1pdCA9ICgwLCB1c2VMYXRlc3RfMS51c2VMYXRlc3QpKF9vblN1Ym1pdCk7XG4gICAgY29uc3QgZm9jdXMgPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoKGlkKSA9PiB7XG4gICAgICAgIHJlZnMuY3VycmVudFtpZF0/LmZvY3VzKCk7XG4gICAgfSwgW3JlZnNdKTtcbiAgICBjb25zdCBoYW5kbGVTdWJtaXQgPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoYXN5bmMgKHZhbHVlcykgPT4ge1xuICAgICAgICBsZXQgdmFsaWRhdGlvbkVycm9ycyA9IGZhbHNlO1xuICAgICAgICBmb3IgKGNvbnN0IFtpZCwgdmFsaWRhdGlvbl0gb2YgT2JqZWN0LmVudHJpZXMobGF0ZXN0VmFsaWRhdGlvbi5jdXJyZW50KSkge1xuICAgICAgICAgICAgY29uc3QgZXJyb3IgPSB2YWxpZGF0aW9uRXJyb3IodmFsaWRhdGlvbiwgdmFsdWVzW2lkXSk7XG4gICAgICAgICAgICBpZiAoZXJyb3IpIHtcbiAgICAgICAgICAgICAgICBpZiAoIXZhbGlkYXRpb25FcnJvcnMpIHtcbiAgICAgICAgICAgICAgICAgICAgdmFsaWRhdGlvbkVycm9ycyA9IHt9O1xuICAgICAgICAgICAgICAgICAgICAvLyB3ZSBmb2N1cyB0aGUgZmlyc3QgaXRlbSB0aGF0IGhhcyBhbiBlcnJvclxuICAgICAgICAgICAgICAgICAgICBmb2N1cyhpZCk7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHZhbGlkYXRpb25FcnJvcnNbaWRdID0gZXJyb3I7XG4gICAgICAgICAgICB9XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHZhbGlkYXRpb25FcnJvcnMpIHtcbiAgICAgICAgICAgIHNldEVycm9ycyh2YWxpZGF0aW9uRXJyb3JzKTtcbiAgICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgfVxuICAgICAgICBjb25zdCByZXN1bHQgPSBhd2FpdCBsYXRlc3RPblN1Ym1pdC5jdXJyZW50KHZhbHVlcyk7XG4gICAgICAgIHJldHVybiB0eXBlb2YgcmVzdWx0ID09PSBcImJvb2xlYW5cIiA/IHJlc3VsdCA6IHRydWU7XG4gICAgfSwgW2xhdGVzdFZhbGlkYXRpb24sIGxhdGVzdE9uU3VibWl0LCBmb2N1c10pO1xuICAgIGNvbnN0IHNldFZhbGlkYXRpb25FcnJvciA9ICgwLCByZWFjdF8xLnVzZUNhbGxiYWNrKSgoaWQsIGVycm9yKSA9PiB7XG4gICAgICAgIHNldEVycm9ycygoZXJyb3JzKSA9PiAoeyAuLi5lcnJvcnMsIFtpZF06IGVycm9yIH0pKTtcbiAgICB9LCBbc2V0RXJyb3JzXSk7XG4gICAgY29uc3Qgc2V0VmFsdWUgPSAoMCwgcmVhY3RfMS51c2VDYWxsYmFjaykoZnVuY3Rpb24gKGlkLCB2YWx1ZSkge1xuICAgICAgICBzZXRWYWx1ZXMoKHZhbHVlcykgPT4gKHsgLi4udmFsdWVzLCBbaWRdOiB2YWx1ZSB9KSk7XG4gICAgfSwgW3NldFZhbHVlc10pO1xuICAgIGNvbnN0IGl0ZW1Qcm9wcyA9ICgwLCByZWFjdF8xLnVzZU1lbW8pKCgpID0+IHtcbiAgICAgICAgLy8gd2UgaGF2ZSB0byB1c2UgYSBwcm94eSBiZWNhdXNlIHdlIGRvbid0IGFjdHVhbGx5IGhhdmUgYW55IG9iamVjdCB0byBpdGVyYXRlIHRocm91Z2hcbiAgICAgICAgLy8gc28gaW5zdGVhZCB3ZSBkeW5hbWljYWxseSBjcmVhdGUgdGhlIHByb3BzIHdoZW4gcmVxdWlyZWRcbiAgICAgICAgcmV0dXJuIG5ldyBQcm94eShcbiAgICAgICAgLy8gQHRzLWV4cGVjdC1lcnJvciB0aGUgd2hvbGUgcG9pbnQgb2YgYSBwcm94eS4uLlxuICAgICAgICB7fSwge1xuICAgICAgICAgICAgZ2V0KHRhcmdldCwgaWQpIHtcbiAgICAgICAgICAgICAgICBjb25zdCB2YWxpZGF0aW9uID0gbGF0ZXN0VmFsaWRhdGlvbi5jdXJyZW50W2lkXTtcbiAgICAgICAgICAgICAgICBjb25zdCB2YWx1ZSA9IHZhbHVlc1tpZF07XG4gICAgICAgICAgICAgICAgcmV0dXJuIHtcbiAgICAgICAgICAgICAgICAgICAgb25DaGFuZ2UodmFsdWUpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnJvcnNbaWRdKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZXJyb3IgPSB2YWxpZGF0aW9uRXJyb3IodmFsaWRhdGlvbiwgdmFsdWUpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZXJyb3IpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0VmFsaWRhdGlvbkVycm9yKGlkLCB1bmRlZmluZWQpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIHNldFZhbHVlKGlkLCB2YWx1ZSk7XG4gICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgIG9uQmx1cihldmVudCkge1xuICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZXJyb3IgPSB2YWxpZGF0aW9uRXJyb3IodmFsaWRhdGlvbiwgZXZlbnQudGFyZ2V0LnZhbHVlKTtcbiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnJvcikge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNldFZhbGlkYXRpb25FcnJvcihpZCwgZXJyb3IpO1xuICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICBlcnJvcjogZXJyb3JzW2lkXSxcbiAgICAgICAgICAgICAgICAgICAgaWQsXG4gICAgICAgICAgICAgICAgICAgIC8vIHdlIHNob3VsZG4ndCByZXR1cm4gYHVuZGVmaW5lZGAgb3RoZXJ3aXNlIGl0IHdpbGwgYmUgYW4gdW5jb250cm9sbGVkIGNvbXBvbmVudFxuICAgICAgICAgICAgICAgICAgICB2YWx1ZTogdHlwZW9mIHZhbHVlID09PSBcInVuZGVmaW5lZFwiID8gbnVsbCA6IHZhbHVlLFxuICAgICAgICAgICAgICAgICAgICByZWY6IChpbnN0YW5jZSkgPT4ge1xuICAgICAgICAgICAgICAgICAgICAgICAgcmVmcy5jdXJyZW50W2lkXSA9IGluc3RhbmNlO1xuICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgIH07XG4gICAgICAgICAgICB9LFxuICAgICAgICB9KTtcbiAgICB9LCBbZXJyb3JzLCBsYXRlc3RWYWxpZGF0aW9uLCBzZXRWYWxpZGF0aW9uRXJyb3IsIHZhbHVlcywgcmVmcywgc2V0VmFsdWVdKTtcbiAgICBjb25zdCByZXNldCA9ICgwLCByZWFjdF8xLnVzZUNhbGxiYWNrKSgoaW5pdGlhbFZhbHVlcyA9IHt9KSA9PiB7XG4gICAgICAgIC8vIEB0cy1leHBlY3QtZXJyb3IgaXQncyBmaW5lIGlmIHdlIGRvbid0IHNwZWNpZnkgYWxsIHRoZSB2YWx1ZXNcbiAgICAgICAgc2V0VmFsdWVzKGluaXRpYWxWYWx1ZXMpO1xuICAgICAgICBzZXRFcnJvcnMoe30pO1xuICAgIH0sIFtzZXRWYWx1ZXMsIHNldEVycm9yc10pO1xuICAgIHJldHVybiB7IGhhbmRsZVN1Ym1pdCwgc2V0VmFsaWRhdGlvbkVycm9yLCBzZXRWYWx1ZSwgdmFsdWVzLCBpdGVtUHJvcHMsIGZvY3VzLCByZXNldCB9O1xufVxuZXhwb3J0cy51c2VGb3JtID0gdXNlRm9ybTtcbiIsICJcInVzZSBzdHJpY3RcIjtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbmV4cG9ydHMuc2xpZ2h0bHlMaWdodGVyQ29sb3IgPSBleHBvcnRzLnNsaWdodGx5RGFya2VyQ29sb3IgPSB2b2lkIDA7XG5mdW5jdGlvbiBoZXhUb1JHQihoZXgpIHtcbiAgICBsZXQgciA9IDA7XG4gICAgbGV0IGcgPSAwO1xuICAgIGxldCBiID0gMDtcbiAgICAvLyAzIGRpZ2l0c1xuICAgIGlmIChoZXgubGVuZ3RoID09PSA0KSB7XG4gICAgICAgIHIgPSBwYXJzZUludChgJHtoZXhbMV19JHtoZXhbMV19YCwgMTYpO1xuICAgICAgICBnID0gcGFyc2VJbnQoYCR7aGV4WzJdfSR7aGV4WzJdfWAsIDE2KTtcbiAgICAgICAgYiA9IHBhcnNlSW50KGAke2hleFszXX0ke2hleFszXX1gLCAxNik7XG4gICAgICAgIC8vIDYgZGlnaXRzXG4gICAgfVxuICAgIGVsc2UgaWYgKGhleC5sZW5ndGggPT09IDcpIHtcbiAgICAgICAgciA9IHBhcnNlSW50KGAke2hleFsxXX0ke2hleFsyXX1gLCAxNik7XG4gICAgICAgIGcgPSBwYXJzZUludChgJHtoZXhbM119JHtoZXhbNF19YCwgMTYpO1xuICAgICAgICBiID0gcGFyc2VJbnQoYCR7aGV4WzVdfSR7aGV4WzZdfWAsIDE2KTtcbiAgICB9XG4gICAgZWxzZSB7XG4gICAgICAgIHRocm93IG5ldyBFcnJvcihgTWFsZm9ybWVkIGhleCBjb2xvcjogJHtoZXh9YCk7XG4gICAgfVxuICAgIHJldHVybiB7IHIsIGcsIGIgfTtcbn1cbmZ1bmN0aW9uIHJnYlRvSGV4KHsgciwgZywgYiB9KSB7XG4gICAgbGV0IHJTdHJpbmcgPSByLnRvU3RyaW5nKDE2KTtcbiAgICBsZXQgZ1N0cmluZyA9IGcudG9TdHJpbmcoMTYpO1xuICAgIGxldCBiU3RyaW5nID0gYi50b1N0cmluZygxNik7XG4gICAgaWYgKHJTdHJpbmcubGVuZ3RoID09PSAxKSB7XG4gICAgICAgIHJTdHJpbmcgPSBgMCR7clN0cmluZ31gO1xuICAgIH1cbiAgICBpZiAoZ1N0cmluZy5sZW5ndGggPT09IDEpIHtcbiAgICAgICAgZ1N0cmluZyA9IGAwJHtnU3RyaW5nfWA7XG4gICAgfVxuICAgIGlmIChiU3RyaW5nLmxlbmd0aCA9PT0gMSkge1xuICAgICAgICBiU3RyaW5nID0gYDAke2JTdHJpbmd9YDtcbiAgICB9XG4gICAgcmV0dXJuIGAjJHtyU3RyaW5nfSR7Z1N0cmluZ30ke2JTdHJpbmd9YDtcbn1cbmZ1bmN0aW9uIHJnYlRvSFNMKHsgciwgZywgYiB9KSB7XG4gICAgLy8gTWFrZSByLCBnLCBhbmQgYiBmcmFjdGlvbnMgb2YgMVxuICAgIHIgLz0gMjU1O1xuICAgIGcgLz0gMjU1O1xuICAgIGIgLz0gMjU1O1xuICAgIC8vIEZpbmQgZ3JlYXRlc3QgYW5kIHNtYWxsZXN0IGNoYW5uZWwgdmFsdWVzXG4gICAgY29uc3QgY21pbiA9IE1hdGgubWluKHIsIGcsIGIpO1xuICAgIGNvbnN0IGNtYXggPSBNYXRoLm1heChyLCBnLCBiKTtcbiAgICBjb25zdCBkZWx0YSA9IGNtYXggLSBjbWluO1xuICAgIGxldCBoID0gMDtcbiAgICBsZXQgcyA9IDA7XG4gICAgbGV0IGwgPSAwO1xuICAgIC8vIENhbGN1bGF0ZSBodWVcbiAgICAvLyBObyBkaWZmZXJlbmNlXG4gICAgaWYgKGRlbHRhID09PSAwKSB7XG4gICAgICAgIGggPSAwO1xuICAgIH1cbiAgICAvLyBSZWQgaXMgbWF4XG4gICAgZWxzZSBpZiAoY21heCA9PT0gcikge1xuICAgICAgICBoID0gKChnIC0gYikgLyBkZWx0YSkgJSA2O1xuICAgIH1cbiAgICAvLyBHcmVlbiBpcyBtYXhcbiAgICBlbHNlIGlmIChjbWF4ID09PSBnKSB7XG4gICAgICAgIGggPSAoYiAtIHIpIC8gZGVsdGEgKyAyO1xuICAgIH1cbiAgICAvLyBCbHVlIGlzIG1heFxuICAgIGVsc2Uge1xuICAgICAgICBoID0gKHIgLSBnKSAvIGRlbHRhICsgNDtcbiAgICB9XG4gICAgaCA9IE1hdGgucm91bmQoaCAqIDYwKTtcbiAgICAvLyBNYWtlIG5lZ2F0aXZlIGh1ZXMgcG9zaXRpdmUgYmVoaW5kIDM2MFx1MDBCMFxuICAgIGlmIChoIDwgMCkge1xuICAgICAgICBoICs9IDM2MDtcbiAgICB9XG4gICAgLy8gQ2FsY3VsYXRlIGxpZ2h0bmVzc1xuICAgIGwgPSAoY21heCArIGNtaW4pIC8gMjtcbiAgICAvLyBDYWxjdWxhdGUgc2F0dXJhdGlvblxuICAgIHMgPSBkZWx0YSA9PT0gMCA/IDAgOiBkZWx0YSAvICgxIC0gTWF0aC5hYnMoMiAqIGwgLSAxKSk7XG4gICAgLy8gTXVsdGlwbHkgbCBhbmQgcyBieSAxMDBcbiAgICBzID0gKyhzICogMTAwKS50b0ZpeGVkKDEpO1xuICAgIGwgPSArKGwgKiAxMDApLnRvRml4ZWQoMSk7XG4gICAgcmV0dXJuIHsgaCwgcywgbCB9O1xufVxuZnVuY3Rpb24gaHNsVG9SR0IoeyBoLCBzLCBsIH0pIHtcbiAgICAvLyBNdXN0IGJlIGZyYWN0aW9ucyBvZiAxXG4gICAgcyAvPSAxMDA7XG4gICAgbCAvPSAxMDA7XG4gICAgY29uc3QgYyA9ICgxIC0gTWF0aC5hYnMoMiAqIGwgLSAxKSkgKiBzO1xuICAgIGNvbnN0IHggPSBjICogKDEgLSBNYXRoLmFicygoKGggLyA2MCkgJSAyKSAtIDEpKTtcbiAgICBjb25zdCBtID0gbCAtIGMgLyAyO1xuICAgIGxldCByID0gMDtcbiAgICBsZXQgZyA9IDA7XG4gICAgbGV0IGIgPSAwO1xuICAgIGlmIChoID49IDAgJiYgaCA8IDYwKSB7XG4gICAgICAgIHIgPSBjO1xuICAgICAgICBnID0geDtcbiAgICAgICAgYiA9IDA7XG4gICAgfVxuICAgIGVsc2UgaWYgKGggPj0gNjAgJiYgaCA8IDEyMCkge1xuICAgICAgICByID0geDtcbiAgICAgICAgZyA9IGM7XG4gICAgICAgIGIgPSAwO1xuICAgIH1cbiAgICBlbHNlIGlmIChoID49IDEyMCAmJiBoIDwgMTgwKSB7XG4gICAgICAgIHIgPSAwO1xuICAgICAgICBnID0gYztcbiAgICAgICAgYiA9IHg7XG4gICAgfVxuICAgIGVsc2UgaWYgKGggPj0gMTgwICYmIGggPCAyNDApIHtcbiAgICAgICAgciA9IDA7XG4gICAgICAgIGcgPSB4O1xuICAgICAgICBiID0gYztcbiAgICB9XG4gICAgZWxzZSBpZiAoaCA+PSAyNDAgJiYgaCA8IDMwMCkge1xuICAgICAgICByID0geDtcbiAgICAgICAgZyA9IDA7XG4gICAgICAgIGIgPSBjO1xuICAgIH1cbiAgICBlbHNlIGlmIChoID49IDMwMCAmJiBoIDwgMzYwKSB7XG4gICAgICAgIHIgPSBjO1xuICAgICAgICBnID0gMDtcbiAgICAgICAgYiA9IHg7XG4gICAgfVxuICAgIHIgPSBNYXRoLnJvdW5kKChyICsgbSkgKiAyNTUpO1xuICAgIGcgPSBNYXRoLnJvdW5kKChnICsgbSkgKiAyNTUpO1xuICAgIGIgPSBNYXRoLnJvdW5kKChiICsgbSkgKiAyNTUpO1xuICAgIHJldHVybiB7IHIsIGcsIGIgfTtcbn1cbmZ1bmN0aW9uIGhleFRvSFNMKGhleCkge1xuICAgIHJldHVybiByZ2JUb0hTTChoZXhUb1JHQihoZXgpKTtcbn1cbmZ1bmN0aW9uIGhzbFRvSGV4KGhzbCkge1xuICAgIHJldHVybiByZ2JUb0hleChoc2xUb1JHQihoc2wpKTtcbn1cbmZ1bmN0aW9uIGNsYW1wKHZhbHVlLCBtaW4sIG1heCkge1xuICAgIHJldHVybiBtaW4gPCBtYXggPyAodmFsdWUgPCBtaW4gPyBtaW4gOiB2YWx1ZSA+IG1heCA/IG1heCA6IHZhbHVlKSA6IHZhbHVlIDwgbWF4ID8gbWF4IDogdmFsdWUgPiBtaW4gPyBtaW4gOiB2YWx1ZTtcbn1cbmNvbnN0IG9mZnNldCA9IDEyO1xuZnVuY3Rpb24gc2xpZ2h0bHlEYXJrZXJDb2xvcihoZXgpIHtcbiAgICBjb25zdCBoc2wgPSBoZXhUb0hTTChoZXgpO1xuICAgIHJldHVybiBoc2xUb0hleCh7XG4gICAgICAgIGg6IGhzbC5oLFxuICAgICAgICBzOiBoc2wucyxcbiAgICAgICAgbDogY2xhbXAoaHNsLmwgLSBvZmZzZXQsIDAsIDEwMCksXG4gICAgfSk7XG59XG5leHBvcnRzLnNsaWdodGx5RGFya2VyQ29sb3IgPSBzbGlnaHRseURhcmtlckNvbG9yO1xuZnVuY3Rpb24gc2xpZ2h0bHlMaWdodGVyQ29sb3IoaGV4KSB7XG4gICAgY29uc3QgaHNsID0gaGV4VG9IU0woaGV4KTtcbiAgICByZXR1cm4gaHNsVG9IZXgoe1xuICAgICAgICBoOiBoc2wuaCxcbiAgICAgICAgczogaHNsLnMsXG4gICAgICAgIGw6IGNsYW1wKGhzbC5sICsgb2Zmc2V0LCAwLCAxMDApLFxuICAgIH0pO1xufVxuZXhwb3J0cy5zbGlnaHRseUxpZ2h0ZXJDb2xvciA9IHNsaWdodGx5TGlnaHRlckNvbG9yO1xuIiwgIlwidXNlIHN0cmljdFwiO1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5nZXRBdmF0YXJJY29uID0gdm9pZCAwO1xuY29uc3QgY29sb3JfMSA9IHJlcXVpcmUoXCIuL2NvbG9yXCIpO1xuZnVuY3Rpb24gZ2V0V2hvbGVDaGFyQW5kSShzdHIsIGkpIHtcbiAgICBjb25zdCBjb2RlID0gc3RyLmNoYXJDb2RlQXQoaSk7XG4gICAgaWYgKE51bWJlci5pc05hTihjb2RlKSkge1xuICAgICAgICByZXR1cm4gW1wiXCIsIGldO1xuICAgIH1cbiAgICBpZiAoY29kZSA8IDB4ZDgwMCB8fCBjb2RlID4gMHhkZmZmKSB7XG4gICAgICAgIHJldHVybiBbc3RyLmNoYXJBdChpKSwgaV07IC8vIE5vcm1hbCBjaGFyYWN0ZXIsIGtlZXBpbmcgJ2knIHRoZSBzYW1lXG4gICAgfVxuICAgIC8vIEhpZ2ggc3Vycm9nYXRlIChjb3VsZCBjaGFuZ2UgbGFzdCBoZXggdG8gMHhEQjdGIHRvIHRyZWF0IGhpZ2ggcHJpdmF0ZVxuICAgIC8vIHN1cnJvZ2F0ZXMgYXMgc2luZ2xlIGNoYXJhY3RlcnMpXG4gICAgaWYgKDB4ZDgwMCA8PSBjb2RlICYmIGNvZGUgPD0gMHhkYmZmKSB7XG4gICAgICAgIGlmIChzdHIubGVuZ3RoIDw9IGkgKyAxKSB7XG4gICAgICAgICAgICB0aHJvdyBuZXcgRXJyb3IoXCJIaWdoIHN1cnJvZ2F0ZSB3aXRob3V0IGZvbGxvd2luZyBsb3cgc3Vycm9nYXRlXCIpO1xuICAgICAgICB9XG4gICAgICAgIGNvbnN0IG5leHQgPSBzdHIuY2hhckNvZGVBdChpICsgMSk7XG4gICAgICAgIGlmICgweGRjMDAgPiBuZXh0IHx8IG5leHQgPiAweGRmZmYpIHtcbiAgICAgICAgICAgIHRocm93IG5ldyBFcnJvcihcIkhpZ2ggc3Vycm9nYXRlIHdpdGhvdXQgZm9sbG93aW5nIGxvdyBzdXJyb2dhdGVcIik7XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuIFtzdHIuY2hhckF0KGkpICsgc3RyLmNoYXJBdChpICsgMSksIGkgKyAxXTtcbiAgICB9XG4gICAgLy8gTG93IHN1cnJvZ2F0ZSAoMHhEQzAwIDw9IGNvZGUgJiYgY29kZSA8PSAweERGRkYpXG4gICAgaWYgKGkgPT09IDApIHtcbiAgICAgICAgdGhyb3cgbmV3IEVycm9yKFwiTG93IHN1cnJvZ2F0ZSB3aXRob3V0IHByZWNlZGluZyBoaWdoIHN1cnJvZ2F0ZVwiKTtcbiAgICB9XG4gICAgY29uc3QgcHJldiA9IHN0ci5jaGFyQ29kZUF0KGkgLSAxKTtcbiAgICAvLyAoY291bGQgY2hhbmdlIGxhc3QgaGV4IHRvIDB4REI3RiB0byB0cmVhdCBoaWdoIHByaXZhdGUgc3Vycm9nYXRlc1xuICAgIC8vIGFzIHNpbmdsZSBjaGFyYWN0ZXJzKVxuICAgIGlmICgweGQ4MDAgPiBwcmV2IHx8IHByZXYgPiAweGRiZmYpIHtcbiAgICAgICAgdGhyb3cgbmV3IEVycm9yKFwiTG93IHN1cnJvZ2F0ZSB3aXRob3V0IHByZWNlZGluZyBoaWdoIHN1cnJvZ2F0ZVwiKTtcbiAgICB9XG4gICAgLy8gUmV0dXJuIHRoZSBuZXh0IGNoYXJhY3RlciBpbnN0ZWFkIChhbmQgaW5jcmVtZW50KVxuICAgIHJldHVybiBbc3RyLmNoYXJBdChpICsgMSksIGkgKyAxXTtcbn1cbmNvbnN0IGF2YXRhckNvbG9yU2V0ID0gW1xuICAgIFwiI0RDODI5QVwiLFxuICAgIFwiI0Q2NDg1NFwiLFxuICAgIFwiI0Q0NzYwMFwiLFxuICAgIFwiI0QzNkNERFwiLFxuICAgIFwiIzUyQTlFNFwiLFxuICAgIFwiIzc4NzFFOFwiLFxuICAgIFwiIzcwOTIwRlwiLFxuICAgIFwiIzQzQjkzQVwiLFxuICAgIFwiI0VCNkIzRVwiLFxuICAgIFwiIzI2Qjc5NVwiLFxuICAgIFwiI0Q4NUE5QlwiLFxuICAgIFwiI0EwNjdEQ1wiLFxuICAgIFwiI0JEOTUwMFwiLFxuICAgIFwiIzUzODVEOVwiLCAvLyBCbHVlXG5dO1xuLyoqXG4gKiBJY29uIHRvIHJlcHJlc2VudCBhbiBhdmF0YXIgd2hlbiB5b3UgZG9uJ3QgaGF2ZSBvbmUuIFRoZSBnZW5lcmF0ZWQgYXZhdGFyXG4gKiB3aWxsIGJlIGdlbmVyYXRlZCBmcm9tIHRoZSBpbml0aWFscyBvZiB0aGUgbmFtZSBhbmQgaGF2ZSBhIGNvbG9yZnVsIGJ1dCBjb25zaXN0ZW50IGJhY2tncm91bmQuXG4gKlxuICogQHJldHVybnMgYW4gSW1hZ2UgdGhhdCBjYW4gYmUgdXNlZCB3aGVyZSBSYXljYXN0IGV4cGVjdHMgdGhlbS5cbiAqXG4gKiBAZXhhbXBsZVxuICogYGBgXG4gKiA8TGlzdC5JdGVtIGljb249e2dldEF2YXRhckljb24oJ01hdGhpZXUgRHV0b3VyJyl9IHRpdGxlPVwiUHJvamVjdFwiIC8+XG4gKiBgYGBcbiAqL1xuZnVuY3Rpb24gZ2V0QXZhdGFySWNvbihuYW1lLCBvcHRpb25zKSB7XG4gICAgY29uc3Qgd29yZHMgPSBuYW1lLnRyaW0oKS5zcGxpdChcIiBcIik7XG4gICAgbGV0IGluaXRpYWxzO1xuICAgIGlmICh3b3Jkcy5sZW5ndGggPT0gMSAmJiBnZXRXaG9sZUNoYXJBbmRJKHdvcmRzWzBdLCAwKVswXSkge1xuICAgICAgICBpbml0aWFscyA9IGdldFdob2xlQ2hhckFuZEkod29yZHNbMF0sIDApWzBdO1xuICAgIH1cbiAgICBlbHNlIGlmICh3b3Jkcy5sZW5ndGggPiAxKSB7XG4gICAgICAgIGNvbnN0IGZpcnN0V29yZEZpcnN0TGV0dGVyID0gZ2V0V2hvbGVDaGFyQW5kSSh3b3Jkc1swXSwgMClbMF0gfHwgXCJcIjtcbiAgICAgICAgY29uc3QgbGFzdFdvcmRGaXJzdExldHRlciA9IGdldFdob2xlQ2hhckFuZEkod29yZHNbd29yZHMubGVuZ3RoIC0gMV0sIDApWzBdID8/IFwiXCI7XG4gICAgICAgIGluaXRpYWxzID0gZmlyc3RXb3JkRmlyc3RMZXR0ZXIgKyBsYXN0V29yZEZpcnN0TGV0dGVyO1xuICAgIH1cbiAgICBlbHNlIHtcbiAgICAgICAgaW5pdGlhbHMgPSBcIlwiO1xuICAgIH1cbiAgICBsZXQgYmFja2dyb3VuZENvbG9yO1xuICAgIGlmIChvcHRpb25zPy5iYWNrZ3JvdW5kKSB7XG4gICAgICAgIGJhY2tncm91bmRDb2xvciA9IG9wdGlvbnM/LmJhY2tncm91bmQ7XG4gICAgfVxuICAgIGVsc2Uge1xuICAgICAgICBsZXQgaW5pdGlhbHNDaGFySW5kZXggPSAwO1xuICAgICAgICBsZXQgW2NoYXIsIGldID0gZ2V0V2hvbGVDaGFyQW5kSShpbml0aWFscywgMCk7XG4gICAgICAgIHdoaWxlIChjaGFyKSB7XG4gICAgICAgICAgICBpbml0aWFsc0NoYXJJbmRleCArPSBjaGFyLmNoYXJDb2RlQXQoMCk7XG4gICAgICAgICAgICBbY2hhciwgaV0gPSBnZXRXaG9sZUNoYXJBbmRJKGluaXRpYWxzLCBpICsgMSk7XG4gICAgICAgIH1cbiAgICAgICAgY29uc3QgY29sb3JJbmRleCA9IGluaXRpYWxzQ2hhckluZGV4ICUgYXZhdGFyQ29sb3JTZXQubGVuZ3RoO1xuICAgICAgICBiYWNrZ3JvdW5kQ29sb3IgPSBhdmF0YXJDb2xvclNldFtjb2xvckluZGV4XTtcbiAgICB9XG4gICAgY29uc3QgcGFkZGluZyA9IDA7XG4gICAgY29uc3QgcmFkaXVzID0gNTAgLSBwYWRkaW5nO1xuICAgIGNvbnN0IHN2ZyA9IGA8c3ZnIHdpZHRoPVwiMTAwcHhcIiBoZWlnaHQ9XCIxMDBweFwiPlxuICAke29wdGlvbnM/LmdyYWRpZW50ICE9PSBmYWxzZVxuICAgICAgICA/IGA8ZGVmcz5cbiAgICAgIDxsaW5lYXJHcmFkaWVudCBpZD1cIkdyYWRpZW50XCIgeDE9XCIwLjI1XCIgeDI9XCIwLjc1XCIgeTE9XCIwXCIgeTI9XCIxXCI+XG4gICAgICAgIDxzdG9wIG9mZnNldD1cIjAlXCIgc3RvcC1jb2xvcj1cIiR7KDAsIGNvbG9yXzEuc2xpZ2h0bHlMaWdodGVyQ29sb3IpKGJhY2tncm91bmRDb2xvcil9XCIvPlxuICAgICAgICA8c3RvcCBvZmZzZXQ9XCI1MCVcIiBzdG9wLWNvbG9yPVwiJHtiYWNrZ3JvdW5kQ29sb3J9XCIvPlxuICAgICAgICA8c3RvcCBvZmZzZXQ9XCIxMDAlXCIgc3RvcC1jb2xvcj1cIiR7KDAsIGNvbG9yXzEuc2xpZ2h0bHlEYXJrZXJDb2xvcikoYmFja2dyb3VuZENvbG9yKX1cIi8+XG4gICAgICA8L2xpbmVhckdyYWRpZW50PlxuICA8L2RlZnM+YFxuICAgICAgICA6IFwiXCJ9XG4gICAgICA8Y2lyY2xlIGN4PVwiNTBcIiBjeT1cIjUwXCIgcj1cIiR7cmFkaXVzfVwiIGZpbGw9XCIke29wdGlvbnM/LmdyYWRpZW50ICE9PSBmYWxzZSA/IFwidXJsKCNHcmFkaWVudClcIiA6IGJhY2tncm91bmRDb2xvcn1cIiAvPlxuICAgICAgJHtpbml0aWFsc1xuICAgICAgICA/IGA8dGV4dCB4PVwiNTBcIiB5PVwiODBcIiBmb250LXNpemU9XCIke3JhZGl1cyAtIDF9XCIgZm9udC1mYW1pbHk9XCJJbnRlciwgc2Fucy1zZXJpZlwiIHRleHQtYW5jaG9yPVwibWlkZGxlXCIgZmlsbD1cIndoaXRlXCI+JHtpbml0aWFscy50b1VwcGVyQ2FzZSgpfTwvdGV4dD5gXG4gICAgICAgIDogXCJcIn1cbiAgICA8L3N2Zz5cbiAgYC5yZXBsYWNlQWxsKFwiXFxuXCIsIFwiXCIpO1xuICAgIHJldHVybiBgZGF0YTppbWFnZS9zdmcreG1sLCR7c3ZnfWA7XG59XG5leHBvcnRzLmdldEF2YXRhckljb24gPSBnZXRBdmF0YXJJY29uO1xuIiwgIlwidXNlIHN0cmljdFwiO1xuT2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFwiX19lc01vZHVsZVwiLCB7IHZhbHVlOiB0cnVlIH0pO1xuZXhwb3J0cy5nZXRGYXZpY29uID0gdm9pZCAwO1xuY29uc3QgYXBpXzEgPSByZXF1aXJlKFwiQHJheWNhc3QvYXBpXCIpO1xuY29uc3QgdXJsXzEgPSByZXF1aXJlKFwidXJsXCIpO1xuLyoqXG4gKiBJY29uIHNob3dpbmcgdGhlIGZhdmljb24gb2YgYSB3ZWJzaXRlLlxuICpcbiAqIEEgZmF2aWNvbiAoZmF2b3JpdGUgaWNvbikgaXMgYSB0aW55IGljb24gaW5jbHVkZWQgYWxvbmcgd2l0aCBhIHdlYnNpdGUsIHdoaWNoIGlzIGRpc3BsYXllZCBpbiBwbGFjZXMgbGlrZSB0aGUgYnJvd3NlcidzIGFkZHJlc3MgYmFyLCBwYWdlIHRhYnMsIGFuZCBib29rbWFya3MgbWVudS5cbiAqXG4gKiBAcGFyYW0gdXJsIFRoZSBVUkwgb2YgdGhlIHdlYnNpdGUgdG8gcmVwcmVzZW50LlxuICpcbiAqIEByZXR1cm5zIGFuIEltYWdlIHRoYXQgY2FuIGJlIHVzZWQgd2hlcmUgUmF5Y2FzdCBleHBlY3RzIHRoZW0uXG4gKlxuICogQGV4YW1wbGVcbiAqIGBgYFxuICogPExpc3QuSXRlbSBpY29uPXtnZXRGYXZpY29uKFwiaHR0cHM6Ly9yYXljYXN0LmNvbVwiKX0gdGl0bGU9XCJSYXljYXN0IFdlYnNpdGVcIiAvPlxuICogYGBgXG4gKi9cbmZ1bmN0aW9uIGdldEZhdmljb24odXJsLCBvcHRpb25zKSB7XG4gICAgdHJ5IHtcbiAgICAgICAgY29uc3QgdXJsT2JqID0gdHlwZW9mIHVybCA9PT0gXCJzdHJpbmdcIiA/IG5ldyB1cmxfMS5VUkwodXJsKSA6IHVybDtcbiAgICAgICAgY29uc3QgaG9zdG5hbWUgPSB1cmxPYmouaG9zdG5hbWU7XG4gICAgICAgIHJldHVybiB7XG4gICAgICAgICAgICBzb3VyY2U6IGBodHRwczovL3d3dy5nb29nbGUuY29tL3MyL2Zhdmljb25zP3N6PSR7b3B0aW9ucz8uc2l6ZSA/PyA2NH0mZG9tYWluPSR7aG9zdG5hbWV9YCxcbiAgICAgICAgICAgIGZhbGxiYWNrOiBvcHRpb25zPy5mYWxsYmFjayA/PyBhcGlfMS5JY29uLkxpbmssXG4gICAgICAgICAgICBtYXNrOiBvcHRpb25zPy5tYXNrLFxuICAgICAgICB9O1xuICAgIH1cbiAgICBjYXRjaCAoZSkge1xuICAgICAgICBjb25zb2xlLmVycm9yKGUpO1xuICAgICAgICByZXR1cm4gYXBpXzEuSWNvbi5MaW5rO1xuICAgIH1cbn1cbmV4cG9ydHMuZ2V0RmF2aWNvbiA9IGdldEZhdmljb247XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5leHBvcnRzLmdldFByb2dyZXNzSWNvbiA9IHZvaWQgMDtcbmNvbnN0IGFwaV8xID0gcmVxdWlyZShcIkByYXljYXN0L2FwaVwiKTtcbmZ1bmN0aW9uIHBvbGFyVG9DYXJ0ZXNpYW4oY2VudGVyWCwgY2VudGVyWSwgcmFkaXVzLCBhbmdsZUluRGVncmVlcykge1xuICAgIGNvbnN0IGFuZ2xlSW5SYWRpYW5zID0gKChhbmdsZUluRGVncmVlcyAtIDkwKSAqIE1hdGguUEkpIC8gMTgwLjA7XG4gICAgcmV0dXJuIHtcbiAgICAgICAgeDogY2VudGVyWCArIHJhZGl1cyAqIE1hdGguY29zKGFuZ2xlSW5SYWRpYW5zKSxcbiAgICAgICAgeTogY2VudGVyWSArIHJhZGl1cyAqIE1hdGguc2luKGFuZ2xlSW5SYWRpYW5zKSxcbiAgICB9O1xufVxuZnVuY3Rpb24gZGVzY3JpYmVBcmMoeCwgeSwgcmFkaXVzLCBzdGFydEFuZ2xlLCBlbmRBbmdsZSkge1xuICAgIGNvbnN0IHN0YXJ0ID0gcG9sYXJUb0NhcnRlc2lhbih4LCB5LCByYWRpdXMsIGVuZEFuZ2xlKTtcbiAgICBjb25zdCBlbmQgPSBwb2xhclRvQ2FydGVzaWFuKHgsIHksIHJhZGl1cywgc3RhcnRBbmdsZSk7XG4gICAgY29uc3QgbGFyZ2VBcmNGbGFnID0gZW5kQW5nbGUgLSBzdGFydEFuZ2xlIDw9IDE4MCA/IFwiMFwiIDogXCIxXCI7XG4gICAgY29uc3QgZCA9IFtcIk1cIiwgc3RhcnQueCwgc3RhcnQueSwgXCJBXCIsIHJhZGl1cywgcmFkaXVzLCAwLCBsYXJnZUFyY0ZsYWcsIDAsIGVuZC54LCBlbmQueV0uam9pbihcIiBcIik7XG4gICAgcmV0dXJuIGQ7XG59XG4vKipcbiAqIEljb24gdG8gcmVwcmVzZW50IHRoZSBwcm9ncmVzcyBvZiBfc29tZXRoaW5nXy5cbiAqXG4gKiBAcGFyYW0gcHJvZ3Jlc3MgTnVtYmVyIGJldHdlZW4gMCBhbmQgMS5cbiAqIEBwYXJhbSBjb2xvciBIZXggY29sb3IgKGRlZmF1bHQgYFwiI0ZGNjM2M1wiYCkuXG4gKlxuICogQHJldHVybnMgYW4gSW1hZ2UgdGhhdCBjYW4gYmUgdXNlZCB3aGVyZSBSYXljYXN0IGV4cGVjdHMgdGhlbS5cbiAqXG4gKiBAZXhhbXBsZVxuICogYGBgXG4gKiA8TGlzdC5JdGVtIGljb249e2dldFByb2dyZXNzSWNvbigwLjEpfSB0aXRsZT1cIlByb2plY3RcIiAvPlxuICogYGBgXG4gKi9cbmZ1bmN0aW9uIGdldFByb2dyZXNzSWNvbihwcm9ncmVzcywgY29sb3IgPSBcIiNGRjYzNjNcIiwgb3B0aW9ucykge1xuICAgIGNvbnN0IGJhY2tncm91bmQgPSBvcHRpb25zPy5iYWNrZ3JvdW5kIHx8IChhcGlfMS5lbnZpcm9ubWVudC50aGVtZSA9PT0gXCJsaWdodFwiID8gXCJibGFja1wiIDogXCJ3aGl0ZVwiKTtcbiAgICBjb25zdCBiYWNrZ3JvdW5kT3BhY2l0eSA9IG9wdGlvbnM/LmJhY2tncm91bmRPcGFjaXR5IHx8IDAuMTtcbiAgICBjb25zdCBzdHJva2UgPSAxMDtcbiAgICBjb25zdCBwYWRkaW5nID0gNTtcbiAgICBjb25zdCByYWRpdXMgPSA1MCAtIHBhZGRpbmcgLSBzdHJva2UgLyAyO1xuICAgIGNvbnN0IHN2ZyA9IGA8c3ZnIHdpZHRoPVwiMTAwcHhcIiBoZWlnaHQ9XCIxMDBweFwiPlxuICAgICAgPGNpcmNsZSBjeD1cIjUwXCIgY3k9XCI1MFwiIHI9XCIke3JhZGl1c31cIiBzdHJva2Utd2lkdGg9XCIke3N0cm9rZX1cIiBzdHJva2U9XCIke3Byb2dyZXNzIDwgMSA/IGJhY2tncm91bmQgOiBjb2xvcn1cIiBvcGFjaXR5PVwiJHtwcm9ncmVzcyA8IDEgPyBiYWNrZ3JvdW5kT3BhY2l0eSA6IFwiMVwifVwiIGZpbGw9XCJub25lXCIgLz5cbiAgICAgICR7cHJvZ3Jlc3MgPiAwICYmIHByb2dyZXNzIDwgMVxuICAgICAgICA/IGA8cGF0aCBkPVwiJHtkZXNjcmliZUFyYyg1MCwgNTAsIHJhZGl1cywgMCwgcHJvZ3Jlc3MgKiAzNjApfVwiIHN0cm9rZT1cIiR7Y29sb3J9XCIgc3Ryb2tlLXdpZHRoPVwiJHtzdHJva2V9XCIgZmlsbD1cIm5vbmVcIiAvPmBcbiAgICAgICAgOiBcIlwifVxuICAgIDwvc3ZnPlxuICBgLnJlcGxhY2VBbGwoXCJcXG5cIiwgXCJcIik7XG4gICAgcmV0dXJuIGBkYXRhOmltYWdlL3N2Zyt4bWwsJHtzdmd9YDtcbn1cbmV4cG9ydHMuZ2V0UHJvZ3Jlc3NJY29uID0gZ2V0UHJvZ3Jlc3NJY29uO1xuIiwgIlwidXNlIHN0cmljdFwiO1xudmFyIF9fY3JlYXRlQmluZGluZyA9ICh0aGlzICYmIHRoaXMuX19jcmVhdGVCaW5kaW5nKSB8fCAoT2JqZWN0LmNyZWF0ZSA/IChmdW5jdGlvbihvLCBtLCBrLCBrMikge1xuICAgIGlmIChrMiA9PT0gdW5kZWZpbmVkKSBrMiA9IGs7XG4gICAgdmFyIGRlc2MgPSBPYmplY3QuZ2V0T3duUHJvcGVydHlEZXNjcmlwdG9yKG0sIGspO1xuICAgIGlmICghZGVzYyB8fCAoXCJnZXRcIiBpbiBkZXNjID8gIW0uX19lc01vZHVsZSA6IGRlc2Mud3JpdGFibGUgfHwgZGVzYy5jb25maWd1cmFibGUpKSB7XG4gICAgICBkZXNjID0geyBlbnVtZXJhYmxlOiB0cnVlLCBnZXQ6IGZ1bmN0aW9uKCkgeyByZXR1cm4gbVtrXTsgfSB9O1xuICAgIH1cbiAgICBPYmplY3QuZGVmaW5lUHJvcGVydHkobywgazIsIGRlc2MpO1xufSkgOiAoZnVuY3Rpb24obywgbSwgaywgazIpIHtcbiAgICBpZiAoazIgPT09IHVuZGVmaW5lZCkgazIgPSBrO1xuICAgIG9bazJdID0gbVtrXTtcbn0pKTtcbnZhciBfX2V4cG9ydFN0YXIgPSAodGhpcyAmJiB0aGlzLl9fZXhwb3J0U3RhcikgfHwgZnVuY3Rpb24obSwgZXhwb3J0cykge1xuICAgIGZvciAodmFyIHAgaW4gbSkgaWYgKHAgIT09IFwiZGVmYXVsdFwiICYmICFPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwoZXhwb3J0cywgcCkpIF9fY3JlYXRlQmluZGluZyhleHBvcnRzLCBtLCBwKTtcbn07XG5PYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgXCJfX2VzTW9kdWxlXCIsIHsgdmFsdWU6IHRydWUgfSk7XG5fX2V4cG9ydFN0YXIocmVxdWlyZShcIi4vYXZhdGFyXCIpLCBleHBvcnRzKTtcbl9fZXhwb3J0U3RhcihyZXF1aXJlKFwiLi9mYXZpY29uXCIpLCBleHBvcnRzKTtcbl9fZXhwb3J0U3RhcihyZXF1aXJlKFwiLi9wcm9ncmVzc1wiKSwgZXhwb3J0cyk7XG4iLCAiXCJ1c2Ugc3RyaWN0XCI7XG52YXIgX19jcmVhdGVCaW5kaW5nID0gKHRoaXMgJiYgdGhpcy5fX2NyZWF0ZUJpbmRpbmcpIHx8IChPYmplY3QuY3JlYXRlID8gKGZ1bmN0aW9uKG8sIG0sIGssIGsyKSB7XG4gICAgaWYgKGsyID09PSB1bmRlZmluZWQpIGsyID0gaztcbiAgICB2YXIgZGVzYyA9IE9iamVjdC5nZXRPd25Qcm9wZXJ0eURlc2NyaXB0b3IobSwgayk7XG4gICAgaWYgKCFkZXNjIHx8IChcImdldFwiIGluIGRlc2MgPyAhbS5fX2VzTW9kdWxlIDogZGVzYy53cml0YWJsZSB8fCBkZXNjLmNvbmZpZ3VyYWJsZSkpIHtcbiAgICAgIGRlc2MgPSB7IGVudW1lcmFibGU6IHRydWUsIGdldDogZnVuY3Rpb24oKSB7IHJldHVybiBtW2tdOyB9IH07XG4gICAgfVxuICAgIE9iamVjdC5kZWZpbmVQcm9wZXJ0eShvLCBrMiwgZGVzYyk7XG59KSA6IChmdW5jdGlvbihvLCBtLCBrLCBrMikge1xuICAgIGlmIChrMiA9PT0gdW5kZWZpbmVkKSBrMiA9IGs7XG4gICAgb1trMl0gPSBtW2tdO1xufSkpO1xudmFyIF9fZXhwb3J0U3RhciA9ICh0aGlzICYmIHRoaXMuX19leHBvcnRTdGFyKSB8fCBmdW5jdGlvbihtLCBleHBvcnRzKSB7XG4gICAgZm9yICh2YXIgcCBpbiBtKSBpZiAocCAhPT0gXCJkZWZhdWx0XCIgJiYgIU9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChleHBvcnRzLCBwKSkgX19jcmVhdGVCaW5kaW5nKGV4cG9ydHMsIG0sIHApO1xufTtcbk9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBcIl9fZXNNb2R1bGVcIiwgeyB2YWx1ZTogdHJ1ZSB9KTtcbl9fZXhwb3J0U3RhcihyZXF1aXJlKFwiLi91c2VQcm9taXNlXCIpLCBleHBvcnRzKTtcbl9fZXhwb3J0U3RhcihyZXF1aXJlKFwiLi91c2VDYWNoZWRTdGF0ZVwiKSwgZXhwb3J0cyk7XG5fX2V4cG9ydFN0YXIocmVxdWlyZShcIi4vdXNlQ2FjaGVkUHJvbWlzZVwiKSwgZXhwb3J0cyk7XG5fX2V4cG9ydFN0YXIocmVxdWlyZShcIi4vdXNlRmV0Y2hcIiksIGV4cG9ydHMpO1xuX19leHBvcnRTdGFyKHJlcXVpcmUoXCIuL3VzZUV4ZWNcIiksIGV4cG9ydHMpO1xuX19leHBvcnRTdGFyKHJlcXVpcmUoXCIuL3VzZVNRTFwiKSwgZXhwb3J0cyk7XG5fX2V4cG9ydFN0YXIocmVxdWlyZShcIi4vdXNlRm9ybVwiKSwgZXhwb3J0cyk7XG4vL2V4cG9ydCAqIGFzIHN1c3BlbnNlIGZyb20gXCIuL3N1c3BlbnNlXCI7XG5fX2V4cG9ydFN0YXIocmVxdWlyZShcIi4vaWNvblwiKSwgZXhwb3J0cyk7XG4iLCAiaW1wb3J0IHsgQWN0aW9uLCBBY3Rpb25QYW5lbCwgZ2V0UHJlZmVyZW5jZVZhbHVlcywgSWNvbiwgTGlzdCwgTG9jYWxTdG9yYWdlIH0gZnJvbSBcIkByYXljYXN0L2FwaVwiO1xuaW1wb3J0IHsgdXNlRWZmZWN0LCB1c2VTdGF0ZSB9IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0IHsgbGFzdFBhc3MgfSBmcm9tIFwiLi9jbGlcIjtcbmltcG9ydCB7IEVtcHR5TGlzdFZpZXcsIEVycm9yRGV0YWlscywgTGlzdEl0ZW0gfSBmcm9tIFwiLi9jb21wb25lbnRzXCI7XG5cbnR5cGUgU3luY1JhdGUgPSBcIjBcIiB8IFwiODY0MDAwMDBcIiB8IFwiNjA0ODAwMDAwXCI7XG5pbnRlcmZhY2UgUHJlZmVyZW5jZXMge1xuICBlbWFpbDogc3RyaW5nO1xuICBwYXNzd29yZDogc3RyaW5nO1xuICBzeW5jUmF0ZTogU3luY1JhdGU7XG59XG5cbmNvbnN0IGNhbGN1bGF0ZVN5bmNTdGF0ZSA9IGFzeW5jIChzeW5jUmF0ZTogU3luY1JhdGUpOiBQcm9taXNlPFwibm93XCIgfCBcIm5vXCI+ID0+IHtcbiAgY29uc3QgbG9jYWxTdG9yYWdlS2V5ID0gXCJsYXN0cGFzcy1zeW5jLXRpbWVzdGFtcFwiO1xuICBjb25zdCBjdXJyZW50VGltZXN0YW1wID0gRGF0ZS5ub3coKTtcbiAgY29uc3QgbGFzdFN5bmNUaW1lc3RhbXAgPSAoYXdhaXQgTG9jYWxTdG9yYWdlLmdldEl0ZW08bnVtYmVyPihsb2NhbFN0b3JhZ2VLZXkpKSB8fCBjdXJyZW50VGltZXN0YW1wO1xuICBhd2FpdCBMb2NhbFN0b3JhZ2Uuc2V0SXRlbShsb2NhbFN0b3JhZ2VLZXksIGN1cnJlbnRUaW1lc3RhbXApO1xuICBjb25zdCB0aW1lc3RhbXBEaWZmID0gcGFyc2VJbnQoc3luY1JhdGUsIDEwKTtcbiAgY29uc3QgaXNTeW5jTm93ID0gY3VycmVudFRpbWVzdGFtcCAtIGxhc3RTeW5jVGltZXN0YW1wID4gdGltZXN0YW1wRGlmZjtcbiAgcmV0dXJuIGlzU3luY05vdyA/IFwibm93XCIgOiBcIm5vXCI7XG59O1xuXG5leHBvcnQgZGVmYXVsdCBmdW5jdGlvbiBDb21tYW5kKCkge1xuICBjb25zdCB7IGVtYWlsLCBwYXNzd29yZCwgc3luY1JhdGUgfSA9IGdldFByZWZlcmVuY2VWYWx1ZXM8UHJlZmVyZW5jZXM+KCk7XG5cbiAgY29uc3QgYXBpID0gbGFzdFBhc3MoZW1haWwsIHBhc3N3b3JkKTtcbiAgY29uc3QgW2lzTG9hZGluZywgc2V0SXNMb2FkaW5nXSA9IHVzZVN0YXRlKHRydWUpO1xuICBjb25zdCBbYWNjb3VudHMsIHNldEFjY291bnRzXSA9IHVzZVN0YXRlPFxuICAgIHsgaWQ6IHN0cmluZzsgbmFtZTogc3RyaW5nOyB1c2VybmFtZTogc3RyaW5nOyBwYXNzd29yZDogc3RyaW5nOyB1cmw6IHN0cmluZyB9W11cbiAgPihbXSk7XG4gIGNvbnN0IFtlcnJvciwgc2V0RXJyb3JdID0gdXNlU3RhdGU8RXJyb3IgfCBudWxsPihudWxsKTtcblxuICB1c2VFZmZlY3QoKCkgPT4ge1xuICAgIChhc3luYyAoKSA9PiB7XG4gICAgICB0cnkge1xuICAgICAgICBjb25zdCBpc0xvZ2dlZCA9IGF3YWl0IGFwaS5pc0xvZ2dlZCgpO1xuICAgICAgICBpZiAoIWlzTG9nZ2VkKSB7XG4gICAgICAgICAgYXdhaXQgYXBpLmxvZ2luKCk7XG4gICAgICAgIH1cblxuICAgICAgICBjb25zdCBhY2NvdW50cyA9IGF3YWl0IGNhbGN1bGF0ZVN5bmNTdGF0ZShzeW5jUmF0ZSkudGhlbigoc3luYykgPT4gYXBpLmxpc3QoeyBzeW5jIH0pKTtcbiAgICAgICAgc2V0QWNjb3VudHMoYWNjb3VudHMpO1xuICAgICAgICBzZXRJc0xvYWRpbmcoZmFsc2UpO1xuICAgICAgfSBjYXRjaCAoZXJyb3IpIHtcbiAgICAgICAgaWYgKGVycm9yIGluc3RhbmNlb2YgRXJyb3IpIHtcbiAgICAgICAgICBzZXRFcnJvcihlcnJvcik7XG4gICAgICAgIH1cbiAgICAgIH1cbiAgICB9KSgpO1xuICB9LCBbXSk7XG5cbiAgaWYgKGVycm9yKSB7XG4gICAgcmV0dXJuIDxFcnJvckRldGFpbHMgZXJyb3I9e2Vycm9yfSAvPjtcbiAgfVxuXG4gIGNvbnN0IGFjdGlvbnMgPSAoXG4gICAgPEFjdGlvblBhbmVsPlxuICAgICAgPEFjdGlvblBhbmVsLlNlY3Rpb24+XG4gICAgICAgIDxBY3Rpb25cbiAgICAgICAgICBpY29uPXtJY29uLkFycm93Q2xvY2t3aXNlfVxuICAgICAgICAgIHRpdGxlPVwiTWFudWFsIFN5bmNcIlxuICAgICAgICAgIHNob3J0Y3V0PXt7IG1vZGlmaWVyczogW1wiY21kXCJdLCBrZXk6IFwic1wiIH19XG4gICAgICAgICAgb25BY3Rpb249eygpID0+IGFwaS5leHBvcnQoeyBzeW5jOiBcIm5vd1wiIH0pLnRoZW4oc2V0QWNjb3VudHMsIHNldEVycm9yKX1cbiAgICAgICAgLz5cbiAgICAgIDwvQWN0aW9uUGFuZWwuU2VjdGlvbj5cbiAgICA8L0FjdGlvblBhbmVsPlxuICApO1xuXG4gIHJldHVybiAoXG4gICAgPExpc3QgaXNMb2FkaW5nPXtpc0xvYWRpbmd9IGlzU2hvd2luZ0RldGFpbCBhY3Rpb25zPXthY3Rpb25zfT5cbiAgICAgIHshYWNjb3VudHMubGVuZ3RoID8gKFxuICAgICAgICA8RW1wdHlMaXN0VmlldyAvPlxuICAgICAgKSA6IChcbiAgICAgICAgYWNjb3VudHMubWFwKChhY2NvdW50KSA9PiAoXG4gICAgICAgICAgPExpc3RJdGVtXG4gICAgICAgICAgICB7Li4uYWNjb3VudH1cbiAgICAgICAgICAgIGdldERldGFpbHM9eygpID0+IGNhbGN1bGF0ZVN5bmNTdGF0ZShzeW5jUmF0ZSkudGhlbigoc3luYykgPT4gYXBpLnNob3coYWNjb3VudC5pZCwgeyBzeW5jIH0pKX1cbiAgICAgICAgICAvPlxuICAgICAgICApKVxuICAgICAgKX1cbiAgICA8L0xpc3Q+XG4gICk7XG59XG4iLCAiaW1wb3J0IHsgZXhlYywgRXhlY0V4Y2VwdGlvbiB9IGZyb20gXCJjaGlsZF9wcm9jZXNzXCI7XG5cbmV4cG9ydCB0eXBlIEFjY291bnQgPSB7XG4gIG5hbWU6IHN0cmluZztcbiAgaWQ6IHN0cmluZztcbiAgdXNlcm5hbWU6IHN0cmluZztcbiAgcGFzc3dvcmQ6IHN0cmluZztcbiAgdXJsOiBzdHJpbmc7XG4gIGxhc3RNb2RpZmllZDogRGF0ZTtcbiAgbGFzdFRvdWNoOiBEYXRlO1xuICBmdWxsbmFtZTogc3RyaW5nO1xuICBncm91cDogc3RyaW5nO1xuICBub3RlPzogc3RyaW5nO1xufTtcblxuY29uc3Qgc2VyaWFsaXplRnJvbUpzb24gPSAoanNvbkFycmF5OiBzdHJpbmcpOiBBY2NvdW50W10gPT4ge1xuICBjb25zdCBhcnJheTogYW55W10gPSBKU09OLnBhcnNlKGpzb25BcnJheSk7XG4gIGNvbnN0IHJlcyA9IGFycmF5Lm1hcChcbiAgICAob2JqKSA9PlxuICAgICAgKHtcbiAgICAgICAgLi4ub2JqLFxuICAgICAgICBsYXN0TW9kaWZpZWQ6IG5ldyBEYXRlKHBhcnNlSW50KG9iai5sYXN0X21vZGlmaWVkX2dtdCwgMTApICogMTAwMCksXG4gICAgICAgIGxhc3RUb3VjaDogbmV3IERhdGUocGFyc2VJbnQob2JqLmxhc3RfdG91Y2gsIDEwKSAqIDEwMDApLFxuICAgICAgfSBhcyBBY2NvdW50KVxuICApO1xuICByZXR1cm4gcmVzO1xufTtcblxuY29uc3QgZXhlY3V0ZSA9IGFzeW5jIChjb21tYW5kOiBzdHJpbmcsIG9wdHM6IHsgbG9nOiB7IHN0ZG91dDogYm9vbGVhbiB9IH0gPSB7IGxvZzogeyBzdGRvdXQ6IGZhbHNlIH0gfSkgPT4ge1xuICBjb25zdCBQQVRIID0gXCIvdXNyL2dudS9iaW46L3Vzci9sb2NhbC9iaW46L2JpbjovdXNyL2JpbjouOi9vcHQvaG9tZWJyZXcvYmluXCI7XG4gIGNvbnN0IHdyYXBwZWRDb21tYW5kID0gYHpzaCAtbCAtYyAnZXhwb3J0IFBBVEg9XCIkUEFUSDoke1BBVEh9XCIgJiYgJHtjb21tYW5kfSdgO1xuICBjb25zb2xlLmxvZyhgRXhlY3V0aW5nOiAke3dyYXBwZWRDb21tYW5kfWApO1xuICBjb25zdCBzdGFydFRpbWVzdGFtcCA9IERhdGUubm93KCk7XG4gIHJldHVybiBuZXcgUHJvbWlzZTxzdHJpbmc+KChyZXMsIHJlaikgPT5cbiAgICBleGVjKHdyYXBwZWRDb21tYW5kLCAoZXJyb3I6IEV4ZWNFeGNlcHRpb24gfCBudWxsLCBzdGRvdXQ6IHN0cmluZywgc3RkZXJyOiBzdHJpbmcpID0+IHtcbiAgICAgIGNvbnN0IGVuZFRpbWVzdGFtcCA9IERhdGUubm93KCk7XG4gICAgICBjb25zdCB0b29rU2Vjb25kcyA9IChlbmRUaW1lc3RhbXAgLSBzdGFydFRpbWVzdGFtcCkgLyAxMDAwO1xuICAgICAgaWYgKGVycm9yKSB7XG4gICAgICAgIGNvbnNvbGUuZXJyb3IoYFske3Rvb2tTZWNvbmRzfXNdIEZhaWxlZDpcXG4ke3N0ZGVycn1gKTtcbiAgICAgICAgcmVqKGVycm9yKTtcbiAgICAgIH1cbiAgICAgIGNvbnNvbGUubG9nKGBbJHt0b29rU2Vjb25kc31zXSBTdWNjZXNzJHtvcHRzLmxvZy5zdGRvdXQgPyBgOlxcbiR7c3Rkb3V0fWAgOiBcIlwifWApO1xuICAgICAgcmVzKHN0ZG91dC50cmltKCkpO1xuICAgIH0pXG4gICk7XG59O1xuXG5leHBvcnQgY29uc3QgbGFzdFBhc3MgPSAoZW1haWw6IHN0cmluZywgcGFzc3dvcmQ6IHN0cmluZykgPT4gKHtcbiAgaXNMb2dnZWQ6ICgpID0+XG4gICAgZXhlY3V0ZShcImxwYXNzIHN0YXR1c1wiKVxuICAgICAgLnRoZW4oKHN0ZG91dCkgPT4gc3Rkb3V0LmluY2x1ZGVzKGVtYWlsKSlcbiAgICAgIC5jYXRjaCgoKSA9PiBmYWxzZSksXG5cbiAgbG9naW46ICgpID0+IGV4ZWN1dGUoYGVjaG8gXCIke3Bhc3N3b3JkfVwiIHwgTFBBU1NfRElTQUJMRV9QSU5FTlRSWT0xIGxwYXNzIGxvZ2luICR7ZW1haWx9YCksXG5cbiAgLy8gcmV0dXJucyBleGl0IGNvZGUgPiAwIGlmIGZhaWxlZCwgc28ganVzdCBuZWVkIHRvIGNvbnZlcnQgcmV0dXJuIHR5cGUgdG8gUHJvbWlzZTx2b2lkPlxuICBzeW5jOiAoKSA9PlxuICAgIGV4ZWN1dGUoXCJscGFzcyBzeW5jXCIpLnRoZW4oKCkgPT4ge1xuICAgICAgLyogbm9vcCAqL1xuICAgIH0pLFxuXG4gIHNob3c6IChpZDogc3RyaW5nLCBvcHRzOiB7IHN5bmM6IFwiYXV0b1wiIHwgXCJub3dcIiB8IFwibm9cIiB9ID0geyBzeW5jOiBcImF1dG9cIiB9KTogUHJvbWlzZTxBY2NvdW50PiA9PlxuICAgIGV4ZWN1dGUoYGVjaG8gXCIke3Bhc3N3b3JkfVwiIHwgTFBBU1NfRElTQUJMRV9QSU5FTlRSWT0xIGxwYXNzIHNob3cgLS1zeW5jPSR7b3B0cy5zeW5jfSAtLWpzb24gJHtpZH1gKS50aGVuKFxuICAgICAgKHN0ZG91dCkgPT4gc2VyaWFsaXplRnJvbUpzb24oc3Rkb3V0KVswXVxuICAgICksXG5cbiAgbGlzdDogKG9wdHM6IHsgc3luYzogXCJhdXRvXCIgfCBcIm5vd1wiIHwgXCJub1wiIH0gPSB7IHN5bmM6IFwiYXV0b1wiIH0pID0+XG4gICAgZXhlY3V0ZShcbiAgICAgIGBlY2hvIFwiJHtwYXNzd29yZH1cIiB8IExQQVNTX0RJU0FCTEVfUElORU5UUlk9MSBscGFzcyBscyAtLXN5bmM9JHtvcHRzLnN5bmN9IC0tZm9ybWF0PVwiJWFpPD0+JWFuPD0+JWF1PD0+JWFwPD0+JWFsXCJgXG4gICAgKS50aGVuKChzdGRvdXQpID0+IHtcbiAgICAgIGNvbnN0IGl0ZW1zOiB7IGlkOiBzdHJpbmc7IG5hbWU6IHN0cmluZzsgdXNlcm5hbWU6IHN0cmluZzsgcGFzc3dvcmQ6IHN0cmluZzsgdXJsOiBzdHJpbmcgfVtdID0gc3Rkb3V0XG4gICAgICAgIC5zcGxpdChcIlxcblwiKVxuICAgICAgICAubWFwKChsaW5lKSA9PiB7XG4gICAgICAgICAgY29uc3QgW2lkLCBuYW1lLCB1c2VybmFtZSwgcGFzc3dvcmQsIHVybF0gPSBsaW5lLnNwbGl0KFwiPD0+XCIpO1xuICAgICAgICAgIHJldHVybiB7IGlkLCBuYW1lLCB1c2VybmFtZSwgcGFzc3dvcmQsIHVybCB9O1xuICAgICAgICB9KVxuICAgICAgICAuZmlsdGVyKCh7IG5hbWUgfSkgPT4gbmFtZSk7XG4gICAgICByZXR1cm4gaXRlbXM7XG4gICAgfSksXG5cbiAgZXhwb3J0OiAob3B0czogeyBzeW5jOiBcImF1dG9cIiB8IFwibm93XCIgfCBcIm5vXCIgfSA9IHsgc3luYzogXCJhdXRvXCIgfSkgPT5cbiAgICBleGVjdXRlKFxuICAgICAgYGVjaG8gXCIke3Bhc3N3b3JkfVwiIHwgTFBBU1NfRElTQUJMRV9QSU5FTlRSWT0xIGxwYXNzIGV4cG9ydCAtLXN5bmM9JHtvcHRzLnN5bmN9IC0tZmllbGRzPWlkLG5hbWUsdXNlcm5hbWUscGFzc3dvcmQsdXJsYFxuICAgICkudGhlbigoc3Rkb3V0KSA9PiB7XG4gICAgICBjb25zdCBpdGVtczogeyBpZDogc3RyaW5nOyBuYW1lOiBzdHJpbmc7IHVzZXJuYW1lOiBzdHJpbmc7IHBhc3N3b3JkOiBzdHJpbmc7IHVybDogc3RyaW5nIH1bXSA9IHN0ZG91dFxuICAgICAgICAuc3BsaXQoXCJcXG5cIilcbiAgICAgICAgLmZpbHRlcigobGluZSkgPT4gbGluZS50cmltKCkgIT09IFwiXCIpXG4gICAgICAgIC5zbGljZSgxKVxuICAgICAgICAubWFwKChsaW5lKSA9PiB7XG4gICAgICAgICAgY29uc3QgW2lkLCBuYW1lLCB1c2VybmFtZSwgcGFzc3dvcmQsIHVybF0gPSBsaW5lLnNwbGl0KFwiLFwiKTtcbiAgICAgICAgICByZXR1cm4geyBpZCwgbmFtZSwgdXNlcm5hbWUsIHBhc3N3b3JkLCB1cmwgfTtcbiAgICAgICAgfSlcbiAgICAgICAgLmZpbHRlcigoeyBuYW1lIH0pID0+IG5hbWUpO1xuICAgICAgcmV0dXJuIGl0ZW1zO1xuICAgIH0pLFxufSk7XG4iLCAiaW1wb3J0IHsgRGV0YWlsIH0gZnJvbSBcIkByYXljYXN0L2FwaVwiO1xuXG5leHBvcnQgY29uc3QgVW5rbm93bkVycm9yID0gKHsgZXJyb3IgfTogeyBlcnJvcjogRXJyb3IgfSkgPT4gKFxuICA8RGV0YWlsXG4gICAgbWFya2Rvd249e1tcbiAgICAgIFwiIyBPb3BzISBTb21ldGhpbmcgd2VudCB3cm9uZyFcIixcbiAgICAgIFwiUGxlYXNlIGNoZWNrIGVycm9yIGZvciBtb3JlIGluZm9ybWF0aW9uLlwiLFxuICAgICAgXCJgYGBlcnJvclwiLFxuICAgICAgZXJyb3Iuc3RhY2ssXG4gICAgICBcImBgYFwiLFxuICAgIF0uam9pbihcIlxcblwiKX1cbiAgPjwvRGV0YWlsPlxuKTtcbiIsICJpbXBvcnQgeyBBY3Rpb25QYW5lbCwgQWN0aW9uLCBEZXRhaWwgfSBmcm9tIFwiQHJheWNhc3QvYXBpXCI7XG5cbmV4cG9ydCBjb25zdCBDb21tYW5kTm90Rm91bmRFcnJvciA9ICgpID0+IChcbiAgPERldGFpbFxuICAgIG1hcmtkb3duPXtbXG4gICAgICBcIiMgTGFzdFBhc3MgQ0xJIGlzIG1pc3NpbmchXCIsXG4gICAgICBcIlBsZWFzZSBtYWtlIHN1cmUgdGhhdFwiLFxuICAgICAgXCJcIixcbiAgICAgIFwiMS4gTGFzdFBhc3MgY2xpIGlzIFtjb3JyZWN0bHkgaW5zdGFsbGVkXShodHRwczovL2dpdGh1Yi5jb20vbGFzdHBhc3MvbGFzdHBhc3MtY2xpI2luc3RhbGxpbmctb24tb3MteClcIixcbiAgICAgIFwiMi4gQ29tbWFuZCBgenNoIC1sIC1jICdscGFzcyBzdGF0dXMnYCBwYXNzZXNcIixcbiAgICBdLmpvaW4oXCJcXG5cIil9XG4gICAgYWN0aW9ucz17XG4gICAgICA8QWN0aW9uUGFuZWw+XG4gICAgICAgIDxBY3Rpb24uQ29weVRvQ2xpcGJvYXJkIHRpdGxlPVwiQ29weSBIb21lYnJldyBJbnN0YWxsYXRpb24gQ29tbWFuZFwiIGNvbnRlbnQ9XCJicmV3IGluc3RhbGwgbGFzdHBhc3MtY2xpXCIgLz5cbiAgICAgICAgPEFjdGlvbi5PcGVuSW5Ccm93c2VyIHVybD1cImh0dHBzOi8vZ2l0aHViLmNvbS9sYXN0cGFzcy9sYXN0cGFzcy1jbGkjaW5zdGFsbGluZy1vbi1vcy14XCIgLz5cbiAgICAgIDwvQWN0aW9uUGFuZWw+XG4gICAgfVxuICAvPlxuKTtcbiIsICJpbXBvcnQgeyBEZXRhaWwsIExpc3QgfSBmcm9tIFwiQHJheWNhc3QvYXBpXCI7XG5pbXBvcnQgeyB1c2VFZmZlY3QsIHVzZVN0YXRlIH0gZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgeyBVbmtub3duRXJyb3IgfSBmcm9tIFwiLi91bmtub3duRXJyb3JcIjtcbmltcG9ydCB7IEFjY291bnQgfSBmcm9tIFwiLi4vY2xpXCI7XG5pbXBvcnQgeyBpc1ZhbGlkVXJsIH0gZnJvbSBcIi4uL3V0aWxzXCI7XG5cbmV4cG9ydCBjb25zdCBBY2NvdW50RGV0YWlsID0gKGFyZ3M6IHsgZ2V0RGF0YTogKCkgPT4gUHJvbWlzZTxBY2NvdW50PiB9KSA9PiB7XG4gIGNvbnN0IFtkYXRhLCBzZXREYXRhXSA9IHVzZVN0YXRlPEFjY291bnQ+KCk7XG4gIGNvbnN0IFtlcnJvciwgc2V0RXJyb3JdID0gdXNlU3RhdGU8RXJyb3I+KCk7XG5cbiAgdXNlRWZmZWN0KCgpID0+IHtcbiAgICAoYXN5bmMgKCkgPT4gYXJncy5nZXREYXRhKCkudGhlbihzZXREYXRhLCBzZXRFcnJvcikpKCk7XG4gIH0sIFtdKTtcblxuICByZXR1cm4gZXJyb3IgPyAoXG4gICAgPFVua25vd25FcnJvciBlcnJvcj17ZXJyb3J9IC8+XG4gICkgOiAoXG4gICAgPExpc3QuSXRlbS5EZXRhaWxcbiAgICAgIGlzTG9hZGluZz17IWRhdGF9XG4gICAgICBtYXJrZG93bj17ZGF0YT8ubm90ZSAmJiBkYXRhLm5vdGUuc3BsaXQoXCJcXG5cIikuam9pbihcIlxcblwiKX1cbiAgICAgIG1ldGFkYXRhPXtcbiAgICAgICAgZGF0YSAmJiAoXG4gICAgICAgICAgPExpc3QuSXRlbS5EZXRhaWwuTWV0YWRhdGE+XG4gICAgICAgICAgICA8RGV0YWlsLk1ldGFkYXRhLkxhYmVsIHRpdGxlPVwiSURcIiB0ZXh0PXtkYXRhLmlkfSAvPlxuICAgICAgICAgICAge2lzVmFsaWRVcmwoZGF0YS51cmwpICYmIDxEZXRhaWwuTWV0YWRhdGEuTGFiZWwgdGl0bGU9XCJVcmxcIiB0ZXh0PXtkYXRhLnVybH0gLz59XG4gICAgICAgICAgICB7ZGF0YS51c2VybmFtZSAmJiA8RGV0YWlsLk1ldGFkYXRhLkxhYmVsIHRpdGxlPVwiVXNlcm5hbWVcIiB0ZXh0PXtkYXRhLnVzZXJuYW1lfSAvPn1cbiAgICAgICAgICAgIHtkYXRhLnBhc3N3b3JkICYmIDxEZXRhaWwuTWV0YWRhdGEuTGFiZWwgdGl0bGU9XCJQYXNzd29yZFwiIHRleHQ9e2RhdGEucGFzc3dvcmR9IC8+fVxuICAgICAgICAgICAge2RhdGEuZ3JvdXAgJiYgPERldGFpbC5NZXRhZGF0YS5MYWJlbCB0aXRsZT1cIkdyb3VwXCIgdGV4dD17ZGF0YS5ncm91cH0gLz59XG4gICAgICAgICAgICB7ZGF0YS5mdWxsbmFtZSAmJiA8RGV0YWlsLk1ldGFkYXRhLkxhYmVsIHRpdGxlPVwiRnVsbCBOYW1lXCIgdGV4dD17ZGF0YS5mdWxsbmFtZX0gLz59XG4gICAgICAgICAgICA8RGV0YWlsLk1ldGFkYXRhLkxhYmVsXG4gICAgICAgICAgICAgIHRpdGxlPVwiTGFzdCBtb2RpZmllZFwiXG4gICAgICAgICAgICAgIHRleHQ9e2Ake2RhdGEubGFzdE1vZGlmaWVkLnRvTG9jYWxlVGltZVN0cmluZygpfSAtICR7ZGF0YS5sYXN0TW9kaWZpZWQudG9Mb2NhbGVEYXRlU3RyaW5nKCl9YH1cbiAgICAgICAgICAgIC8+XG4gICAgICAgICAgICA8RGV0YWlsLk1ldGFkYXRhLkxhYmVsXG4gICAgICAgICAgICAgIHRpdGxlPVwiTGFzdCB0b3VjaGVkXCJcbiAgICAgICAgICAgICAgdGV4dD17YCR7ZGF0YS5sYXN0VG91Y2gudG9Mb2NhbGVUaW1lU3RyaW5nKCl9IC0gJHtkYXRhLmxhc3RUb3VjaC50b0xvY2FsZURhdGVTdHJpbmcoKX1gfVxuICAgICAgICAgICAgLz5cbiAgICAgICAgICA8L0xpc3QuSXRlbS5EZXRhaWwuTWV0YWRhdGE+XG4gICAgICAgIClcbiAgICAgIH1cbiAgICAvPlxuICApO1xufTtcbiIsICJpbXBvcnQgeyBJY29uLCBJbWFnZSB9IGZyb20gXCJAcmF5Y2FzdC9hcGlcIjtcbmltcG9ydCB7IGdldEZhdmljb24gfSBmcm9tIFwiQHJheWNhc3QvdXRpbHNcIjtcblxuZXhwb3J0IGNvbnN0IGlzVmFsaWRVcmwgPSAodXJsTGlrZTogc3RyaW5nIHwgdW5kZWZpbmVkKSA9PiB1cmxMaWtlICYmIHVybExpa2UgIT09IFwiaHR0cDovL3NuXCI7XG5leHBvcnQgY29uc3QgZ2V0RG9tYWluRmF2aWNvbiA9ICh1cmw6IHN0cmluZyB8IHVuZGVmaW5lZCk6IEltYWdlLkltYWdlTGlrZSA9PiB7XG4gIGlmICghdXJsKSB7XG4gICAgcmV0dXJuIEljb24uS2V5O1xuICB9XG4gIHRyeSB7XG4gICAgbmV3IFVSTCh1cmwgfHwgXCJcIik7XG4gICAgcmV0dXJuIGdldEZhdmljb24odXJsKTtcbiAgfSBjYXRjaCB7XG4gICAgcmV0dXJuIEljb24uS2V5O1xuICB9XG59O1xuIiwgImltcG9ydCB7IExpc3QgfSBmcm9tIFwiQHJheWNhc3QvYXBpXCI7XG5cbmV4cG9ydCBjb25zdCBFbXB0eUxpc3RWaWV3ID0gKCkgPT4gPExpc3QuRW1wdHlWaWV3IHRpdGxlPVwiU29ycnksIHlvdSBoYXZlIG5vIGFjY291bnRzXCIgLz47XG4iLCAiaW1wb3J0IHsgQWN0aW9uLCBBY3Rpb25QYW5lbCwgSWNvbiwgTGlzdCB9IGZyb20gXCJAcmF5Y2FzdC9hcGlcIjtcbmltcG9ydCB7IEFjY291bnQgfSBmcm9tIFwiLi4vY2xpXCI7XG5pbXBvcnQgeyBnZXREb21haW5GYXZpY29uIH0gZnJvbSBcIi4uL3V0aWxzXCI7XG5pbXBvcnQgeyBBY2NvdW50RGV0YWlsIH0gZnJvbSBcIi4vYWNjb3VudERldGFpbFwiO1xuXG5leHBvcnQgY29uc3QgTGlzdEl0ZW0gPSAocHJvcHM6IHtcbiAgaWQ6IHN0cmluZztcbiAgbmFtZTogc3RyaW5nO1xuICB1c2VybmFtZT86IHN0cmluZztcbiAgcGFzc3dvcmQ/OiBzdHJpbmc7XG4gIHVybD86IHN0cmluZztcbiAgZ2V0RGV0YWlsczogKCkgPT4gUHJvbWlzZTxBY2NvdW50Pjtcbn0pID0+IChcbiAgPExpc3QuSXRlbVxuICAgIGlkPXtwcm9wcy5pZH1cbiAgICBrZXk9e3Byb3BzLmlkfVxuICAgIGljb249e2dldERvbWFpbkZhdmljb24ocHJvcHMudXJsKX1cbiAgICB0aXRsZT17cHJvcHMubmFtZX1cbiAgICBkZXRhaWw9ezxBY2NvdW50RGV0YWlsIGdldERhdGE9e3Byb3BzLmdldERldGFpbHN9IC8+fVxuICAgIGtleXdvcmRzPXtbcHJvcHMuaWRdfVxuICAgIGFjdGlvbnM9e1xuICAgICAgPEFjdGlvblBhbmVsPlxuICAgICAgICA8QWN0aW9uUGFuZWwuU2VjdGlvbj5cbiAgICAgICAgICA8QWN0aW9uLlBhc3RlXG4gICAgICAgICAgICBpY29uPXtJY29uLkNsaXBib2FyZH1cbiAgICAgICAgICAgIHRpdGxlPVwiUGFzdGUgUGFzc3dvcmRcIlxuICAgICAgICAgICAgc2hvcnRjdXQ9e3sgbW9kaWZpZXJzOiBbXSwga2V5OiBcImVudGVyXCIgfX1cbiAgICAgICAgICAgIGNvbnRlbnQ9e3Byb3BzLnBhc3N3b3JkIHx8IFwiXCJ9XG4gICAgICAgICAgLz5cbiAgICAgICAgICA8QWN0aW9uLkNvcHlUb0NsaXBib2FyZFxuICAgICAgICAgICAgaWNvbj17SWNvbi5DbGlwYm9hcmR9XG4gICAgICAgICAgICB0aXRsZT1cIlBhc3RlIFVzZXJuYW1lXCJcbiAgICAgICAgICAgIHNob3J0Y3V0PXt7IG1vZGlmaWVyczogW1wic2hpZnRcIl0sIGtleTogXCJlbnRlclwiIH19XG4gICAgICAgICAgICBjb250ZW50PXtwcm9wcy51c2VybmFtZSB8fCBcIlwifVxuICAgICAgICAgIC8+XG4gICAgICAgICAgPEFjdGlvbi5Db3B5VG9DbGlwYm9hcmRcbiAgICAgICAgICAgIGljb249e0ljb24uQ2xpcGJvYXJkfVxuICAgICAgICAgICAgdGl0bGU9XCJDb3B5IFBhc3N3b3JkXCJcbiAgICAgICAgICAgIHNob3J0Y3V0PXt7IG1vZGlmaWVyczogW1wiY21kXCJdLCBrZXk6IFwicFwiIH19XG4gICAgICAgICAgICBjb250ZW50PXtwcm9wcy5wYXNzd29yZCB8fCBcIlwifVxuICAgICAgICAgIC8+XG4gICAgICAgICAgPEFjdGlvbi5Db3B5VG9DbGlwYm9hcmRcbiAgICAgICAgICAgIGljb249e0ljb24uQ2xpcGJvYXJkfVxuICAgICAgICAgICAgdGl0bGU9XCJDb3B5IFVzZXJuYW1lXCJcbiAgICAgICAgICAgIHNob3J0Y3V0PXt7IG1vZGlmaWVyczogW1wiY21kXCJdLCBrZXk6IFwidVwiIH19XG4gICAgICAgICAgICBjb250ZW50PXtwcm9wcy51c2VybmFtZSB8fCBcIlwifVxuICAgICAgICAgIC8+XG4gICAgICAgICAgPEFjdGlvbi5Db3B5VG9DbGlwYm9hcmRcbiAgICAgICAgICAgIGljb249e0ljb24uQ2xpcGJvYXJkfVxuICAgICAgICAgICAgdGl0bGU9XCJDb3B5IFVybFwiXG4gICAgICAgICAgICBzaG9ydGN1dD17eyBtb2RpZmllcnM6IFtcImNtZFwiXSwga2V5OiBcImxcIiB9fVxuICAgICAgICAgICAgY29udGVudD17cHJvcHMudXJsIHx8IFwiXCJ9XG4gICAgICAgICAgLz5cbiAgICAgICAgPC9BY3Rpb25QYW5lbC5TZWN0aW9uPlxuICAgICAgPC9BY3Rpb25QYW5lbD5cbiAgICB9XG4gIC8+XG4pO1xuIiwgImltcG9ydCB7IFRvYXN0LCBzaG93VG9hc3QgfSBmcm9tIFwiQHJheWNhc3QvYXBpXCI7XG5pbXBvcnQgeyBDb21tYW5kTm90Rm91bmRFcnJvciB9IGZyb20gXCIuL2NvbW1hbmROb3RGb3VuZEVycm9yXCI7XG5pbXBvcnQgeyBVbmtub3duRXJyb3IgfSBmcm9tIFwiLi91bmtub3duRXJyb3JcIjtcblxuZXhwb3J0IGNvbnN0IEVycm9yRGV0YWlscyA9IChhcmdzOiB7IGVycm9yOiBFcnJvciB9KSA9PiB7XG4gIGlmIChhcmdzLmVycm9yLm1lc3NhZ2UuaW5jbHVkZXMoXCJjb21tYW5kIG5vdCBmb3VuZFwiKSkge1xuICAgIHNob3dUb2FzdCh7XG4gICAgICBzdHlsZTogVG9hc3QuU3R5bGUuRmFpbHVyZSxcbiAgICAgIHRpdGxlOiBcIkxhc3RQYXNzIENMSSBub3QgZm91bmRcIixcbiAgICAgIG1lc3NhZ2U6IGFyZ3MuZXJyb3IubWVzc2FnZSxcbiAgICB9KTtcbiAgICByZXR1cm4gPENvbW1hbmROb3RGb3VuZEVycm9yIC8+O1xuICB9IGVsc2Uge1xuICAgIHNob3dUb2FzdCh7XG4gICAgICBzdHlsZTogVG9hc3QuU3R5bGUuRmFpbHVyZSxcbiAgICAgIHRpdGxlOiBcIlNvbWV0aGluZyB3ZW50IHdyb25nXCIsXG4gICAgICBtZXNzYWdlOiBhcmdzLmVycm9yLm1lc3NhZ2UsXG4gICAgfSk7XG4gICAgcmV0dXJuIDxVbmtub3duRXJyb3IgZXJyb3I9e2FyZ3MuZXJyb3J9IC8+O1xuICB9XG59O1xuIl0sCiAgIm1hcHBpbmdzIjogIjs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFBQTtBQUFBO0FBQUEsUUFBSSxNQUFNLE9BQU8sVUFBVTtBQUUzQixhQUFTLE9BQU8sS0FBSyxLQUFLO0FBQ3pCLFVBQUksTUFBTTtBQUNWLFVBQUksUUFBUTtBQUFLLGVBQU87QUFFeEIsVUFBSSxPQUFPLFFBQVEsT0FBSyxJQUFJLGlCQUFpQixJQUFJLGFBQWE7QUFDN0QsWUFBSSxTQUFTO0FBQU0saUJBQU8sSUFBSSxRQUFRLE1BQU0sSUFBSSxRQUFRO0FBQ3hELFlBQUksU0FBUztBQUFRLGlCQUFPLElBQUksU0FBUyxNQUFNLElBQUksU0FBUztBQUU1RCxZQUFJLFNBQVMsT0FBTztBQUNuQixlQUFLLE1BQUksSUFBSSxZQUFZLElBQUksUUFBUTtBQUNwQyxtQkFBTyxTQUFTLE9BQU8sSUFBSSxNQUFNLElBQUksSUFBSTtBQUFFO0FBQUEsVUFDNUM7QUFDQSxpQkFBTyxRQUFRO0FBQUEsUUFDaEI7QUFFQSxZQUFJLENBQUMsUUFBUSxPQUFPLFFBQVEsVUFBVTtBQUNyQyxnQkFBTTtBQUNOLGVBQUssUUFB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WUFBVyxNQUFNLG1CQUFtQixRQUFRLEVBQUUsS0FBSyxDQUFDLFNBQVMsSUFBSSxLQUFLLEVBQUUsS0FBSyxDQUFDLENBQUM7QUFDckYsb0JBQVlBLFNBQVE7QUFDcEIscUJBQWEsS0FBSztBQUFBLE1BQ3BCLFNBQVNDLFFBQVA7QUFDQSxZQUFJQSxrQkFBaUIsT0FBTztBQUMxQixtQkFBU0EsTUFBSztBQUFBLFFBQ2hCO0FBQUEsTUFDRjtBQUFBLElBQ0YsR0FBRztBQUFBLEVBQ0wsR0FBRyxDQUFDLENBQUM7QUFFTCxNQUFJLE9BQU87QUFDVCxXQUFPLDRDQUFDO0FBQUEsTUFBYTtBQUFBLEtBQWM7QUFBQSxFQUNyQztBQUVBLFFBQU0sVUFDSiw0Q0FBQztBQUFBLElBQ0Msc0RBQUMsd0JBQVksU0FBWjtBQUFBLE1BQ0Msc0RBQUM7QUFBQSxRQUNDLE1BQU0saUJBQUs7QUFBQSxRQUNYLE9BQU07QUFBQSxRQUNOLFVBQVUsRUFBRSxXQUFXLENBQUMsS0FBSyxHQUFHLEtBQUssSUFBSTtBQUFBLFFBQ3pDLFVBQVUsTUFBTSxJQUFJLE9BQU8sRUFBRSxNQUFNLE1BQU0sQ0FBQyxFQUFFLEtBQUssYUFBYSxRQUFRO0FBQUEsT0FDeEU7QUFBQSxLQUNGO0FBQUEsR0FDRjtBQUdGLFNBQ0UsNENBQUM7QUFBQSxJQUFLO0FBQUEsSUFBc0IsaUJBQWU7QUFBQSxJQUFDO0FBQUEsSUFDekMsV0FBQyxTQUFTLFNBQ1QsNENBQUMsaUJBQWMsSUFFZixTQUFTLElBQUksQ0FBQyxZQUNaLDRDQUFDO0FBQUEsTUFDRSxHQUFHO0FBQUEsTUFDSixZQUFZLE1BQU0sbUJBQW1CLFFBQVEsRUFBRSxLQUFLLENBQUMsU0FBUyxJQUFJLEtBQUssUUFBUSxJQUFJLEVBQUUsS0FBSyxDQUFDLENBQUM7QUFBQSxLQUM5RixDQUNEO0FBQUEsR0FFTDtBQUVKOyIsCiAgIm5hbWVzIjogWyJhcmdzIiwgIm9wdGlvbnMiLCAibW9kdWxlIiwgImRhdGEiLCAib3B0aW9ucyIsICJtb2R1bGUiLCAibW9kdWxlIiwgIm1vZHVsZSIsICJtb2R1bGUiLCAicmVzIiwgIm1vZHVsZSIsICJVUkwiLCAicmVxdWlyZV9saWIiLCAibW9kdWxlIiwgIlVSTCIsICJpc0RvbWFpbk9yU3ViZG9tYWluIiwgImFib3J0IiwgImFib3J0QW5kRmluYWxpemUiLCAibW9kdWxlIiwgImV4ZWN1dGUiLCAidXJsIiwgIm9wdGlvbnMiLCAibW9kdWxlIiwgIm1vZHVsZSIsICJwcm9jZXNzIiwgInVubG9hZCIsICJlbWl0IiwgImxvYWQiLCAicHJvY2Vzc1JlYWxseUV4aXQiLCAicHJvY2Vzc0VtaXQiLCAiZXhlY3V0ZSIsICJpbnB1dCIsICJjb21tYW5kIiwgIm9wdGlvbnMiLCAicXVlcnkiLCAic3Bhd25lZCIsICJzcGF3bmVkUHJvbWlzZSIsICJGb3JtVmFsaWRhdGlvbiIsICJ2YWx1ZXMiLCAidmFsaWRhdGlvbiIsICJlcnJvcnMiLCAidmFsdWUiLCAiaW5pdGlhbFZhbHVlcyIsICJnZXRGYXZpY29uIiwgImV4cG9ydHMiLCAiZXhwb3J0cyIsICJpbXBvcnRfYXBpIiwgImltcG9ydF9yZWFjdCIsICJwYXNzd29yZCIsICJpbXBvcnRfYXBpIiwgImltcG9ydF9hcGkiLCAiaW1wb3J0X2FwaSIsICJpbXBvcnRfYXBpIiwgImltcG9ydF9hcGkiLCAiaW1wb3J0X2FwaSIsICJhY2NvdW50cyIsICJlcnJvciJdCn0K

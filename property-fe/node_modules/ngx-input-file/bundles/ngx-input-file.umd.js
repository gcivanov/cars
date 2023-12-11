(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined' ? factory(exports, require('@angular/core'), require('@angular/forms'), require('@angular/common'), require('@angular/material/button'), require('@angular/material/form-field'), require('@angular/material/icon'), require('@angular/material/input')) :
    typeof define === 'function' && define.amd ? define('ngx-input-file', ['exports', '@angular/core', '@angular/forms', '@angular/common', '@angular/material/button', '@angular/material/form-field', '@angular/material/icon', '@angular/material/input'], factory) :
    (global = typeof globalThis !== 'undefined' ? globalThis : global || self, factory(global['ngx-input-file'] = {}, global.ng.core, global.ng.forms, global.ng.common, global.ng.material.button, global.ng.material.formField, global.ng.material.icon, global.ng.material.input));
}(this, (function (exports, i0, forms, common, button, formField, icon, input) { 'use strict';

    var defaultSettings = {
        classAnimation: 'bounce-in',
        fileAccept: '*',
        fileLimit: 1,
        iconAdd: 'add',
        iconDelete: 'delete',
        iconFile: 'insert_drive_file',
        iconLink: 'link',
        linkEnabled: false,
        placeholderLink: 'Link',
        sizeLimit: null
    };

    var InputFileRejectedReason;
    (function (InputFileRejectedReason) {
        InputFileRejectedReason[InputFileRejectedReason["badFile"] = 0] = "badFile";
        InputFileRejectedReason[InputFileRejectedReason["limitReached"] = 1] = "limitReached";
        InputFileRejectedReason[InputFileRejectedReason["sizeReached"] = 2] = "sizeReached";
    })(InputFileRejectedReason || (InputFileRejectedReason = {}));

    /*! *****************************************************************************
    Copyright (c) Microsoft Corporation.

    Permission to use, copy, modify, and/or distribute this software for any
    purpose with or without fee is hereby granted.

    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
    REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
    AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
    INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
    LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
    OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
    PERFORMANCE OF THIS SOFTWARE.
    ***************************************************************************** */
    /* global Reflect, Promise */
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b)
                if (Object.prototype.hasOwnProperty.call(b, p))
                    d[p] = b[p]; };
        return extendStatics(d, b);
    };
    function __extends(d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    }
    var __assign = function () {
        __assign = Object.assign || function __assign(t) {
            for (var s, i = 1, n = arguments.length; i < n; i++) {
                s = arguments[i];
                for (var p in s)
                    if (Object.prototype.hasOwnProperty.call(s, p))
                        t[p] = s[p];
            }
            return t;
        };
        return __assign.apply(this, arguments);
    };
    function __rest(s, e) {
        var t = {};
        for (var p in s)
            if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
                t[p] = s[p];
        if (s != null && typeof Object.getOwnPropertySymbols === "function")
            for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
                if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                    t[p[i]] = s[p[i]];
            }
        return t;
    }
    function __decorate(decorators, target, key, desc) {
        var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
        if (typeof Reflect === "object" && typeof Reflect.decorate === "function")
            r = Reflect.decorate(decorators, target, key, desc);
        else
            for (var i = decorators.length - 1; i >= 0; i--)
                if (d = decorators[i])
                    r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
        return c > 3 && r && Object.defineProperty(target, key, r), r;
    }
    function __param(paramIndex, decorator) {
        return function (target, key) { decorator(target, key, paramIndex); };
    }
    function __metadata(metadataKey, metadataValue) {
        if (typeof Reflect === "object" && typeof Reflect.metadata === "function")
            return Reflect.metadata(metadataKey, metadataValue);
    }
    function __awaiter(thisArg, _arguments, P, generator) {
        function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
        return new (P || (P = Promise))(function (resolve, reject) {
            function fulfilled(value) { try {
                step(generator.next(value));
            }
            catch (e) {
                reject(e);
            } }
            function rejected(value) { try {
                step(generator["throw"](value));
            }
            catch (e) {
                reject(e);
            } }
            function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
            step((generator = generator.apply(thisArg, _arguments || [])).next());
        });
    }
    function __generator(thisArg, body) {
        var _ = { label: 0, sent: function () { if (t[0] & 1)
                throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
        return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function () { return this; }), g;
        function verb(n) { return function (v) { return step([n, v]); }; }
        function step(op) {
            if (f)
                throw new TypeError("Generator is already executing.");
            while (_)
                try {
                    if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done)
                        return t;
                    if (y = 0, t)
                        op = [op[0] & 2, t.value];
                    switch (op[0]) {
                        case 0:
                        case 1:
                            t = op;
                            break;
                        case 4:
                            _.label++;
                            return { value: op[1], done: false };
                        case 5:
                            _.label++;
                            y = op[1];
                            op = [0];
                            continue;
                        case 7:
                            op = _.ops.pop();
                            _.trys.pop();
                            continue;
                        default:
                            if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                _ = 0;
                                continue;
                            }
                            if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) {
                                _.label = op[1];
                                break;
                            }
                            if (op[0] === 6 && _.label < t[1]) {
                                _.label = t[1];
                                t = op;
                                break;
                            }
                            if (t && _.label < t[2]) {
                                _.label = t[2];
                                _.ops.push(op);
                                break;
                            }
                            if (t[2])
                                _.ops.pop();
                            _.trys.pop();
                            continue;
                    }
                    op = body.call(thisArg, _);
                }
                catch (e) {
                    op = [6, e];
                    y = 0;
                }
                finally {
                    f = t = 0;
                }
            if (op[0] & 5)
                throw op[1];
            return { value: op[0] ? op[1] : void 0, done: true };
        }
    }
    var __createBinding = Object.create ? (function (o, m, k, k2) {
        if (k2 === undefined)
            k2 = k;
        Object.defineProperty(o, k2, { enumerable: true, get: function () { return m[k]; } });
    }) : (function (o, m, k, k2) {
        if (k2 === undefined)
            k2 = k;
        o[k2] = m[k];
    });
    function __exportStar(m, o) {
        for (var p in m)
            if (p !== "default" && !Object.prototype.hasOwnProperty.call(o, p))
                __createBinding(o, m, p);
    }
    function __values(o) {
        var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
        if (m)
            return m.call(o);
        if (o && typeof o.length === "number")
            return {
                next: function () {
                    if (o && i >= o.length)
                        o = void 0;
                    return { value: o && o[i++], done: !o };
                }
            };
        throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
    }
    function __read(o, n) {
        var m = typeof Symbol === "function" && o[Symbol.iterator];
        if (!m)
            return o;
        var i = m.call(o), r, ar = [], e;
        try {
            while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                ar.push(r.value);
        }
        catch (error) {
            e = { error: error };
        }
        finally {
            try {
                if (r && !r.done && (m = i["return"]))
                    m.call(i);
            }
            finally {
                if (e)
                    throw e.error;
            }
        }
        return ar;
    }
    function __spread() {
        for (var ar = [], i = 0; i < arguments.length; i++)
            ar = ar.concat(__read(arguments[i]));
        return ar;
    }
    function __spreadArrays() {
        for (var s = 0, i = 0, il = arguments.length; i < il; i++)
            s += arguments[i].length;
        for (var r = Array(s), k = 0, i = 0; i < il; i++)
            for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
                r[k] = a[j];
        return r;
    }
    ;
    function __await(v) {
        return this instanceof __await ? (this.v = v, this) : new __await(v);
    }
    function __asyncGenerator(thisArg, _arguments, generator) {
        if (!Symbol.asyncIterator)
            throw new TypeError("Symbol.asyncIterator is not defined.");
        var g = generator.apply(thisArg, _arguments || []), i, q = [];
        return i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i;
        function verb(n) { if (g[n])
            i[n] = function (v) { return new Promise(function (a, b) { q.push([n, v, a, b]) > 1 || resume(n, v); }); }; }
        function resume(n, v) { try {
            step(g[n](v));
        }
        catch (e) {
            settle(q[0][3], e);
        } }
        function step(r) { r.value instanceof __await ? Promise.resolve(r.value.v).then(fulfill, reject) : settle(q[0][2], r); }
        function fulfill(value) { resume("next", value); }
        function reject(value) { resume("throw", value); }
        function settle(f, v) { if (f(v), q.shift(), q.length)
            resume(q[0][0], q[0][1]); }
    }
    function __asyncDelegator(o) {
        var i, p;
        return i = {}, verb("next"), verb("throw", function (e) { throw e; }), verb("return"), i[Symbol.iterator] = function () { return this; }, i;
        function verb(n, f) { i[n] = o[n] ? function (v) { return (p = !p) ? { value: __await(o[n](v)), done: n === "return" } : f ? f(v) : v; } : f; }
    }
    function __asyncValues(o) {
        if (!Symbol.asyncIterator)
            throw new TypeError("Symbol.asyncIterator is not defined.");
        var m = o[Symbol.asyncIterator], i;
        return m ? m.call(o) : (o = typeof __values === "function" ? __values(o) : o[Symbol.iterator](), i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i);
        function verb(n) { i[n] = o[n] && function (v) { return new Promise(function (resolve, reject) { v = o[n](v), settle(resolve, reject, v.done, v.value); }); }; }
        function settle(resolve, reject, d, v) { Promise.resolve(v).then(function (v) { resolve({ value: v, done: d }); }, reject); }
    }
    function __makeTemplateObject(cooked, raw) {
        if (Object.defineProperty) {
            Object.defineProperty(cooked, "raw", { value: raw });
        }
        else {
            cooked.raw = raw;
        }
        return cooked;
    }
    ;
    var __setModuleDefault = Object.create ? (function (o, v) {
        Object.defineProperty(o, "default", { enumerable: true, value: v });
    }) : function (o, v) {
        o["default"] = v;
    };
    function __importStar(mod) {
        if (mod && mod.__esModule)
            return mod;
        var result = {};
        if (mod != null)
            for (var k in mod)
                if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k))
                    __createBinding(result, mod, k);
        __setModuleDefault(result, mod);
        return result;
    }
    function __importDefault(mod) {
        return (mod && mod.__esModule) ? mod : { default: mod };
    }
    function __classPrivateFieldGet(receiver, privateMap) {
        if (!privateMap.has(receiver)) {
            throw new TypeError("attempted to get private field on non-instance");
        }
        return privateMap.get(receiver);
    }
    function __classPrivateFieldSet(receiver, privateMap, value) {
        if (!privateMap.has(receiver)) {
            throw new TypeError("attempted to set private field on non-instance");
        }
        privateMap.set(receiver, value);
        return value;
    }

    var InputFileService = /** @class */ (function () {
        function InputFileService(_config) {
            this._config = _config;
        }
        Object.defineProperty(InputFileService.prototype, "config", {
            get: function () {
                return this._config;
            },
            enumerable: false,
            configurable: true
        });
        /**
         * Whether the limit is not reached.
         * @param files
         */
        InputFileService.prototype.limitGuard = function (files, fileLimit) {
            return files.length < fileLimit;
        };
        /**
         * Whether the file size is not bigger than the limit.
         * @param file
         * @param sizeLimit
         */
        InputFileService.prototype.sizeGuard = function (file, sizeLimit) {
            return !sizeLimit || file.size < sizeLimit * 1024 * 1024; // TODO : improve
        };
        /**
         * Whether the type of the file is enabled.
         * @param file
         * @param fileAccept
         */
        InputFileService.prototype.typeGuard = function (file, fileAccept) {
            var e_1, _a;
            var enabled = fileAccept == null;
            if (fileAccept) {
                var accept = fileAccept.replace('*', '');
                var types = accept.split(',');
                try {
                    for (var types_1 = __values(types), types_1_1 = types_1.next(); !types_1_1.done; types_1_1 = types_1.next()) {
                        var type = types_1_1.value;
                        if (file.type.startsWith(type) || (type.charAt(0) === '.' && file.name != null && file.name.endsWith(type))) {
                            enabled = true;
                            break;
                        }
                    }
                }
                catch (e_1_1) { e_1 = { error: e_1_1 }; }
                finally {
                    try {
                        if (types_1_1 && !types_1_1.done && (_a = types_1.return)) _a.call(types_1);
                    }
                    finally { if (e_1) throw e_1.error; }
                }
            }
            return enabled;
        };
        return InputFileService;
    }());
    InputFileService.ɵprov = i0.ɵɵdefineInjectable({ factory: function InputFileService_Factory() { return new InputFileService(i0.ɵɵinject("config")); }, token: InputFileService, providedIn: "root" });
    InputFileService.decorators = [
        { type: i0.Injectable, args: [{
                    providedIn: 'root'
                },] }
    ];
    InputFileService.ctorParameters = function () { return [
        { type: undefined, decorators: [{ type: i0.Inject, args: ['config',] }] }
    ]; };

    function urlValidator(control) {
        if (forms.Validators.required(control) != null) {
            return null;
        }
        var v = control.value;
        /* tslint:disable */
        return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(v) ? null : { 'url': true };
        /* tslint:enable */
    }

    var InputFileComponent = /** @class */ (function () {
        function InputFileComponent(formBuilder, inputFileService) {
            this.formBuilder = formBuilder;
            this.inputFileService = inputFileService;
            this.acceptedFile = new i0.EventEmitter();
            this.deletedFile = new i0.EventEmitter();
            this.rejectedFile = new i0.EventEmitter();
            this.files = new Array();
            this.id = "ngx-input-file-" + InputFileComponent.nextId++;
            this.onChange = function (files) { };
            this.onTouched = function () { };
        }
        Object.defineProperty(InputFileComponent.prototype, "classAnimation", {
            get: function () {
                return this._classAnimation || this.inputFileService.config.classAnimation || defaultSettings.classAnimation;
            },
            set: function (classAnimation) {
                this._classAnimation = classAnimation;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "fileAccept", {
            get: function () {
                return this._fileAccept || this.inputFileService.config.fileAccept || defaultSettings.fileAccept;
            },
            set: function (fileAccept) {
                this._fileAccept = fileAccept;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "fileLimit", {
            get: function () {
                return this._fileLimit || this.inputFileService.config.fileLimit || defaultSettings.fileLimit;
            },
            set: function (fileLimit) {
                this._fileLimit = fileLimit;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "iconAdd", {
            get: function () {
                return this._iconAdd || this.inputFileService.config.iconAdd || defaultSettings.iconAdd;
            },
            set: function (iconAdd) {
                this._iconAdd = iconAdd;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "iconDelete", {
            get: function () {
                return this._iconDelete || this.inputFileService.config.iconDelete || defaultSettings.iconDelete;
            },
            set: function (iconDelete) {
                this._iconDelete = iconDelete;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "iconFile", {
            get: function () {
                return this._iconFile || this.inputFileService.config.iconFile || defaultSettings.iconFile;
            },
            set: function (iconFile) {
                this._iconFile = iconFile;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "iconLink", {
            get: function () {
                return this._iconLink || this.inputFileService.config.iconLink || defaultSettings.iconLink;
            },
            set: function (iconLink) {
                this._iconLink = iconLink;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "linkEnabled", {
            get: function () {
                return this._linkEnabled || this.inputFileService.config.linkEnabled || defaultSettings.linkEnabled;
            },
            set: function (linkEnabled) {
                this._linkEnabled = linkEnabled;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "placeholderLink", {
            get: function () {
                return this._placeholderLink || this.inputFileService.config.placeholderLink || defaultSettings.placeholderLink;
            },
            set: function (placeholderLink) {
                this._placeholderLink = placeholderLink;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "sizeLimit", {
            get: function () {
                return this._sizeLimit || this.inputFileService.config.sizeLimit || defaultSettings.sizeLimit;
            },
            set: function (sizeLimit) {
                this._sizeLimit = sizeLimit;
            },
            enumerable: false,
            configurable: true
        });
        Object.defineProperty(InputFileComponent.prototype, "canAddFile", {
            get: function () {
                return this.files && this.files.length < this.fileLimit;
            },
            enumerable: false,
            configurable: true
        });
        /**
         * Angular lifecyle OnInit implementation.
         */
        InputFileComponent.prototype.ngOnInit = function () {
            this.setForm();
        };
        /**
         * On delete a file event handler.
         * @param index
         */
        InputFileComponent.prototype.onDeleteFile = function (index) {
            if (!this.disabled) {
                var files = this.files.slice();
                this.deletedFile.emit(files[index]);
                files.splice(index, 1);
                this.writeValue(files);
            }
        };
        /**
         * On drag over event handler.
         * Adds a ripple effect on the button.
         */
        InputFileComponent.prototype.onDragOver = function (button) {
            button.ripple.launch({ centered: true, persistent: true });
        };
        /**
         * On drag leave event handler.
         * Fades the ripple effect of the button.
         */
        InputFileComponent.prototype.onDragLeave = function (button) {
            button.ripple.fadeOutAll();
        };
        /**
         * On adds a link.
         */
        InputFileComponent.prototype.onLink = function () {
            this.addLink = !this.addLink;
        };
        /**
         * On replace one file event handler.
         * Writes the value.
         * @param fileList
         * @param index
         * @param fileInput
         */
        InputFileComponent.prototype.onReplaceFile = function (fileList, index, button, fileInput) {
            if (!this.disabled) {
                // Copies the array without reference.
                var files = this.files.slice();
                // Assumes that a single file can be replaced by a single file.
                var inputFile = { file: fileList.item(0) };
                button.ripple.fadeOutAll();
                if (this.fileGuard(files, inputFile, true)) {
                    files[index] = inputFile;
                    this.acceptedFile.emit(inputFile);
                }
                this.writeValue(files);
                if (fileInput) {
                    fileInput.value = '';
                }
            }
        };
        /**
         * On select one or more files event handler.
         * Writes the value.
         * @param fileList
         */
        InputFileComponent.prototype.onSelectFile = function (fileList, button) {
            var _this = this;
            if (!this.disabled) {
                button.ripple.fadeOutAll();
                // Copies the array without reference.
                var files_1 = this.files.slice();
                Array.from(fileList).forEach(function (file) {
                    var inputFile = { file: file };
                    if (_this.fileGuard(files_1, inputFile)) {
                        files_1.push(inputFile);
                        _this.acceptedFile.emit(inputFile);
                    }
                });
                this.writeValue(files_1);
                this.fileInput.nativeElement.value = '';
            }
        };
        /**
         * On submit the link form event handler.
         */
        InputFileComponent.prototype.onSubmitLink = function () {
            if (!this.disabled && this.form.valid) {
                var files = this.files.slice();
                var inputFile = { link: this.form.value.link, preview: this.form.value.link };
                files.push(inputFile);
                this.acceptedFile.emit(inputFile);
                this.onLink();
                this.form.reset();
                this.writeValue(files);
            }
        };
        /**
         * Implementation of ControlValueAccessor.
         * @param fn
         */
        InputFileComponent.prototype.registerOnChange = function (fn) {
            this.onChange = fn;
        };
        /**
         * Implementation of ControlValueAccessor.
         * @param fn
         */
        InputFileComponent.prototype.registerOnTouched = function (fn) {
            this.onTouched = fn;
        };
        /**
         * Implementation of ControlValueAccessor.
         * @param isDisabled
         */
        InputFileComponent.prototype.setDisabledState = function (isDisabled) {
            this.disabled = isDisabled;
        };
        /**
         * Implementation of ControlValueAccessor.
         * @param files
         */
        InputFileComponent.prototype.writeValue = function (files) {
            if (!files) {
                files = new Array();
            }
            this.files = files;
            this.setFilePreview();
            this.onChange(this.files);
        };
        /**
         * Whether the file can be added to the model.
         * @param files
         * @param file,
         * @param bypassLimit
         */
        InputFileComponent.prototype.fileGuard = function (files, file, bypassLimit) {
            if (!bypassLimit && !this.inputFileService.limitGuard(files, this.fileLimit)) {
                this.rejectedFile.emit({ reason: InputFileRejectedReason.limitReached, file: file });
                return false;
            }
            if (!this.inputFileService.sizeGuard(file.file, this.sizeLimit)) {
                this.rejectedFile.emit({ reason: InputFileRejectedReason.sizeReached, file: file });
                return false;
            }
            if (!this.inputFileService.typeGuard(file.file, this.fileAccept)) {
                this.rejectedFile.emit({ reason: InputFileRejectedReason.badFile, file: file });
                return false;
            }
            return true;
        };
        /**
         * Sets the file preview with FileReader.
         */
        InputFileComponent.prototype.setFilePreview = function () {
            var _this = this;
            var _loop_1 = function (index) {
                if (this_1.files[index].file != null && this_1.inputFileService.typeGuard(this_1.files[index].file, 'image/*')) {
                    var fr_1 = new FileReader();
                    fr_1.onload = function () {
                        _this.files[index].preview = fr_1.result;
                    };
                    fr_1.readAsDataURL(this_1.files[index].file);
                }
            };
            var this_1 = this;
            for (var index in this.files) {
                _loop_1(index);
            }
        };
        /**
         * Sets the reactive form to insert a link.
         */
        InputFileComponent.prototype.setForm = function () {
            this.form = this.formBuilder.group({
                link: ['', [forms.Validators.required, urlValidator]]
            });
        };
        return InputFileComponent;
    }());
    InputFileComponent.nextId = 0;
    InputFileComponent.decorators = [
        { type: i0.Component, args: [{
                    selector: 'input-file',
                    template: "<div class=\"input-file-container\">\n    <label class=\"mat-orphan-label\" [for]=\"id\" [class.active]=\"files?.length\" [innerHtml]=\"placeholder\" *ngIf=\"placeholder\"></label>\n    <div class=\"files-container\">\n\n        <ng-container *ngFor=\"let file of files; let i = index\">\n            <div class=\"file-container\" [ngClass]=\"classAnimation\">\n                <ng-container *ngTemplateOutlet=\"fileTemplate; context: { $implicit: file, index: i }\"></ng-container>\n            </div>\n        </ng-container>\n\n        <ng-container *ngIf=\"canAddFile\">\n            <div class=\"file-container\">\n                <ng-container *ngIf=\"!addLink; else linkTemplate\">\n                    <ng-container *ngTemplateOutlet=\"addTemplate\"></ng-container>\n                </ng-container>\n            </div>\n        </ng-container>\n    </div>\n\n</div>\n\n<ng-template #addTemplate>\n    <button mat-button inputFileDropZone class=\"file-button\" type=\"button\" (click)=\"fileInput.click()\" (itemDrop)=\"onSelectFile($event, selectButton)\"\n        (itemDragOver)=\"onDragOver(selectButton)\" (itemDragLeave)=\"onDragLeave(selectButton)\" [disabled]=\"disabled\" #selectButton>\n        <mat-icon class=\"input-icon\">{{ iconAdd }}</mat-icon>\n    </button>\n    <button mat-button class=\"secondary-button\" type=\"button\" [disabled]=\"disabled\" (click)=\"onLink()\" *ngIf=\"linkEnabled\">\n        <mat-icon>{{ iconLink }}</mat-icon>\n    </button>\n    <input [id]=\"id\" [accept]=\"fileAccept\" hidden type=\"file\" [attr.multiple]=\"fileLimit > 1 ? true : null\" #fileInput (change)=\"onSelectFile($event.target.files, selectButton)\">\n</ng-template>\n\n<ng-template #fileTemplate let-file let-index=\"index\">\n    <img class=\"image-preview\" [src]=\"file.preview\" *ngIf=\"file.preview\">\n    <button mat-button inputFileDropZone class=\"replace-button\" type=\"button\" (click)=\"fileReplace.click()\" (itemDrop)=\"onReplaceFile($event, index, replaceButton)\"\n        [disabled]=\"disabled\" (itemDragOver)=\"onDragOver(replaceButton)\" (itemDragLeave)=\"onDragLeave(replaceButton)\" #replaceButton>\n        <ng-container *ngIf=\"!file.preview\">\n            <mat-icon class=\"input-icon\">{{ iconFile }}</mat-icon>\n            <div class=\"file-name text-truncate\" [innerHtml]=\"file.file.name\" *ngIf=\"file.file\"></div>\n        </ng-container>\n    </button>\n    <button mat-button class=\"secondary-button\" type=\"button\" (click)=\"onDeleteFile(index)\" [disabled]=\"disabled\">\n        <mat-icon>{{ iconDelete }}</mat-icon>\n    </button>\n    <input [accept]=\"fileAccept\" hidden type=\"file\" #fileReplace (change)=\"onReplaceFile($event.target.files, index, replaceButton, fileReplace)\">\n</ng-template>\n\n<ng-template #linkTemplate>\n    <form class=\"form-link slide-in-up\" [formGroup]=\"form\" (ngSubmit)=\"onSubmitLink()\" novalidate>\n        <mat-form-field class=\"input-link\">\n            <input matInput formControlName=\"link\" [placeholder]=\"placeholderLink\">\n        </mat-form-field>\n        <div class=\"form-link-button\">\n            <button mat-button type=\"button\" (click)=\"onLink()\" [disabled]=\"disabled\">\n                <mat-icon>arrow_back</mat-icon>\n            </button>\n            <button mat-button type=\"submit\" [disabled]=\"disabled\">\n                <mat-icon>check</mat-icon>\n            </button>\n        </div>\n    </form>\n</ng-template>",
                    providers: [
                        {
                            provide: forms.NG_VALUE_ACCESSOR,
                            useExisting: i0.forwardRef(function () { return InputFileComponent; }),
                            multi: true
                        }
                    ],
                    styles: [".input-file-container{position:relative}.input-file-container .files-container{display:flex;flex-direction:row;flex-wrap:wrap;padding-top:1.25rem}.input-file-container .file-button,.input-file-container .file-container{align-items:center;display:flex;height:10rem;justify-content:center;width:10rem}.input-file-container .secondary-button{width:10rem}.input-file-container .file-button{flex:1}.input-file-container .file-container{flex-direction:column;margin-right:1rem;overflow:hidden}.input-file-container .replace-button{flex:1;width:10rem}.input-file-container .mat-button:focus{outline:0}.input-file-container .file-name{width:7.5rem}.input-file-container .image-preview{-o-object-fit:contain;height:10rem;object-fit:contain;position:absolute;width:10rem}.input-file-container .input-icon{font-size:2.5rem;height:2.5rem;width:2.5rem}.input-file-container .form-link{display:flex;flex-direction:column;width:10rem}.input-file-container .input-link{width:10rem}.input-file-container .form-link-button{display:flex;flex-direction:row}.input-file-container .form-link-button .mat-button{min-width:5rem;width:5rem}.input-file-container .mat-orphan-label{color:rgba(0,0,0,.54);display:block;font-size:1rem;left:0;margin:0;position:absolute;top:0;transform-origin:0;transition:.4s cubic-bezier(.25,.8,.25,1),width .4s cubic-bezier(.25,.8,.25,1)}.input-file-container .mat-orphan-label.active{transform:scale(.75)}@-webkit-keyframes bounceIn{0%,20%,40%,60%,80%,to{-webkit-animation-timing-function:cubic-bezier(.215,.61,.355,1);animation-timing-function:cubic-bezier(.215,.61,.355,1)}0%{opacity:0;transform:scale3d(.3,.3,.3)}20%{transform:scale3d(1.1,1.1,1.1)}40%{transform:scale3d(.9,.9,.9)}60%{opacity:1;transform:scale3d(1.03,1.03,1.03)}80%{transform:scale3d(.97,.97,.97)}to{opacity:1;transform:scaleX(1)}}@keyframes bounceIn{0%,20%,40%,60%,80%,to{-webkit-animation-timing-function:cubic-bezier(.215,.61,.355,1);animation-timing-function:cubic-bezier(.215,.61,.355,1)}0%{opacity:0;transform:scale3d(.3,.3,.3)}20%{transform:scale3d(1.1,1.1,1.1)}40%{transform:scale3d(.9,.9,.9)}60%{opacity:1;transform:scale3d(1.03,1.03,1.03)}80%{transform:scale3d(.97,.97,.97)}to{opacity:1;transform:scaleX(1)}}.bounce-in{-webkit-animation-duration:.75s;-webkit-animation-name:bounceIn;animation-duration:.75s;animation-name:bounceIn}@-webkit-keyframes slideInUp{0%{opacity:0;transform:translate3d(0,100%,0)}to{opacity:1;transform:translateZ(0)}}@keyframes slideInUp{0%{opacity:0;transform:translate3d(0,100%,0)}to{opacity:1;transform:translateZ(0)}}.slide-in-up{-webkit-animation-duration:.25s;-webkit-animation-name:slideInUp;animation-duration:.25s;animation-name:slideInUp}"]
                },] }
    ];
    InputFileComponent.ctorParameters = function () { return [
        { type: forms.FormBuilder },
        { type: InputFileService }
    ]; };
    InputFileComponent.propDecorators = {
        disabled: [{ type: i0.Input }],
        placeholder: [{ type: i0.Input }],
        classAnimation: [{ type: i0.Input }],
        fileAccept: [{ type: i0.Input }],
        fileLimit: [{ type: i0.Input }],
        iconAdd: [{ type: i0.Input }],
        iconDelete: [{ type: i0.Input }],
        iconFile: [{ type: i0.Input }],
        iconLink: [{ type: i0.Input }],
        linkEnabled: [{ type: i0.Input }],
        placeholderLink: [{ type: i0.Input }],
        sizeLimit: [{ type: i0.Input }],
        acceptedFile: [{ type: i0.Output }],
        deletedFile: [{ type: i0.Output }],
        rejectedFile: [{ type: i0.Output }],
        fileInput: [{ type: i0.ViewChild, args: ['fileInput', { static: false },] }]
    };

    var DropZoneDirective = /** @class */ (function () {
        function DropZoneDirective() {
            this.disabled = false;
            this.itemDragOver = new i0.EventEmitter();
            this.itemDragLeave = new i0.EventEmitter();
            this.itemDrop = new i0.EventEmitter();
            // Prevent dragleave on children, could be better but it's cheap for better performance
            this.whiteListClasses = ['file-button', 'mat-button-wrapper', 'input-icon'];
        }
        /**
         * Drag Over event handler.
         * @param event
         */
        DropZoneDirective.prototype.onDragOver = function (event) {
            this.preventAndStopEventPropagation(event);
            if (!this.isOver && !this.disabled) {
                this.isOver = true;
                this.itemDragOver.emit();
            }
        };
        /**
         * Drag Leave event handler.
         * @param event
         */
        DropZoneDirective.prototype.onDragLeave = function (event) {
            this.preventAndStopEventPropagation(event);
            if (this.isOver && this.isTrueLeave(event) && !this.disabled) {
                this.isOver = false;
                this.itemDragLeave.emit();
            }
        };
        /**
         * Drop event handler.
         * @param event
         */
        DropZoneDirective.prototype.onDrop = function (event) {
            if (!this.disabled) {
                this.preventAndStopEventPropagation(event);
                this.isOver = false;
                try {
                    this.itemDrop.emit(event.dataTransfer.files);
                }
                catch (e) {
                    console.error(e);
                }
            }
        };
        /**
         * Prevents and stops event propagration.
         * @param event
         */
        DropZoneDirective.prototype.preventAndStopEventPropagation = function (event) {
            event.preventDefault();
            event.stopPropagation();
        };
        /**
         * Checks if the leave is not trigger by a children.
         * @param event
         */
        DropZoneDirective.prototype.isTrueLeave = function (event) {
            var e_1, _a;
            try {
                for (var _b = __values(this.whiteListClasses), _c = _b.next(); !_c.done; _c = _b.next()) {
                    var c = _c.value;
                    if (event.fromElement != null && event.fromElement.className.indexOf(c) >= 0) {
                        return false;
                    }
                }
            }
            catch (e_1_1) { e_1 = { error: e_1_1 }; }
            finally {
                try {
                    if (_c && !_c.done && (_a = _b.return)) _a.call(_b);
                }
                finally { if (e_1) throw e_1.error; }
            }
            return true;
        };
        return DropZoneDirective;
    }());
    DropZoneDirective.decorators = [
        { type: i0.Directive, args: [{
                    selector: '[inputFileDropZone]'
                },] }
    ];
    DropZoneDirective.propDecorators = {
        disabled: [{ type: i0.Input }],
        itemDragOver: [{ type: i0.Output }],
        itemDragLeave: [{ type: i0.Output }],
        itemDrop: [{ type: i0.Output }],
        onDragOver: [{ type: i0.HostListener, args: ['dragover', ['$event'],] }],
        onDragLeave: [{ type: i0.HostListener, args: ['dragleave', ['$event'],] }],
        onDrop: [{ type: i0.HostListener, args: ['drop', ['$event'],] }]
    };

    var InputFileModule = /** @class */ (function () {
        function InputFileModule() {
        }
        InputFileModule.forRoot = function (config) {
            return {
                ngModule: InputFileModule,
                providers: [
                    InputFileService,
                    { provide: 'config', useValue: config }
                ]
            };
        };
        return InputFileModule;
    }());
    InputFileModule.decorators = [
        { type: i0.NgModule, args: [{
                    declarations: [
                        DropZoneDirective,
                        InputFileComponent
                    ],
                    imports: [
                        common.CommonModule,
                        forms.FormsModule,
                        button.MatButtonModule,
                        formField.MatFormFieldModule,
                        icon.MatIconModule,
                        input.MatInputModule,
                        forms.ReactiveFormsModule
                    ],
                    exports: [
                        InputFileComponent
                    ],
                    providers: [
                        InputFileService
                    ],
                    entryComponents: [InputFileComponent]
                },] }
    ];

    /**
     * Generated bundle index. Do not edit.
     */

    exports.InputFileComponent = InputFileComponent;
    exports.InputFileModule = InputFileModule;
    exports.InputFileService = InputFileService;
    exports.ɵa = DropZoneDirective;

    Object.defineProperty(exports, '__esModule', { value: true });

})));
//# sourceMappingURL=ngx-input-file.umd.js.map

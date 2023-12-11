import { ɵɵdefineInjectable, ɵɵinject, Injectable, Inject, EventEmitter, Component, forwardRef, Input, Output, ViewChild, Directive, HostListener, NgModule } from '@angular/core';
import { Validators, NG_VALUE_ACCESSOR, FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';

const defaultSettings = {
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

class InputFileService {
    constructor(_config) {
        this._config = _config;
    }
    get config() {
        return this._config;
    }
    /**
     * Whether the limit is not reached.
     * @param files
     */
    limitGuard(files, fileLimit) {
        return files.length < fileLimit;
    }
    /**
     * Whether the file size is not bigger than the limit.
     * @param file
     * @param sizeLimit
     */
    sizeGuard(file, sizeLimit) {
        return !sizeLimit || file.size < sizeLimit * 1024 * 1024; // TODO : improve
    }
    /**
     * Whether the type of the file is enabled.
     * @param file
     * @param fileAccept
     */
    typeGuard(file, fileAccept) {
        let enabled = fileAccept == null;
        if (fileAccept) {
            const accept = fileAccept.replace('*', '');
            const types = accept.split(',');
            for (const type of types) {
                if (file.type.startsWith(type) || (type.charAt(0) === '.' && file.name != null && file.name.endsWith(type))) {
                    enabled = true;
                    break;
                }
            }
        }
        return enabled;
    }
}
InputFileService.ɵprov = ɵɵdefineInjectable({ factory: function InputFileService_Factory() { return new InputFileService(ɵɵinject("config")); }, token: InputFileService, providedIn: "root" });
InputFileService.decorators = [
    { type: Injectable, args: [{
                providedIn: 'root'
            },] }
];
InputFileService.ctorParameters = () => [
    { type: undefined, decorators: [{ type: Inject, args: ['config',] }] }
];

function urlValidator(control) {
    if (Validators.required(control) != null) {
        return null;
    }
    const v = control.value;
    /* tslint:disable */
    return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(v) ? null : { 'url': true };
    /* tslint:enable */
}

class InputFileComponent {
    constructor(formBuilder, inputFileService) {
        this.formBuilder = formBuilder;
        this.inputFileService = inputFileService;
        this.acceptedFile = new EventEmitter();
        this.deletedFile = new EventEmitter();
        this.rejectedFile = new EventEmitter();
        this.files = new Array();
        this.id = `ngx-input-file-${InputFileComponent.nextId++}`;
        this.onChange = (files) => { };
        this.onTouched = () => { };
    }
    set classAnimation(classAnimation) {
        this._classAnimation = classAnimation;
    }
    get classAnimation() {
        return this._classAnimation || this.inputFileService.config.classAnimation || defaultSettings.classAnimation;
    }
    set fileAccept(fileAccept) {
        this._fileAccept = fileAccept;
    }
    get fileAccept() {
        return this._fileAccept || this.inputFileService.config.fileAccept || defaultSettings.fileAccept;
    }
    set fileLimit(fileLimit) {
        this._fileLimit = fileLimit;
    }
    get fileLimit() {
        return this._fileLimit || this.inputFileService.config.fileLimit || defaultSettings.fileLimit;
    }
    set iconAdd(iconAdd) {
        this._iconAdd = iconAdd;
    }
    get iconAdd() {
        return this._iconAdd || this.inputFileService.config.iconAdd || defaultSettings.iconAdd;
    }
    set iconDelete(iconDelete) {
        this._iconDelete = iconDelete;
    }
    get iconDelete() {
        return this._iconDelete || this.inputFileService.config.iconDelete || defaultSettings.iconDelete;
    }
    set iconFile(iconFile) {
        this._iconFile = iconFile;
    }
    get iconFile() {
        return this._iconFile || this.inputFileService.config.iconFile || defaultSettings.iconFile;
    }
    set iconLink(iconLink) {
        this._iconLink = iconLink;
    }
    get iconLink() {
        return this._iconLink || this.inputFileService.config.iconLink || defaultSettings.iconLink;
    }
    set linkEnabled(linkEnabled) {
        this._linkEnabled = linkEnabled;
    }
    get linkEnabled() {
        return this._linkEnabled || this.inputFileService.config.linkEnabled || defaultSettings.linkEnabled;
    }
    set placeholderLink(placeholderLink) {
        this._placeholderLink = placeholderLink;
    }
    get placeholderLink() {
        return this._placeholderLink || this.inputFileService.config.placeholderLink || defaultSettings.placeholderLink;
    }
    set sizeLimit(sizeLimit) {
        this._sizeLimit = sizeLimit;
    }
    get sizeLimit() {
        return this._sizeLimit || this.inputFileService.config.sizeLimit || defaultSettings.sizeLimit;
    }
    get canAddFile() {
        return this.files && this.files.length < this.fileLimit;
    }
    /**
     * Angular lifecyle OnInit implementation.
     */
    ngOnInit() {
        this.setForm();
    }
    /**
     * On delete a file event handler.
     * @param index
     */
    onDeleteFile(index) {
        if (!this.disabled) {
            const files = this.files.slice();
            this.deletedFile.emit(files[index]);
            files.splice(index, 1);
            this.writeValue(files);
        }
    }
    /**
     * On drag over event handler.
     * Adds a ripple effect on the button.
     */
    onDragOver(button) {
        button.ripple.launch({ centered: true, persistent: true });
    }
    /**
     * On drag leave event handler.
     * Fades the ripple effect of the button.
     */
    onDragLeave(button) {
        button.ripple.fadeOutAll();
    }
    /**
     * On adds a link.
     */
    onLink() {
        this.addLink = !this.addLink;
    }
    /**
     * On replace one file event handler.
     * Writes the value.
     * @param fileList
     * @param index
     * @param fileInput
     */
    onReplaceFile(fileList, index, button, fileInput) {
        if (!this.disabled) {
            // Copies the array without reference.
            const files = this.files.slice();
            // Assumes that a single file can be replaced by a single file.
            const inputFile = { file: fileList.item(0) };
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
    }
    /**
     * On select one or more files event handler.
     * Writes the value.
     * @param fileList
     */
    onSelectFile(fileList, button) {
        if (!this.disabled) {
            button.ripple.fadeOutAll();
            // Copies the array without reference.
            const files = this.files.slice();
            Array.from(fileList).forEach(file => {
                const inputFile = { file };
                if (this.fileGuard(files, inputFile)) {
                    files.push(inputFile);
                    this.acceptedFile.emit(inputFile);
                }
            });
            this.writeValue(files);
            this.fileInput.nativeElement.value = '';
        }
    }
    /**
     * On submit the link form event handler.
     */
    onSubmitLink() {
        if (!this.disabled && this.form.valid) {
            const files = this.files.slice();
            const inputFile = { link: this.form.value.link, preview: this.form.value.link };
            files.push(inputFile);
            this.acceptedFile.emit(inputFile);
            this.onLink();
            this.form.reset();
            this.writeValue(files);
        }
    }
    /**
     * Implementation of ControlValueAccessor.
     * @param fn
     */
    registerOnChange(fn) {
        this.onChange = fn;
    }
    /**
     * Implementation of ControlValueAccessor.
     * @param fn
     */
    registerOnTouched(fn) {
        this.onTouched = fn;
    }
    /**
     * Implementation of ControlValueAccessor.
     * @param isDisabled
     */
    setDisabledState(isDisabled) {
        this.disabled = isDisabled;
    }
    /**
     * Implementation of ControlValueAccessor.
     * @param files
     */
    writeValue(files) {
        if (!files) {
            files = new Array();
        }
        this.files = files;
        this.setFilePreview();
        this.onChange(this.files);
    }
    /**
     * Whether the file can be added to the model.
     * @param files
     * @param file,
     * @param bypassLimit
     */
    fileGuard(files, file, bypassLimit) {
        if (!bypassLimit && !this.inputFileService.limitGuard(files, this.fileLimit)) {
            this.rejectedFile.emit({ reason: InputFileRejectedReason.limitReached, file });
            return false;
        }
        if (!this.inputFileService.sizeGuard(file.file, this.sizeLimit)) {
            this.rejectedFile.emit({ reason: InputFileRejectedReason.sizeReached, file });
            return false;
        }
        if (!this.inputFileService.typeGuard(file.file, this.fileAccept)) {
            this.rejectedFile.emit({ reason: InputFileRejectedReason.badFile, file });
            return false;
        }
        return true;
    }
    /**
     * Sets the file preview with FileReader.
     */
    setFilePreview() {
        for (const index in this.files) {
            if (this.files[index].file != null && this.inputFileService.typeGuard(this.files[index].file, 'image/*')) {
                const fr = new FileReader();
                fr.onload = () => {
                    this.files[index].preview = fr.result;
                };
                fr.readAsDataURL(this.files[index].file);
            }
        }
    }
    /**
     * Sets the reactive form to insert a link.
     */
    setForm() {
        this.form = this.formBuilder.group({
            link: ['', [Validators.required, urlValidator]]
        });
    }
}
InputFileComponent.nextId = 0;
InputFileComponent.decorators = [
    { type: Component, args: [{
                selector: 'input-file',
                template: "<div class=\"input-file-container\">\n    <label class=\"mat-orphan-label\" [for]=\"id\" [class.active]=\"files?.length\" [innerHtml]=\"placeholder\" *ngIf=\"placeholder\"></label>\n    <div class=\"files-container\">\n\n        <ng-container *ngFor=\"let file of files; let i = index\">\n            <div class=\"file-container\" [ngClass]=\"classAnimation\">\n                <ng-container *ngTemplateOutlet=\"fileTemplate; context: { $implicit: file, index: i }\"></ng-container>\n            </div>\n        </ng-container>\n\n        <ng-container *ngIf=\"canAddFile\">\n            <div class=\"file-container\">\n                <ng-container *ngIf=\"!addLink; else linkTemplate\">\n                    <ng-container *ngTemplateOutlet=\"addTemplate\"></ng-container>\n                </ng-container>\n            </div>\n        </ng-container>\n    </div>\n\n</div>\n\n<ng-template #addTemplate>\n    <button mat-button inputFileDropZone class=\"file-button\" type=\"button\" (click)=\"fileInput.click()\" (itemDrop)=\"onSelectFile($event, selectButton)\"\n        (itemDragOver)=\"onDragOver(selectButton)\" (itemDragLeave)=\"onDragLeave(selectButton)\" [disabled]=\"disabled\" #selectButton>\n        <mat-icon class=\"input-icon\">{{ iconAdd }}</mat-icon>\n    </button>\n    <button mat-button class=\"secondary-button\" type=\"button\" [disabled]=\"disabled\" (click)=\"onLink()\" *ngIf=\"linkEnabled\">\n        <mat-icon>{{ iconLink }}</mat-icon>\n    </button>\n    <input [id]=\"id\" [accept]=\"fileAccept\" hidden type=\"file\" [attr.multiple]=\"fileLimit > 1 ? true : null\" #fileInput (change)=\"onSelectFile($event.target.files, selectButton)\">\n</ng-template>\n\n<ng-template #fileTemplate let-file let-index=\"index\">\n    <img class=\"image-preview\" [src]=\"file.preview\" *ngIf=\"file.preview\">\n    <button mat-button inputFileDropZone class=\"replace-button\" type=\"button\" (click)=\"fileReplace.click()\" (itemDrop)=\"onReplaceFile($event, index, replaceButton)\"\n        [disabled]=\"disabled\" (itemDragOver)=\"onDragOver(replaceButton)\" (itemDragLeave)=\"onDragLeave(replaceButton)\" #replaceButton>\n        <ng-container *ngIf=\"!file.preview\">\n            <mat-icon class=\"input-icon\">{{ iconFile }}</mat-icon>\n            <div class=\"file-name text-truncate\" [innerHtml]=\"file.file.name\" *ngIf=\"file.file\"></div>\n        </ng-container>\n    </button>\n    <button mat-button class=\"secondary-button\" type=\"button\" (click)=\"onDeleteFile(index)\" [disabled]=\"disabled\">\n        <mat-icon>{{ iconDelete }}</mat-icon>\n    </button>\n    <input [accept]=\"fileAccept\" hidden type=\"file\" #fileReplace (change)=\"onReplaceFile($event.target.files, index, replaceButton, fileReplace)\">\n</ng-template>\n\n<ng-template #linkTemplate>\n    <form class=\"form-link slide-in-up\" [formGroup]=\"form\" (ngSubmit)=\"onSubmitLink()\" novalidate>\n        <mat-form-field class=\"input-link\">\n            <input matInput formControlName=\"link\" [placeholder]=\"placeholderLink\">\n        </mat-form-field>\n        <div class=\"form-link-button\">\n            <button mat-button type=\"button\" (click)=\"onLink()\" [disabled]=\"disabled\">\n                <mat-icon>arrow_back</mat-icon>\n            </button>\n            <button mat-button type=\"submit\" [disabled]=\"disabled\">\n                <mat-icon>check</mat-icon>\n            </button>\n        </div>\n    </form>\n</ng-template>",
                providers: [
                    {
                        provide: NG_VALUE_ACCESSOR,
                        useExisting: forwardRef(() => InputFileComponent),
                        multi: true
                    }
                ],
                styles: [".input-file-container{position:relative}.input-file-container .files-container{display:flex;flex-direction:row;flex-wrap:wrap;padding-top:1.25rem}.input-file-container .file-button,.input-file-container .file-container{align-items:center;display:flex;height:10rem;justify-content:center;width:10rem}.input-file-container .secondary-button{width:10rem}.input-file-container .file-button{flex:1}.input-file-container .file-container{flex-direction:column;margin-right:1rem;overflow:hidden}.input-file-container .replace-button{flex:1;width:10rem}.input-file-container .mat-button:focus{outline:0}.input-file-container .file-name{width:7.5rem}.input-file-container .image-preview{-o-object-fit:contain;height:10rem;object-fit:contain;position:absolute;width:10rem}.input-file-container .input-icon{font-size:2.5rem;height:2.5rem;width:2.5rem}.input-file-container .form-link{display:flex;flex-direction:column;width:10rem}.input-file-container .input-link{width:10rem}.input-file-container .form-link-button{display:flex;flex-direction:row}.input-file-container .form-link-button .mat-button{min-width:5rem;width:5rem}.input-file-container .mat-orphan-label{color:rgba(0,0,0,.54);display:block;font-size:1rem;left:0;margin:0;position:absolute;top:0;transform-origin:0;transition:.4s cubic-bezier(.25,.8,.25,1),width .4s cubic-bezier(.25,.8,.25,1)}.input-file-container .mat-orphan-label.active{transform:scale(.75)}@-webkit-keyframes bounceIn{0%,20%,40%,60%,80%,to{-webkit-animation-timing-function:cubic-bezier(.215,.61,.355,1);animation-timing-function:cubic-bezier(.215,.61,.355,1)}0%{opacity:0;transform:scale3d(.3,.3,.3)}20%{transform:scale3d(1.1,1.1,1.1)}40%{transform:scale3d(.9,.9,.9)}60%{opacity:1;transform:scale3d(1.03,1.03,1.03)}80%{transform:scale3d(.97,.97,.97)}to{opacity:1;transform:scaleX(1)}}@keyframes bounceIn{0%,20%,40%,60%,80%,to{-webkit-animation-timing-function:cubic-bezier(.215,.61,.355,1);animation-timing-function:cubic-bezier(.215,.61,.355,1)}0%{opacity:0;transform:scale3d(.3,.3,.3)}20%{transform:scale3d(1.1,1.1,1.1)}40%{transform:scale3d(.9,.9,.9)}60%{opacity:1;transform:scale3d(1.03,1.03,1.03)}80%{transform:scale3d(.97,.97,.97)}to{opacity:1;transform:scaleX(1)}}.bounce-in{-webkit-animation-duration:.75s;-webkit-animation-name:bounceIn;animation-duration:.75s;animation-name:bounceIn}@-webkit-keyframes slideInUp{0%{opacity:0;transform:translate3d(0,100%,0)}to{opacity:1;transform:translateZ(0)}}@keyframes slideInUp{0%{opacity:0;transform:translate3d(0,100%,0)}to{opacity:1;transform:translateZ(0)}}.slide-in-up{-webkit-animation-duration:.25s;-webkit-animation-name:slideInUp;animation-duration:.25s;animation-name:slideInUp}"]
            },] }
];
InputFileComponent.ctorParameters = () => [
    { type: FormBuilder },
    { type: InputFileService }
];
InputFileComponent.propDecorators = {
    disabled: [{ type: Input }],
    placeholder: [{ type: Input }],
    classAnimation: [{ type: Input }],
    fileAccept: [{ type: Input }],
    fileLimit: [{ type: Input }],
    iconAdd: [{ type: Input }],
    iconDelete: [{ type: Input }],
    iconFile: [{ type: Input }],
    iconLink: [{ type: Input }],
    linkEnabled: [{ type: Input }],
    placeholderLink: [{ type: Input }],
    sizeLimit: [{ type: Input }],
    acceptedFile: [{ type: Output }],
    deletedFile: [{ type: Output }],
    rejectedFile: [{ type: Output }],
    fileInput: [{ type: ViewChild, args: ['fileInput', { static: false },] }]
};

class DropZoneDirective {
    constructor() {
        this.disabled = false;
        this.itemDragOver = new EventEmitter();
        this.itemDragLeave = new EventEmitter();
        this.itemDrop = new EventEmitter();
        // Prevent dragleave on children, could be better but it's cheap for better performance
        this.whiteListClasses = ['file-button', 'mat-button-wrapper', 'input-icon'];
    }
    /**
     * Drag Over event handler.
     * @param event
     */
    onDragOver(event) {
        this.preventAndStopEventPropagation(event);
        if (!this.isOver && !this.disabled) {
            this.isOver = true;
            this.itemDragOver.emit();
        }
    }
    /**
     * Drag Leave event handler.
     * @param event
     */
    onDragLeave(event) {
        this.preventAndStopEventPropagation(event);
        if (this.isOver && this.isTrueLeave(event) && !this.disabled) {
            this.isOver = false;
            this.itemDragLeave.emit();
        }
    }
    /**
     * Drop event handler.
     * @param event
     */
    onDrop(event) {
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
    }
    /**
     * Prevents and stops event propagration.
     * @param event
     */
    preventAndStopEventPropagation(event) {
        event.preventDefault();
        event.stopPropagation();
    }
    /**
     * Checks if the leave is not trigger by a children.
     * @param event
     */
    isTrueLeave(event) {
        for (const c of this.whiteListClasses) {
            if (event.fromElement != null && event.fromElement.className.indexOf(c) >= 0) {
                return false;
            }
        }
        return true;
    }
}
DropZoneDirective.decorators = [
    { type: Directive, args: [{
                selector: '[inputFileDropZone]'
            },] }
];
DropZoneDirective.propDecorators = {
    disabled: [{ type: Input }],
    itemDragOver: [{ type: Output }],
    itemDragLeave: [{ type: Output }],
    itemDrop: [{ type: Output }],
    onDragOver: [{ type: HostListener, args: ['dragover', ['$event'],] }],
    onDragLeave: [{ type: HostListener, args: ['dragleave', ['$event'],] }],
    onDrop: [{ type: HostListener, args: ['drop', ['$event'],] }]
};

class InputFileModule {
    static forRoot(config) {
        return {
            ngModule: InputFileModule,
            providers: [
                InputFileService,
                { provide: 'config', useValue: config }
            ]
        };
    }
}
InputFileModule.decorators = [
    { type: NgModule, args: [{
                declarations: [
                    DropZoneDirective,
                    InputFileComponent
                ],
                imports: [
                    CommonModule,
                    FormsModule,
                    MatButtonModule,
                    MatFormFieldModule,
                    MatIconModule,
                    MatInputModule,
                    ReactiveFormsModule
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

export { InputFileComponent, InputFileModule, InputFileService, DropZoneDirective as ɵa };
//# sourceMappingURL=ngx-input-file.js.map

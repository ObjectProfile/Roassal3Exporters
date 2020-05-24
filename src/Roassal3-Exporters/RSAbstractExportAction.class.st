"
I put menu items in the inspector, in order to use some exporters of this package
"
Class {
	#name : #RSAbstractExportAction,
	#superclass : #RSAbstractAction,
	#instVars : [
		'exporter'
	],
	#classVars : [
		'lastPath'
	],
	#category : #'Roassal3-Exporters-Actions'
}

{ #category : #accessing }
RSAbstractExportAction class >> lastPath [
	^ lastPath ifNil: [ lastPath := FileLocator workingDirectory ].
]

{ #category : #accessing }
RSAbstractExportAction class >> lastPath: aString [
	"
	lastPath := nil
	"
	lastPath := aString
]

{ #category : #hooks }
RSAbstractExportAction >> defaultExporter [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractExportAction >> execute [
	| fileName path |
	path := RSAbstractExportAction lastPath.
	path isFile ifTrue: [
		(path pathString endsWith: exporter extension) ifFalse: [ 
			path := path pathString.
			path := path copyFrom: 1 to: path size - exporter extension size - 1 ] ].
	fileName := UITheme builder 
		chooseForSaveFileReference: 'Enter the ', exporter extension asUppercase, ' file name'
		extensions: { exporter extension }
		path: path.
	self exportToFile: fileName.

]

{ #category : #hooks }
RSAbstractExportAction >> exportToFile: fileName [
	fileName ifNil: [ ^ self ].
	self exporter
		canvas: self roassalCanvas;
		fileName: fileName pathString;
		export.
	RSAbstractExportAction lastPath: fileName.
	self inform: 'Done!!!'
]

{ #category : #hooks }
RSAbstractExportAction >> exporter [
	^ exporter ifNil: [ exporter := self defaultExporter ]
]

{ #category : #hooks }
RSAbstractExportAction >> title [
	^ 'Export to ', self exporter extension
]

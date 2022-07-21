"
I am an interactive exporter you can use my code like this:
```st
canvas @ RSInteractiveExporter
```
Then when you right click in the canvas a popup menu will appear to select the exporter format and the file location
"
Class {
	#name : #RSInteractiveExporter,
	#superclass : #RSInteraction,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Exporters-Interaction'
}

{ #category : #hooks }
RSInteractiveExporter >> addItemsIn: aMenuMorph [
	aMenuMorph
		add: 'Export as ...'
		target: self
		selector: #exportAs
		iconName: #smallPaint
]

{ #category : #hooks }
RSInteractiveExporter >> canvas [
	^ canvas
]

{ #category : #hooks }
RSInteractiveExporter >> createMenuFor: evt [
	| menu |
	menu := MenuMorph new.
	canvas := evt canvas.
	self addItemsIn: menu.
	^ menu.
]

{ #category : #hooks }
RSInteractiveExporter >> exportAs [
	| reference |
	reference := UIManager default
		chooseForSaveFileReference: 'Export canvas as PNG, SVG or PDF'
		extensions: #('png' 'svg' 'pdf' ) 
		path: 'file.png'.

	reference ifNotNil: [ self exportAs: reference. ]
]

{ #category : #hooks }
RSInteractiveExporter >> exportAs: reference [
	| exporterClass file extension |
	extension := reference extension.
	exporterClass := self exporterClassBy: extension.
	file := reference.
	exporterClass ifNil: [ 
		exporterClass := RSPNGExporter.
		file := reference parent / (reference basenameWithoutExtension: reference extension), '.png' ].
	exporterClass new
		canvas: self canvas;
		exportToFile: file.
	self inform: 'File: ', file pathString, ' created!'
]

{ #category : #hooks }
RSInteractiveExporter >> exporterClassBy: extension [
	| string |
	string := extension asLowercase.
	string = 'svg'
		ifTrue: [ ^ RSSVGCairoExporter ].
	^ (RSRoassalExporter withAllSubclasses
		reject: [ :cls | cls hasAbstractMethods ])
		detect: [ :cls | cls extension = extension ] 
		ifNone: [ nil ]
]

{ #category : #hooks }
RSInteractiveExporter >> onShape: aCanvas [
	self assert: aCanvas isShape not description: 'You can only add this interaction in a canvas'.
	aCanvas when: RSMouseRightClick send: #openMenu: to: self.
]

{ #category : #hooks }
RSInteractiveExporter >> openMenu: evt [
	| menu |
	menu := self createMenuFor: evt.
	menu popUpInWorld
]

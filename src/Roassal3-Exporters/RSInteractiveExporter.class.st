"
I am an interactive exporter you can use my code like this:
```st
canvas @ RSInteractiveExporter
```
Then when you right click in the canvas a popup menu will appear to select the exporter format and the file location
"
Class {
	#name : #RSInteractiveExporter,
	#superclass : #RSInspectorToolbar,
	#category : #'Roassal3-Exporters-Interaction'
}

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

{ #category : #testing }
RSInteractiveExporter >> exportIcon [
	| c svg |
	c := RSCanvas new.
	c color: Color transparent.
	svg := RSSVGPath new 
		color: Color black;
		svgPath: self exportIconSVG.
	c add: svg.
	c extent: 16 asPoint.
	c zoomToFit.
	^ c asForm
]

{ #category : #testing }
RSInteractiveExporter >> exportIconSVG [
	^ 'M797,632.3v100.1c0,44.2-15.7,82.2-47.5,113.5c-31.3,31.9-69.4,47.6-113.5,47.6H171.1c-44.2,0-82.2-15.7-114.1-47.6c-31.3-31.3-47-69.4-47-113.5V267.6c0-44.2,15.7-82.2,47-113.5c31.9-31.9,69.9-47.5,114.1-47.5h393.8c9.5,0,17.3,7.3,17.3,17.9v35.8c0,10.6-7.8,17.9-17.3,17.9H171.1c-24.6,0-45.9,9-63.2,26.3c-17.3,17.3-26.3,38.6-26.3,63.2v464.8c0,24.6,9,45.9,26.3,63.2c17.3,17.3,38.6,26.3,63.2,26.3h464.8c24.6,0,45.9-9,63.2-26.3c17.3-17.3,26.3-38.6,26.3-63.2V632.3c0-10.6,7.3-17.3,17.9-17.3h35.8C789.7,614.9,797,621.7,797,632.3L797,632.3z M983.3,350.4L800.4,532.7c-14.5,15.7-38,3.4-38-15.7v-91.2h-80.5c-23.5,0-54.3,1.1-92.9,2.8c-38.6,1.7-76.6,8.4-114.7,19.6c-37.5,11.2-67.7,24-90.6,38.6c-22.4,14.5-38,29.1-47.5,43.6c-9,14-16.8,33-24.1,56.5c-7.3,23.5-10.6,47-10.6,71c0,12.9,0.6,28,1.7,44.2c0,2.8,1.7,13.4,1.7,17.9c0,6.7-4.5,12.3-11.2,12.3c-4.5,0-7.8-2.2-10.1-6.2c-3.9-5-10.1-20.7-13.4-26.8c-30.2-67.7-39.7-137-28-207.5c6.2-48.7,31.3-95.7,76.1-140.4C390.9,279.3,512.3,243,681.8,243h80.5v-91.7c0-19.6,23.5-30.8,38-16.2l182.9,182.9C992.2,327.4,992.2,341.4,983.3,350.4z'
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
RSInteractiveExporter >> newButton [
	^ SpButtonPresenter new
		icon: self exportIcon;
		action: [ self exportAs ];
		help: 'Export to...'
		yourself
]

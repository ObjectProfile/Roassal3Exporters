Class {
	#name : #RSExporterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'exporterClass'
	],
	#category : #'Roassal3-Exporters-Tests'
}

{ #category : #'building suites' }
RSExporterTest class >> testParameters [
	| m classesToConsider |
	m := ParametrizedTestMatrix new.
	classesToConsider := RSRoassalExporter allSubclasses 
		reject: [ :c | c hasAbstractMethods ].
	classesToConsider do: [ :cls | m addCase: {(#exporterClass -> cls)} ].
	^ m
]

{ #category : #accessing }
RSExporterTest >> exporterClass [
	^ exporterClass
]

{ #category : #accessing }
RSExporterTest >> exporterClass: aClass [
	exporterClass := aClass
]

{ #category : #tests }
RSExporterTest >> sample [
	| c menMeans womenMeans lb |
	c := RSChart new.
	c extent: 300@200.
	menMeans := #(20 35 30 35 27).
	womenMeans := #(25 32 34 20 25).
	c barHeights: menMeans.
	(c barHeights: womenMeans)
		bottom: menMeans.
	c addDecoration: (RSHorizontalTick new fromNames: #(Day1 Day2 Day3 Day4 Day5)).
	c addDecoration: (RSVerticalTick new integer).
	c ylabel: 'Scores'.
	c title: 'Scores by group of gender'.
	c build.
	lb := RSLegend new.
	lb layout horizontal.
	#(Men Women) doWithIndex: [ :lbl :index | 
		lb text: lbl withBoxColor: (c plots at:index) computeColor ].
	lb container: c canvas.
	lb build.
	^ c canvas
]

{ #category : #tests }
RSExporterTest >> testExport01 [
	| canvas file exporter |
	canvas := RSCanvas new.
	canvas addShape: (RSLabel new
		text: 'foo';
		isFixed: true;
		yourself).
	exporter := self exporterClass new.
	self assert: exporter cameraSetter class equals: RSCamSetter.
	
	exporter
		canvas: canvas;
		noFixedShapes;
		zoomToShapes.
	self assert: exporter cameraSetter class equals: RSZoomToShapesSetter.
	file := exporter export.
	self assert: file isString.
	file := file asFileReference.
	self assert: file exists.
	file delete.
]

{ #category : #tests }
RSExporterTest >> testExport1080p [
	| exporter canvas |
	exporter := self exporterClass new.
	canvas := self sample.
	canvas extent: 1920@1080.
	exporter
		canvas: canvas;
		noFixedShapes;
		zoomToShapes.
]

{ #category : #tests }
RSExporterTest >> testExportError [
	self should: [ self exporterClass new export ] raise: Error
]

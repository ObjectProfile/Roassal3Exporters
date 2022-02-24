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
	file delete
]

{ #category : #tests }
RSExporterTest >> testExportError [
	self should: [ self exporterClass new export ] raise: Error
]

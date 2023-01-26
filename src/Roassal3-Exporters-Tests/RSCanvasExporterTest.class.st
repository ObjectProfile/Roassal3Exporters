Class {
	#name : #RSCanvasExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas',
		'file'
	],
	#category : #'Roassal3-Exporters-Tests'
}

{ #category : #running }
RSCanvasExporterTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #running }
RSCanvasExporterTest >> tearDown [
	file isString ifTrue: [ ^ self ].
	file ifNotNil: [ file delete ].
	file := nil.
	super tearDown
]

{ #category : #tests }
RSCanvasExporterTest >> testBasicPDF01 [
	file := canvas exportToPDF.
	self assert: file isString.
	self assert: (file endsWith: '.pdf').
	file := file asFileReference.
	self assert: file exists.
]

{ #category : #tests }
RSCanvasExporterTest >> testBasicPDF02 [
	file := canvas pdfExporter
		fileName: 'foo';
		export.
	self assert: file isString.
	self assert: (file endsWith: '.pdf').
	file := file asFileReference.
	self assert: file exists.
]

{ #category : #tests }
RSCanvasExporterTest >> testBasicPDF03 [
	file := canvas pdfExporter
		fileName: 'foo.pdf';
		export.
	self assert: file isString.
	self assert: (file endsWith: 'foo.pdf').
	file := file asFileReference.
	self assert: file exists.
]

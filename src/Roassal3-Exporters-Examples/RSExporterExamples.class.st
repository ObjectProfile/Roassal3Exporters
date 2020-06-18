"
I have examples
"
Class {
	#name : #RSExporterExamples,
	#superclass : #Object,
	#category : #'Roassal3-Exporters-Examples'
}

{ #category : #accessing }
RSExporterExamples >> canvas [
	| chart |
	chart := RSChartExample new example11BarplotCombinedWithLine.
	chart build.
	^ chart canvas
]

{ #category : #examples }
RSExporterExamples >> example01PDFExport [
	"should produce a pdf with resolution 500x500"
	<script: 'self new example01PDFExport'>
	self openFile: self canvas exportToPDF asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example02PDFExport [
	"should produce a pdf with resolution 500x500
	and no fixed shapes"
	<script: 'self new example02PDFExport'>
	self openFile: (self canvas pdfExporter
		noFixedShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example03PDFExport [
	"should produce a pdf with resolution 247@247"
	<script: 'self new example03PDFExport'>
	self openFile: (self canvas pdfExporter
		zoomToShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example04SVGExport [
	"should produce an svg with resolution 500x500"
	<script: 'self new example04SVGExport'>
	self openFile: self canvas exportToSVG asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example05SVGExport [
	"should produce an svg with resolution 500x500
	and no fixed shapes"
	<script: 'self new example05SVGExport'>
	self openFile: (self canvas svgExporter
		noFixedShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example06SVGExport [
	"should produce a pdf with resolution 247@247"
	<script: 'self new example06PDFExport'>
	self openFile: (self canvas svgExporter
		zoomToShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example07PNGExport [
	"should produce a png with resolution 500x500"
	<script: 'self new example07PNGExport'>
	self openFile: self canvas exportToPNG asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example08PNGExport [
	"should produce a png with resolution 500x500
	and no fixed shapes"
	<script: 'self new example08PNGExport'>
	self openFile: (self canvas pngExporter
		noFixedShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example09PNGExport [
	"should produce a png with resolution 247@247"
	<script: 'self new example09PNGExport'>
	self openFile: (self canvas pngExporter
		zoomToShapes;
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #examples }
RSExporterExamples >> example11PDFExport [
	"should produce a pdf with resolution 8.26 inches@ 11.69 inches"
	<script: 'self new example11PDFExport'>
	| c lbls |
	c := RSCanvas new.

	lbls := RSGroup new.
	Collection withAllSubclassesDo: [ :cls | | lbl |
	    lbl := RSLabel new text: cls name; model: cls.
	    lbls add: lbl ].
	c addAll: lbls.

	RSNormalizer fontSize
	    shapes: lbls;
	    normalize: #numberOfMethods.
	c @ RSCanvasController.
	c @ RSHierarchyPacker.
	"c extent: RSPageExtent letter.
	c extent: RSPageExtent a4."
	c extent: (RSPageExtent from: 8.26 inches@ 11.69 inches).
	
	self openFile: (c pdfExporter
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #opening }
RSExporterExamples >> openFile: aFileReference [ 
	| inspector window |
	inspector := GTInspector new.
	window := inspector openOn: aFileReference parent.
	window when: WindowClosed do: [ aFileReference delete ].
	self inform: 'File will be deleted when you close the inspector'.
	
]

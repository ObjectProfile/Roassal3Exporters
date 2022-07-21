"
I represent the exporter of Roassal3 shapes using AthensCairoPDFSurface
"
Class {
	#name : #RSPDFCairoExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #accessing }
RSPDFCairoExporter class >> extension [
	^ 'pdf'
]

{ #category : #public }
RSPDFCairoExporter >> cairoSurfaceClass [ 
	^ AthensCairoPDFSurface
]

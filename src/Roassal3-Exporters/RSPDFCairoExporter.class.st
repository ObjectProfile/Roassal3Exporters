"
TODO
"
Class {
	#name : #RSPDFCairoExporter,
	#superclass : #RSCairoExporter,
	#category : #'Roassal3-Exporters-Core'
}

{ #category : #public }
RSPDFCairoExporter >> cairoSurfaceClass [ 
	^ AthensCairoPDFSurface
]

{ #category : #accessing }
RSPDFCairoExporter >> extension [
	^ 'pdf'
]
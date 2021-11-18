Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> exportToPDF [
	^ self pdfExporter export
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> exportToPNG [
	^ self pngExporter export
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> exportToSVG [
	^ self svgExporter export
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> exportToSVGCairo [
	^ self svgCairoExporter export
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> pdfExporter [
	^ RSPDFCairoExporter new
		canvas: self;
		yourself
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> pngExporter [
	^ RSPNGExporter new
		canvas: self;
		yourself
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> svgCairoExporter [
	^ RSSVGCairoExporter new
		canvas: self;
		yourself
]

{ #category : #'*Roassal3-Exporters' }
RSCanvas >> svgExporter [
	^ RSSVGExporter new
		canvas: self;
		yourself
]

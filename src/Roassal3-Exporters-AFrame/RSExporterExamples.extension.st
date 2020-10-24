Extension { #name : #RSExporterExamples }

{ #category : #'*Roassal3-Exporters-AFrame' }
RSExporterExamples >> example12AFrameExport [
	"This example uses AFrame to build a 3d basic scene in a webbrowser"
	<script: 'self new example12AFrameExport'>
	| c p x y |

	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSBarPlot new x: x y: y.
	self flag: 'TODO'.
	c addPlot: p.
	c xlabel: 'X Axis'.
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c ylabel: 'Y Axis'.
	c title: 'Histogram'.
	c build.
	self openFile: (self canvas aFrameExporter
		fileName: 'test';
		export) asFileReference
	
]

{ #category : #'*Roassal3-Exporters-AFrame' }
RSExporterExamples >> example13AFrameExport [
	"This example uses AFrame to build a 3d basic scene in a webbrowser"
	<script: 'self new example13AFrameExport'>
	| m |
	m := RSMondrian new.
	m shape label height: 30.
	m nodes: Collection withAllSubclasses.
	m line connectFrom: #superclass.

	m normalizeSize: #numberOfMethods.
	m normalizeColor: #numberOfLinesOfCode.

	m layout tree.
	m build.

	m canvas aFrameExporter
	
		noFloor;
			fileName: '/tmp/foo';
			export
]

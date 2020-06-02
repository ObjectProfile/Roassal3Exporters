# Roassal3Exporter
Exporters for [Roassal3](https://github.com/ObjectProfile/Roassal3) and Pharo 9


Execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3Exporters';
    repository: 'github://ObjectProfile/Roassal3Exporters';
    load.
``` 


# Example of usage:
```Smalltalk
classes := Collection withAllSubclasses.

c := RSCanvas new.
shapes := classes collect: [ :cls |
	RSBox new model: cls; 
		height: (cls numberOfMethods max: 5);
		width: (cls instVarNames size * 4 max: 5); 
		@ RSPopup;
		@ RSDraggable  ].
	
c addAll: shapes.

eb := RSEdgeBuilder orthoVertical.
eb withVerticalAttachPoint.
eb canvas: c.
eb connectFrom: #superclass.

RSTreeLayout on: shapes.
c @ RSCanvasController.

(c shapes shapeFromModel: Collection) @ (RSLabeled new text:'Über, genießen').

RSPDFExporter new
		canvas: c;
		exportToFile: '/tmp/foo.pdf' asFileReference

```        

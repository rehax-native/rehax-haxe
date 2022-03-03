package rehax.components.vector;

#if js
typedef VectorContainer = rehax.components.vector.web.VectorContainer.VectorContainer;
typedef VectorCircle = rehax.components.vector.web.VectorCircle.VectorCircle;
typedef VectorPath = rehax.components.vector.web.VectorPath.VectorPath;
#elseif cpp
typedef VectorContainer = rehax.components.vector.cpp.VectorContainer.VectorContainer;
typedef VectorCircle = rehax.components.vector.cpp.VectorCircle.VectorCircle;
typedef VectorPath = rehax.components.vector.cpp.VectorPath.VectorPath;
#end
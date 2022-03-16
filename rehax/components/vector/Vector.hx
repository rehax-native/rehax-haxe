package rehax.components.vector;

#if js
typedef VectorContainer = rehax.components.vector.web.VectorContainer.VectorContainer;
typedef VectorCircle = rehax.components.vector.web.VectorCircle.VectorCircle;
typedef VectorPath = rehax.components.vector.web.VectorPath.VectorPath;
typedef VectorLinearGradient = rehax.components.vector.web.VectorLinearGradient.VectorLinearGradient;
typedef VectorRadialGradient = rehax.components.vector.web.VectorRadialGradient.VectorRadialGradient;
#elseif cpp
typedef VectorContainer = rehax.components.vector.cpp.VectorContainer.VectorContainer;
typedef VectorCircle = rehax.components.vector.cpp.VectorCircle.VectorCircle;
typedef VectorPath = rehax.components.vector.cpp.VectorPath.VectorPath;
typedef VectorLinearGradient = rehax.components.vector.cpp.VectorLinearGradient.VectorLinearGradient;
typedef VectorRadialGradient = rehax.components.vector.cpp.VectorRadialGradient.VectorRadialGradient;
#end
// Simple Lambertian lighting
// Mario Gonzalez
//
// Based on 'WebGL - A Beginners Guide'

// attribute vec3 aVertexPosition;
// attribute vec3 aVertexNormal;
//
// uniform vec3 rotation;
// uniform mat4 uMVMatrix;
// uniform mat4 uPMatrix;
// uniform mat4 uNMatrix;
//
// varying vec3 vNormal;
// varying vec4 vPosition;
// varying vec3 vEyeVec;

varying vec4 v_position;

attribute vec3 a_position;
attribute vec3 a_normal;

uniform vec3 rotation;
uniform mat4 u_modelViewProjectionMatrix;
uniform mat4 u_projectionMatrix;
uniform mat4 u_normalMatrix;

varying vec3 v_normal;
varying vec3 u_camera;
 
mat4 rotationX( in float angle ) {
	return mat4(	1.0,		0,			0,			0,
			 		0, 	cos(angle),	-sin(angle),		0,
					0, 	sin(angle),	 cos(angle),		0,
					0, 			0,			  0, 		1);
}

mat4 rotationY( in float angle ) {
	return mat4(	cos(angle),		0,		sin(angle),	0,
			 				0,		1.0,			 0,	0,
					-sin(angle),	0,		cos(angle),	0,
							0, 		0,				0,	1);
}

mat4 rotationZ( in float angle ) {
	return mat4(	cos(angle),		-sin(angle),	0,	0,
			 		sin(angle),		cos(angle),		0,	0,
							0,				0,		1,	0,
							0,				0,		0,	1);
}

void main( void ) {
	vec4 vertex = vec4(gl_Vertex.xyz, 1.0);

	vertex = vertex * rotationX(rotation.x) * rotationY(rotation.y) * rotationZ(rotation.z);
	vertex = u_modelViewProjectionMatrix * vertex;
	v_normal = vec3( u_normalMatrix * vec4( gl_Normal, 1.0 ) );
	u_camera = -vec3( vertex.xyz );
	
	// * rotationX(uTimer*5.0)
	gl_Position = u_projectionMatrix * vertex;
	v_position = gl_Position;
}

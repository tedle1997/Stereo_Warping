#version 460 core
// Preprocess Geometry Shader
layout (points) in;
layout(points, max_vertices = 24) out;

uniform sampler2D maxTexture;
uniform sampler2D minTexture;

uniform int level_uniform;
uniform int num_level;
uniform int grid_size;
uniform int lod;

in vec4 v_value[];
out int outValue;

float minmax_thresh = 0.5 * pow(0.1,lod);

float minmax_calculation(vec4 position, int level) {
    return abs(textureLod(maxTexture, (position.xy) * 0.5 + vec2(0.5, 0.5), level).x
        - textureLod(minTexture, (position.xy) * 0.5 + vec2(0.5, 0.5), level).x);
}

void processVertex(vec4 position){
    
    float minmax_diff = minmax_calculation(position, 0);
    
    if(minmax_diff >= minmax_thresh){
        outValue = 0;
    } else { 
        minmax_diff = minmax_calculation(position, 1);
        if (minmax_diff >= minmax_thresh) outValue = 1;
        else {
            minmax_diff = minmax_calculation(position, 2);
            if (minmax_diff >= minmax_thresh) outValue = 2;
            else {
                minmax_diff = minmax_calculation(position, 3);
                if (minmax_diff >= minmax_thresh) outValue = 3;
                else {
                    minmax_diff = minmax_calculation(position, 4);
                    if (minmax_diff >= minmax_thresh) outValue = 4;
                    else {
                        minmax_diff = minmax_calculation(position, 5);
                        if (minmax_diff >= minmax_thresh) outValue = 5;
                    }
                }
            }
        }
    }
}

void main(){
    processVertex(vec4(v_value[0][0], v_value[0][1], v_value[0][2], 1.0));
}

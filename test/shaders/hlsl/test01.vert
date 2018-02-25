cbuffer _14
{
    row_major float4x4 _14_uMVP : packoffset(c0);
};

static float4 gl_Position;
static float4 position;
static float3 vNormal;
static float3 normal;

struct SPIRV_Cross_Input
{
    float4 position : TEXCOORD0;
    float3 normal : TEXCOORD1;
};

struct SPIRV_Cross_Output
{
    float3 vNormal : TEXCOORD0;
    float4 gl_Position : SV_Position;
};

void vert_main()
{
    gl_Position = mul(position, _14_uMVP);
    vNormal = normal;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    position = stage_input.position;
    normal = stage_input.normal;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.vNormal = vNormal;
    return stage_output;
}

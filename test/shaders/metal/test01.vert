#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct params
{
    float4x4 uMVP;
};

struct main0_in
{
    float3 normal [[attribute(1)]];
    float4 position [[attribute(0)]];
};

struct main0_out
{
    float3 vNormal [[user(locn0)]];
    float4 gl_Position [[position]];
};

vertex main0_out main0(main0_in in [[stage_in]], constant params& _14 [[buffer(0)]], uint gl_VertexID [[vertex_id]], uint gl_InstanceID [[instance_id]])
{
    main0_out out = {};
    out.gl_Position = _14.uMVP * in.position;
    out.vNormal = in.normal;
    return out;
}


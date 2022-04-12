Shader "Custom/Demo2" // 名字
{
	Properties
	{

	}
	SubShader
	{
		Pass{
			CGPROGRAM
			//定点着色器函数
			#pragma vertex vert 
			//片元着色器函数
			#pragma fragment frag
			float4 vert(float4 v:POSITION):SV_POSITION{
				return UnityObjectToClipPos(v);
			}
			fixed4 frag():SV_Target{
				return fixed4(0.5,1.0,1.0,1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}

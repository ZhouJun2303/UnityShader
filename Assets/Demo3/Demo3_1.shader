
/**
	漫反射光照 （逐定点计算）
	2022年4月19日14:29:02
*/
Shader "Custom/Demo3_1"
{
	Properties{
		// 漫反射颜色 纯白 （1,1,1,1）
		_Diffuse("Diffuse",Color) = (1,1,1,1)
	}	
	SubShader{
		Pass{
			// 指明光照模式
			Tags{"LightMode" = "ForwardBase"}
			//CG 代码块
			CGPROGRAM
			//定点着色器
			#pragma vertex vert
			//片元着色器
			#pragma fragment frag
			//光照函数库文件
			#include "Lighting.cginc"
			//材质颜色  1
			fixed4 _Diffuse;

			struct a2v{
				float4 vertex :POSITION;
				//定点法线 2
				float3 normal :NORMAL;
			};

			struct v2f{
				float4 pos:SV_POSITION;
				fixed3 color:COLOR;
			};

			v2f vert(a2v v){
				//定义返回值 o
				v2f o;
				//把定点位置从模型空间转换到裁剪空间
				o.pos = UnityObjectToClipPos(v.vertex);
				//获取环境光
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//世界方向
				fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb *saturate(dot(worldNormal,worldLight));
				o.color = ambient + diffuse;
				return o;
			}

			fixed4 frag(v2f i):SV_Target{
				return fixed4(i.color,1.0);
			}
			ENDCG
		}
	}

	FallBack "Diffuse"
}

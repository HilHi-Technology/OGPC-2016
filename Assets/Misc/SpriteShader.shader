﻿Shader "Sprites/GrayScale"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		RepeatX ("Repeat X", Float) = 1
		RepeatY ("Repeat Y", Float) = 1
        _EffectAmount ("Effect Amount", Range (0, 1)) = 1.0
    }
 
    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }
 
        Cull Off
        Lighting Off
        ZWrite Off
        Fog { Mode Off }
        Blend SrcAlpha OneMinusSrcAlpha
 
        Pass
        {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile DUMMY PIXELSNAP_ON
            #include "UnityCG.cginc"
           
            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                half2 texcoord  : TEXCOORD0;
            };
           
            fixed4 _Color;
			half RepeatX;
			half RepeatY;
 
            v2f vert(appdata_t IN)
            {
                v2f OUT;
                OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
                OUT.texcoord = IN.texcoord * half2(RepeatX, RepeatY);
                OUT.color = IN.color * _Color;
                #ifdef PIXELSNAP_ON
                OUT.vertex = UnityPixelSnap (OUT.vertex);
                #endif
 
                return OUT;
            }
 
            sampler2D _MainTex;
            uniform float _EffectAmount;
 
            fixed4 frag(v2f IN) : COLOR
            {
                half4 texcol = tex2D (_MainTex, IN.texcoord);              
                texcol.rgb = lerp(dot(texcol.rgb, float3(0.3, 0.59, 0.11)), texcol.rgb, _EffectAmount);
                texcol = texcol * IN.color;
                return texcol;
            }
        ENDCG
        }
    }
    Fallback "Sprites/Default"
}
﻿using UnityEngine;

public class ZoneEffectScript : MonoBehaviour {
    public float shakeRange;
    public GameObject shade;
    private int colorInt = 0;

    void Start () {
        InvokeRepeating("EffectUpdate", 0, 0.03f);
    }

	// Update is called once per frame
	void EffectUpdate () {
        float x = Random.value * shakeRange;
        float y = Random.value * shakeRange;
        shade.transform.localPosition = new Vector2(x - shakeRange/2, y - shakeRange/2);
        SpriteRenderer shadeSprite = shade.GetComponent<SpriteRenderer>();
        if (shadeSprite.color != Color.white) {
            shadeSprite.color = Color.white;
        } else {
            if (colorInt == 0) {
                shadeSprite.color = Color.red;
                colorInt++;
            }
            else if (colorInt == 1) {
                shadeSprite.color = Color.green;
                colorInt++;
            }
            else if (colorInt == 2) {
                shadeSprite.color = Color.blue;
                colorInt = 0;
            }
        }
	}
}

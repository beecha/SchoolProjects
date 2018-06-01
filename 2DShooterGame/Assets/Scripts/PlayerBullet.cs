﻿using UnityEngine;
using System.Collections;

public class PlayerBullet : MonoBehaviour 
{
    float speed;

	// Use this for initialization
	void Start () 
    {
        speed = 8f;
	}
	
	// Update is called once per frame
	void Update () 
    {
        Vector2 position = transform.position;

        position = new Vector2(position.x, position.y + speed * Time.deltaTime);

        transform.position = position;

        // Upper Right limit of screen
        Vector2 max = Camera.main.ViewportToWorldPoint(new Vector2(1, 1));

        // Destroy bullet when it goes outside the main screen
        if(transform.position.y > max.y)
        {
            Destroy(gameObject);
        }
	}

    void OnTriggerEnter2D(Collider2D col)
    {
        if ((col.tag == "EnemyShipTag"))
            Destroy(gameObject);
    }
}

using UnityEngine;
using System.Collections;

public class EnemyBullet : MonoBehaviour 
{
    float speed;
    Vector2 _direction;
    bool isReady;

    // Default Values
    void Awake()
    {
        speed = 3f;
        isReady = false;
    }

	// Use this for initialization
	void Start () 
    {
	
	}
	
    // Set Bullet Direction
    public void SetDirection(Vector2 direction)
    {
        // Normalize direction
        _direction = direction.normalized;

        isReady = true;
    }

	// Update is called once per frame
	void Update () 
    {
	    if(isReady)
        {
            // Current position of bullet
            Vector2 position = transform.position;

            // Get new position
            position += _direction * speed * Time.deltaTime;

            // Update new position
            transform.position = position;

            // Remove Bullet when going out of frame
            Vector2 min = Camera.main.ViewportToWorldPoint(new Vector2(0, 0));

            Vector2 max = Camera.main.ViewportToWorldPoint(new Vector2(1, 1));

            if ( (transform.position.x < min.x) || (transform.position.x > max.x) ||
                 (transform.position.y < min.y) || (transform.position.y > max.y))
            {
                Destroy(gameObject);
            }
        }
	}

    void OnTriggerEnter2D(Collider2D col)
    {
        if (col.tag == "PlayerShipTag")
            Destroy(gameObject);
    }

}

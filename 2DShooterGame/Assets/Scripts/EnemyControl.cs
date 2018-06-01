using UnityEngine;
using System.Collections;

public class EnemyControl : MonoBehaviour 
{
    GameObject scoreText;

    public GameObject Explosion;

    float speed;

	// Use this for initialization
	void Start () 
    {
        speed = 2f;

        scoreText = GameObject.FindGameObjectWithTag("ScoreTextTag");
	}
	
	// Update is called once per frame
	void Update ()
    {
        // Current Position
        Vector2 position = transform.position;

        // Update DOWN position
        position = new Vector2(position.x, position.y - speed * Time.deltaTime);
        transform.position = position;

        // Bottom-left border
        Vector2 min = Camera.main.ViewportToWorldPoint(new Vector2(0, 0));

        // Destroy object if it goes outside the border
        if(transform.position.y < min.y)
        {
            Destroy(gameObject);
        }
	}

    void OnTriggerEnter2D(Collider2D col)
    {
        if( (col.tag == "PlayerShipTag") || (col.tag == "PlayerBulletTag"))
        {
            PlayExplosion();

            scoreText.GetComponent<GameScore>().Score += 100;

            Destroy(gameObject);
        }
    }


    // Instantiate the explosion
    void PlayExplosion()
    {
        GameObject explosion = (GameObject)Instantiate(Explosion);

        explosion.transform.position = transform.position;
    }

}

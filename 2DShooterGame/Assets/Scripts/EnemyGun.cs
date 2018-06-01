using UnityEngine;
using System.Collections;

public class EnemyGun : MonoBehaviour
{
    public GameObject EnemyBullet;

	// Use this for initialization
	void Start () 
    {
	    // Fire enemy bullet after 1 second
        InvokeRepeating("FireEnemyBullet", 0.3f, 1f);
	}
	
	// Update is called once per frame
	void Update () 
    {
	
	}

    // Function to fire bullet
    void FireEnemyBullet()
    {
        // Get Player's reference
        GameObject playerShip = GameObject.Find("PlayerShip");

        if(playerShip != null) // If player not dead
        {
            GameObject bullet = (GameObject)Instantiate(EnemyBullet);

            // Set bullet's initial position
            bullet.transform.position = transform.position;

            // Compute bullet's direction
            Vector2 direction = playerShip.transform.position - bullet.transform.position;

            // Set bullet's direction
            bullet.GetComponent<EnemyBullet>().SetDirection(direction);
        }
    }
}

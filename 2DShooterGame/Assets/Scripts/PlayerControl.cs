using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class PlayerControl : MonoBehaviour
{
    public GameObject GameManagerGO;
    public GameObject PlayerBullet;
    public GameObject BulletPos1;
    public GameObject BulletPos2;
    public GameObject Explosion;

    // Reference to Lives
    public Text LivesText;

    const int MaxLives = 5;
    int lives;

    public float fireRate;
    private float nextFire;

    public void Init()
    {
        lives = MaxLives;

        LivesText.text = lives.ToString();

        // Starting position of player when play button is pressed
        transform.position = new Vector2(0, -2);

        gameObject.SetActive(true);
    }

	public float speed;
	// Use this for initialization
	void Start ()
	{
	
	}
	
	// Update is called once per frame
	void Update ()
	{
        // Trigger bullet on spacebar or LMB
        if ( (Input.GetKeyDown("space") || Input.GetButton("Fire1")) && (Time.time > nextFire) )
        {
            nextFire = Time.time + fireRate;

            // Play laser sound clip
            GetComponent<AudioSource>().Play();

            GameObject bullet01 = (GameObject)Instantiate(PlayerBullet);
            bullet01.transform.position = BulletPos1.transform.position;

            GameObject bullet02 = (GameObject)Instantiate(PlayerBullet);
            bullet02.transform.position = BulletPos2.transform.position;
        }

		// Values corresponding to Horizontal Movement
		// -1 Left, 0 None, 1 Right
		float x = Input.GetAxisRaw ("Horizontal");
		
		// Values corresponding to Vertical Movement
		// -1 Up, 0 None, 1 Down
		float y = Input.GetAxisRaw ("Vertical");
        


        Vector2 direction = new Vector2(x, y).normalized;

        Move(direction);
	}

    void Move(Vector2 direction)
    {

        Vector2 min = Camera.main.ViewportToWorldPoint(new Vector2(0, 0));
        Vector2 max = Camera.main.ViewportToWorldPoint(new Vector2(1, 1));

        max.x = max.x - 0.225f;
        min.x = min.x + 0.225f;

        max.y = max.y - 0.285f;
        min.y = min.y + 0.285f;

        Vector2 pos = transform.position;

        pos += direction * speed * Time.deltaTime;

        pos.x = Mathf.Clamp(pos.x, min.x, max.x);
        pos.y = Mathf.Clamp(pos.y, min.y, max.y);

        transform.position = pos;
    }

    void OnTriggerEnter2D(Collider2D col)
    {
        // Collision Detection of player with enemy
        if( (col.tag == "EnemyShipTag") || (col.tag == "EnemyBulletTag") )
        {
            PlayExplosion();
            lives--;
            LivesText.text = lives.ToString();

            if(lives == 0)
            {
                GameManagerGO.GetComponent<GameManager>().SetGameManagerState(GameManager.GameManagerState.Gameover);
                //Destroy(gameObject);
                gameObject.SetActive(false);
            }
           // Destroy(gameObject);
        }
    }

    // Instantiate explosion
    void PlayExplosion()
    {
        GameObject explosion = (GameObject)Instantiate(Explosion);

        explosion.transform.position = transform.position;
    }
}
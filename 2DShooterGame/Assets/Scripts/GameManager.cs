using UnityEngine;
using System.Collections;

public class GameManager : MonoBehaviour
{
    // Reference to game objects
    public GameObject playButton;
    public GameObject PlayerShip;
    public GameObject enemySpawner;
    public GameObject GameOver;
    public GameObject scoreText;

    public enum GameManagerState
    {
        Opening, Gameplay, Gameover,
    }

    GameManagerState GMState;

	// Use this for initialization
	void Start () 
    {
        GMState = GameManagerState.Opening;
	}

    // Update Gama Manager
    void UpdateGameManagerState()
    {
        switch (GMState)
        {
            case GameManagerState.Opening:
                // Hide game over
                GameOver.SetActive(false);
                // Set play button visible
                playButton.SetActive(true);

                break;
            case GameManagerState.Gameplay:
                scoreText.GetComponent<GameScore>().Score = 0;
                playButton.SetActive(false); // Hide button
                PlayerShip.GetComponent<PlayerControl>().Init();
                enemySpawner.GetComponent<EnemySpawner>().ScheduleEnemySpawner();
                break;

            case GameManagerState.Gameover:
                // Stop spawner
                enemySpawner.GetComponent<EnemySpawner>().UnscheduleEnemySpawner();
                // Display Game over
                GameOver.SetActive(true);
                // Change game state
                Invoke("ChangeToOpeningState", 8f);
                break;
        }
    }
	
    public void SetGameManagerState(GameManagerState state)
    {
        GMState = state;
        UpdateGameManagerState();
    }

    public void StartGamePlay()
    {
        //Start game when button is clicked
        GMState = GameManagerState.Gameplay;
        UpdateGameManagerState();
    }

    public void ChangeToOpeningState()
    {
        SetGameManagerState(GameManagerState.Opening);
    }
}

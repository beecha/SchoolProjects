using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class GameScore : MonoBehaviour 
{

    Text scoreText;

    int score;

    public int Score
    {
        get
        {
            return this.score;
        }
        set
        {
            this.score = value;
            UpdateScoreText();
        }
    }

	// Use this for initialization
	void Start () 
    {
	    // Get Text component
        scoreText = GetComponent<Text>();

	}

    void UpdateScoreText()
    {
        string scoreStr = string.Format("{0:0000000}", score);
        scoreText.text = scoreStr;
    }
}

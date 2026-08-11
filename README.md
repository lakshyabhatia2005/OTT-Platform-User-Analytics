# 🎬 OTT Platform User Analytics


End-to-end analysis of user behavior on an OTT streaming platform, covering **~2,000 users** and **30,000+ viewing sessions** across 5 relational tables. The goal: identify what drives watch time and engagement, predict churn, and flag users at risk of dropping off — using SQL, Python, and Power BI.


## Table of Contents

- [Business Problem](#business-problem)
- [Dataset](#dataset)
- [Tech Stack](#tech-stack)
- [Repository Structure](#repository-structure)
- [Methodology](#methodology)
- [Key Insights](#key-insights)
- [Model Performance](#model-performance)
- [Recommendations](#recommendations)

---

## Business Problem

OTT platforms sit on huge volumes of user data but struggle to translate it into what actually increases watch time and engagement — especially for free-tier users who haven't converted, and for users showing early signs of churn.

## Dataset

- ~2,000 unique users
- 30,000+ viewing sessions
- 12,000+ ratings
- 5 relational tables: Users, Subscriptions, Watch History, Ratings, Feedback

## Tech Stack

| Layer | Tools |
|---|---|
| Data prep & querying | SQL (stored procedures, triggers) |
| Statistical testing | Python — SciPy (T-test, Chi-square) |
| Machine learning | Python — Scikit-learn (K-Means, Logistic Regression, KNN) |
| Dashboard | Power BI |
| Supporting analysis | Excel |

## Repository Structure

```
OTT-Platform-User-Analytics/
├── README.md
├── sql/
│   └── SQL_Final_Project.sql          # Stored procedure + trigger
├── notebooks/
│   ├── Course_7_final_code.ipynb      # K-Means, Logistic Regression, KNN
│   └── Stats_part_.ipynb              # T-test, Chi-square hypothesis tests
├── powerbi/
│   └── course7_FINAL_PROJECT_Power_BI_.pbix   # Interactive dashboard
├── excel/
│   └── Final_Project_Excel.xlsx       # Supporting workbook
└── presentation/
    └── OTT_Platform_User_Analytics.pptx    # Full project deck
```

## Methodology

1. **Data engineering (SQL):** Built a stored procedure to surface free-tier users eligible for upgrade (high watch time + active rating behavior), and a trigger to auto-categorize feedback as Positive/Neutral/Negative based on rating.
2. **Hypothesis testing (Python):** Ran T-tests and Chi-square tests to check whether watch time, subscription type, device type, and time of day actually relate to churn.
3. **Segmentation & prediction (Python):** Used K-Means to segment users into behavioral groups, Logistic Regression to predict churn, and KNN to classify/predict subscription type.
4. **Visualization (Power BI):** Built an interactive dashboard surfacing engagement, feedback, and subscription trends.

## Key Insights

- Free Trial users log the highest total watch time (1.86M mins) of any subscription tier, ahead of Premium
- 12K ratings from 2,000 users show strong platform activity; 40.3% of feedback is positive
- K-Means segmented users into 3 groups (prospective, high engagers, at-risk); best K = 2 for churn-relevant splits
- At-risk users average a 2.35 rating despite a long average tenure (274 days) — they're not leaving quickly, they're leaving unhappy
- **Chi-square:** subscription type has a significant relationship with churn
- **Chi-square:** time of day has no significant relationship with churn
- **T-test:** no significant difference in watch time between churned and active users — watch time alone doesn't explain churn

## Model Performance

| Model | Task | Result |
|---|---|---|
| Logistic Regression | Churn prediction | 70% accuracy; 83% recall on non-churn, only 53% recall on churn |
| KNN Classifier | Subscription type prediction | 75.4% accuracy, balanced across classes |
| K-Means | User segmentation | 3 meaningful segments, some cluster overlap |

## Recommendations

- Improve churn-model recall — the current logistic regression misses nearly half of at-risk users
- Address the at-risk segment's dissatisfaction directly: low ratings and low completion despite long tenure point to a **content/recommendation quality issue**, not a pricing one
- Since time of day doesn't predict churn but subscription type does, prioritize plan-level retention levers over scheduling-based ones

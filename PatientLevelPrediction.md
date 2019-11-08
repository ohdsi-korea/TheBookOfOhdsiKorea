# 환자 수준 예측 {#PatientLevelPrediction}

*Chapter leads: Peter Rijnbeek & Jenna Reps*

\index{patient-level prediction}

임상의사결정(clinical decision making)이란 임상 의사가 알 수 있는 환자의 병력에 대한 정보와 현재 임상지침에 따라 진단 또는 치료 경로를 추론해야 하는 복잡한 일이다. 임상 예측 모형은 이러한 의사 결정 과정을 지원하기 위해 개발되었으며 광범위한 전문 분야에서 임상 실무에 사용된다. 이러한 모형은 인구 통계학적 정보, 질병력 및 치료력과 같은 환자 특성들을 조합하여 이를 기반으로 진단 또는 예후 결과를 예측한다. \index{clinical decision making} \index{diagnostic outcome} \index{prognostic outcome}

임상 예측 모형을 설명하는 출판물의 수가 지난 10년 동안 많이 증가했다. 현재 사용되는 대부분 모형은 소규모 데이터 집합을 사용하여 추정되며, 소규모 환자 특성만 고려한다. 이처럼 소 표본이고 그래서 낮아지는 통계학적 검정력으로 인해 데이터 분석가는 엄격한 가정하게 모델링을 수행하게 된다. 제한적인 환자 특성을 가진 데이터 집합의 선택은 현재 알고 있는 전문가의 지식에만 의존해서 강하게 설명된다. 이는 환자들이 풍부한 디지털 트레일(digital trail)을 생성하는 현대 의학의 현실과 크게 대조되며, 이는 모든 의료 전문가가 완전히 동화될 힘을 훨씬 뛰어넘는다. 현재, 건강 관리는 EHR(Electronic Health Records)에 저장된 엄청난 양의 환자 개인별 정보를 생성하고 있다. 여기에는 진단, 약물치료, 실험실 검사 결과와 같은 정형화된 데이터와 임상적 기술(clinical narratives)에 포함된 비정형화된 데이터가 포함되어 있다. 대량의 환자 데이터를 완전한 EHR로부터 얻고 이것을 활용하여도 예측 정확도를 얼마나 얻을 수 있는지는 알 수 없다. \index{prediction model}

대규모 데이터 세트 분석을 위한 머신 러닝의 발전으로 이러한 유형의 데이터에 환자-수준 예측을 적용하는 데 관심이 높아졌다. 그러나 환자-수준 예측을 위한 많은 수의 출판물들은 모형 개발 지침을 따르지 않아 광범위한 외적 타당도를 수행에 실패하거나 또는 독립적인 연구자들이 그 모형을 재현하고 외적 타당도를 검증하기 위해 필요 가능성을 제한하는 모델링을 위한 세부사항을 제공하지 않는다. 이것은 모형의 예측 성능을 공정하게 평가하기 어렵게 하고 임상 실무에서 모형이 적절하게 사용될 가능성을 줄인다. 표준화를 개선하기 위해 예측 모형을 개발하고 보고하는 모범 사례에 대한 지침을 자세히 설명하는 여러 논문이 작성되었다. 예를 들어, 개별 예측 또는 진단(TRIPOD)[^tripodUrl] 선언문에 다변량 예측 모형의 투명한 보고(Transparent Reporting)는 예측 모형 개발 및 타당도 보고에 대한 명확한 권장 사항을 제공하고 투명성과 관련된 일부 우려를 해결한다. \index{machine learning} \index{TRIPOD}

[^tripodUrl]: https://www.equator-network.org/reporting-guidelines/tripod-statement/

OHDSI CDM(Common Data Model)을 통해 전례 없는 규모의 데이터에서 균일하고 투명한 분석이 가능하게 되어 대규모의 환자 개별 예측 모델링이 현실화하였다. CDM으로 표준화된 데이터베이스 네트워크가 증가하면서 전 세계적으로 다양한 의료 환경에서 모형의 외적 타당도 검증을 가능하게 한다. 우리는 이것이 치료의 질적 개선을 가장 필요로 하는 환자의 대규모 공동체에 즉시 서비스를 제공 할 수 있는 기회를 제공한다고 믿는다. 이러한 모형은 정확히 맞춤형 의료서비스에 정보를 제공하고 환자 결과를 크게 향상할 수 있다고 희망한다.

이 장에서는 환자-수준 예측을 위한 OHDSI의 표준화된 프레임워크 [@reps2018] 를 설명하고 개발 및 타당도 검증을 위해 확립된 모범 사례를 구현하는 [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) R 패키지에 대해 설명한다. 우리는 환자-수준 예측의 개발과 평가에 필요한 이론을 제공하는 것으로 시작하고 구현된 기계 학습 알고리즘에 대한 높은 수준의 개요를 제공한다. 그런 다음 예측 문제에 대한 예제에 대하여 논의하고 ATLAS 또는 사용자 정의 R 코드를 사용하여 그것의 정의 및 실행에 대한 단계별 지침을 제공한다. 마지막으로 연구 결과의 보급을 위해 Shiny 앱을 사용하는 방법에 대해 논의한다.

## 예측 문제

그림 \@ref(fig:figure1)은 우리가 다루는 예측 문제를 보여준다. 위험에 처한 모집단 중에서, 우리는 정의된 특정 시점 (t = 0) 에서 어떤 환자가 위험에 처하는 동안 어떤 결과를 경험할 것인지 예측하는 것을 목표로 한다. 예측은 해당 시점 이전의 관찰 기간에서 환자에 대한 정보만 사용하여 수행된다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/Figure1.png" alt="예측 문제" width="100%" />
<p class="caption">(\#fig:figure1)예측 문제</p>
</div>

표 \@ref(tab:plpDesign)에서 볼 수 있듯이 예측 문제를 밝히려면 표적 코호트(target cohort)의 t = 0, 결과 코호트(outcome cohort)에 의해 예측하고자 하는 결과, 그리고 위험 노출 시간(time-at-risk)을 정의해야 한다. 표준 예측 질문을 다음과 같이 정의한다: \index{target cohort} \index{outcome cohort} \index{time-at-risk}

> *[표적 코호트, T]*에서, 누가  *[위험에 노출된 시간, t]* 내에 *[결과 코호트, O]*가 발생하는가?

또한 개발하고자 하는 모형에 대해 디자인을 선택하고 내적 및 외적 타당도 검증을 수행할 관측 데이터 세트를 결정해야 한다.

Table: (\#tab:plpDesign) Main design choices in a prediction design.

| Choice            | Description                                              |
|:----------------- |:-------------------------------------------------------- |
| Target cohort     | How do we define the cohort of persons for whom we wish to predict?                    |
| Outcome cohort    | How do we define the outcome we want to predict?|
| Time-at-risk      | In which time window relative to t=0 do we want to make the prediction? |
| Model             | What algorithms do we want to use, and which potential predictor variables do we include? |


이 개념적 프레임워크는 다음과 같은 모든 유형의 예측 문제에 적용된다, 예를 들면:

- 질병 발병 및 진행
  - **구조**: *[질병 A]*로 새로 진단된 환자 중, **[진단 시점 t]* 내에 *[또 다른 질병이나 합병증, B*]*이 있는 사람은 누구인가?
  - **예제**: 새로 진단된 심방세동 환자 중 향후 3년 동안 허혈성 뇌졸중이 발생하는 사람은 누구인가?
- 치료 선택
  - **구조**: *[치료 1]* 또는 *[치료 2]*로 치료한 *[표시된 질병, D]* 환자 중 [치료 1]로 치료받은 환자는 무엇인가?
  - **예제**: 와파린 또는 리바록사반을 복용한 심방세동 환자 중 어떤 환자가 와파린을 복용하는가? (예를 들어 성향 모형의 경우)
- 치료 반응
  - **구조**: *[치료 1]*을 처음 사용하는 사람 중, 누가 *[시간대 t]*에서 *[어떤 효과, E]*를 경험했는가? 
  - **예제**: 메트포민으로 치료받기 시작한 당뇨병 환자 중 어떤 환자가 3년 동안 메트포민을 유지하는가?
- 치료 안전
  - **구조**: *[치료 1]*을 처음 사용하는 사람 중 누가 *[시간대 t]*에서 *[이상 반응 E]*를 경험하게 되는가?
  - **예제**: 와파린을 처음 사용하는 사람 중 누가 1년 안에 위장관 출혈이 발생했는가?
- 치료 준수 
  - **구조**: *[치료 1]*를 처음 사용하는 사람 중 누가 *[시간대, t]*에서 *[준수 지표 수치]*를 달성하는가? 
  - **예제**: 메트포민으로 치료를 시작한 당뇨병 환자 중 어떤 환자가 1년 중 80% 이상을 복용 순응도를 보이는가?
  
## 데이터 추출

예측 모형을 만들 때 상태에 따라 분류된 예제들 기반으로 공변량과 결과 상태 간의 관계를 유추하기 위하여 기계학습과 같은 지도 학습이라는 프로세스를 사용한다. \index{supervised learning} 따라서, 표적 코호트에 있는 사람들의 CDM에서 공변량을 추출하는 방법이 필요하며 그들의 결과 레이블을 얻을 필요가 있다.

**공변량** ("예측변수", "특징" 또는 "독립 변수"라고도 함)은 환자의 특성을 묘사한다. 공변량은 연령, 성별, 특정 질병 존재, 그리고 환자 기록에 있는 노출 코드 그리고 그 외 여러 가지가 될 수 있다. 공변량은 [FeatureExtraction](https://ohdsi.github.io/FeatureExtraction/) 패키지를 사용하여 구성되었고, \@ref(Characterization)장에 자세히 설명돼 있다. 예측을 위해 우리는 오직 표적 코호트에 들어오는 날짜 기준으로 환자의 이전 또는 그때의 데이터만 사용할 수 있다. 이 날짜를 인덱스 날짜라고 한다.\index{index date} 

또한 위험 노출 기간(time-at-risk) 동안 모든 환자의 **결과 상태** ("라벨" 또는 "분류"라고도 함) 를 생성할 필요가 있다. 만약 결과가 위험에 노출된 시간 안에 발생하거나 그 결과 상태는 “양성”으로 정의된다.\index{outcome status} \index{labels} \index{classes}

### 데이터 추출 예제

표 \@ref(tab:plpExampleCohorts)는 두 개의 코호트가 있는 COHORT에 대한 예를 보여준다. 코호트 정의 ID 1인 코호트는 표적 코호트 (예를 들어 "최근 심방세동 진단을 받은 사람들") 이고 코호트 정의 ID 2는 결과 코호트 (예를 들어 "뇌졸중") 이다

Table: (\#tab:plpExampleCohorts) Example COHORT table. For simplicity the COHORT_END_DATE has been omitted. 

| COHORT_DEFINITION_ID | SUBJECT_ID | COHORT_START_DATE |
|:--------------------:|:----------:|:-----------------:|
| 1                    |   1        | 2000-06-01        |
| 1                    |   2        | 2001-06-01        |
| 2                    |   2        | 2001-07-01        |

표 \@ref(tab:plpExampleConditions)은 CONDITION_OCCURRENCE에 대한 예제이다. 개념(concept) ID [320128](http://athena.ohdsi.org/search-terms/terms/320128)은 "본태성 고혈압"을 나타낸다.

Table: (\#tab:plpExampleConditions) Example CONDITION_OCCURRENCE table. For simplicity only three columns are shown.

| PERSON_ID | CONDITION_CONCEPT_ID | CONDITION_START_DATE |
|:---------:|:--------------------:|:--------------------:|
| 1         | 320128               | 2000-10-01           |
| 2         | 320128               | 2001-05-01           |

이 예제 데이터를 기반으로, 위험에 노출된 시간이 인덱스 날짜 (표적 코호트 시작 날짜) 의 다음 연도라고 가정하고 다음과 같이 공변량 및 결과 상태를 구성할 수 있다. Person ID가 1인 환자 (인덱스 날짜 *이후*에 발생한 질병) 의 경우 "이전 해의 본태성 고혈압"을 나타내는 공변량은 값 0 (현재 아님) 으로 하고, person ID가 2인 환자는 값 1 (현재 진행) 을 갖는다. 유사하게, 결과 상태는 person ID가 1인 환자 (이 사람은 결과 코호트에 못 들어감) 의 경우는 값 0을 갖고 person ID가 2인 환자 (인덱스 날짜 다음 1 년 내에 결과가 발생하였음) 의 경우에는 값 1을 갖는다.

### 결측

관찰 의료 데이터는 데이터 누락 여부를 거의 반영하지 않는다. 이전의 예제에서, 우리는 person ID가 1인 환자가 인덱스 날짜 이전에 본태성 고혈압이 없었음을 관찰했다. 이는 그 당시 본태성 고혈압이 없었거나 기록되지 않았기 때문일 수 있다. 머신 러닝 알고리즘은 두 시나리오를 구분할 수 없고 사용 가능한 데이터 안에서 예측값을 대략 평가한다는 것을 인지해야 한다. \index{missing data}

## 모형 적합 {#modelFitting}

예측 모형을 적합할 때 상태에 따라 분류된 예제들로부터 공변량과 관찰된 결과 상태 간의 관계를 알려고 노력한다. 만약 수축기 혈압과 이완기 혈압의 두 가지 공변량이 있다고 가정하면 그림 \@ref(fig:decisionBoundary)와 같이 2차원 공간에서 그림으로 각 환자를 나타낼 수 있다. 이 그림에서 데이터를 나타내는 점의 모양은 환자의 결과 상태 (예를 들어, 뇌졸중) 를 나타낸다.

지도 학습 모형은 두 결과 분류(classes)를 최적으로 분리하는 결정 경계(decision boundaries)를 찾아내려고 노력할 것이다. 다른 지도 학습 기법은 다른 분류 결정 경계로 이어지고 분류 결정 경계의 복잡성에 영향을 줄 수 있는 하이퍼-파라미터(hyper-parameters)가 종종 있다. \index{decision boundary}

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/decisionBoundary.png" alt="결정 경계." width="80%" />
<p class="caption">(\#fig:decisionBoundary)결정 경계.</p>
</div>

그림 \@ref(fig:decisionBoundary)에서 세 가지 다른 결정 경계를 볼 수 있다. 그 경계들은 새로운 데이터 포인트의 결과 상태를 추론하기 위하여 사용되기도 한다. 새 데이터 포인트가 음영이 있는 영역에 포함되면 모형은 "결과가 있음"을 예측하고, 그렇지 않으면 "결과가 없음"으로 예측한다. 이상적으로는 결정 경계가 두 분류(class)를 완벽하게 구분해야 한다. 그러나 너무 복잡한 모형은 데이터에 "과적합(overfit)"할 위험이 있다. 이는 보이지 않는 데이터에 대한 모형의 일반화에 부정적인 영향을 줄 수 있다. 예를 들어, 데이터에 레이블이 없거나 잘못 지정된 데이터 포인트를 갖는 잡음(noise)이 포함된 경우 해당 잡음(noise)에 예측 모형을 적합하고 싶지 않을 것이다. 그러므로 우리는 학습 데이터(training data)를 갖고 완벽하게 판별하지는 않지만 “실제의” 복잡성을 반영하는 결정 경계를 정의하는 것을 선호 할 수 있다. 정규화(regularization)와 같은 기술은 복잡성을 최소화하면서 모형 성능을 최대화하는 것을 목표로 한다. 

각각의 지도 학습 알고리즘마다 의사 결정 경계를 학습하는 방법이 다르므로 어떤 알고리즘이 데이터에 가장 적합한지 간단하지 않다. No Free Lunch 정리에 따르면 모든 예측 문제에서 하나의 알고리즘이 언제나 다른 알고리즘보다 성능이 우수하지는 않다는 것을 알 수 있다.\index{no free lunch} 따라서 환자-수준 예측 모형을 개발할 때 다양한 하이퍼-파라미터 설정으로 여러 개의 지도 학습 알고리즘을 사용하는 것이 좋다. 

다음의 알고리즘은 [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지에서 사용할 수 있다:

### 정규화된 로지스틱 회귀

LASSO(least absolute shrinkage and selection operator) 로지스틱 회귀는 변수의 선형결합을 알 수 있는 일반화 선형 모형(generalized linear models)에 속하고 로지스틱 함수는 결국 0과 1 사잇값으로 배치구조를 나타낸다. LASSO 정규화는 모형 학습 시 모형 복잡도에 따른 비용을 목적 함수(objective function)에 추가한다. 이 비용은 계수들의 선형 결합의 절댓값의 합이다. 모형은 이 비용을 최소화하면서 특징 선택(feature selection)을 자동으로 수행한다. 우리는 대규모 정규화 로지스틱 회귀 분석을 수행하기 위하여 [Cyclops](https://ohdsi.github.io/Cyclops/)(Cyclic coordinate descent for logistic, Poisson and survival analysis) 패키지를 사용한다. \index{LASSO} \index{logistic regression} \index{regularization} \index{Cyclops}

Table: (\#tab:lassoParameters) Hyper-parameters for the regularized logistic regression.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| Starting variance | The starting variance of the prior distribution. | 0.1 |

교차 검증에서 표본 외(out-of-sample) 우도(likelihood)를 최대화하여 분산이 최적화되므로 시작 분산은 결과 모형의 성능에 거의 영향을 미치지 않는다. 그러나 시작 분산이 최적값에서 너무 차이가 나면 모형 적합 시간이 길어질 수 있다. \index{variance} \index{hyper-parameter} \index{cross-validation}


### Gradient Boosting Machines

Gradient boosting machines은 부스팅 앙상블 기법(boosting ensemble technique)이며 프레임워크 안에서 다중 의사 결정 나무를 연결한다. 부스팅은 의사 결정 나무를 반복적으로 추가하는 것이지만, 다음에 생성될 의사 결정 나무를 학습할 때 비용 함수(cost function)에서 이전 의사 결정 나무에 의해 잘못 분류된 데이터 포인트에 더 많은 가중치를 추가한다. CRAN에서 제공하는 xgboost R 패키지로 수행된 gradient boosting framework를 효율적으로 구현하는 Extreme Gradient Boosting을 사용한다. \index{gradient boosting} \index{xgboost}

Table: (\#tab:gbmParameters) Hyper-parameters for gradient boosting machines.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| earlyStopRound | Stopping after rounds without improvement | 25 |
| learningRate| The boosting learn rate | 0.005,0.01,0.1|
| maxDepth | Max levels in a tree | 4,6,17 |
| minRows | Min data points in a node | 2 |
| ntrees | Number of trees |100,1000|


### 랜덤 포레스트 (Random Forest)

랜덤 포레스트(Random forest)는 다중 의사 결정 나무를 연결하는 배깅 앙상블 기법(bagging ensemble technique)이다. 배깅의 기본 개념은 유사도가 낮은 classfiers들을 사용하여 유사도가 높은 classfier로 결합하여 과적합 가능성을 줄이는 것이다. 랜덤 포레스트(Random forest)는 다중 의사 결정 나무를 학습하여 저장하는 것으로 하지만 각 나무(trees)에서 변수의 하위 집합만 사용하며 변수 하위 집합은 의사 결정 나무마다 다르다. 우리 패키지는 Python에서 Random Forest의 sklearn 수행을 사용한다. \index{random forest} \index{python} \index{sklearn}

Table: (\#tab:randomForestParameters) Hyper-parameters for random forests.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| maxDepth | Max levels in a tree | 4,10,17 |
| mtries | Number of features in each tree | -1 = square root of total features,5,20 |
| ntrees | Number of trees | 500 |


### K-최근접 이웃 (K-Nearest neighbor)

KNN(K-nearest neighbors)은 몇 개의 거리 척도(distance metric)를 사용하여 레이블이 지정되지 않은 새로운 데이터 포인트에 가장 가까운 K 개의 레이블이 있는 데이터 포인트를 찾는 알고리즘이다. 새로운 데이터 포인트의 예측은 K-최근접의 레이블이 된 데이터 포인트의 가장 보편적인 분류이다. 모형에 새 데이터에 대한 예측을 수행하기 위해 레이블이 지정된 데이터가 필요하므로 KNN의 공유 제한이 있으며 데이터 사이트 간에 이 데이터를 공유할 수 없는 경우가 종종 있다. 우리는 대규모 KNN classfier인 OHDSI에서 개발된 [BigKnn](https://github.com/OHDSI/BigKnn) 패키지를 포함했다. \index{k-nearest neighbors} \index{bigknn}

Table: (\#tab:knnParameters) Hyper-parameters for K-nearest neighbors.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| k | Number of neighbors | 1000 |

### 나이브 베이즈 (Naive Bayes)

나이브 베이즈 알고리즘은 클래스 변수의 값이 주어지는 모든 특징 사이의 조건부 독립성의 나이브 추정을 가진 베이즈(Bayes) 이론을 적용한다. 클래스의 사전 배포와 데이터가 클래스에 속할 가능성에 기초하여, 사후 배포가 얻어진다. 나이브 베이즈는 하이퍼-파라미터를 갖지 않는다. \index{naive bayes}

### AdaBoost

AdaBoost는 부스팅 앙상블 기법(boosting ensemble technique)이다. 부스팅은 classfier를 반복적으로 추가하여 수행되지만, 다음 classfier가 학습될 때 비용 함수에서 이전 classfier에 의해 잘못 분류된 데이터 포인트에 더 많은 가중치를 준다. 우리는 파이썬에 있는 sklearn AdaboostClassifier 구현을 사용한다. \index{adaboost} \index{python}

Table: (\#tab:adaBoostParameters) Hyper-parameters for AdaBoost.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| nEstimators | The maximum number of estimators at which boosting is terminated | 4 |
| learningRate | Learning rate shrinks the contribution of each classifier by learning_rate. There is a trade-off between learningRate and nEstimators | 1 |

### 의사 결정 트리

의사 결정 나무는 탐욕 접근(greedy approach)방식을 사용하여 선택한 개별 테스트를 사용하여 가변 공간을 분할하는 classifier이다. 이것은 클래스를 분리하는 데 가장 많은 정보를 얻는 파티션을 찾는 것을 목표로 한다. 의사 결정 나무는 많은 수의 파티션(tree depth)을 사용하게 되면 쉽게 과적합 되기 때문에 종종 일부 정규화 (예를 들어, 모형의 복잡성을 제한하는 하이퍼-파라미터의 정리 또는 지정) 가 필요하다. 우리는 파이썬에 있는 sklearn DecisionTreeClassifier 구현을 사용한다. \index{decision tree} \index{python}

Table: (\#tab:decisionTreeParameters) Hyper-parameters for decision trees.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| classWeight | "Balance" or "None" | None |
| maxDepth | The maximum depth of the tree | 10 |
| minImpuritySplit | Threshold for early stopping in tree growth. A node will split if its impurity is above the threshold, otherwise it is a leaf | 10^-7|
| minSamplesLeaf | The minimum number of samples per leaf | 10 |
| minSamplesSplit | The minimum samples per split | 2 |


### Multilayer Perceptron

Multilayer perceptrons은 비선형 함수를 사용하여 입력에 가중치를 부여하는 여러 계층의 노드를 포함하는 신경망이다. 첫 번째 레이어는 입력 레이어(input layer)이고 마지막 레이어는 출력 레이어(output layer)이며 그리고 그 사이에는 히든 레이어(hidden layers)가 있다. 신경망은 일반적으로 역 전파(back-propagation)를 사용하여 학습된다. 즉, 학습 입력(training input)이 네트워크를 통해 앞으로 전달되어 출력을 생성하고, 출력과 결과 상태 사이의 오류가 계산되며, 이 오류는 네트워크를 통해 뒤로 전달되어 선형 함수 가중치를 업데이트한다. \index{neural network} \index{perceptron} \index{back-propagation}

Table: (\#tab:mpParameters) Hyper-parameters for Multilayer Perceptrons.

| Parameter| Description | Typical values |
|:-------- |:----------- |:-------------- |
| alpha | The l2 regularization | 0.00001 |
| size | The number of hidden nodes | 4 |


### 딥 러닝 (Deep Learning)

Deep net, convolutional neural networks 또는 recurrent neural networks와 같은 딥 러닝(deep learning)은 Multilayer perceptrons과 유사하지만, 예측에 유용한 잠재 표현을 학습하는 것을 목표로 하는 숨겨진 레이어를 여러 개 가지고 있다. [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지의 별도의 [vignette](https://ohdsi.github.io/PatientLevelPrediction/articles/BuildingDeepLearningModels.html) 이러한 모형과 하이퍼-파라미터에 대해 자세히 기술되어 있다.\index{deep learning} \index{convolutional neural network} \index{recurrent neural networks}

### 다른 알고리즘

다른 알고리즘도 환자-수준 예측 프레임워크에 추가될 수 있다. 이것은 이 장의 범위를 벗어난다. 자세한 내용은 [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지의 ["Adding Custom Patient-Level Prediction Algorithms" vignette](https://ohdsi.github.io/PatientLevelPrediction/articles/AddingCustomAlgorithms.html) 에 있다.

## 예측 모형 평가

### 평가 유형

모형의 예측과 관측된 결과 상태 간의 일치도(agreement)를 측정하여 예측 모형을 평가할 수 있고 그렇게 하려면, 결과 상태를 알 수 있는 데이터가 필요하다. \index{evaluating prediction models}


\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">평가를 위해서는 모형을 개발하는 데 사용된 것과 다른 데이터 세트를 사용해야 한다. 그렇지 않으면 과잉 적합 (\@ref(modelFitting)절 참조) 되었거나 새로운 환자에게 잘 맞지 않는 모형을 선호하게 되는 위험이 발생할 수 있다.</div>\EndKnitrBlock{rmdimportant}

우리는 내적 타당도와 외적 타당도로 구분할 수 있다. 

- **내적 타당도**: 동일한 데이터베이스에서 추출된 다른 데이터 세트를 사용하여 모형을 개발하고 평가. 
- **외적 타당도**: 한 데이터베이스에서 모형을 개발하고 다른 데이터베이스에서 평가. \index{validation!internal validation} \index{validation!external validation}

아래는 내적 타당도를 수행하는 두 가지 방법에 대한 소개이다:

- **홀드 아웃 세트(holdout set) 접근법**은 레이블이 지정된 데이터를 두 개의 독립된 세트로 나눈 것이다: 검증데이터 세트(train set)와 테스트 세트(test set). 검증 세트(train set)는 모형 학습에 사용되고, 테스트 세트(test set)는 모형평가에 사용된다. 환자를 무작위로 검증과 테스트 세트로 나누거나 또는 다음과 같이 선택할 수 있다:
    - 날짜를 기반으로 데이터를 분할한다. (시점 타당도) 예를 들어, 특정 날짜 이전의 데이터를 학습시키거나, 그 특정 날짜 이후로는 데이터를 평가하는 것이다. 이것은 모형이 서로 다른 시간대에서도 일반화가 가능한지의 여부를 알 수 있게 해준다.
    - 지리적 위치를 기반으로 데이터를 분할한다. (공간 타당도) \index{validation!temporal validation} \index{validation!spatial validation}
- **교차 검증**은 데이터가 제한적일 때 유용하다. 데이터는 $n$개의 동일한 크기의 세트로 구분된다. 여기서 $n$은 미리 정해져야 한다 (예를 들어, $n=10$). 이러한 각 세트에 대해 모형은 해당 세트의 데이터를 제외한 모든 데이터에 대해 학습되며 홀드 아웃 세트에 대한 예측을 생성하는 데 사용된다. 이러한 방식으로 모든 데이터가 한 번 사용되어 모형 작성 알고리즘을 평가한다. 환자 수준 예측 프레임 워크에서 교차 검증을 사용하여 최적의 하이퍼-파라미터를 선택한다. \index{cross-validation}

외적 타당도는 다른 데이터베이스, 즉 개발에 사용된 데이터베이스가 아닌 다른 데이터베이스로부터 데이터를 얻어 모형 성능을 평가하는 것을 목표로 한다. 이 모형의 타당성을 확보할 수 있는지에 대한 측정은 학습된 데이터베이스뿐만 아니라 모형에 예측 모형에 적용하기 때문에 중요하다. 다른 데이터베이스는 다른 환자 모집단, 다른 의료 시스템 및 다른 데이터 캡처 프로세스를 말할 것이다. 우리는 대규모 데이터베이스 세트에 대한 예측 모형의 외적 타당도 검증이 임상 실무에서 모형이 수행되고 구현되기 위한 중요한 단계라고 생각한다.

### 성능 지표 {#performance}

#### 임계값 측정 {-}

예측 모형은 위험에 노출된 시간 동안 관심 결과가 발생할 위험에 해당하는 각 환자에 대해 0과 1 사이의 값을 할당한다. 0값은 0% 위험을 의미하고 0.5값은 50% 위험을 의미하고 1값은 100% 위험을 의미한다. 정확도, 민감도, 특이도, 양성 예측도와 같은 일반적인 측정 지표들은 위험에 처한 시간 동안 환자가 관심 결과를 갖는지의 여부를 분류하는 데 사용되는 임계값을 먼저 지정하여 계산할 수 있다. 예를 들어, 표 \@ref(tab:tabletheorytab)에서 임계값을 0.5로 설정하면 환자 1, 3, 7 및 10은 예상 위험이 임계값 0.5보다 크거나 같으므로 관심 결과가 발생할 것으로 예측된다. 다른 모든 환자는 0.5 미만의 예측 위험을 가지고 있으므로 관심 결과는 없을 것으로 예측된다. \index{performance metrics} \index{accuracy} \index{sensitivity} \index{specificity} \index{positive predictive value}

Table: (\#tab:tabletheorytab) Example of using a threshold on the predicted probability.

| Patient ID    | Predicted risk  | Predicted class at 0.5 threshold | Has outcome during time-at-risk | Type |
|:-------:|:---------:|:---------:|:---------:|:------:|
| 1   | 0.8 | 1| 1 | TP |
| 2   | 0.1   | 0 | 0 | TN |
| 3 | 0.7   | 1 | 0 | FP |
| 4   | 0 | 0 | 0 | TN |
| 5   | 0.05   |  0 | 0 | TN |
| 6 | 0.1   | 0 | 0 | TN |
| 7   | 0.9 | 1 | 1 | TP |
| 8   | 0.2   |  0 | 1 | FN |
| 9 | 0.3   | 0 | 0 | TN |
| 10 | 0.5   | 1 | 0 | FP |

환자에게 관심 결과가 예측되고 (위험 노출 시간 동안) 관심 결과가 발생했다면 이를 진양성(TP)이라고 한다. 환자에게 관심 결과가 있을 것으로 예상되지만 그 결과가 없는 경우라면 이를 거짓 양성(FP)이라고 한다. 환자에게 관심 결과가 없을 것으로 예상되고 실제 결과가 없는 경우 이를 진음성(TN)이라고 한다. 마지막으로, 환자에게 관심 결과가 없을 것으로 예상되지만 결과가 있는 경우 이를 거짓 음성(FN)이라고 한다.\index{true positive} \index{false positive} \index{true negative} \index{false negative}

다음과 같이 임계값-기반 지표를 계산할 수 있다:

-	정확도(accuracy): $(TP+TN)/(TP+TN+FP+FN)$
-	민감도(sensitivity): $TP/(TP+FN)$
-	특이도(specificity): $TN/(TN+FP)$
-	양성예측도(positive predictive value): $TP/(TP+FP)$

임계값을 낮추면 이러한 값이 감소하거나 증가 할 수 있다. classifier의 임계값을 낮추면 반영되는 결과 수가 증가하여 분모가 증가할 수 있다. 임계값이 이전에 너무 높게 설정된 경우, 새로운 결과는 모두 진양성일 수 있으며, 이는 양성 예측도를 증가시킨다. 이전 임계값이 맞거나 또는 너무 낮다면 임계값을 더 낮추게 되면 거짓 양성이 발생하여 양성 예측도가 감소한다. 민감도의 분모는 classifirer 임계값 ($TP+FN$은 상수) 에 의존하지 않는다. 이는 classifier 임계값을 낮추면 진양성 결과 수를 증가 시켜 민감도를 높일 수 있음을 의미한다. 또한 임계값을 낮추면 민감도가 바뀌지 않고 양성 예측도가 변할 수 있다.

#### 판별력 (discrimination) {-}

판별력(discrimination)은 위험에 노출된 시간 동안 관심 결과를 경험할 환자에게 더 높은 위험을 할당하는 능력이다. ROC(Receiver Operating Characteristics) 곡선은 가능한 모든 임계값에 대하여 x축은 1-특이도를 그리고 y축에는 민감도를 나타낸다. ROC 곡선은 이 장의 뒷부분에 있는 그림 \@ref(fig:shinyROC)에 나와 있다. AUC(area under the receiver operating characteristic curve)가 0.5이면 위험에 무작위로 할당되는 것을 의미하고 값이 1이면 완벽하게 판별한다는 의미이다. 대부분 출판된 예측 모형의 AUC는 0.6-0.8 사이의 값을 갖고 있다. \index{AUC} \index{ROC} \index{discrimination}

AUC는 위험에 노출된 시간 동안 관심 결과를 경험한 환자와 그렇지 않은 환자 간에 예측된 위험 분포가 얼마나 다른지 결정하는 방법을 제공한다. AUC가 높으면 위험 분포가 대부분 분리되지만, 겹치는 부분이 많을 때는 그림 \@ref(fig:figuretheoryroctheory)에서와 같이 AUC가 0.5에 가까워진다.


<div class="figure">
<img src="images/PatientLevelPrediction/theory/roctheory.png" alt="ROC 플롯이 어떻게 차별과 연관되어 있는지를 설명한다. 두 등급의 예측 위험 분포가 유사한 경우, ROC는 대각선에 가까우며 AUC는 0.5에 가깝다." width="100%" />
<p class="caption">(\#fig:figuretheoryroctheory)ROC 플롯이 어떻게 차별과 연관되어 있는지를 설명한다. 두 등급의 예측 위험 분포가 유사한 경우, ROC는 대각선에 가까우며 AUC는 0.5에 가깝다.</p>
</div>

결과가 드물게 발생할 경우, AUC가 높은 값을 갖는 모형이라도 주어진 임계값을 초과하는 모든 양성에 대해 음성이 많을 수 있으므로 (즉, 양성예측도가 낮을 수 있기 때문에) 실용적이지 않을 수 있다. 결과의 심각성과 일부 중재에 대한 비용 (건강 위험/ 금전적) 에 따라, 거짓 양성비가 높아질 수 있다. 결과가 드물게 발생하는 것이라면 AUPRC(area under the precision-recall curve)라고 알려진 다른 측정법이 권장된다. AUPRC는 x축은 민감도 (재현율이라고도 함) 와 y축은 양성예측도 (정밀도라고도 함) 을 나타내는 곡선하 면적이다. \index{area under the precision-recall curve} 

#### 적합도 (calibration) {-}

적합도(calibration)는 모형이 정확한 위험을 적합 한지에 대한 것이다. 예를 들어, 모형에 100명의 환자에게 10%의 위험이 발생 가능성이 있다고 할 경우 10명의 환자가 위험에 노출된 시간 동안 결과를 경험해야 한다. 모형에 100명의 환자에게 80%의 위험이 발생 가능성이 있다면 80명의 환자가 위험에 노출되는 시간 동안 결과를 경험해야 한다. 적합도(calibration)는 일반적으로 예측된 위험에 기초하여 환자를 십분 위로 분할하고 각 그룹에서 평균 예측 위험과 위험에 노출 시간 동안 결과를 경험한 환자의 비율이 계산된다. 그런 다음 10개의 점 (y축에 예측 위험과 x축에 관찰된 위험)을 그리고 x = y에 있는지 확인하여 모형이 잘 보정되었음을 나타낸다. 적합도 그래프는 이 장의 뒷부분에 있는 그림 \@ref(fig:shinyCal)에 나와 있다. 또한 점을 사용하여 절편 (0에 가까워 야 함) 과 기울기 (1에 가까워야 함) 를 계산하여야 선형 모형으로 적합하다. 기울기가 1보다 크면 모형이 실제 위험보다 높은 위험을 할당하고 있고 기울기가 1보다 작으면 모형이 실제 위험보다 낮은 위험을 나타내는 것이다. 또한 예측된 위험과 관찰된 위험 사이의 비선형 관계를 보다 잘 포착하기 위해 R 패키지에 Smooth Calibration Curves를 수행했다. \index{calibration}

## 환자-수준 예측 연구 설계

이 장에서는 예측 연구를 설계하는 방법을 보여준다. 첫 번째 단계는 예측 문제를 명확하게 정의하는 것이다. 흥미롭게도, 많은 출판된 논문에서 예측 문제가 잘 정의되어 있지 않다. 예를 들어 인덱스 날짜 (표적 코호트의 시작) 가 어떻게 정의되어 있는지 명확하지 않다. 잘못 정의된 예측 문제는 임상 실무에서의 구현은 물론 다른 사람들에 의한 외적 타당도 검정이 불가능하다.  환자-수준 예측 프레임워크에서 표 \@ref(tab:plpDesign)에 정의된 주요 선택 사항을 명시적으로 정의하고 예측 문제의 적절한 선택을 한다. 여기서는 "치료의 안전성"을 보는 유형의 예측 문제를 예로 들어 이 프로세스를 살펴보자. \index{index date}

### 문제 정의

혈관 부종(Angioedema)은 ACE 억제제의 잘 알려진 부작용이며, ACE 억제제에 대한 레이블에 보고된 혈관 부종의 발생률은 0.1 % ~ 0.7 %의 범위이다. [@byrd_2006] 혈관 부종은 드물지만, 생명을 위협하여 호흡 정지 및 사망으로 이어질 수 있기 때문에 이러한 부작용에 대한 환자 모니터링은 중요하다. [@norman_2013] 또한, 혈관 부종이 초기에 인식되지 않으면, 원인으로 식별되기 전에 범위가 넓어지고 비싼 정밀검사로 이어질 수 있다. [@norman_2013; @thompson_1993] 아프리카계 미국인 환자들 사이에서 발생한 높은 위험 외에 ACE 억제제 관련 혈관 부종의 발생에 대한 알려진 소인은 없다. [@byrd_2006] 대부분의 반응은 초기 요법의 첫 주 또는 한 달 안에, 그리고 종종 초기 복용 후 몇 시간 내에 발생한다 [@circardi_2004]. 그러나 치료가 시작된 후 몇 년이 걸릴 수도 있다. [@mara_1996] 위험에 처한 사람들을 구체적으로 식별하는 진단 테스트가 없다. 우리가 위험에 처한 사람들을 식별 할 수 있다면, 예를 들어, 의사는 ACE 억제제를 처방을 중단하고 다른 고혈압 약물을 처방할 수 있다.\index{angioedema} \index{ACE inhibitors}

관찰 의료 데이터에 환자-수준 예측 프레임워크를 적용하여 다음의 환자-수준 예측 질문에 응용해 보자.

> 처음에 ACE 억제제로 치료를 시작한 환자 중, 그다음 해에 혈액 부종을 경험한 환자는 누구인가?

### 연구 모집단 정의

예측 모형을 개발하기 위한 최종 연구 모집단은 종종 표적 코호트의 하위 집단이다. 예를 들어 관심 결과에 의존하는 기준을 적용하거나 또는 표적 코호트의 부분 모집단(sub-population)의 민감도 분석을 수행하고자 하기 때문이다. 이것을 위하여 우리는 다음의 질문들을 설명해야만 한다:

- *표적 코호트의 인덱스 날짜 이전에 필요한 최소 관찰 시간은 얼마입니까?* 이 선택은 학습 데이터에서 사용 가능한 환자 시간에 따라 달라질 수 있지만, 장차 모형을 적용하려는 데이터 소스에서 사용 가능할 것으로 예상되는 시간에 따라 달라질 수도 있다. 최소 관측 시간이 길어질수록 더 많은 기저력 시간(baseline history time)이 특징 추출(feature extraction)에 사용할 수 있는 기저력 시간(baseline history time)이 길어지지만, 분석 할 수 있는 환자는 줄어든다. 또한, 단기 또는 look-back 기간을 선택해야 하는 임상적 이유가 있을 수 있다. 예제에서는 365일 이전 기록을 look-back 기간 (휴약기, washout period) 으로 사용한다.

- *환자가 표적 코호트에 여러 번 포함될 수 있습니까?* 표적 코호트 정의에서, 사람은 서로 다른 시간 간격 동안, 예를 들어 서로 다른 에피소드의 질병이 있거나 의료 제품에 대한 별도의 노출 기간이 있는 경우 그 코호트에 여러 번 포함될 수 있다. 코호트 정의는 환자가 한 번만 들어갈 수 있도록 제한을 적용할 필요는 없지만, 특정 환자-수준 예측 문제와 관련하여 코호트를 첫 번째 적격 에피소드로 제한 할 수 있다. 이 예제에서는 기준이 ACE 억제제의 첫 번째 사용을 기반으로 했기 때문에 표적 코호트에 한 번만 들어갈 수 있다.

- *이전에 관심 결과를 경험 한 사람이 코호트에 들어가도록 허용합니까?* 표적 코호트에 포함되기 전에 관심 결과를 경험 한 사람이 표적 코호트에 들어가도록 허용합니까? 특정 환자-수준 예측 문제에 따라, 결과가 처음 발생하게 되는 것을 예측하고자 할 수 있으며, 이 경우 이전에 결과를 경험한 환자는 처음 발생할 위험이 없으므로 표적 코호트에서 제외돼야 한다. 다른 상황에서, 유행하는 에피소드를 예측하고자 하는 경우가 있을 수 있는데, 이로 인해 사전에 관심 결과를 가진 환자가 분석에 포함될 수 있고 사전 결과 자체가 미래 결과를 예측하기 위한 변수가 될 수 있다. 예측을 위한 예제로, 우리는 이전에 혈관 부종을 가진 사람들을 포함하지 않기도 선택할 것이다.

- *대상 코호트 시작에 대한 결과를 예측할 기간을 어떻게 정의합니까?* 우리는 이 질문에 답하기 위해 두 가지 결정을 내려야 한다. 첫째, 위험에 노출된 시간 기간은 표적 코호트가 시작된 날짜 또는 그 이후에 시작되는가? 나중에 시작하게 하자는 주장은 표적 코호트가 시작되기 전에 실제로 발생한 기록에서 늦게 입력된 결과를 모면하고 싶거나 그 결과를 방지하기 위한 중재가 이론적으로 구현될 수 있는 것의 차이를 남기고 싶을 수 있다. 둘째, 표적 코호트 시작일 또는 종료일에 대해 상쇄된 날을 지정함으로써 위험에 노출된 시간의 기간 정의해야 한다. 우리의 문제를 위해, 우리는 365일까지 표적 코호트의 시작일부터 하루 뒤부터 위험에 노출된 시간의 기간 내에서 예측할 것이다.

- *위험에 노출된 최소 시간이 필요합니까?* 관심 결과를 경험하지 않았지만, 위험에 노출된 시간이 끝나기 전에 데이터베이스에 남지 않는 환자를 포함할 것인지 결정해야 한다. 이 환자들은 더 관찰하지 않는 동안 결과를 경험할 수도 있다. 예측 문제에 대해, 우리는 이 질문에 “예”로 대답하기로 했는데, 그 이유는 최소 위험 시간이 필요하기 때문이다. 또한 이 제약 조건이 결과를 경험한 사람에게도 적용되는지 결정해야 한다. 그렇지 않으면 위험에 노출된 총 시간과 관계없이 결과를 가진 모든 사람을 포함해야 한다. 예를 들어, 결과가 사망인 경우 전체 위험에 노출된 시간이 완료되기 전에 결과를 가진 사람이 중도 절단될 가능성이 있다.

### 모형 개발 설정

예측 모형을 개발하기 위해 학습하고자 하는 알고리즘을 결정해야 한다. 우리는 경험적 질문으로 특정 예측 문제에 대한 최상의 알고리즘을 선택하는 것이라고 본다. 즉, 데이터 그 자체를 언급하고 가장 최고의 모형을 찾기 위해 다른 접근법을 시도하는 것을 선호한다. 우리 프레임워크에서는 \@ref(modelFitting)절에 설명된 대로 많은 알고리즘을 구현했으며 그리고 다른 알고리즘을 추가 할 수 있다. 이 예제에서는 작업을 단순하게 하기 위해 Gradient Boosting Machines 알고리즘을 선택한다.

또한 모형을 학습하기 위하여 사용할 공변량을 결정해야 한다. 이 예제에서는 성별, 연령, 모든 질병, 의약품 및 의약품 그룹 및 방문 횟수를 추가한다. 우리는 이러한 임상적 사건을 인덱스 날짜 이전과 그 전 해에서 발견할 수 있을 것이다.

### 모형 평가

마지막으로 모형 평가 방법을 정의해야 한다. 편의상 여기서는 내적 타당도를 선택했다. 학습과 테스트를 위한 데이터 세트에서 이것을 나누는 방법과 환자를 이 두 데이터 세트로 할당하는 방법을 결정해야 한다. 여기에서는 일반적으로 하는 75%-25% 분할을 사용한다. 매우 큰 데이터 세트의 경우 학습데이터 세트에 더 많은 데이터를 포함해서 사용할 수 있다.

### 연구 요약

우리 연구를 위하여 완벽하게 정의한 내용을 표 \@ref(tab:plpSummary)에 나타내었다.

Table: (\#tab:plpSummary) Main design choices for our study.

| Choice      | Value                          |
|:----------------- |:-------------------------------------------------------- |
| Target cohort   | Patients who have just started on an ACE inhibitor for the first time. Patients are excluded if they have less than 365 days of prior observation time or have prior angioedema.|
| Outcome cohort  | Angioedema.                       |
| Time-at-risk   | 1 day until 365 days from cohort start. We will require at least 364 days at risk. |
| Model       | Gradient Boosting Machine with hyper-parameters ntree: 5000, max depth: 4 or 7 or 10 and learning rate: 0.001 or 0.01 or 0.1 or 0.9. Covariates will include gender, age, conditions, drugs, drug groups, and visit count. Data split: 75% train - 25% test, randomly assigned by person. |

## ATLAS에서의 연구 구현하기

예측 연구를 설계하기 위한 인터페이스는 ATLAS 메뉴![](images/PatientLevelPrediction/predictionButton.png) 버튼을 누르면 열 수 있다. 새로운 예측 연구를 만든다. 새로운 예측 연구를 생성하십시오. 연구에 알기 쉬운 이름을 부여하십시오. 연구 디자인은![](images/PopulationLevelEstimation/save.png) 버튼을 클릭하면 언제든지 저장이 가능하다. \index{ATLAS}

예측 디자인 기능에는 4개의 세션이 있다: 예측 문제 설정, 분석 설정, 실행 설정, 학습 설정. 다음은 각 세션에 대한 설명이다.

### 예측 문제 설정

여기서는 표적 코호트와 결과 코호트를 선택할 수 있다. 표적 코호트와 결과 코호트의 모든 조합에 대해 예측 모형이 개발될 것이다. 예를 들어, 만약 두 개의 표적 모집단과 두 개의 대상 결과들을 지정한다면 네 개의 예측 문제가 지정된다.

표적 코호트를 선택하기 위해서는 ATLAS에 사전에 정의되어야 한다. 예시 코호트가 \@ref(Cohorts)장에 있다. 부록은 이 예시에 사용된 대상 (부록 \@ref(AceInhibitors)) 과 결과 (부록 \@ref(Angioedema)) 코호트의 전체 정의를 제공한다. 표적 모집단을 코호트에 추가하기 위해서는 “표적 코호트 추가 [Add Target Cohort]” 버튼을 클릭해라. 결과 코호트를 추가하는 것은 “결과 코호트 추가 [Add Outcome Cohort]” 버튼을 클릭하면 마찬가지로 작동된다. 완료되면, Dialog는 그림 \@ref(fig:problemSettings)처럼 보일 것이다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/problemSettings.png" alt="예측 문제 설정." width="100%" />
<p class="caption">(\#fig:problemSettings)예측 문제 설정.</p>
</div>

### 분석 설정

분석 설정은 지도 학습 알고리즘, 공변량 및 모집단 설정을 선택 할 수 있다.

#### 모형 설정 {-}

모형 개발을 위해 하나 혹은 더 많은 지도 학습 알고리즘을 선택할 수 있다. 지도 학습 알고리즘을 추가하기 위해서는 “모형 설정 추가 [Add Model Settings]”버튼을 눌러라. 현재 ATLAS에서 지원되는 모든 모형이 포함된 드롭다운이 나타난다. 드롭다운 메뉴에 있는 이름을 클릭하여 원하는 연구가 포함된 지도 학습 모형을 선택 할 수 있다. 그러고 나면 지정된 모형의 창을 볼 수 있고, 하이퍼-파라미터값을 선택 할 수 있다. 여러 값이 제공되는 경우 가능한 모든 값의 조합으로 교차 검증을 사용하여 최적의 조합을 선택하기 위해 그리드서치(Grid Search)를 시행한다.

여기의 예에서는 점진적 부스팅 머신(Gradient Boosting Machine, GBM)을 선택하고 그림 \@ref(fig:gbmSettings)에 지정된 것처럼 하이퍼-파라미터를 설정한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/gbmSettings.png" alt="점진적 부스팅 머신 설정." width="100%" />
<p class="caption">(\#fig:gbmSettings)점진적 부스팅 머신 설정.</p>
</div>

#### 공변량 설정 {-}

CDM 포맷에 있는 관찰된 데이터에서 추출할 수 있는 표준 공변량을 정의했다. 공변량 설정 창에서 포함할 표준 공변량을 선택할 수 있다. 다양한 유형의 공변량을 정의 할 수 있으며 각 모형은 각각 지정된 공변량 설정과 함께 별도로 생성될 것이다.

연구에서 공변량 설정을 추가하려면, “공변량 설정 추가 [Add Covariate Settings] ”을 클릭해라. 그러면 공변량 설정 창이 열린다.

공변량 설정 창의 첫 번째 부분은 제외/포함 옵션이다. 공변량은 일반적으로 모든 개념에 맞게 구성된다. 그러나, 어떤 개념이 표적 코호트 정의와 연결된 경우와 같이 특정한 개념을 추가/제외하는 것을 원할 수도 있다. 특정 개념만 포함하려면 ATLAS에서 개념 세트(concept set)를 설정한 다음에 **"환자-수준 예측 모형의 기저 공변량에 어떤 개념을 포함하시겠습니까? (모든 것을 포함하려면 비워 두십시오)"** 아래 ![](images/PopulationLevelEstimation/open.png)를 클릭하여 개념 세트(concept set)를 선택한다. **"하위 개념이 포함된 개념 목록에 추가해야 합니까?"**라는 질문에 “예”라고 답함으로써 모든 하위 개념을 자동으로 개념 세트(concept set)에 추가할 수 있다. 같은 절차는 **환자 수준 예측 모형의 기저 공변량에 어떤 개념을 제외하시겠습니까? (모든 것을 포함하려면 비워 두십시오)"** 질문에서 동일한 과정을 반복할 수 있고 선택된 개념에 해당하는 공변량을 제거할 수 있다. 마지막 옵션인 **"쉼표는 구분되어야 하는 공변량 ID의 리스트의 범위를 정한다."**를 사용하면 공변량의 IDs 세트 (개념 IDs가 아닌) 을 쉼표로 구분하여 추가할 수 있다. 이 옵션은 고급(advanced) 사용자에게만 있다. 완료되면 포함 및 제외 옵션이 그림 \@ref(fig:covariateSettings1)과 같아야 한다.
 +
<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings1.png" alt="공변량 포함 및 제외 설정." width="100%" />
<p class="caption">(\#fig:covariateSettings1)공변량 포함 및 제외 설정.</p>
</div>

다음은 non-time bound 변수를 선택할 수 있다.

- 성 [Sex]: 남자 또는 여자 성별을 나타내는 이항 변수
- 나이 [Age]: 연령에 해당하는 연속 변수
- 나이 그룹 [Age group]: 5년 단위의 이항 변수 (0-4, 5-9, 10-14, …, 95+)
- 인종 [Race]: 각 인종의 이항 변수, 1은 환자의 인종이 기록됨을 의미하며, 그렇지 않으면 0이다.
- 민족 [Ethnicity]: 민족에 대한 이항 변수, 1은 환자의 민족이 기록됨을 의미하며, 그렇지 않으면 0이다.
- 색인 연도 [Index year]: 각 코호트 연도 시작 날짜에 대한 이항변수, 1은 환자 코호트 시작 날짜 연도를 의미하고, 그렇지 않으면 0이다. **미래에 이 모형을 적용하기를 원하기 때문에, 때때로는 색인 연도를 포함하는 것은 합리적이지 않다.**
- 색인 월 [Index month]: 각 코호트 달 시작 날짜에 대한 이항 변수, 1은 환자 코호트 월 시작 날짜를 의미하고, 그렇지 않으면 0이다.
- 사전 관찰 시간 [Prior observation time]: [예측에 권장되지 않음] 코호트 시작일 이전에 환자가 데이터베이스에 있었던 기간 (일) 에 해당하는 연속 변수
- 사후 관찰 시간 [Post observation time]: [예측에 권장되지 않음] 코호트 시작일 이후에 환자가 데이터베이스에 있었던 기간 (일) 에 해당하는 연속 변수
- 시간 코호트 [Time cohort]: 환자가 코호트에 있었던 기간에 해당하는 연속 변수 (코호트 종료일에서 코호트 시작일을 뺀)
- 색인 연도 및 월 [Index year and month]: [예측에 권장되지 않음] 각 코호트 시작 연월 날짜에 대한 이항변수, 1은 환자 코호트 시작 연월 날짜이고, 그렇지 않으면 0이다.

완료된다면, 그림 \@ref(fig:covariateSettings2)과 같아야 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings2.png" alt="공변량 선택." width="100%" />
<p class="caption">(\#fig:covariateSettings2)공변량 선택.</p>
</div>

표준 공변량은 공변량에 대해 세 개의 유동적인 시간 간격을 가능하게 한다:

- 종료일: 코호트 시작 날짜를 기준으로 종료 시기와의 간격 [기본값 0]
- 장기간 [코호트 시작일 이전의 기본값 -365일에서 종료일]
- 중기간 [코호트 시작일 이전의 기본값 -180일에서 종료일]
- 단기간 [코호트 시작일 이전의 기본값 -30일에서 종료일]

완료가 된다면, 그림 \@ref(fig:covariateSettings3)과 같아야 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings3.png" alt="Time bound 공변량." width="100%" />
<p class="caption">(\#fig:covariateSettings3)Time bound 공변량.</p>
</div>

다음 옵션은 era 테이블에서 추출한 공변량이다:

- 질병 [Condition]: 선택된 각 질병 개념 ID와 시간 간격으로 공변량을 계산하고 환자가 질병 era 테이블에서 코호트 시작일 이전에 지정된 시간 간격 동안, era가 있는 개념 ID를 갖는 경우 (즉, 시간 간격 동안 상태가 시작 또는 종료되었거나 시간 간격 이전에 시작하고 시간 간격 이후에 종료되거나), 공변량 값은 1이고, 그렇지 않으면 0이다.
- 질병 그룹 [Condition group]: 선택된 각 질병 개념 ID와 시간 간격으로 공변량을 계산하고 환자가 질병 era 테이블에서 코호트 시작일 이전에 지정된 시간 간격 동안, era가 있는 개념 ID를 **또는 하위 개념 ID(any descendant concept ID)**를 갖는 경우, 공변량 값은 1이고, 그렇지 않으면 0이다.
- 약물 [Drug]: 선택된 각 약물 개념 ID와 시간 간격으로 공변량을 계산하고 환자가 약물 era 테이블에서 코호트 시작일 이전의 지정된 시간 간격 동안 era가 있는 개념 ID를 가지고 있는 경우 공변량 값은 1이며, 그렇지 않으면 0이다.
- 약물 그룹 [Drug group]: 선택된 각 약물 개념 ID 및 시간 간격으로 공변량을 계산하고 환자가 약물 era 테이블에서 코호트 시작일 이전의 지정된 시간 간격 기간 동안 개념 ID **또는 하위 개념 ID(any descendant concept ID)**를 가진 경우 공변량 값은 1이며, 그렇지 않으면 0이다. 

겹치는 시간 간격 설정은 약물 또는 질병 발생대(era)가 코호트 시작 날짜 이전에 시작하고 코호트 시작 날짜 이후에 끝나야 하므로 코호트 시작 날짜와 겹친다. Era start 옵션은 선택한 시간 간격 동안 시작되는 질병 또는 약물 era를 찾는 것으로 제한된다.

완료된다면, 그림 \@ref(fig:covariateSettings4)과 같아야 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings4.png" alt="Time bound era 공변량." width="100%" />
<p class="caption">(\#fig:covariateSettings4)Time bound era 공변량.</p>
</div>

다음 옵션은 다양한 시간 간격에 대한 각 도메인의 개념 ID에 해당하는 공변량을 선택한다.

- 질병 [Condition]: 선택된 각 질병 개념 ID 및 시간 간격으로 공변량을 계산하고 환자가 질병 발생 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 공변량 값은 1이며, 그렇지 않으면 0이다.
- Condition Primary Inpatient (1차 입원환자 질병): 질병_발생 표의 입원환자 설정에서 일차 진단으로 관찰된 질병당 이항 공변량 1개이다.
- 약물 [Drug]: 선택된 각 약물 개념 ID 및 시간 간격으로 공변량을 계산하고 약물 노출 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 공변량 값은 1, 그렇지 않으면 0이다.
- 수술 [Procedure]: 선택된 각 수술 개념 ID 및 시간 간격으로 공변량을 계산하고 환자의 수술 발생 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 공변량 값은 1, 그렇지 않으면 0이다.
- 측정 [Measurement]: 선택된 각 측정 개념 ID 및 시간 간격으로 공변량을 계산하고 환자가 측정 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 공변량 값은 1, 그렇지 않으면 0이다.
- 측정값 [Measurement Value]: 선택된 각 측정 개념 ID 값과 시간 간격으로 공변량을 계산하며 환자가 측정 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 값은 측정값, 그렇지 않으면 0이다.
- 측정 범위 그룹 [Measurement range group]: 측정값이 정상 범위 이하인지 이내인지 또는 그 이상인지를 나타내는 이항 공변량이다.
- 관찰 [Observation]: 선택된 각 관찰 개념 ID와 시간 간격으로 공변량을 계산하며, 환자가 관찰 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 concept ID를 가지고 있는 경우 공변량 값은 1이며, 그렇지 않으면 0이다.
- 기기 [Device]: 선택된 각 기기 개념 ID 및 시간 간격으로 공변량을 계산하며 환자가 기기 테이블의 코호트 시작일 이전에 지정된 시간 간격 동안 기록된 개념 ID를 가지고 있는 경우 공변량 값은 1이며, 그렇지 않으면 0이다.
- 방문 수 [Visit count]: 선택된 각 방문 및 시간 간격으로 공변량을 계산하고 시간 간격 동안 기록된 방문 수를 공변량 값으로 계산한다.
- 방문 개념 수 [Visit Concept Count]: 선택된 각 방문, 도메인 및 시간 간격으로 공변량을 계산하고 방문 유형 및 시간 간격 동안 기록된 도메인 당 기록의 수를 공변량 값으로 계산한다.

중복 카운트 옵션은 도메인과 시간 간격 당 중복되는 개념 IDs의 수를 계산한다.

완료된다면, 그림 \@ref(fig:covariateSettings5)과 같아야 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings5.png" alt="Time bound 공변량." width="100%" />
<p class="caption">(\#fig:covariateSettings5)Time bound 공변량.</p>
</div>
마지막 옵션은 공통으로 사용된 위험 점수를 공변량으로 포함할 것인지의 여부이다. 완료된다면, 위험점수 설정은 그림 \@ref(fig:covariateSettings6)과 같아야 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/covariateSettings6.png" alt="위험 점수 공변량 설정." width="100%" />
<p class="caption">(\#fig:covariateSettings6)위험 점수 공변량 설정.</p>
</div>

#### 모집단 설정 {-}

모집단 설정은 선정 기준이 표적 모집단에 적용할 수 있는 것이며 위험에 노출된 시간을 정의하는 것이기도 하다. 연구에서 모집단 설정을 추가하기 위해서는 “모집단 설정 추가 [Add Population Settings]” 버튼을 클릭하면 모집단 설정 창이 열린다.

옵션의 첫 번째 설정은 위험에 노출된 기간을 사용자가 지정할 수 있게 한다. 관심 결과가 발생하는지 알아보는 시간 간격이다. 만약 환자가 위험에 노출된 기간의 관심 결과가 있다면 그것을 “결과가 있음 [Has outcome]”이라고 분류하고, 그렇지 않으면 “결과가 없음 [No outcome]”으로 분류할 것이다. “**표적 코호트 입력과 관련하여 위험에 노출된 시간의 기간 시작의 정의**" 는 표적 코호트 시작과 끝 일자와 비례하여 위험에 노출된 시간으로 정의한다. 마찬가지로, “**위험에 노출된 시간의 기간 종료 정의**”는 위험에 노출된 시간의 끝으로 정의한다.

“**표적 코호트에 적용되는 최소 휴약기간**” 최소 기준 기간, 환자가 지속적으로 관찰되는 코호트 시작일 이전의 최소 일수를 지정한다. 365일이 기본값이다. 가장 적은 lookback을 늘이는 것은 환자 (더 오래 관찰해야 하므로)를 보다 완벽하게 파악할 수 있지만, 최소 관찰일 수가 없는 환자를 필터링해야 할 것이다.

“**위험에 노출된 시간이 없는 대상자를 제거해야 하는가?**”에서 ‘예 [yes]’로 설정되어 있다면, “**최소 위험 시간**”의 값도 필요하다. 이를 통해 추적 기간에 잃은 대상 (즉, 위험에 노출된 기간 동안 데이터베이스에서 떠난 경우) 을 제거 할 수 있다. 예를 들어, 위험에 노출된 기간이 코호트 시작에서부터 365일까지 하루이면 전체 위험 발생 기간은 364(365-1)일이다. 만약 전체 기간에서 관찰된 환자가 포함되기 원한다면 최소 위험 시간을 364일이라고 설정한다. 사람들이 처음 100일 동안 위험에 노출된 시간이 있는 것이 좋은 것이라면, 최소 위험 시간을 100일로 선택한다. 위험에 노출된 시간의 시작이 코호트 시작으로부터 1일이기 때문에 코호트 시작일로부터 적어도 101일 동안 데이터베이스에 남아있으면 환자가 포함될 것이다. 만약 “위험이 있는 대상자를 제거해야 하는가? [Should subjects without time at risk be removed?]” 에서 ‘아니오 [no]’라고 설정하면, 모든 환자, 위험에 노출된 시간 동안 데이터베이스에서 이탈한 환자들까지도 유지할 것이다.

“**위험 기간 전체에서 관찰되지 않은 결과를 가진 사람들을 포함하겠습니까?**” 옵션은 이전 옵션과 관련된다. “예 [yes]”라고 설정하면 지정된 최소 시간 동안 관찰되지 않더라도 위험에 노출된 시간 동안 결과가 발생한 사람들은 항상 유지된다.

“**대상자마다 첫 번째 노출만 포함되어야 하는가?**” 옵션은 만약 표적 코호트가 다른 코호트 시작일을 가진 환자를 여러 번 포함되어있을 때 유용하다. “예 [yes]”를 선택하면 분석 시 환자당 가장 처음의 표적 코호트만 유지될 것이다. 그렇지 않으면 환자는 데이터 세트에 여러 번 있을 수 있다. 

“**코호트 포함하기 전 관심 결과가 관찰된 환자를 제거하시겠습니까?**”에서 “예 [yes]”로 설정한다면 위험에 노출된 시간 시작일 이전의 결과가 있는 환자들을 제거할 수 있어서 전에 결과를 경험하지 못한 환자들을 위한 모형이 된다. “아니오”를 선택한다면 환자는 이전에 결과가 있을 수 있다. 종종, 결과를 미리 얻는 것은 위험 시간 동안 결과를 얻는 것에 대해 매우 예측 가능하다.

완료된다면, 모집단 설정 다이얼로그는 그림 \@ref(fig:populationSettings)와 같다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/populationSettings.png" alt="모집단 설정." width="100%" />
<p class="caption">(\#fig:populationSettings)모집단 설정.</p>
</div>

이제 분석 설정을 끝냈으므로, 전체적인 다이얼로그는 그림 \@ref(fig:analysisSettings)와 같다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/analysisSettings.png" alt="분석 설정." width="100%" />
<p class="caption">(\#fig:analysisSettings)분석 설정.</p>
</div>

### 실행 설정

여기에는 세 가지의 옵션이 있다:

- “**표본추출 실행**”: 표본추출을 실행할지 말지 선택할 수 있다 (기본값 = “아니오 [NO]”). 만약 “예 [yes] ”라고 설정하면, 또 다른 옵션이 나타날 것이다: “**몇 명의 환자를 부분집합으로 사용할 것인가?**”. 여기서 표본 크기는 결정될 수 있다. 표본추출은 대규모 모집단 (예로 1,000만 환자)의 모형이 환자의 표본을 가지고 모형을 테스트하고 작성함으로써 예측 가능한지 여부를 결정하는 효율적인 수단이 될 수 있다. 예를 들어, 그 표본에서 AUC가 0.5에 가까우면, 그 모형은 쓸모가 없다. 
- “**최소 공변량 발생: 만약 어떤 공변량이 이 값보다 작은 표적 모집단의 일부에서 발생하면 제거된다:**” 여기서 최소 공변량 발생을 선택할 수 있다 (기본값 = 0.001). 전체 모집단을 대표하지 않은 드문 사건을 제거하려면 공변량 발생의 최소 임계값이 필요하다. 
- “**공변량 표준화**”: 여기서 공변량을 표준화할 것인지 선택할 수 있다 (기본값 = “예 [yse]”). 공변량의 표준화는 보통 LASSO모형의 성공적인 요소로 필요로 한다.

예를 들어, 그림 \@ref(fig:executionSettings)에 나타난 선택을 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/executionSettings.png" alt="실행 설정." width="100%" />
<p class="caption">(\#fig:executionSettings)실행 설정.</p>
</div>

### 학습 설정

여기에는 네 가지 옵션이 있다:

- "**테스트/검증 세트를 분할하는 방법 지정:**" 학습/테스트 데이터를 사람 (관심 결과에 따라 분류됨) 별로 구분할지, 시간 (모형을 학습하기 위해 이전 데이터, 나중에 모형을 평가하기 위한 이전 데이터) 별로 구분할지를 선택한다.
- "**테스트 세트로 사용될 데이터의 백분율 (0~100%)**": 테스트 데이터에서 사용될 데이터의 백분율을 선택한다 (기본값 = 25%).
- "**교차 검정에 사용된 폴드 수**": 최적의 하이퍼-파라미터 선택에 사용되는 교차 검증을 위한 폴드 수를 선택한다 (기본값 = 3).
- "**사용자 유형 testSplit 사용 시 테스트/검증 세트를 분할하는 데 사용되는 초기값 (선택적)**”: 사용자 유형 testSplit에서 트레인/테스트 세트를 분할하는 데 사용되는 임의의 초기값을 선택한다.

이 예에서는 그림 \@ref(fig:trainingSettings)와 같이 선택을 한다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/trainingSettings.png" alt="학습 설정." width="100%" />
<p class="caption">(\#fig:trainingSettings)학습 설정.</p>
</div>

### 연구 가져오기 및 내보내기

연구를 내보내려면 “유틸리티 [Utilities] ” 아래의 “내보내기 [Export] ”탭을 클릭해야 한다. ATLAS는 연구를 실행할 때 필요한 연구 이름, 코호트 정의, 선택된 모형, 공변량, 설정과 같은 모든 데이터를 포함하는 파일에 직접 복사하여 붙여넣을 수 있는 JSON을 생성할 것이다. 
연구를 가져오려면 “유틸리티 [Utilities] ”아래의 “가져오기 [Import] ”탭을 클릭해야 한다. 환자 수준 예측 연구 JSON의 내용을 이 창에 붙여넣은 다음 다른 탭 버튼 아래에 있는 가져오기 버튼을 클릭해야 한다. 이 작업은 해당 연구에 대한 이전 설정을 모두 덮어쓰므로 일반적으로 비어있는 새 연구 디자인을 사용할 때 수행된다는 점을 유의해야 한다.

### 연구 패키지 다운로드

“유틸리티 [Utilities] ”탭 아래의 “리뷰 & 다운로드 [Review & Download] ” 클릭해라.  “연구 패키지 다운로드 [Download Study Package] ” 부분에서 R의 허용되지 않은 모든 문자가 ATLAS에 의해 파일 이름에서 자동으로 제거된다는 점에 유의하여 R 패키지 서술 이름을 입력해야 한다. ![](images/PatientLevelPrediction/download.png)를 클릭하여 R 패키지를 로컬 폴더로 다운로드할 수 있다.

### 연구 실행

R 패키지를 실행하려면 \@ref(installR)절에 설명된 대로 R, RStudio, Java가 설치되어 있어야 한다. 또한 다음과 같이 R에 설치할 수 있는 [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지가 필요하다:


```r
install.packages("drat")
drat::addRepo("OHDSI")
install.packages("PatientLevelPrediction")
```

머신 러닝 알고리즘의 몇몇은 추가적인 소프트웨어 설치를 요구한다. [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지를 설치하는 방법에 대한 자세한 내용은 ["Patient-Level Prediction Installation Guide" vignette](https://ohdsi.github.io/PatientLevelPrediction/articles/InstallationGuide.html)를 참조하면 된다.

연구 R 패키지를 사용하려면 R Studio를 이용하는 것을 추천한다. 로컬에서 R Studio를 사용 중인 경우 ATLAS에서 생성한 파일의 압축을 풀고 .Rproj를 두 번 누르면 RStudio에서 열린다. RStudio 서버에서 RStudio를 실행 중인 경우 파일을 업로드하고 압축을 푼 다음 ![](images/PopulationLevelEstimation/upload.png)을 클릭하여 연구프로젝트를 열면 된다.

일단 R Studio에서 연구프로젝트를 열면 README 파일을 열 수 있고 설명을 따르면 된다. 모든 파일 경로를 시스템의 기존 경로로 변경해야 한다.

## R에서의 연구 실행

ATLAS 사용하여 연구 디자인을 실행하는 방법은 R에서 코드를 직접 작성하는 것이다. [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 패키지에서 제공하는 함수를 사용할 수 있다. 패키지는 OMOP CDM으로 변환된 데이터로부터 데이터 추출, 모형 구축 및 모형 평가를 가능하게 한다.

### 코호트 예시화

우선 표적 코호트와 결과 코호트를 만들어야 한다. 코호트 만드는 것은 \@ref(Cohorts)장에 설명되어 있다. 부록에선 표적 코호트 (부록 \@ref(AceInhibitors))와 결과 코호트 (부록 \@ref(Angioedema)) 에 대한 전체 정의를 제공한다. 이 예제에서 우리는 ACE 억제제 코호트를 ID 1, 혈관부종 코호트를 ID 2로 가정한다.

### 데이터 추출

우선 R에서 서버를 연결해야 한다. [`PatientLevelPrediction`](https://ohdsi.github.io/PatientLevelPrediction/)은 다양한 데이터베이스 관리 시스템(DBMS)에 필요한 구체적인 설정을 위한 `createConnectionDetails`. Type `?createConnectionDetails` 라고 불리는 기능을 제공하는 [`DatabaseConnector`](https://ohdsi.github.io/DatabaseConnector/) 패키지를 사용한다. 예를 들어 이 코드를 사용하여 PostgreSQL 데이터베이스에 연결할 수 있다.


```r
library(PatientLevelPrediction)
connDetails <- createConnectionDetails(dbms = "postgresql",
                                       server = "localhost/ohdsi",
                                       user = "joe",
                                       password = "supersecret")

cdmDbSchema <- "my_cdm_data"
cohortsDbSchema <- "scratch"
cohortsDbTable <- "my_cohorts"
cdmVersion <- "5"
```

마지막 4줄은 `cdmDbSchema`, `cohortsDbSchema` 및 `cohortsDbTable` 변수와 CDM 버전을 정의한다. 나중에 이것들을 사용하여 CDM 형식의 데이터 위치, 관심 있는 코호트 위치, 사용되는 CDM 버전을 R에 입력한다. Microsoft SQL의 경우 데이터베이스 스키마는 데이터와 스키마 모두 지정해야 한다. 예를 들어 `cdmDbSchema <- “my_cdm_data.dbo”`이다.

먼저 코호트 항목 수를 세어 코호트 생성이 되었는지 확인하는 것이 좋다:


```r
sql <- paste("SELECT cohort_definition_id, COUNT(*) AS count",
"FROM @cohortsDbSchema.cohortsDbTable",
"GROUP BY cohort_definition_id")
conn <- connect(connDetails)
renderTranslateQuerySql(connection = conn, 
                        sql = sql,
                        cohortsDbSchema = cohortsDbSchema,
                        cohortsDbTable = cohortsDbTable)
```

```
##   cohort_definition_id  count
## 1                    1 527616
## 2                    2   3201
```

이제 [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/)을 통해 분석에 필요한 모든 데이터를 추출할 수 있다. 공변량은 FeatureExtraction 패키지를 사용하여 추출된다. [`FeatureExtraction`](https://ohdsi.github.io/FeatureExtraction/) 패키지에 대한 자세한 내용은 해당 vignettes에서 볼 수 있다. 예제 연구에서는 다음과 같은 설정을 사용하기로 하였다:


```r
covariateSettings <- createCovariateSettings(
useDemographicsGender = TRUE,
                          useDemographicsAge = TRUE,
                          useConditionGroupEraLongTerm = TRUE,
                          useConditionGroupEraAnyTimePrior = TRUE,
                          useDrugGroupEraLongTerm = TRUE,
                          useDrugGroupEraAnyTimePrior = TRUE,
                          useVisitConceptCountLongTerm = TRUE,
                          longTermStartDays = -365,
                          endDays = -1)
```

데이터를 추출의 마지막 단계는 `getPlpData`함수를 실행하고 코호트가 저장되는 데이터베이스 스키마, 코호트와 결과를 위한 코호트 정의 ID, 해당 사람이 데이터에 포함되도록 관찰되어야 하는 코호트 색인 일자 이전의 최소 일자인 최소 휴약기(washout period)와 같은 연결 세부사항들을 입력하는 것이고 마지막으로 이전에 생성된 공변량 설정을 입력하는 것이다.


```r
plpData <- getPlpData(connectionDetails = connDetails,
                      cdmDatabaseSchema = cdmDbSchema,
                      cohortDatabaseSchema = cohortsDbSchema,
                      cohortTable = cohortsDbSchema,
                      cohortId = 1,
                      covariateSettings = covariateSettings,
                      outcomeDatabaseSchema = cohortsDbSchema,
                      outcomeTable = cohortsDbSchema,
                      outcomeIds = 2,
                      sampleSize = 10000
)
```

(번역 생략된 부분)
There are many additional parameters for the `getPlpData` function which are all documented in the [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) manual. The resulting `plpData` object uses the package `ff` to store information in a way that ensures R does not run out of memory, even when the data are large.
(번역 생략된 부분)
Creating the `plpData` object can take considerable computing time, and it is probably a good idea to save it for future sessions. Because `plpData` uses `ff`, we cannot use R's regular save function. Instead, we'll have to use the `savePlpData` function:


```r
savePlpData(plpData, "angio_in_ace_data")
```
(번역 생략된 부분)
We can use the `loadPlpData()` function to load the data in a future session.

### 추가 포함 기준

최종 연구 모집단은 이전에 정의된 2개의 코호트에서 추가적인 제약조건을 적용하여 얻어진다. 예를 들어 최소 위험에 노출된 시간을 적용할 수 있으며 (`requireTimeAtRisk, minTimeAtRisk`), 이것이 결과를 가진 환자에게도 적용되는지 여부를 지정할 수 있다 (`includeAllOutcomes`). 또한 여기서 표적 코호트 시작에 관련된 위험 기간(risk window)의 시작과 끝을 지정한다. 예를 들어 위험 코호트가 시작된 후 30일부터 위험 기간으로 시작하고 1년 후 종료하려면 `riskWindowStart = 30`, `riskWindowStart = 365`로 설정할 수 있다. 때에 따라 위험 기간은 코호트 종료일에 시작해야 한다. `addExposureToStart = Ture` 로 설정하면 코호트 (노출) 시간을 시작일에 추가할 수 있다.

아래의 예에서는 연구를 위해 정의한 모든 설정을 시행한 것이다:


```r
population <- createStudyPopulation(plpData = plpData,
                                    outcomeId = 2,
                                    washoutPeriod = 364,
                                    firstExposureOnly = FALSE,
                                    removeSubjectsWithPriorOutcome = TRUE,
                                    priorOutcomeLookback = 9999,
                                    riskWindowStart = 1,
                                    riskWindowEnd = 365,
                                    addExposureDaysToStart = FALSE,
                                    addExposureDaysToEnd = FALSE,
                                    minTimeAtRisk = 364,
                                    requireTimeAtRisk = TRUE,
                                    includeAllOutcomes = TRUE,
                                    verbosity = "DEBUG"
)
```

### 모형 개발

알고리즘의 설정 기능에서 사용자는 각 하이퍼-파라미터에 대한 적합한 값의 목록을 지정할 수 있다. 하이퍼-파라미터에서 가능한 모든 조합은 학습 세트에 교차 검증을 사용하는 이른바 그리드서치에 포함된다. 만일 사용자가 어떤 값도 지정하지 않으면 기본값이 사용된다.

예를 들어 점진적 부스팅 머신에 다음 설정을 사용하는 경우: `ntrees = c(100,200), maxDepth = 4` 그리드서치는 점진적 부스팅 머신 알고리즘을 다른 하이퍼-파라미터의 기본 설정을 더한 `ntrees = 100`과 `maxDepth = 4` , 다른 하이퍼-파라미터의 기본 설정을 더한 `ntrees = 200`과 `maxDepth = 4`에적용할 것이다. 최고의 교차 검증 실행을 이끄는 하이퍼-파라미터는 마지막 모형으로 선택될 것이다. 이 문제를 위해 여러 하이퍼-파라미터값을 가지고 점진적 부스팅 머신을 만들기로 하였다: 


```r
gbmModel <- setGradientBoostingMachine(ntrees = 5000, 
                                       maxDepth = c(4,7,10), 
                                       learnRate = c(0.001,0.01,0.1,0.9))
```

`runPIP` 함수는 모형을 훈련하고 평가하기 위해 모집단, `plpData` 및 모형 설정을 사용한다. 데이터를 75% ~ 25%로 분할하기 위해 `testSplit`(사람/시간)과 `testFraction` 파라미터를 사용하고 환자 수준 예측 파이프라인을 실행할 수 있다:


```r
gbmResults <- runPlp(population = population, 
                     plpData = plpData, 
                     modelSettings = gbmModel, 
                     testSplit = 'person',
                     testFraction = 0.25, 
                     nfold = 2, 
                     splitSeed = 1234)
```

패키지 안에 R xgboost 패키지를 사용하여 데이터의 75%를 사용하는 점진적 부스팅 머신 모형(gradient boosting machine model)을 맞추고 나머지 25%에 대해 모형을 평가한다. 결과 데이터 구조는 모형과 성능에 대한 정보가 포함되어 있다.

`runPIP` 함수에는 기본적으로 `TRUE`로 설정된 `plpData`, `plpResults`, `plpplots`, `evaluation` 등을 저장할 수 있는 몇 가지 파라미터가 있다.

다음을 사용하여 모형을 저장할 수 있다:


```r
savePlpModel(gbmResults$model, dirPath = "model")
```
(번역 생략된 부분)
We can load the model using:


```r
plpModel <- loadPlpModel("model")
```
(번역 생략된 부분)
You can also save the full results structure using:


```r
savePlpResult(gbmResults, location = "gbmResults")
```
(번역 생략된 부분)
To load the full results structure use:


```r
gbmResults <- loadPlpResult("gbmResults")
```

### 내부 검증

연구를 실행하면 `runPLP`함수는 학습/테스트 세트에서 학습된 모형과 학습/테스트 세트에서 모형의 평가를 해준다. `viewPLP(runPLP = gbmResults)`를 실행하여 양방향의 결과를 볼 수 있다. 이것은 대화식 그림을 포함하여 프레임워크에 생성한 모든 측정값을 볼 수 있는 Shiny App을 열 것이다(Shiny Application 섹션의 그림 \@ref(fig:shinySummary)을 참조). 

모든 평가 그림을 폴더에 생성하고 저장하려면 다음 코드를 실행하면 된다:


```r
plotPlp(gbmResults, "plots")
```

The plots are described in more detail in Section \@ref(performance).

### 외부 검증

항상 외적 타당도를 수행하는 것을 권장한다. 즉 가능한 많은 새로운 데이터에 최종모형을 적용하고 성능을 평가해야 한다. 여기서 이미 두 번째 데이터베이스에서 데이터 추출이 수행되어 `newData` 폴더에 저장되었다고 가정한다. 이전에 장착된 모형을 `model` 폴더로부터 로딩한다.


```r
# load the trained model
plpModel <- loadPlpModel("model")

#load the new plpData and create the population
plpData <- loadPlpData("newData")

population <- createStudyPopulation(plpData = plpData,
                                    outcomeId = 2,
                                    washoutPeriod = 364,
                                    firstExposureOnly = FALSE,
                                    removeSubjectsWithPriorOutcome = TRUE,
                                    priorOutcomeLookback = 9999,
                                    riskWindowStart = 1,
                                    riskWindowEnd = 365,
                                    addExposureDaysToStart = FALSE,
                                    addExposureDaysToEnd = FALSE,
                                    minTimeAtRisk = 364,
                                    requireTimeAtRisk = TRUE,
                                    includeAllOutcomes = TRUE
)

# apply the trained model on the new data
validationResults <- applyModel(population, plpData, plpModel)
```

또한 필요한 데이터를 추출하는 외부 검증을 보다 쉽게 하기 위해 `externalValidatePLP` 함수를 제공한다. `result <- runPlp(...)`을 실행했다고 가정했을 때 모형에 필요한 데이터를 추출하여 새 데이터에 대해 평가할 수 있다. 검증 코호트가 ID 1과2가 있는 테이블 `mainschema.dob.cohort` 과CMD 데이터가 스키마 `cdmschema.dob` 라고 가정한다: 


```r
valResult <- externalValidatePlp(
	plpResult = result, 
	connectionDetails = connectionDetails,
	validationSchemaTarget = 'mainschema.dob',
	validationSchemaOutcome = 'mainschema.dob',
	validationSchemaCdm = 'cdmschema.dbo',
	databaseNames = 'new database',
	validationTableTarget = 'cohort',
	validationTableOutcome = 'cohort',
	validationIdTarget = 1,
	validationIdOutcome = 2
)
```

모형을 검증할 데이터베이스가 여러 개 있는 경우 다음을 실행 할 수 있다:


```r
valResults <- externalValidatePlp(
	plpResult = result, 
	connectionDetails = connectionDetails,
	validationSchemaTarget = list('mainschema.dob',
								'difschema.dob', 
								'anotherschema.dob'),
	validationSchemaOutcome = list('mainschema.dob',
								 'difschema.dob', 
								 'anotherschema.dob'),
	validationSchemaCdm = list('cdms1chema.dbo',
							 'cdm2schema.dbo',
							 'cdm3schema.dbo'),
	databaseNames = list('new database 1',
					   'new database 2',
					   'new database 3'),
	validationTableTarget = list('cohort1',
							   'cohort2',
							   'cohort3'),
	validationTableOutcome = list('cohort1',
								'cohort2',
								'cohort3'),
	validationIdTarget = list(1,3,5),
	validationIdOutcome = list(2,4,6)
)
```

## 결과 보급

### 모델 성능

`viewPlp` 함수를 사용하면 예측 모델의 성능을 탐색하기 가장 쉽다. 이 함수는 **입력 결과 객체**가 필요하다. R에서 모델을 개발하는 경우 입력을 위해 runPLp 결과를 사용할 수 있다. 연구패키지로 만들어진 ATLAS에서 사용한다면 모형 중 하나를 로딩해야 한다 (이 예제에서는 Analysis_1을 로딩할 것이다): \index{model viewer app}


```r
plpResult <- loadPlpResult(file.path(outputFolder, 
                                     'Analysis_1', 
                                     'plpResult'))
```

여기서 “Analysis_1”은 앞에서 지정한 분석에 해당한다.

이후에 다음을 실행하여 Shiny 앱을 시작할 수 있다:


```r
viewPlp(plpResult)
```

Shiny 앱은 그림 \@ref(fig:shinySummary)에서 볼 수 있듯이 테스트와 트레인 셋에 있는 실행 메트릭스의 요약본을 함께 보여준다. 이 결과는 트레인 세트에 있는 AUC가 0.78이고 테스트 세트에서는 0.74까지 떨어지는 것을 보여준다. 테스트 세트 AUC가 좀 더 정확한 측정이다. 전반적으로 이 모형은 ACE 억제제를 처음 사용하는 사용자에서 결과를 예측할 수 있을 것처럼 보이지만 트레인세트가 테스트 세트보다 실행력이 더 높기 때문에 다소 과적합되었다.  ROC 도표는 그림 \@ref(fig:shinyROC)에 제시되어 있다.

<div class="figure">
<img src="images/PatientLevelPrediction/shinysummary.png" alt="Shiny 앱에서의 요약 평가 통계." width="100%" />
<p class="caption">(\#fig:shinySummary)Shiny 앱에서의 요약 평가 통계.</p>
</div>

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/singleShiny/singleShinyRoc.png" alt="ROC 도표." width="100%" />
<p class="caption">(\#fig:shinyROC)ROC 도표.</p>
</div>

그림 \@ref(fig:shinyCal)에 있는 모형 적합 도표는 점들이 대각선 주위에 있을 때 일반적으로 관찰된 위험이 예측된 위험과 일치함을 보여준다. 그러나 그림 \@ref(fig:shinyDemo)에 있는 인구통계학적 그래프는 곡선(예측위험)이 40세 미만의 적색선(관측위험)모형과 다르기 때문에 모형이 젊은 환자에 대해 잘 보정되지 않았음을 보여준다. 이것은 표적 모집단(target population)에서 40대 미만을 제거해야 하리 필요가 있다는 것을 알 수 있다 (젊은 환자들의 관찰된 위험이 거의 0이므로).

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/singleShiny/singleShinyCal.png" alt="모델의 보정" width="100%" />
<p class="caption">(\#fig:shinyCal)모델의 보정</p>
</div>

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/singleShiny/singleShinyDemo.png" alt="모델의 인구 통계학적 보정" width="100%" />
<p class="caption">(\#fig:shinyDemo)모델의 인구 통계학적 보정</p>
</div>

마지막으로, 손실표(attrition plot)는 선정/제외 기준에 기초한 라벨링 된 데이터에서 손실된 환자의 수를 나타낸다 (그림 \@ref(fig:shinyAtt)참조). 이 표는 위험에 노출된 전체 기간 동안 관찰되지 않았기 때문에 표적 모집단의 많은 부분을 잃었다는 것을 보여준다 (1년 후). 흥미롭게도, 위험에 노출된 환자들의 수가 완전히 부족하지는 않은 것으로 나타났다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/singleShiny/singleShinyAtt.png" alt="예측 문제의 손실표" width="100%" />
<p class="caption">(\#fig:shinyAtt)예측 문제의 손실표</p>
</div>


### 모형 비교

ATLAS에서 생성된 연구 패키지는 다른 예측 문제에 대해 다양한 예측 모델을 생성하고 평가할 수 있다. 그러므로 연구 패키지에 의해 생성된 결과에 대해 여러 모델을 볼 수 있도록 Shiny 앱이 개발되었다. 앱을 시작하기 위해서는 `execute` 명령을 실행할 때 지정된 분석 결과를 포함하는 경로인 `outputFolder`에 있는 `viewMultiplePlp(outputFolder)`을 실행한다 (그리고 예를 들어 “Analysis_1”이라는 하위 폴더를 포함해야 함).

#### 모형 요약 보기 및 설정 {-}

상호적인 Shiny 앱은 그림 \@ref(fig:multiShinySummary)과 같이 요약 페이지에서 시작된다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyFilter.png" alt="학습된 각 모델에 대한 key hold out set 성능 지표를 포함하는 shiny 요약 페이지" width="100%" />
<p class="caption">(\#fig:multiShinySummary)학습된 각 모델에 대한 key hold out set 성능 지표를 포함하는 shiny 요약 페이지</p>
</div>

요약 페이지 테이블에는 아래 내용이 있다:

- 모형에 관한 기본 정보 (예를 들어, 데이터베이스 정보, 분류 유형, 위험에 노출된 시간 설정, 표적 모집단, 결과명)
- 표적 모집단 수와 결과 발생률
- 예측 행렬(discrimination metrics): AUC, AUPRC

표 왼쪽에는 필터 옵션이 있는데 여기서는 초점을 맞출 개발/검증 데이터베이스, 모형 유형, 관심 있는 위험에 노출된 시간 설정 그리고/또는 관심 코호트가 있다. 예를 들어, 표적 모집단 “고혈압의 일차 단일 요법으로 ACE 억제제의 신규 사용자[New users of ACE inhibitors as first line mono-therapy for hypertension”에 해당하는 모델을 선택하려면 *표적 코호트[Target Cohort]* 옵션을 선택하면 된다.

해당 행을 클릭하여 모형을 탐색하면, 선택된 행이 강조 표시된다. 행을 선택하면 *모형 설정[Model Settings]* 탭을 클릭하여 모형을 개발할 때 사용되는 모형 설정을 탐색할 수 있다:

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyModel.png" alt="모델을 개발할 때 사용되는 모델 설정 보기." width="100%" />
<p class="caption">(\#fig:shinyModel)모델을 개발할 때 사용되는 모델 설정 보기.</p>
</div>

비슷하게, 다른 탭에서 모형을 생성하는데 사용된 모집단과 공변량 설정을 탐색할 수 있다.

#### 모형 성능 보기 {-}

일단 모형 행을 선택하면 모델 성능도 볼 수 있다. 임계값 성능 요약을 보기위하여 ![](images/PatientLevelPrediction/performance.png) 를 클릭하면 그림 \@ref(fig:shinyPerformanceSum)처럼 나타난다. 

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyPerformanceSum.png" alt="요약 성능은 설정된 임계값을 측정한다." width="100%" />
<p class="caption">(\#fig:shinyPerformanceSum)요약 성능은 설정된 임계값을 측정한다.</p>
</div>

이 요약 보기에서는 선택한 예측 질문을 표준 형식, 임계값 선택기(threshold selector)  및 대시보드에 양성예측도(PPV), 음성예측도(NPV), 민감도 및 특이도 (\@ref(performance)장 참조) 와 같은 주요 임계값 기반 메트릭을 포함하고 있다. 그림 \@ref(fig:shinyPerformanceSum)에서 0.00482 임계값에서 민감도는 83.4% (다음 해(following year)에 결과를 가진 83.4% 환자가 0.00482보다 크거나 같은 위험을 가지고 있다) 이고 PPV는 1.2% (0.00482보다 크거나 같은 위험을 가진 환자의 1.2%는 다음 해에 그 결과를 가진다) 이다. 연간 결과 발생률이 0.741%이므로 위험이 0.00482보다 크거나 같은 환자를 식별하는 것은 모집단의 평균 위험의 거의 두 배가 되는 환자의 하위그룹에서 찾을 수 있다. 다른 값의 실행을 보여주는 슬라이더를 사용하여 임계값을 조정할 수 있다.

모델의 전체적인 예측력을 보려면 “Discrimination” 탭을 클릭하면 ROC 도표, 정밀도-검출률(precision-recall) 도표, 분포 도표를 볼 수 있다. 그림의 선은 선택한 임계값 포인트에 해당한다. 그림 \@ref(fig:shinyPerformanceDisc)는 ROC와 정밀도-검출률 도표를 보여준다. ROC 도표는 모형이 연내에 결과를 얻을 사람과 그렇지 않은 사람을 구별할 수 있음을 보여준다. 그러나 결과 발생률이 낮다는 것은 거짓 양성률이 높다는 것을 의미하기 때문에 정밀도-재현율 도표를 보면 그 실행이 덜 인상적으로 보인다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyPerformanceDisc.png" alt="모델의 전체적인 예측력에 접근하기 위해 사용되는 ROC와 정밀도-검출률 도표." width="100%" />
<p class="caption">(\#fig:shinyPerformanceDisc)모델의 전체적인 예측력에 접근하기 위해 사용되는 ROC와 정밀도-검출률 도표.</p>
</div>

그림 \@ref(fig:shinyPerformanceDist)는 예측과 선호 점수 분포를 보여준다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyPerformanceDist.png" alt="결과를 가지거나 가지고 있지 않은 경우를 모두 포함하는 예측된 위험 분포. 이것들이 중복될수록 그 차별은 더 심해진다." width="100%" />
<p class="caption">(\#fig:shinyPerformanceDist)결과를 가지거나 가지고 있지 않은 경우를 모두 포함하는 예측된 위험 분포. 이것들이 중복될수록 그 차별은 더 심해진다.</p>
</div>

마지막으로 “Calibration” 탭을 클릭하여 모형의 적합력(calibration)을 검사할 수 있다. 그림 \@ref(fig:shinyPerformanceCal)은 적합력 그림과 인구통계학적 적합력을 보여준다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyPerformanceCal.png" alt="위험 계층화 보정 및 인구통계학적 보정" width="100%" />
<p class="caption">(\#fig:shinyPerformanceCal)위험 계층화 보정 및 인구통계학적 보정</p>
</div>


평균 예측 위험은 1년 이내 결과를 경험한 관측된 비율과 일치하는 것으로 나타나므로 모델은 잘 보정되어 있다. 흥미롭게도 인구통계학적 적합력은 기대 선이 젊은 환자들에게 관찰된 선보다 더 높게 나왔다는 것을 보여주어서 젊은 연령 집단이 더 높은 위험을 예측한다. 이것은 젊은 환자나 고령 환자를 위한 별도의 모델을 개발해야 할 수도 있다.


#### 모형 확인 {-}

최종 모형을 확인하려면 왼쪽 메뉴에서 ![](images/PatientLevelPrediction/modelButton.png) 옵션을 선택하면 된다. 옵션을 선택하면 그림 \@ref(fig:shinyModelPlots)과 \@ref(fig:shinyModelTable)과 같이 모형의 각 변수에 대한 그래프와 공변량에 대한 요약표를 볼 수 있다. 변수 그래프는 범주형 변수와 연속형 변수로 구분된다. x축은 결과가 없는 환자의 유병률/평균이고 y축은 결과가 있는 환자의 유병률/평균이다. 그래프를 보면 결과가 있는 환자는 대각선 아래보다 대각선 위에 더 많이 분포하고 있다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyModelPlots.png" alt="모형 요약 도표. 각 점은 모델에 포함된 변수에 해당한다." width="100%" />
<p class="caption">(\#fig:shinyModelPlots)모형 요약 도표. 각 점은 모델에 포함된 변수에 해당한다.</p>
</div>

그림 \@ref(fig:shinyModelTable)의 표에는 공변량과 공변량으로 사용될 수 있는 모든 변수의 값 (일반 선형 모형을 사용할 경우 계수, 그렇지 않을 경우 변수 중요도), 그리고 결과 평균 (결과가 있는 사람들의 평균), 비결과 평균 (결과가 없는 사람들의 평균) 이 나타나 있다.

<div class="figure" style="text-align: center">
<img src="images/PatientLevelPrediction/shiny/shinyModelTable.png" alt="모델 세부사항 표." width="100%" />
<p class="caption">(\#fig:shinyModelTable)모델 세부사항 표.</p>
</div>

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">예측 모형은 인과관계를 판단하는 모형이 아니며 예측 변수들을 결과의 원인으로 오인해서는 안된다. 그림 \@ref(fig:shinyModelTable)의 변수를 수정해도 결과의 위험에 영향을 미친다는 보장은 없다.</div>\EndKnitrBlock{rmdimportant}

## 추가적 환자-수준 예측 변수

### 저널에 논문 작성

저널에 논문을 실을 때 목차를 자동으로 생성하는 기능이 추가되었다. 이 기능에는 작성된 연구의 많은 세부사항과 결과들을 포함한다. 외적 타당도를 수행한 경우 그 결과도 추가 할 수 있다. 선택적으로, 표적 집단의 공변량이 포함된 표를 추가할 수 있다. 다음 기능을 사용하여 학술지의 초안을 작성할 수 있다:


```r
 createPlpJournalDocument(plpResult = <your plp results>,
             plpValidation = <your validation results>,
             plpData = <your plp data>,
             targetName = "<target population>",
             outcomeName = "<outcome>",
             table1 = F,
             connectionDetails = NULL,
             includeTrain = FALSE,
             includeTest = TRUE,
             includePredictionPicture = TRUE,
             includeAttritionPlot = TRUE,
             outputLocation = "<your location>")
```

더욱 자세한 내용에 대해서는 기능의 도움 페이지를 참조하십시오.

## 요약

\BeginKnitrBlock{rmdsummary}<div class="rmdsummary">- 환자-수준 예측은 과거의 데이터를 사용하여 미래의 사건을 예측하는 모형을 개발하는 것을 목표로 한다.

- 모형 개발을 위한 최고의 머신 알고리즘 선택은 경험적인 문제이다. 즉 당면한 문제와 데이터에 의해 결정된다.

- PatientLevelPrediction 패키지는 OMOP-CDM의 데이터를 사용하여 예측 모형을 개발하고 검증하기 위한 사례를 제공한다.

- 모형 예측 및 모형 성능 측도는 인터랙티브 대시보드(interactive dashboard)로 수행된다.

- OHDSI의 예측 프레임워크는 임상 허가의 전제 조건인 예측 모형의 대규모 외적 타당도 검증을 가능하게 한다.
</div>\EndKnitrBlock{rmdsummary}

## 예제

#### 전제조건 {-}

이 내용을 연습하기 위하여 \@ref(installR)절에 설명한 대로 R, R-Studio, Java가 설치돼야 한다. 또한 SqlRender, DatabaseConnector, Eunomia, 그리고 PatientLevelPrediction 패키지도 필요하며 다음을 설치하면 된다:
[SqlRender](https://ohdsi.github.io/SqlRender/), [DatabaseConnector](https://ohdsi.github.io/DatabaseConnector/), [Eunomia](https://ohdsi.github.io/Eunomia/) and [PatientLevelPrediction](https://ohdsi.github.io/PatientLevelPrediction/) 


```r
install.packages(c("SqlRender", "DatabaseConnector", "devtools"))
devtools::install_github("ohdsi/Eunomia", ref = "v1.0.0")
devtools::install_github("ohdsi/PatientLevelPrediction")
```

Eunomia 패키지는 R에서 실행될 CDM에 있는 훈련된 데이터를 제공한다. 세부 내용은 다음을 통해 확인 할 수 있다:


```r
connectionDetails <- Eunomia::getEunomiaConnectionDetails()
```

CDM 데이터베이스 스키마는 “main”이다.  이 예제들은 여러 코호트를 사용한다.  Eunomia 패키지의 `createCohorts` 함수는 코호트 테이블에서 다음과 같이 작성된다:


```r
Eunomia::createCohorts(connectionDetails)
```

#### 문제 정의 {-}

> NSAID를 처음 사용하기 시작한 환자의 경우, 내년에 위장관 출혈(GI)을 일으킬지 예측하자.

NSAID 신규 사용자 코호트는 COHORT_DEFINITION_ID = 4를 갖고, 위장관 출혈 코호트는 COHORT_DEFINITION_ID = 3을 갖는다.

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:exercisePlp1"><strong>(\#exr:exercisePlp1) </strong></span>PatientLevelPrediction R 패키지를 사용하여 예측에 사용할 공변량을 정의하고, CDM에서 PLP 데이터를 추출하고, PLP 데이터를 요약하십시오.
</div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:exercisePlp2"><strong>(\#exr:exercisePlp2) </strong></span>최종 모집단을 정의하고 `createStudyPopulation` 함수를 사용하여 이를 지정하기 위해 디자인 선택을 다시 검토해야 한다. 선택한 것이 최종 모집단의 크기에 어떤 영향을 미칠 것인가?
  </div>\EndKnitrBlock{exercise}

\BeginKnitrBlock{exercise}<div class="exercise"><span class="exercise" id="exr:exercisePlp3"><strong>(\#exr:exercisePlp3) </strong></span>LASSO를 사용하여 예측 모델을 만들고 Shiny 어플리케이션을 사용하여 성능을 평가해야 한다. 모델 성능은 어느 정도인가? 추천 답변은 부록 E.9에서 확인 할 수 있다.
  </div>\EndKnitrBlock{exercise}

제안된 답변은 부록 \@ref(Plpanswers)에서 찾을 수 있다.
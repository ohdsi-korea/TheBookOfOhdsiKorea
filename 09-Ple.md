# Population-Level Estimation {#PopulationLevelEstimation}

*Chapter leads: Martijn Schuemie, David Madigan, Marc Suchard & Patrick Ryan*
*번역: 양영모, 유승찬*

\index{population-level estimation}

Observational healthcare data(예: administrative claims, electronic health records)는 환자의 삶을 의미 있게 향상시킬 수 있는 치료효과에 대한 실제 증거를 생성할 수 있는 기회를 제공한다. 이 장에서는 인구 수준 효과 추정(population-level effect estimation), 즉 특정 건강 결과에 대한 노출(예: 약물 노출 또는 절차와 같은 의료개입)의 평균 인과 관계 효과에 대한 추정에 초점을 맞춘다. 두 가지의 다른 추정 업무를 고려한다.

- **직접 효과 추정(direct effect estimation)**: 노출 위험과 결과의 위험에 대한 노출 효과를 추정. \index{direct effect estimation}
- **비교 효과 추정(comparative effect estimation)**: 다른 노출(comparator exposure)과 비교하여 노출(target exposure)의 결과 위험에 대한 영향 추정. \index{comparative effect estimation}

In both cases, the patient-level causal effect contrasts a factual outcome, i.e., what happened to the exposed patient, with a counterfactual outcome, i.e., what would have happened had the exposure not occurred (direct) or had a different exposure occurred (comparative). Since any one patient reveals only the factual outcome (the fundamental problem of causal inference), the various effect estimation designs employ different analytic devices to shed light on the counterfactual outcomes. \index{counterfactual}

인구 수준 효과 추정의 사용 사례(use-cases)는 치료선택, 안전 감시(safety surveillance), 비교 효과(comparative effectiveness)를 포함한다. 방법은 특정 가설을 한 번에 하나씩 테스트(예: signal evaluation)하거나 다중 가설을 한 번에 탐색(예: signal detection)할 수 있다. 모든 경우에 있어, 목적은 고품질의 인과 관계 추정을 산출하는 것이다. \index{safety surveillance} \index{comparative effectiveness|see {comparative effect estimation}}

이 장에서는 우선 [OHDSI Methods Library](https://ohdsi.github.io/MethodsLibrary/)에 R 패키지로 구현되어 있는 다양한 **Population-Level Estimation** study design를 설명한다. 예제 평가 연구의 설계를 자세히 설명한 다음, ATLAS 및 R을 사용하여 설계를 구현하는 방법에 대한 단계별 가이드를 또한 설명한다.
마지막으로 연구 진단 및 효과 크기 추정을 포함하여 연구에서 생성된 다양한 결과를 검토한다.

## The cohort method design {#CohortMethod}

\index{cohort method}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/cohortMethod.png" alt="대상 치료(target treatment)를 시작하기 위해 관찰된 대상은 비교 대상 치료(comparator treatment)를 시작한 대상과 비교된다. 두 치료군 간의 차이를 조정하기 위해 층화(stratification), 매칭(matching), 성향 점수에 의한 가중치 부여 (weighting), 결과 모델에 기저 특징(baseline characteristics) 보정 추가와 같은 다양한 조정 방법(adjustment strategy)을 사용할 수 있다. 성향 모델 (Propensity model) 또는 결과 모델 (Outcome model)에 포함된 특징은 치료 시작 전에 결정된다." width="90%" />
<p class="caption">(\#fig:cohortMethod)대상 치료(target treatment)를 시작하기 위해 관찰된 대상은 비교 대상 치료(comparator treatment)를 시작한 대상과 비교된다. 두 치료군 간의 차이를 조정하기 위해 층화(stratification), 매칭(matching), 성향 점수에 의한 가중치 부여 (weighting), 결과 모델에 기저 특징(baseline characteristics) 보정 추가와 같은 다양한 조정 방법(adjustment strategy)을 사용할 수 있다. 성향 모델 (Propensity model) 또는 결과 모델 (Outcome model)에 포함된 특징은 치료 시작 전에 결정된다.</p>
</div>

코호트 방법은 무작위 임상 시험을 모방하려고 한다[@hernan_2016]. 하나의 치료를 시작한 환자(target)는 다른 치료를 시작한 환자(comparator)와 비교되고, 치료를 받은 후 특정 기간 동안(예: 치료를 받는 기간) 추적 관찰된다. 표 13.1에서 강조하는 5가지 사항을 선택함으로써 코호트 연구에서 연구자가 얻기 원하는 답에 대한 질문을 지정할 수 있다. \@ref(tab:cmChoices). \index{target cohort!cohort method} \index{comparator cohort} \index{outcome cohort!cohort method}


Table: (\#tab:cmChoices) Main design choices in a comparative cohort design.

| Choice            | Description                                              |
|:----------------- |:-------------------------------------------------------- |
| Target cohort     | A cohort representing the target treatment               |
| Comparator cohort | A cohort representing the comparator treatment           |
| Outcome cohort    | A cohort representing the outcome of interest            |
| Time-at-risk      | At what time (often relative to the target and comparator cohort start and end dates) do we consider the risk of the outcome?  |
| Model             | The model used to estimate the effect while adjusting for differences between the target and comparator  |

모델 선택은 모델 유형을 지정한다. 예를 들어, 결과가 발생했는지 여부를 평가하고 교차비(odds ratio)를 산출하는 로지스틱 회귀분석(logistic regression)을 사용할 수 있다. 로지스틱 회귀분석은 time-at-risk가 target과 comparator 양쪽 모두에서 같거나 무관하다고 가정한다. 대안으로, 포아송 회귀분석(poisson regression)을 선택할 수 있는데, 이는 일정한 발생률(incidence rate)을 가정하고, 발생률 비율(incidence rate ratio)를 추정한다. 콕스 회귀분석(cox regression)을 종종 사용하기도 하는데, 이는 target과 comparator 사이의 비례 위험(proportional hazard)을 가정하며, 위험 비율(hazard ratio)을 추정하려고 time-to-first-outcome을 고려한다. \index{logistic regression} \index{Poisson regression} \index{Cox regression} \index{Cox proportional hazards model|see {Cox regression}}

New-user cohort method는 본질적으로 하나의 치료를 다른 치료에 비교하여 비교 효과를 추정하는 방법이다. 치료 노출 군의 비교 대상인 치료 비노출 군을 정의하기 힘들어 치료와 비치료를 비교하기 위해 이 방법을 사용하긴 어렵다. 직접 효과 추정에 이 방법을 사용하려는 경우, 결과에 영향을 미치지 않을, 동일한 적응증이 적용되는 비교 대상을 관심 노출군(exposure of interest)으로 선택하는 방법이 선호된다. 하지만, 이러한 비교 대상을 항상 사용할 수 있는 것은 아니다. 

주요 관심사는 치료를 받는 군이 비교 치료를 받는 군과 전체적으로 (systemically) 다를 수 있다는 것이다. 예를 들어, 연구 대상 치료를 받는 실험군 (target cohort)이 평균 60세인 반면, 해당 치료를 받지 않은 대조군 (comparator cohort)이 평균 40세라고 가정하자. 연령과 관련된 건강 결과(예: 뇌졸중)는 양 군간에 상당히 차이가 날 것이다. 이런 정보에 대해 정확히 숙지하지 못한 연구자는 해당 치료가 뇌졸중과 유의미한 인과관계를 보인다고 결론을 내릴 수 있다. 따라서, 해당 치료를 받지 않았다면 실험군의 환자들이 뇌졸중에 걸리지 않을 것이라 생각할 수 있다. 이러한 결과는 전적으로 잘못되었다. 단순히 실험군의 연령이 높기 때문에 뇌졸중을 많이 경험할 수 있기 때문이다. 실험군이 해당 치료를 받지 않았더라도, 뇌졸중의 발병률은 비슷할 수 있다. 여기서 나이는 “confounder”이다. \index{confounder}

### Propensity scores

\index{propensity score}

무작위 시험(randomized trial)에서 (가상의) 동전던지기는 환자를 각각의 그룹에 배정한다. 따라서, 설계상 비교 치료 군과 비교하여 환자가 대상치료를 받을 확률은 어떤 식으로든 연령과 같은 환자의 특성과 관련이 없다. 동전에는 환자에 대한 정보가 없으며, 환자가 대상에 노출될 정확한 확률을 확실하게 알고 있다. 결과적으로 임상시험에서 환자 수가 증가함에 따라 신뢰도가 증가해 두 환자군은 본질적으로 환자 특성에 따라 체계적으로 다를 수 없다. 이 보장된 균형은 trial이 측정한 특성(예: 연령)과 trial이 측정하지 못한 특성에 적용된다. \index{randomized trial}

주어진 환자의 **성향 점수(Propensity score, PS)**는 환자가 비교 치료군과 비교하여 대상 치료를 받을 확률이다 [@rosenbaum_1983]. 균형 잡힌 two-arm 무작위 임상시험에서, 모든 환자의 성향 점수는 0.5이다. 성향 점수 조정된 관찰 연구에서, 우리는 치료개시 시점과 치료개시 전(환자가 실제로 받은 치료와 관계없이)에 관찰할 수 있는 것에 근거해 대상 치료를 받을 환자들의 확률을 추정한다. 이것은 간단한 예측 모델링 응용프로그램이다. 환자가 표적 치료를 받았는지 여부를 예측하는 적합한 모델(예: 로지스틱 회귀분석)을 만들고, 이 모델을 사용하여 각 환자들에 대한 예측 확률을 생성한다. 표준 무작위 임상시험과 달리, 다른 환자는 대상 치료를 받을 확률이 다르다. PS는 여러 가지 방법으로 사용할 수 있다. 예를 들어, target 피험자를 유사한 PS를 가진 comparator 피험자에게 매칭 (PS matching)하거나, PS를 기반으로 연구 집단을 층화 (PS stratification) 하거나, PS에서 파생된 IPTW(Inverse Probability of Treatment Weighting)을 사용하여 피험자에게 가중치를 적용하여 사용할 수 있다. 매칭할 때, 각 대상에 대하여 한 명의 비교 대상을 선택하거나, variable-ratio matching을 활용하여 대상 당 두 명 이상의 비교 대상을 허용할 수 있다. [@rassen_2012] \index{propensity model} \index{propensity score!matching} \index{propensity score!stratification} \index{propensity score!weighting} \index{inverse probability of treatment weighting (IPTW)|see {propensity score!weighting}} \index{variable ratio matching}


예를 들면, one-on-one PS 매칭을 사용한다고 가정하면, Jan은 대상 치료를 받을 확률이 0.4이고, 실제로 대상 치료를 받는다. Jun이라고 하는 환자가 대상 치료를 받을 선험(priori) 확률이 0.4이지만, 사실상 비교 치료를 받았다면, 적어도 measured confounders와 관련하여 Jan과 Jun의 outcome 비교는 mini-randomized trial과 같다. 이 비교는 무작위 시험으로 산출한 결과만큼 양호한 Jan과 Jun의 인과적인 대조를 추정할 것이다. 추정은 다음과 같이 진행된다: 표적을 받은 모든 환자에 대해, 비교 치료를 받았지만 표적을 받는 선험적 확률이 동일한 하나 이상의 일치하는 환자를 찾는다. 대상 환자의 결과와 비교 그룹의 결과를 비교한다.

Propensity scoring은 측정된 교란변수 (measured confounder)를 제어한다. 사실, 측정된 특성 하에서 치료배정(treatment assignment)이 “강하게 무시할 수 있는” 경우라면, 성향 점수는 인과 관계의 비편향적 추정을 산출할 것이다. “강력하게 무시할 수 있는” 이란 측정되지 않은 교란변수가 없고, 측정된 교란변수는 적절하게 조정된다는 것을 의미한다. 불행히도, 이것은 검증할만한 가정은 아니다. \index{strongly ignorable}

>Propensity scoring controls for measured confounders. In fact, if treatment assignment is “strongly ignorable” given measured characteristics, propensity scoring will yield an unbiased estimate of the causal effect. “Strongly ignorable” essentially means that there are no unmeasured confounders, and that the measured confounders are adjusted for appropriately. Unfortunately this is not a testable assumption.

### Variable selection {#VariableSelection}

전통적으로, 성향 점수는 임의로 선택된 특성 (manually selected characteristics) 을 기반으로 계산되었다. OHDSI 도구가 그러한 관행을 지원할 수는 있지만, 많은 일반적 특성(즉, 연구의 특정 노출 및 결과에 따라 선택되지 않은 특성)을 포함하는 것을 선호한다. [@tian_2018] 이러한 특성에는 인구학적인 특성뿐만 아니라 치료 개시일 전과 개시일에 관찰된 모든 진단, 약물노출, 측정 및 의료절차가 포함된다. 모델은 전형적으로 10,000 – 100,000가지의 독특한 특성을 포함하며, 이러한 모델은 [Cyclops](https://ohdsi.github.io/Cyclops/) 패키지에서 구현되는 large-scale regularized regression[@suchard_2013]을 사용하여 적합화시킨다.

치료로 이어지는 진단과 같은 많은 관련 데이터 포인트가 치료 개시일을 기준으로 기록되기 때문에 일반적으로 공변량 캡쳐 윈도우(covariate capture window)에 치료 개시일을 포함시킨다. **그렇기 때문에 변수에서 표적과 비교 치료법을 명시적으로 배제할 것을 요구한다.** 왜냐하면, 이것이 예측하려고 하는 것들이기 때문이다.

>We typically include the day of treatment initiation in the covariate capture window because many relevant data points such as the diagnosis leading to the treatment are recorded on that date. This does require us to explicitly exclude the target and comparator treatment from the set of covariates, because these are the things we are trying to predict.

일부는 “올바른” 인과 관계 구조를 지정하기 위해 임상 전문 지식에 의존하지 않는 공변량 선정에 대한 데이터 중심 접근 방식은 소위 기계적 변수 및 충돌자(collider)를 잘못 포함하여 분산을 증가시키고 잠재적으로 편견을 유발할 위험을 내포하고 있다고 주장한다. [@hernan_2002] 그러나 이러한 우려는 실제 시나리오에 큰 영향을 미치지 않을 것이다.[@schneeweiss_2018] 또한 의학에서 진정한 인과관계 구조는 거의 알려지지 않았으며, 다른 연구자가 특정 연구 질문에 포함시킬 “올바른” 공변량을 확인하도록 요청할 때 각 연구자는 언제나 다른 목록을 제시하므로 그 과정은 재현 불가능하다. 가장 중요한 점은, 성향 모델 검사, 모든 공변량의 균형 평가, 부정적인 통제를 포함하는 진단은 충돌자 및 도구 변수와 관련된 대부분의 문제를 확인하는 것이다. \index{instrumental variables} \index{colliders}

>Some have argued that a data-driven approach to covariate selection that does not depend on clinical expertise to specify the "right" causal structure runs the risk of erroneously including so-called instrumental variables and colliders, thus increasing variance and potentially introducing bias. [@hernan_2002] However, these concerns are unlikely to have a large impact in real-world scenarios. [@schneeweiss_2018] Furthermore, in medicine the true causal structure is rarely known, and when different researchers are asked to identify the ‘right’ covariates to include for a specific research question, each researcher invariably comes up with a different list, thus making the process irreproducible. Most importantly, our diagnostics such as inspection of the propensity model, evaluating balance on all covariates, and including negative controls would identify most problems related to colliders and instrumental variables.

### Caliper

\index{caliper}

성향 점수가 0에서 1까지의 연속성을 갖기 때문에 정확한 일치는 거의 불가능하다. 그 대신, 매칭 프로세스는 대상 환자의 성향 점수와 일치하는 환자를 “캘리퍼 (caliper)”라고 알려진 내성 범위 내에서 찾는다. 이전 연구 [@austin_2011]에 따라, 우리는 로짓 척도에서 0.2 표준편차의 기본(default) 캘리퍼를 사용한다.

### Overlap: preference scores

\index{preference score}

성향 매칭 방법은 일치하는 환자가 필요하다! 따라서 주요 진단은 두 그룹의 성향 점수 분포를 보여준다. 해석을 용이하게 하기 위해 OHDSI 도구는 “선호 점수(preference score)”라는 성향 점수의 변형을 그린다.[@walker_2013] 선호 점수는 두 가지 치료법의 “market share”을 조정하다. 예를 들면, 10%의 환자가 대상 치료를 받고(90%가 비교 치료를 받는 경우), 선호 점수가 0.5인 환자는 대상 치료를 받을 확률이 10%이다. 수학적으로 선호 점수는

$$\ln\left(\frac{F}{1-F}\right)=\ln\left(\frac{S}{1-S}\right)-\ln\left(\frac{P}{1-P}\right)$$

여기서 $F$ 는 선호 점수 (preference score), $S$ 는 성향 점수 (propensity score), 그리고 $P$ 는 대상치료를 받은 환자의 비율 ( proportion of patients receiving the target treatment) 이다.

@walker_2013 는 “경험적 평형(empirical equipoise)”의 개념을 논의한다. 적어도 노출의 절반이 0.3과 0.7사이의 선호 점수를 갖는 환자에게 노출쌍(exposure pair)이 경험적 평형에서 나오는 것으로 받아 들인다. \index{clinical equipoise}

>@walker_2013 discuss the concept of “empirical equipoise.” They accept exposure pairs as emerging from empirical equipoise if at least half of the exposures are to patients with a preference score of between 0.3 and 0.7. 

### Balance

\index{covariate balance} \index{balance|see {covariate balance}}

좋은 방침(good practice)은 PS 조정이 균형 잡힌 환자 그룹을 만드는데 성공했는지 항상 확인하는 것이다. 그림 \@ref(fig:balance) 은 균형을 점검하기 위한 표준 OHDSI 출력물을 보여준다. 각 환자의 특성에 대해 PS 조정 전과 후에 두 노출 그룹간의 평균 차이를 표준화한다. 일부 지침에서는 조정 후 표준화된 차이의 상한 0.1을 권장한다. [@rubin_2001]

## The self-controlled cohort design

\index{self-controlled cohort design}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/selfControlledCohort.png" alt="The self-controlled cohort design. The rate of outcomes during exposure to the target is compared to the rate of outcomes in the time pre-exposure." width="90%" />
<p class="caption">(\#fig:scc)The self-controlled cohort design. The rate of outcomes during exposure to the target is compared to the rate of outcomes in the time pre-exposure.</p>
</div>

The self-controlled cohort (SCC) design [@ryan_2013] compares the rate of outcomes during exposure to the rate of outcomes in the time just prior to the exposure. The  four choices shown in Table \@ref(tab:sccChoices) define a self-controlled cohort question. \index{target cohort!self-controlled cohort design} \index{outcome cohort!self-controlled cohort design}

Table: (\#tab:sccChoices) Main design choices in a self-controlled cohort design.

| Choice            | Description                                              |
|:----------------- |:-------------------------------------------------------- |
| Target cohort     | A cohort representing the treatment                      |
| Outcome cohort    | A cohort representing the outcome of interest            |
| Time-at-risk      | At what time (often relative to the target cohort start and end dates) do we consider the risk of the outcome?  |
| Control time      | The time period used as the control time                 |

Because the same subject that make up the exposed group are also used as the control group, no adjustment for between-person differences need to be made. However, the method is vulnerable to other differences, such as differences in the baseline risk of the outcome between different time periods.

## The case-control design

\index{case-control design}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/caseControl.png" alt="The case-control design. Subjects with the outcome (‘cases’) are compared to subjects without the outcome (‘controls’) in terms of their exposure status. Often, cases and controls are matched on various characteristics such as age and sex." width="90%" />
<p class="caption">(\#fig:caseControl)The case-control design. Subjects with the outcome (‘cases’) are compared to subjects without the outcome (‘controls’) in terms of their exposure status. Often, cases and controls are matched on various characteristics such as age and sex.</p>
</div>

Case-control studies [@vandenbroucke_2012] consider the question “are persons with a specific disease outcome exposed more frequently to a specific agent than those without the disease?” Thus, the central idea is to compare “cases,” i.e., subjects that experience the outcome of interest, with “controls,” i.e., subjects that did not experience the outcome of interest. The choices in Table \@ref(tab:ccChoices) define a case-control question. \index{outcome cohort!case-control design} \index{target cohort!case-control design} \index{nesting cohort!case-control design}

Table: (\#tab:ccChoices) Main design choices in a case-control design.

| Choice            | Description                                               |
|:----------------- |:--------------------------------------------------------- |
| Outcome cohort    | A cohort representing the cases (the outcome of interest) |
| Control cohort    | A cohort representing the controls. Typically the control cohort is automatically derived from the outcome cohort using some selection logic |
| Target cohort     | A cohort representing the treatment                       |
| Nesting cohort  | Optionally, a cohort defining the subpopulation from which cases and controls are drawn  |
| Time-at-risk      | At what time (often relative to the index date) do we consider exposure status?  |

Often, one selects controls to match cases based on characteristics such as age and sex to make them more comparable. Another widespread practice is to nest the analysis within a specific subgroup of people, for example people that have all been diagnosed with one of the indications of the exposure of interest.

## The case-crossover design

\index{case-crossover design}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/caseCrossover.png" alt="The case-crossover design. The time around the outcome is compared to a control date set at a predefined interval prior to the outcome date." width="90%" />
<p class="caption">(\#fig:caseCrossover)The case-crossover design. The time around the outcome is compared to a control date set at a predefined interval prior to the outcome date.</p>
</div>

The case-crossover [@maclure_1991] design evaluates whether the rate of exposure is different at the time of the outcome than at some predefined number of days prior to the outcome. It is trying to determine whether there is something special about the day the outcome occurred. Table \@ref(tab:ccrChoices) shows the choices that define a case-crossover question. \index{outcome cohort!case-crossover design} \index{target cohort!case-crossover design}

Table: (\#tab:ccrChoices) Main design choices in a case-crossover design.

| Choice            | Description                                              |
|:----------------- |:-------------------------------------------------------- |
| Outcome cohort    | A cohort representing the cases (the outcome of interest)  |
| Target cohort     | A cohort representing the treatment  |
| Time-at-risk      | At what time (often relative to the index date) do we consider exposure status?  |
| Control time      | The time period used as the control time                 |

Cases serve as their own controls. As self-controlled designs, they should be robust to confounding due to between-person differences. One concern is that, because the outcome date is always later than the control date, the method will be positively biased if the overall frequency of exposure increases over time (or negatively biased if there is a decrease). To address this, the case-time-control design [@suissa_1995] was developed, which adds controls, matched for example on age and sex, to the case-crossover design to adjust for exposure trends. \index{case-time-control design}

## The self-controlled case series design

\index{self-controlled case series (SCCS) design}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/selfControlledCaseSeries.png" alt="The Self-Controlled Case Series design. The rate of outcomes during exposure is compared to the rate of outcomes when not exposed." width="90%" />
<p class="caption">(\#fig:selfControlledCaseSeries)The Self-Controlled Case Series design. The rate of outcomes during exposure is compared to the rate of outcomes when not exposed.</p>
</div>

The Self-Controlled Case Series (SCCS) design [@farrington_1995; @whitaker_2006] compares the rate of outcomes during exposure to the rate of outcomes during all unexposed time, including before, between, and after exposures. It is a Poisson regression that is conditioned on the person. Thus, it seeks to answer the question: “Given that a patient has the outcome, is the outcome more likely during exposed time compared to non-exposed time?”. The choices in Table \@ref(tab:sccsChoices) define an SCCS question. \index{outcome cohort!SCCS design} \index{target cohort!SCCS design}

Table: (\#tab:sccsChoices) Main design choices in a self-controlled case series design.

| Choice            | Description                                              |
|:----------------- |:-------------------------------------------------------- |
| Target cohort     | A cohort representing the treatment                      |
| Outcome cohort    | A cohort representing the outcome of interest            |
| Time-at-risk      | At what time (often relative to the target cohort start and end dates) do we consider the risk of the outcome?  |
| Model             | The model to estimate the effect, including any adjustments for time-varying confounders |

Like other self-controlled designs, the SCCS is robust to confounding due to between-person differences, but vulnerable to confounding due to time-varying effects. Several adjustments are possible to attempt to account for these, for example by including age and season. A special variant of the SCCS includes not just the exposure of interest, but all other exposures to drugs recorded in the database  [@simpson_2013] potentially adding thousands of additional variables to the model. L1-regularization using cross-validation to select the regularization hyperparameter is applied to the coefficients of all exposures except the exposure of interest.

One important assumption underlying the SCCS is that the observation period end is independent of the date of the outcome. For some outcomes, especially ones that can be fatal such as stroke, this assumption can be violated. An extension to the SCCS has been developed that corrects for any such dependency. [@farrington_2011]


## Designing a hypertension study


### Problem definition

ACE inhibitors (ACEi) are widely used in patients with hypertension or ischemic heart disease, especially those with other comorbidities such as congestive heart failure, diabetes mellitus, or chronic kidney disease. [@zaman_2002] Angioedema, a serious and sometimes life-threatening adverse event that usually manifests as swelling of the lips, tongue, mouth, larynx, pharynx, or periorbital region, has been linked to the use of these medications. [@sabroe_1997] However, limited information is available about the absolute and relative risks for angioedema associated with the use of these medications. Existing evidence is primarily based on investigations of specific cohorts (e.g., predominantly male veterans or Medicaid beneficiaries) whose findings may not be generalizable to other populations, or based on investigations with few events, which provide unstable risk estimates [@powers_2012]. Several observational studies compare ACEi to beta-blockers for the risk of angioedema, [@magid_2010; @toh_2012] but beta-blockers are no longer recommended as first-line treatment of hypertension. [@whelton_2018] A viable alternative treatment could be thiazides or thiazide-like diuretics (THZ), which could be just as effective in managing hypertension and its associated risks such as acute myocardial infarction (AMI), but without increasing the risk of angioedema.

The following will demonstrate how to apply our population-level estimation framework to observational healthcare data to address the following comparative estimation questions:

> What is the risk of angioedema in new users of ACE inhibitors compared to new users of thiazide and thiazide-like diuretics?

> What is the risk of acute myocaridal infarction in new users of ACE inhibitors compared to new users of thiazide and thiazide-like diuretics?

Since these are comparative effect estimation questions we will apply the cohort method as described in Cohort Method Section.

### Target and comparator

We consider patients new-users if their first observed treatment for hypertension was monotherapy with any active ingredient in either the ACEi or THZ class. We define mono therapy as not starting on any other anti-hypertensive drug in the seven days following treatment initiation. We require patients to have at least one year of prior continuous observation in the database before first exposure and a recorded hypertension diagnosis at or in the year preceding treatment initiation.

### Outcome

We define angioedema as any occurrence of an angioedema condition concept during an inpatient or emergency room (ER) visit, and require there to be no angioedema diagnosis recorded in the seven days prior. We define AMI as any occurrence of an AMI condition concept during an inpatient or ER visit, and require there to be no AMI diagnosis record in the 180 days prior.

### Time-at-risk

We define time-at-risk to start on the day after treatment initiation, and stop when exposure stops, allowing for a 30-day gap between subsequent drug exposures.

### Model

We  fit a PS model using the default set of covariates, including demographics, conditions, drugs, procedures, measurements, observations, and several co-morbidity scores. We exclude ACEi and THZ from the covariates. We perform variable-ratio matching and condition the Cox regression on the matched sets.

### Study summary

Table: (\#tab:aceChoices) Main design choices for our comparative cohort study.

| Choice            | Value                                                    |
|:----------------- |:-------------------------------------------------------- |
| Target cohort     | New users of ACE inhibitors as first-line monotherapy for hypertension. |
| Comparator cohort | New users of thiazides or thiazide-like diuretics as first-line monotherapy for hypertension. |
| Outcome cohort    | Angioedema or acute myocardial infarction. |
| Time-at-risk      | Starting the day after treatment initiation, stopping when exposure stops. |
| Model             | Cox proportional hazards model using variable-ratio matching. |

### Control questions

To evaluate whether our study design produces estimates in line with the truth, we additionally include a set of control questions where the true effect size is known. Control questions can be divided in negative controls, having a hazard ratio of 1, and positive controls, having a known hazard ratio greater than 1. For several reasons we use real negative controls, and synthesize positive controls based on these negative controls. How to define and use control questions is discussed in detail in Method Validity Chapter.


## Implementing the study using ATLAS {#PleAtlas}

Here we demonstrate how this study can be implemented using the Estimation function in ATLAS. Click on ![](images/PopulationLevelEstimation/estimation.png) in the left bar of ATLAS, and create a new estimation study. Make sure to give the study an easy-to-recognize name. The study design can be saved at any time by clicking the ![](images/PopulationLevelEstimation/save.png) button.

In the Estimation design function, there are three sections: Comparisons, Analysis Settings, and Evaluation Settings. We can specify multiple comparisons and multiple analysis settings, and ATLAS will execute all combinations of these as separate analyses. Here we discuss each section:

### Comparative cohort settings {#ComparisonSettings}

A study can have one or more comparisons. Click on "Add Comparison," which will open a new dialog. Click on ![](images/PopulationLevelEstimation/open.png) to select the target and  comparator cohorts. By clicking on "Add Outcome" we can add our two outcome cohorts. We assume the cohorts have already been created in ATLAS as described in Cohorts Chapter. 

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/comparisons.png" alt="The comparison dialog" width="100%" />
<p class="caption">(\#fig:comparisons)The comparison dialog</p>
</div>

Note that we can select multiple outcomes for a target-comparator pair. Each outcome will be treated independently, and will result in a separate analysis.

**Negative control outcomes**

Negative control outcomes are outcomes that are not believed to be caused by either the target or the comparator, and where therefore the true hazard ratio equals 1. Ideally, we would have proper cohort definitions for each outcome cohort. However, typically, we only have a concept set, with one concept per negative control outcome, and some standard logic to turn these into outcome cohorts. Here we assume the concept set has already been created as described in Method Validity Chapter and can simply be selected. The negative control concept set should contain a concept per negative control, and not include descendants. Figure \@ref(fig:ncConceptSet) shows the negative control concept set used for this study.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/ncConceptSet.png" alt="Negative Control concept set." width="100%" />
<p class="caption">(\#fig:ncConceptSet)Negative Control concept set.</p>
</div>

**Concepts to include**

[//]: # (TODO: Update these sections when ATLAS interface has been updated.)

When selecting concept to include, we can specify which covariates we would like to generate, for example to use in a propensity model. When specifying covariates here, all other covariates (aside from those you specified) are left out. We usually want to include all baseline covariates, letting the regularized regression build a model that balances all covariates. The only reason we might want to specify particular covariates is to replicate an existing study that manually picked covariates. These inclusions can be specified in this comparison section or in the analysis section, because sometimes they pertain to a specific comparison (e.g. know confounders in a comparison), or sometimes they pertain to an analysis (e.g. when evaluating a particular covariate selection strategy).

**Concepts to exclude**

Rather than specifying which concepts to include, we can instead specify concepts to *exclude*. When we submit a concept set in this field, we use every covariate except for those that we submitted. When using the default set of covariates, which includes all drugs and procedures occurring on the day of treatment initiation, we must exclude the target and comparator treatment, as well as any concepts that are directly related to these. For example, if the target exposure is an injectable, we should not only exclude the drug, but also the injection procedure from the propensity model. In this example, the covariates we want to exclude are ACEi and THZ. Figure \@ref(fig:covsToExclude) shows we select a concept set that includes all these concepts.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/covsToExclude.png" alt="The concept set defining the concepts to exclude." width="100%" />
<p class="caption">(\#fig:covsToExclude)The concept set defining the concepts to exclude.</p>
</div>

After selecting the negative controls and covariates to exclude, the lower half of the comparisons dialog should look like Figure \@ref(fig:comparisons2).

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/comparisons2.png" alt="The comparison window showing concept sets for negative controls and concepts to exclude." width="100%" />
<p class="caption">(\#fig:comparisons2)The comparison window showing concept sets for negative controls and concepts to exclude.</p>
</div>

### Effect estimation analysis settings

After closing the comparisons dialog we can click on "Add Analysis Settings." In the box labeled "Analysis Name," we can give the analysis a unique name that is easy to remember and locate in the future. For example, we could set the name to "Propensity score matching."

**Study population**

There are a wide range of options to specify the study population, which is the set of subjects that will enter the analysis. Many of these overlap with options available when designing the target and comparator cohorts in the cohort definition tool. One  reason for using the options in Estimation instead of in the cohort definition is re-usability; we can define the target, comparator, and outcome cohorts completely independently, and add dependencies between these at a later point in time. For example, if we wish to remove people who had the outcome before treatment initiation, we could do so in the definitions of the target and comparator cohort, but then we would need to create separate cohorts for every outcome! Instead, we can choose to have people with prior outcomes be removed in the analysis settings, and now we can reuse our target and comparator cohorts for our two outcomes of interest (as well as our negative control outcomes).

The **study start and end dates** can be used to limit the analyses to a specific period. The study end date also truncates risk windows, meaning no outcomes beyond the study end date will be considered. One reason for selecting a study start date might be that one of the drugs being studied is new and did not exist in an earlier time. Automatically adjusting for this can be done by answering “yes” to the question "**Restrict the analysis to the period when both exposures are observed?**". Another reason to adjust study start and end dates might be that medical practice changed over time (e.g., due to a drug warning) and we are only interested in the time where medicine was practiced a specific way.

The option "**Should only the first exposure per subject be included?**" can be used to restrict to the first exposure per patient. Often this is already done in the cohort definition, as is the case in this example. Similarly, the option "**The minimum required continuous observation time prior to index date for a person to be included in the cohort**" is often already set in the cohort definition, and can therefore be left at 0 here. Having observed time (as defined in the OBSERVATION_PERIOD table) before the index date ensures that there is sufficient information about the patient to calculate a propensity score, and is also often used to ensure the patient is truly a new user, and therefore was not exposed before.

"**Remove subjects that are in both the target and comparator cohort?**" defines, together with the option "**If a subject is in multiple cohorts, should time-at-risk be censored when the new time-at-risk starts to prevent overlap?**" what happens when a subject is in both target and comparator cohorts. The first setting has three choices:

- "**Keep All**" indicating to keep the subjects in both cohorts. With this option it might be possible to double-count subjects and outcomes.
- "**Keep First**" indicating to keep the subject in the first cohort that occurred.
- "**Remove All**" indicating to remove the subject from both cohorts.

If the options "keep all" or "keep first" are selected, we may wish to censor the time when a person is in both cohorts. This is illustrated in Figure \@ref(fig:tar). By default, the time-at-risk is defined relative to the cohort start and end date. In this example, the time-at-risk starts one day after cohort entry, and stops at cohort end. Without censoring the time-at-risk for the two cohorts might overlap. This is especially problematic if we choose to keep all, because any outcome that occurs during this overlap (as shown) will be counted twice. If we choose to censor, the first cohort's time-at-risk ends when the second cohort's time-at-risk starts.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/tar.png" alt="Time-at-risk (TAR) for subjects who are in both cohorts, assuming time-at-risk starts the day after treatment initiation, and stops at exposure end." width="80%" />
<p class="caption">(\#fig:tar)Time-at-risk (TAR) for subjects who are in both cohorts, assuming time-at-risk starts the day after treatment initiation, and stops at exposure end.</p>
</div>

We can choose to **remove subjects that have the outcome prior to the risk window start**, because often a second outcome occurrence is the continuation of the first one. For instance, when someone develops heart failure, a second occurrence is likely, which means the heart failure probably never fully resolved in between. On the other hand, some outcomes are episodic, and it would be expected for patients to have more than one independent occurrence, like an upper respiratory infection. If we  choose to remove people that had the outcome before, we can select **how many days we should look back when identifying prior outcomes**.

Our choices for our example study are shown in Figure \@ref(fig:studyPopulation). Because our target and comparator cohort definitions already restrict to the first exposure and require observation time prior to treatment initiation, we do not apply these criteria here.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/studyPopulation.png" alt="Study population settings." width="100%" />
<p class="caption">(\#fig:studyPopulation)Study population settings.</p>
</div>

**Covariate settings**

Here we specify the covariates to construct. These covariates are typically used in the propensity model, but can also be included in the outcome model (the Cox proporitional hazards model in this case). If we **click to view details** of our covariate settings, we can select which sets of covariates to construct. However, the recommendation is to use the default set, which constructs covariates for demographics, all conditions, drugs, procedures, measurements, etc.

We can modify the set of covariates by specifying concepts to **include** and/or **exclude**. These settings are the same as the ones found in Comparison Settings Section on comparison settings. The reason why they can be found in two places is because sometimes these settings are related to a specific comparison, as is the case here because we wish to exclude the drugs we are comparing, and sometimes the settings are related to a specific analysis. When executing an analysis for a specific comparison using specific analysis settings, the OHDSI tools will take the union of these sets.

The choice to **add descendants to include or exclude** affects this union of the two settings. So in this example we specified only the ingredients to exclude when defining the comparisons. Here we set "Should descendant concepts be added to the list of excluded concepts?" to "Yes" to also add all descendants.

Figure \@ref(fig:covariateSettings) shows our choices for this study. Note that we have selected to add descendants to the concept to exclude, which we defined in the comparison settings in Figure \@ref(fig:comparisons2).

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/covariateSettings.png" alt="Covariate settings." width="100%" />
<p class="caption">(\#fig:covariateSettings)Covariate settings.</p>
</div>

**Time at risk**

Time-at-risk is defined relative to the start and end dates of our target and comparator cohorts. In our example, we had set the cohort start date to start on treatment initiation, and cohort end date when exposure stops (for at least 30 days). We set the start of time-at-risk to one day after cohort start, so one day after treatment initiation. A reason to set the time-at-risk start to be later than the cohort start is because we may want to exclude outcome events that occur on the day of treatment initiation if we do not believe it biologically plausible they can be caused by the drug.

We set the end of the time-at-risk to the cohort end, so when exposure stops. We could choose to set the end date later if for example we believe events closely following treatment end may still be attributable to the exposure. In the extreme we could set the time-at-risk end to a large number of days (e.g. 99999) after the cohort end date, meaning we will effectively follow up subjects until observation end. Such a design is sometimes referred to as an *intent-to-treat* design.

A patient with zero days at risk adds no information, so the **minimum days at risk** is normally set at one day. If there is a known latency for the side effect, then this may be increased to get a more informative proportion. It can also be used to create a cohort more similar to that of a randomized trial it is being compared to (e.g., all the patients in the randomized trial were observed for at least N days).

A golden rule in designing a cohort study is to never use information that falls after the cohort start date to define the study population, as this may introduce bias. For example, if we require everyone to have at least a year of time-at-risk, we will likely have limited our analyses to those who tolerate the treatment well. This setting should therefore be used with extreme care.


<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/timeAtRisk.png" alt="Time-at-risk settings." width="100%" />
<p class="caption">(\#fig:timeAtRisk)Time-at-risk settings.</p>
</div>

**Propensity score adjustment**

We can opt to **trim** the study population, removing people with extreme PS values. We can choose to remove the top and bottom percentage, or we can remove subjects whose preference score falls outside the range we specify. Trimming the cohorts is generally not recommended because it requires discarding observations, which reduces statistical power. It may be desirable to trim in some cases, for example when using IPTW. \index{propensity score!trimming}

In addition to, or instead of trimming, we can choose to **stratify** or **match** on the propensity score. When stratifying we need to specify the **number of strata** and whether to select the strata based on the target, comparator, or entire study population. When matching we need to specify the **maximum number of people from the comparator group to match to each person in the target group**. Typical values are 1 for one-on-one matching, or a large number (e.g. 100) for variable-ratio matching. We also need to specify the **caliper**: the maximum allowed difference between propensity scores to allow a match. The caliper can be defined on difference **caliper scales**: \index{caliper!scale}

* **The propensity score scale**: the PS itself
* **The standardized scale**: in standard deviations of the PS distributions
* **The standardized logit scale**: in standard deviations of the PS distributions after the logit transformation to make the PS more normally distributed.

In case of doubt, we suggest using the default values, or consult the work on this topic by @austin_2011.

Fitting large-scale propensity models can be computationally expensive, so we may want to restrict the data used to fit the model to just a sample of the data. By default the maximum size of the target and comparator cohort is set to 250,000. In most studies this limit will not be reached. It is also unlikely that more data will lead to a better model. Note that although a sample of the data may be used to fit the model, the model will be used to compute PS for the entire population.

**Test each covariate for correlation with the target assignment?** If any covariate has an unusually high correlation (either positive or negative), this will throw an error. This avoids lengthy calculation of a propensity model only to discover complete separation. Finding very high univariate correlation allows you to review the covariate to determine why it has high correlation and whether it should be dropped.

Figure \@ref(fig:psSettings) shows our choices for this study. Note that we select variable-ratio matching by setting the maximum number of people to match to 100.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/psSettings.png" alt="Propensity score adjustment settings." width="100%" />
<p class="caption">(\#fig:psSettings)Propensity score adjustment settings.</p>
</div>

**Outcome model settings**

First, we need to **specify the statistical model we will use to estimate the relative risk of the outcome between target and comparator cohorts**. We can choose between Cox, Poisson, and logistic regression, as discussed briefly in CohortMethod Section. For our example we choose a Cox proportional hazards model, which considers time to first event with possible censoring. Next, we need to specify **whether the regression should be conditioned on the strata**. One way to understand conditioning is to imagine a separate estimate is produced in each stratum, and then combined across strata. For one-to-one matching this is likely unnecessary and would just lose power. For stratification or variable-ratio matching it is required. \index{conditioned model} \index{stratified model|see {conditioned model}}

We can also choose to **add all covariates to the outcome model** to adjust the analysis. This can be done in addition or instead of using a propensity model. However, whereas there usually is ample data to fit a propensity model, with many people in both treatment groups, there is typically very little data to fit the outcome model, with only few people having the outcome. We therefore recommend keeping the outcome model as simple as possible and not include additional covariates.

Instead of stratifying or matching on the propensity score we can also choose to **use inverse probability of treatment weighting** (IPTW). If weighting is used it is often recommended to use some form of trimming to avoid extreme weights and therefore unstable estimates.

Figure \@ref(fig:outcomeModelSettings) shows our choices for this study. Because we use variable-ratio matching, we must condition the regression on the strata (i.e. the matched sets).

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/outcomeModelSettings.png" alt="Outcome model settings." width="100%" />
<p class="caption">(\#fig:outcomeModelSettings)Outcome model settings.</p>
</div>

### Evaluation settings {#evaluationSettings}

As described in Method Validity Chapter, negative and positive controls should be included in our study to evaluate the operating characteristics, and perform empirical calibration.

**Negative control outcome cohort definition**

In Comparison Settings Section we selected a concept set representing the negative control outcomes. However, we need logic to convert concepts to cohorts to be used as outcomes in our analysis. ATLAS provides standard logic with three choices. The first choice is whether to **use all occurrences** or just  the **first occurrence** of the concept. The second choice determines **whether occurrences of descendant concepts should be considered**. For example, occurrences of the descendant "ingrown nail of foot" can also be counted as an occurrence of the ancestor "ingrown nail." The third choice specifies which domains should be considered when looking for the concepts.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/ncSettings.png" alt="Negative control outcome cohort definition settings." width="100%" />
<p class="caption">(\#fig:ncSettings)Negative control outcome cohort definition settings.</p>
</div>

**Positive control synthesis**

In addition to negative controls we can also include positive controls, which are exposure-outcome pairs where a causal effect is believed to exist with known effect size. For various reasons real positive controls are problematic, so instead we rely on synthetic positive controls, derived from negative controls as described in Method Validity Chapter. Positive control synthesis is an advanced topic that we will skip for now.

[//]: # (TODO: Add positive control synthesis settings when ATLAS interface is updated.)

### Running the study package

Now that we have fully defined our study, we can export it as an executable R package. This package contains everything that is needed to execute the study at a site that has data in CDM. This includes the cohort definitions that can be used to instantiate the target, comparator and outcome cohorts, the negative control concept set and logic to create the negative control outcome cohorts, as well as the R code to execute the analysis. Before generating the package make sure to save your study, then click on the **Utilities** tab. Here we can review the set of analyses that will be performed. As mentioned before, every combination of a comparison and an analysis setting will result in a separate analysis. In our example we have specified two analyses: ACEi versus THZ for AMI, and ACEi versus THZ for angioedema, both using propensity score matching.

We must provide a name for our package, after which we can click on "Download" to download the zip file. The zip file contains an R package, with the usual required folder structure for R packages. [@Wickham_2015] To use this package we recommend using R Studio. If you are running R Studio locally, unzip the file, and double click the .Rproj file to open it in R Studio. If you are running R Studio on an R studio server, click ![](images/PopulationLevelEstimation/upload.png) to upload and unzip the file, then click on the .Rproj file to open the project.

Once you have opened the project in R Studio, you can open the README file, and follow the instructions. Make sure to change all file paths to existing paths on your system.

A common error message that may appear when running the study is "High correlation between covariate(s) and treatment detected." This indicates that when fitting the propensity model, some covariates were observed to be highly correlated with the exposure. Please review the covariates mentioned in the error message, and exclude them from the set of covariates if appropriate (see Variable Selection Section). \index{high correlation}

## Implementing the study using R {#pleR}

Instead of using ATLAS to write the R code that executes the study, we can also write the R code ourselves. One reason we might want to do this is because R offers far greater flexibility than is exposed in ATLAS. If we for example wish to use custom covariates, or a linear outcome model, we will need to write some custom R code, and combine it with the functionality provided by the OHDSI R packages.

For our example study we will rely on the [CohortMethod](https://ohdsi.github.io/CohortMethod/) package to execute our study. CohortMethod extracts the necessary data from a database in the CDM and can use a large set of covariates for the propensity model. In the following example we first only consider angioedema as outcome. In Multiple Analyses Section we then describe how this can be extended to include AMI and the negative control outcomes.

### Cohort instantiation

We first need to instantiate the target and outcome cohorts. 

### Data extraction

We first need to tell R how to connect to the server. [CohortMethod](https://ohdsi.github.io/CohortMethod/) uses the [DatabaseConnector](https://ohdsi.github.io/DatabaseConnector/) package, which provides a function called `createConnectionDetails`. Type `?createConnectionDetails` for the specific settings required for the various database management systems (DBMS). For example, one might connect to a PostgreSQL database using this code:


```r
library(CohortMethod)
connDetails <- createConnectionDetails(dbms = "postgresql",
                                       server = "localhost/ohdsi",
                                       user = "joe",
                                       password = "supersecret")

cdmDbSchema <- "my_cdm_data"
cohortDbSchema <- "scratch"
cohortTable <- "my_cohorts"
cdmVersion <- "5"
```

The last four lines define the `cdmDbSchema`, `cohortDbSchema`, and `cohortTable` variables, as well as the CDM version. We will use these later to tell R where the data in CDM format live, where the cohorts of interest have been created, and what version CDM is used. Note that for Microsoft SQL Server, database schemas need to specify both the database and the schema, so for example `cdmDbSchema <- "my_cdm_data.dbo"`.

Now we can tell CohortMethod to extract the cohorts, construct covariates, and extract all necessary data for our analysis:


```r
# target and comparator ingredient concepts:
aceI <- c(1335471,1340128,1341927,1363749,1308216,1310756,1373225,
          1331235,1334456,1342439)
thz <- c(1395058,974166,978555,907013)

# Define which types of covariates must be constructed:
cs <- createDefaultCovariateSettings(excludedCovariateConceptIds = c(aceI,
                                                                     thz),
                                     addDescendantsToExclude = TRUE)

#Load data:
cmData <- getDbCohortMethodData(connectionDetails = connectionDetails,
                                cdmDatabaseSchema = cdmDatabaseSchema,
                                oracleTempSchema = NULL,
                                targetId = 1,
                                comparatorId = 2,
                                outcomeIds = 3,
                                studyStartDate = "",
                                studyEndDate = "",
                                exposureDatabaseSchema = cohortDbSchema,
                                exposureTable = cohortTable,
                                outcomeDatabaseSchema = cohortDbSchema,
                                outcomeTable = cohortTable,
                                cdmVersion = cdmVersion,
                                firstExposureOnly = FALSE,
                                removeDuplicateSubjects = FALSE,
                                restrictToCommonPeriod = FALSE,
                                washoutPeriod = 0,
                                covariateSettings = cs)
cmData
```

```
## CohortMethodData object
## 
## Treatment concept ID: 1
## Comparator concept ID: 2
## Outcome concept ID(s): 3
```

There are many parameters, but they are all documented in the [CohortMethod manual](https://ohdsi.github.io/CohortMethod/reference/). The `createDefaultCovariateSettings` function is described in the [FeatureExtraction](https://ohdsi.github.io/FeatureExtraction/) package. In short, we are pointing the function to the table containing our cohorts and specify which cohort definition IDs in that table identify the target, comparator and outcome. We instruct that the default set of covariates should be constructed, including covariates for all conditions, drug exposures, and procedures that were found on or before the index date. As mentioned in Cohort Method Section we must exclude the target and comparator treatments from the set of covariates, and here we achieve this by listing all ingredients in the two classes, and tell FeatureExtraction to also exclude all descendants, thus excluding all drugs that contain these ingredients.

All data about the cohorts, outcomes, and covariates are extracted from the server and stored in the `cohortMethodData` object. This object uses the package `ff` to store information in a way that ensures R does not run out of memory, even when the data are large, as mentioned in Section Big Data Support .

We can use the generic `summary()` function to view some more information of the data we extracted:


```r
summary(cmData)
```

```
## CohortMethodData object summary
## 
## Treatment concept ID: 1
## Comparator concept ID: 2
## Outcome concept ID(s): 3
## 
## Treated persons: 67166
## Comparator persons: 35333
## 
## Outcome counts:
##          Event count Person count
## 3               980          891
## 
## Covariates:
## Number of covariates: 58349
## Number of non-zero covariate values: 24484665
```

Creating the `cohortMethodData` file can take considerable computing time, and it is probably a good idea to save it for future sessions. Because `cohortMethodData` uses `ff`, we cannot use R's regular save function. Instead, we'll have to use the `saveCohortMethodData()` function:


```r
saveCohortMethodData(cmData, "AceiVsThzForAngioedema")
```

We can use the `loadCohortMethodData()` function to load the data in a future session.

**Defining new users**

Typically, a new user is defined as first time use of a drug (either target or comparator), and typically a washout period (a minimum number of days prior to first use) is used to increase the probability that it is truly first use. When using the CohortMethod package, you can enforce the necessary requirements for new use in three ways:

1. When defining the cohorts.
2. When loading the cohorts using the `getDbCohortMethodData` function, you can use the `firstExposureOnly`, `removeDuplicateSubjects`, `restrictToCommonPeriod`, and `washoutPeriod` arguments.
3. When defining the study population using the `createStudyPopulation` function (see below).

The advantage of option 1 is that the input cohorts are already fully defined outside of the CohortMethod package, and external cohort characterization tools can be used on the same cohorts used in this analysis. The advantage of options 2 and 3 is that they save you the trouble of limiting to first use yourself, for example allowing you to directly use the DRUG_ERA table in the CDM. Option 2 is more efficient than 3, since only data for first use will be fetched, while option 3 is less efficient but allows you to compare the original cohorts to the study population.

###  Defining the study population

Typically, the exposure cohorts and outcome cohorts will be defined independently of each other. When we want to produce an effect size estimate, we need to further restrict these cohorts and put them together, for example by removing exposed subjects that had the outcome prior to exposure, and only keeping outcomes that fall within a defined risk window. For this we can use the `createStudyPopulation` function:


```r
studyPop <- createStudyPopulation(cohortMethodData = cmData,
                                  outcomeId = 3,
                                  firstExposureOnly = FALSE,
                                  restrictToCommonPeriod = FALSE,
                                  washoutPeriod = 0,
                                  removeDuplicateSubjects = "remove all",
                                  removeSubjectsWithPriorOutcome = TRUE,
                                  minDaysAtRisk = 1,
                                  riskWindowStart = 1,
                                  addExposureDaysToStart = FALSE,
                                  riskWindowEnd = 0,
                                  addExposureDaysToEnd = TRUE)
```

Note that we've set `firstExposureOnly` and `removeDuplicateSubjects` to FALSE, and `washoutPeriod` to 0 because we already applied those criteria in the cohort definitions. We specify the outcome ID we will use, and that people with outcomes prior to the risk window start date will be removed. The risk window is defined as starting on the day after the cohort start date (`riskWindowStart = 1` and `addExposureDaysToStart = FALSE`), and the risk windows ends when the cohort exposure ends (`riskWindowEnd = 0` and `addExposureDaysToEnd = TRUE`), which was defined as the end of exposure in the cohort definition. Note that the risk windows are automatically truncated at the end of observation or the study end date. We also remove subjects who have no time at risk. To see how many people are left in the study population we can always use the `getAttritionTable` function:


```r
getAttritionTable(studyPop)
```

```
##                    description targetPersons comparatorPersons	...
## 1             Original cohorts         67212             35379	...
## 2 Removed subs in both cohorts         67166             35333	...
## 3             No prior outcome         67061             35238	...
## 4 Have at least 1 days at risk         66780             35086	...
```

### Propensity scores

We can fit a propensity model using the covariates constructed by the `getDbcohortMethodData()` function, and compute a PS for each person:


```r
ps <- createPs(cohortMethodData = cmData, population = studyPop)
```

The `createPs` function uses the [Cyclops](https://ohdsi.github.io/Cyclops/) package to fit a large-scale regularized logistic regression. To fit the propensity model, Cyclops needs to know the hyperparameter value which specifies the variance of the prior. By default Cyclops will use cross-validation to estimate the optimal hyperparameter. However, be aware that this can take a really long time. You can use the `prior` and `control` parameters of the `createPs` function to specify Cyclops' behavior, including using multiple CPUs to speed-up the cross-validation.

Here we use the PS to perform variable-ratio matching:


```r
matchedPop <- matchOnPs(population = ps, caliper = 0.2,
                        caliperScale = "standardized logit", maxRatio = 100)
```

Alternatively, we could have used the PS in the `trimByPs`, `trimByPsToEquipoise`, or `stratifyByPs` functions.

###  Outcome models

The outcome model is a model describing which variables are associated with the outcome. Under strict assumptions, the coefficient for the treatment variable can be interpreted as the causal effect. In this case we fit a Cox proportional hazards model, conditioned (stratified) on the matched sets:


```r
outcomeModel <- fitOutcomeModel(population = matchedPop,
                                modelType = "cox",
                                stratified = TRUE)
outcomeModel
```

```
## Model type: cox
## Stratified: TRUE
## Use covariates: FALSE
## Use inverse probability of treatment weighting: FALSE
## Status: OK
## 
##           Estimate lower .95 upper .95   logRr seLogRr
## treatment   4.3203    2.4531    8.0771 1.4633   0.304
```

### Running multiple analyses {#MultipleAnalyses}

Often we want to perform more than one analysis, for example for multiple outcomes including negative controls. The [CohortMethod](https://ohdsi.github.io/CohortMethod/) offers functions for performing such studies efficiently. This is described in detail in the [package vignette on running multiple analyses](https://ohdsi.github.io/CohortMethod/articles/MultipleAnalyses.html). Briefly, assuming the outcome of interest and negative control cohorts have already been created, we can specify all target-comparator-outcome combinations we wish to analyze:


```r
# Outcomes of interest:
ois <- c(3, 4) # Angioedema, AMI

# Negative controls:
ncs <- c(434165,436409,199192,4088290,4092879,44783954,75911,137951,77965,
         376707,4103640,73241,133655,73560,434327,4213540,140842,81378,432303,
         4201390,46269889,134438,78619,201606,76786,4115402,45757370,433111
         433527,4170770,4092896,259995,40481632,4166231,433577,4231770,440329,
         4012570,4012934,441788,4201717,374375,4344500,139099,444132,196168,
         432593,434203,438329,195873,4083487,4103703,4209423,377572,40480893,
         136368,140648,438130,4091513,4202045,373478,46286594,439790,81634,
         380706,141932,36713918,443172,81151,72748,378427,437264,194083,
         140641,440193,4115367)

tcos <- createTargetComparatorOutcomes(targetId = 1,
                                       comparatorId = 2,
                                       outcomeIds = c(ois, ncs))

tcosList <- list(tcos)
```

Next, we specify what arguments should be used when calling the various functions described previously in our example with one outcome:


```r
aceI <- c(1335471,1340128,1341927,1363749,1308216,1310756,1373225,
          1331235,1334456,1342439)
thz <- c(1395058,974166,978555,907013)

cs <- createDefaultCovariateSettings(excludedCovariateConceptIds = c(aceI,
                                                                     thz),
                                     addDescendantsToExclude = TRUE)

cmdArgs <- createGetDbCohortMethodDataArgs(
  studyStartDate = "",
  studyEndDate = "",
  firstExposureOnly = FALSE,
  removeDuplicateSubjects = FALSE,
  restrictToCommonPeriod = FALSE,
  washoutPeriod = 0,
  covariateSettings = cs)

spArgs <- createCreateStudyPopulationArgs(
  firstExposureOnly = FALSE,
  restrictToCommonPeriod = FALSE,
  washoutPeriod = 0,
  removeDuplicateSubjects = "remove all",
  removeSubjectsWithPriorOutcome = TRUE,
  minDaysAtRisk = 1,
  riskWindowStart = 1,
  addExposureDaysToStart = FALSE,
  riskWindowEnd = 0,
  addExposureDaysToEnd = TRUE)

psArgs <- createCreatePsArgs()

matchArgs <- createMatchOnPsArgs(
  caliper = 0.2,
  caliperScale = "standardized logit",
  maxRatio = 100)

fomArgs <- createFitOutcomeModelArgs(
  modelType = "cox",
  stratified = TRUE)
```

We then combine these into a single analysis settings object, which we provide a unique analysis ID and some description. We can combine one or more  analysis settings objects into a list:


```r
cmAnalysis <- createCmAnalysis(
  analysisId = 1,
  description = "Propensity score matching",
  getDbCohortMethodDataArgs = cmdArgs,
  createStudyPopArgs = spArgs,
  createPs = TRUE,
  createPsArgs = psArgs,
  matchOnPs = TRUE,
  matchOnPsArgs = matchArgs
  fitOutcomeModel = TRUE,
  fitOutcomeModelArgs = fomArgs)

cmAnalysisList <- list(cmAnalysis)
```

We can now run the study including all comparisons and analysis settings:


```r
result <- runCmAnalyses(connectionDetails = connectionDetails,
                        cdmDatabaseSchema = cdmDatabaseSchema,
                        exposureDatabaseSchema = cohortDbSchema,
                        exposureTable = cohortTable,
                        outcomeDatabaseSchema = cohortDbSchema,
                        outcomeTable = cohortTable,
                        cdmVersion = cdmVersion,
                        outputFolder = outputFolder,
                        cmAnalysisList = cmAnalysisList,
                        targetComparatorOutcomesList = tcosList)
```

The `result` object contains references to all the artifacts that were created. For example, we can retrieve the outcome model for AMI:


```r
omFile <- result$outcomeModelFile[result$targetId == 1 &
                                    result$comparatorId == 2 &
                                    result$outcomeId == 4 &
                                    result$analysisId == 1]
outcomeModel <- readRDS(file.path(outputFolder, omFile))
outcomeModel
```

```
## Model type: cox
## Stratified: TRUE
## Use covariates: FALSE
## Use inverse probability of treatment weighting: FALSE
## Status: OK
## 
##           Estimate lower .95 upper .95   logRr seLogRr
## treatment   1.1338    0.5921    2.1765 0.1256   0.332
```

We can also retrieve the effect size estimates for all outcomes with one command:

```r
summ <- summarizeAnalyses(result, outputFolder = outputFolder)
head(summ)
```

```
##     analysisId targetId comparatorId outcomeId        rr    ci95lb  ...
## 1            1        1            2     72748 0.9734698 0.5691589  ...
## 2            1        1            2     73241 0.7067981 0.4009951  ...
## 3            1        1            2     73560 1.0623951 0.7187302  ...
## 4            1        1            2     75911 0.9952184 0.6190344  ...
## 5            1        1            2     76786 1.0861746 0.6730408  ...
## 6            1        1            2     77965 1.1439772 0.5173222  ...
```

## Study outputs {#studyOutputs}

Our estimates are only valid if several assumptions have been met. We use a wide set of diagnostics to evaluate whether this is the case. These are available in the results produced by the R package generated by ATLAS, or can be generated on the fly using specific R functions.

### Propensity scores and model

We first need to evaluate whether the target and comparator cohort are to some extent comparable. For this we can compute the Area Under the Receiver Operator Curve (AUC) statistic for the propensity model. An AUC of 1 indicates the treatment assignment was completely predictable based on baseline covariates, and that the two groups are therefore incomparable. We can use the `computePsAuc` function to compute the AUC, which in our example is 0.79. Using the `plotPs` function, we can also generate the preference score distribution as shown in Figure \@ref(fig:ps). Here we see that for many people the treatment they received was predictable, but there is also a large amount of overlap, indicating that adjustment can be used to select comparable groups. \index{preference score!example}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/ps.png" alt="Preference score distribution." width="80%" />
<p class="caption">(\#fig:ps)Preference score distribution.</p>
</div>

In general it is a good idea to also inspect the propensity model itself, and especially so if the model is very predictive. That way we may discover which variables are most predictive. Table \@ref(tab:psModel) shows the top predictors in our propensity model. Note that if a variable is too predictive, the CohortMethod package will throw an informative error rather than attempt to fit a model that is already known to be perfectly predictive. \index{propensity model!example}

Table: (\#tab:psModel) Top 10 predictors in the propensity model for ACEi and THZ. Positive values mean subjects with the covariate are more likely to receive the target treatment.

| Beta | Covariate
| ----:|:----------------------------------------------------------------------------|
| -1.42 | condition_era group during day -30 through 0 days relative to index: Edema |
| -1.11 | drug_era group during day 0 through 0 days relative to index: Potassium Chloride |
| 0.68 | age group: 05-09 |
| 0.64 | measurement during day -365 through 0 days relative to index: Renin |
| 0.63 | condition_era group during day -30 through 0 days relative to index: Urticaria |
| 0.57 | condition_era group during day -30 through 0 days relative to index: Proteinuria |
| 0.55 | drug_era group during day -365 through 0 days relative to index: INSULINS AND ANALOGUES |
| -0.54 | race = Black or African American |
| 0.52 | (Intercept) |
| 0.50 | gender = MALE |

If a variable is found to be highly predictive, there are two possible conclusions: Either we find that the variable is clearly part of the exposure itself and should be removed before fitting the model, or else we must conclude that the two populations are truly incomparable, and the analysis must be stopped.```

### Covariate balance

The goal of using PS is to make the two groups comparable (or at least to select comparable groups). We must verify whether this is achieved, for example by checking whether the baseline covariates are indeed balanced after adjustment. We can use the `computeCovariateBalance` and `plotCovariateBalanceScatterPlot` functions to generate Figure \@ref(fig:balance). One rule-of-thumb to use is that no covariate may have an absolute standardized difference of means greater than 0.1 after propensity score adjustment. Here we see that although there was substantial imbalance before matching, after matching we meet this criterion. \index{covariate balance!example}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/balance.png" alt="Covariate balance, showing the absolute standardized difference of mean before and after propensity score matching. Each blue dot represents a covariate." width="70%" />
<p class="caption">(\#fig:balance)Covariate balance, showing the absolute standardized difference of mean before and after propensity score matching. Each blue dot represents a covariate.</p>
</div>

### Follow up and power

Before fitting an outcome model, we might be interested to know whether we have sufficient power to detect a particular effect size. It makes sense to perform these power calculations once the study population has been fully defined, so taking into account loss to the various inclusion and exclusion criteria (such as no prior outcomes), and loss due to matching and/or trimming. We can view the attrition of subjects in our study using the `drawAttritionDiagram` function as shown in Figure \@ref(fig:attrition). \index{attrition diagram}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/attrition.png" alt="Attrition diagram. The counts shown at the top are those that meet our target and comparator cohort definitions. The counts at the bottom are those that enter our outcome model, in  this case a Cox regression." width="70%" />
<p class="caption">(\#fig:attrition)Attrition diagram. The counts shown at the top are those that meet our target and comparator cohort definitions. The counts at the bottom are those that enter our outcome model, in  this case a Cox regression.</p>
</div>

Since the sample size is fixed in retrospective studies (the data has already been collected), and the true effect size is unknown, it is therefore less meaningful to compute the power given an expected effect size. Instead, the CohortMethod package provides the `computeMdrr` function to compute the minimum detectable relative risk (MDRR). In our example study the MDRR is 1.69. \index{minimum detectable relative risk (MDRR)} \index{power}

To gain a better understanding of the amount of follow-up available we can also inspect the distribution of follow-up time. We defined follow-up time as time at risk, so not censored by the occurrence of the outcome. The `getFollowUpDistribution` can provide a simple overview as shown in Figure \@ref(fig:followUp), which suggests the follow-up time for both cohorts is comparable.

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/followUp.png" alt="Distribution of follow-up time for the target and comparator cohorts." width="80%" />
<p class="caption">(\#fig:followUp)Distribution of follow-up time for the target and comparator cohorts.</p>
</div>

### Kaplan-Meier

One last check is to review the Kaplan-Meier plot, showing the survival over time in both cohorts. Using the `plotKaplanMeier` function we can create s(fig:kmPlot), which we can check for example if our assumption of proportionality of hazards holds. The Kaplan-Meier plot automatically adjusts for stratification or weighting by PS. In this case, because variable-ratio matching is used, the survival curve for the comparator groups is adjusted to mimick what the curve had looked like for the target group had they been exposued to the comparator instead. \index{Kaplan-Meier plot} \index{survival plot|see {Kaplan-Meier plot}}

<div class="figure" style="text-align: center">
<img src="images/PopulationLevelEstimation/kmPlot.png" alt="Kaplan-Meier plot." width="100%" />
<p class="caption">(\#fig:kmPlot)Kaplan-Meier plot.</p>
</div>

### Effect size estimate

We observe a hazard ratio of 4.32 (95% confidence interval: 2.45 - 8.08) for angioedema, which tells us that ACEi appears to increase the risk of angioedema compared to THZ. Similarly, we observe a hazard ratio of 1.13 (95% confidence interval: 0.59 - 2.18) for AMI, suggesting little or no effect for AMI. Our diagnostics, as reviewed earlier, give no reason for doubt. However, ultimately the quality of this evidence, and whether we choose to trust it, depends on many factors that are not covererd by the study diagnostics as described in Evidence Quality Chapter.

## Summary

- Population-level estimation aims to infer causal effects from observational data.

- The **counterfactual**, what would have happened if the subject had received an alternative exposure or no exposure, cannot be observed.

- Different designs aim to construct the counterfactual in different ways.

- The various designs as implemented in the OHDSI Methods Library provide diagnostics to evaluate whether the assumptions for creating an appropriate counterfactual have been met.


## Excercises

Note: The exercises still have to be defined. The idea is to require readers to define a study that estimates the effect of celecoxib on GI bleed, compared to diclofenac. For this they must use the Eunomia package, which is still under development.







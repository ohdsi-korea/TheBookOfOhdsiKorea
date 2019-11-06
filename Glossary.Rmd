# (APPENDIX) Appendix {-}

# Glossary {#Glossary}

ACHILLES
: 데이터베이스 수준의 특성 보고서. 

ARACHNE
: 연합 네트워크의 조정 및 실행을 위해 개발중인 OHDSI 플랫폼.

ATLAS
: 환자 수준 임상 데이터로부터 실제 근거를 생성하기 위한 관찰 분석의 실행과 설계를 지원하기 위하여 참여 사이트에 설치된 웹 기반 어플리케이션.

편향 (Bias)
: 오류의 예상 값 (실제 값과 예상 값의 차이).

부울 (Boolean)
: 오직 두개의 값만 가지는 변수 (참 혹은 거짓).

Care site
: 의료 서비스 제공을 실천하는 고유하게 식별된 기관 (물리적 혹은 조직적) 단위 (사무실 병동, 병원, 클리닉 등).

환자 대조군 (Case control)
: 인구-수준 효과 추정을 위한 회고 연구 설계(retrospective study design)의 유형. 환자 대조군 연구는 표적 결과와의 "사례(cases)"를 표적 결과가 없는 "대조(controls)"로 일치시킨다. 그 후 이전의 시간을 살펴보고 사례와 대조의 노출 오즈(odds)를 비교한다.

인과적 영향 (Causal effect)
: 인구 수준 추정이 그 자체로 얼마나 영향을 미치는가에 대한 것. 한 가지 정의는 "인과적 영향"를 표적 인구 안 "단위 수준(unit-level) 인과적 영향"의 평균으로 일치시킨다. 단위 수준 인과적 영향은 노출된 개인의 결과와 노출되지 않은 개인의 결과 간의 대조이다 (혹은 B에 대응하여 A에 노출된 적이 있는지).

특성 (Characterization)
: 코호트 혹은 전체 데이터베이스의 서술적 연구. \@ref(Characterization)장 참조.

청구 자료 (Claims data)
: 의료 보험 회사에게 청구하기 위한 목적으로 생성된 데이터

임상 시험 (Clinical trial)
: 중재(Interventional) 임상 연구.

코호트 (Cohort)
: 특정 기간 동안 하나 혹은 다수 기준의 포함을 만족시키는 사람들의 집합. \@ref(Cohorts)장 참조.

Concept
: 의학 전문 용어에 정의된 용어 (코드 포함) (예를 들어, SNOMED CT ). \@ref(StandardizedVocabularies)장 참조.

Concept 세트
: concept 세트는 다양한 분석에서 재사용 가능한 요소들로 사용될 수 있는 concept의 목록을 나타내는 표현. \@ref(Cohorts)장 참조.

공통 데이터 모델 (Common Data Model, CDM)
: 분석의 이식성을 허용하는 의료 데이터를 대표하는 조약 (수정되지 않은 동일한 분석을 여러 데이터 세트에서 실행할 수 있다). \@ref(CommonDataModel)장 참조.

비교 효과 (Comparative Effectiveness)
: 관심 결과에 대한 두 개의 다른 노출의 영향 비교. \@ref(PopulationLevelEstimation)장 참조.

조건 (Condition)
: 제공자가 진찰하거나 환자가 보고한 진단, 기호, 혹은 증상.

교란 (Confounding)
: 교란은 주요 관심 노출이 결과와 관련된 몇가지 다른 사실이 섞일 때 일어나는 연관성 예상 측정 안의 왜곡 (불확실성) 이다.

변수 (Covariate)
: 독립적 변수로 통계적 모델에 사용되는 데이터 요소 (예를 들어, 체중).

데이터 질 (Data quality)
: 데이터를 특정 용도에 적합하게 만드는 완전성, 유효성, 일관성, 적시성 및 정확성의 상태.

의료 기기 (Device)
: 화학 작용을 넘어서는 매커니즘을 통해 진단 또는 치료 목적으로 사용되는 대외 물리적 물체 혹은 기구. 의료 기기는 이식할 수 있는 물체 (예를 들면, 심박조정기, 스텐트, 인공 관절 등), 의료 장비 및 보급품 (예를 들어, 붕대, 목발, 주사기), 의료 절차에 사용되는 기구 (예를 들어, 봉합, 제세동기) 그리고 임상 치료에 사용되는 재료 (예를 들어, 접착제, body 재료, 치과용 재료, 수술용 재료)를 포함한다.

약물 (Drug)
: 약물은 사람에게 투여할 때 특정한 화학 반응을 발휘 할 수 있도록 조제된 생화학 물질이다. 약물은 처방전 및 처방전 없이 구입 가능한 약물, 백신, 그리고 대용량 molecule 생물학적 치료법을 포함한다. 국소 부위에 섭취되거나 접촉되는 방사선 기기는 약물로 간주되지 않는다.

도메인 (Domain)
: 도메인은 CDM 표의 표준화된 필드에 대해 허용하는 concept의 세트를 정의한다. 예를 들어, "조건" 도메인은 환자의 컨디션을 설명하는 concept을 포함하고, 이 concept는 CONDITION_OCCURRENCE와 CONDITION_ERA 테이블의 condition_concept_id 필드에만 저장된다.

전자 의무기록 (Electronic Health Record, EHR)
: 전자기록 시스템에 기록되고 치료 기간동안 생성된 데이터를 의미한다.

역학 (Epidemiology)
: 정의된 인구의 건강 및 질병 조건의 분포, 패턴, 결정의 연구.

근거 중심 의학 (Evidence-based medicine)
: 개인의 환자 관리에 대한 의사 결정의 경험적, 과학적 근거의 사용.

추출-변환-적재 (Extract-Transform-Load, ETL)
: 한 형식에서 다른 형식으로 데이터를 변환하는 과정, 예를 들어 원천 포맷을 CDM으로 변환한다. \@ref(ExtractTransformLoad)장 참조.

짝짓기 (Matching)
: 많은 인구-수준 효과 추정은 노출의 인과적 영향을 노출된 환자의 결과를 노출되지 않은 환자의 동일한 결과로 비교함으로써 식별하는 것을 시도한다 (혹은 A를 B의 대립으로 노출시킨다).이 두 환자 집단은 노출 이외의 방식이 다를 수 있으므로, "짝짓기"는 최소한 측정된 환자 특성과 관련하여 최대한 비슷한 노출된 환자 그룹 및 노출되지 않은 환자 그룹을 생성하기 위해 시도한다.

측정 (Measurement)
: 개인 혹은 개인의 표본에 대한 체계적이고 표준화된 검사 혹은 학습을 통하여 얻어진 구조적 값 (숫자 혹은 범주형).

측정 오차 (Measurement error)
: 기록된 측정 (혈압, 환자 연령, 치료 기간) 이 해당 참 측정과 다를 때 발생한다.

메타데이터 (Metadata)
: 다른 데이터에 대한 정보를 제공하고 기술하는 데이터의 집단이다. 이것은 구체적 메타데이터, 구조적 메타데이터, 관리 메타데이터, 참조 메타데이터, 통계적 메타데이터를 포함한다.

Methods Library
: 관찰 연구를 수행하기 위하여 OHDSI공동체에 의해 개발된 R 패키지의 집단.

Model misspecification
: 많은 OHDSI 방법은 비례 위험 회귀 또는 무작위 forest와 같은 통계적 모델을 채택한다. 데이터를 생성한 메커니즘이 가정된 모델에서 벗어나는 한, 모델은 "불특정"이 된다.

음성 통제 결과 (Negative control)
: An exposure-outcome pair where the exposure is believed to not cause or prevent the outcome. Can be used to assess whether effect estimation methods produce results in line with the truth. See Chapter \@ref(MethodValidity).

Observation
: A clinical fact about a Person obtained in the context of examination, questioning or a procedure.

Observation period
: The span of time for which a person is at-risk to have clinical events recorded within the source systems, even if no events in fact are recorded (healthy patient with no healthcare interactions).

관찰 연구 (Observational study)
: A study where the researcher has no control over the intervention.

OHDSI SQL
: A SQL dialect that can be automatically translated to various other SQL dialects using the SqlRender R package. OHDSI SQL is mostly a subset of SQL Server SQL, but allows for additional parameterization. See Chapter \@ref(SqlAndR).

오픈 사이언스 (Open science)
: The movement to make scientific research (including publications, data, physical samples, and software) and its dissemination accessible to all levels of an inquiring society, amateur or professional. See Chapter \@ref(OpenScience).

Outcome
: An observation that provides a focal point for an analysis. For example, a patient-level predictive model might predict the outcome "stroke." Or a population-level estimation might estimate the causal effect of a drug on the outcome "headache."

Patient-level prediction
: Development and application of predictive models to produce patient-specific probabilities for experiencing some future outcome based on baseline characteristics.

표현형 (Phenotype)
: A description of physical characteristics. This includes visible characteristics like your weight and hair color, but also your overall health, your disease history, and your behavior.

Population-level estimation
: A study into causal effects. Estimates an average (population-level) effect size.

양성 통제 결과 (Negative control)
: An exposure-outcome pair where the exposure is believed to cause or prevent the outcome. Can be used to assess whether effect estimation methods produce results in line with the truth. See Chapter \@ref(MethodValidity).

Procedure
: Activity or process ordered by, or carried out by, a healthcare provider on the patient to have a diagnostic or therapeutic purpose.

성향 점수 (Propensity score, PS)
: a single metric used in population-level estimation to balance populations in order to mimic randomization between two treatment groups in an observational study.  The PS represents the probability of a patient receiving a treatment of interest as a function of a set of observed baseline covariates. It is most often calculated using a logistic regression model where the binary outcome is set to one for the group receiving the target treatment of interest and to zero for the comparator treatment. See Chapter \@ref(PopulationLevelEstimation).

프로토콜 (Protocol)
: A human readable document that fully specifies the design of a study.

Rabbit-in-a-Hat
: An interactive software tool to help define the ETL from source format to CDM. Uses the database profile generated by White Rabbit as input. See Chapter 7.

선택 편향 (Selection bias)
: A bias that occurs when the set of patients in your data deviates from the patients in the population in ways that distort statistical analyses.

Self-controlled designs
: Study designs that compare outcomes during different exposures within the same patient.

민감도 분석 (Sensitivity analysis)
: A variant of the main analysis used in a study to asses the impact of an analysis choice over which uncertainty exists.

SNOMED
: A systematically organized computer processable collection of medical terms providing codes, terms, synonyms and definitions used in clinical documentation and reporting.

Study diagnostics
: Set of analytical steps where the goal is to determine whether a given analytical approach can be used (is valid) for answering a given research question. See Chapter \@ref(MethodValidity).

Study package
: A computer-executable program that fully executes the study. See Chapter \@ref(SoftwareValidity).

Source code
: A code used in a source database. For example an ICD-10 code.

Standard Concept
: A concept that is designated as valid concept and allowed to appear in the CDM.

THEMIS
: OHDSI workgroup that addresses target data format that is of higher granularity and detail with respect to CDM model specifications.

Visit
: The span of time a person continuously receives medical services from one or more providers at a care site in a given setting within the health care system.

Vocabulary
: A list of words and often phrases, usually arranged alphabetically and defined or translated. See Chapter \@ref(StandardizedVocabularies).

White Rabbit
: A software tool for profiling a database before defining the ETL to the CDM. See Chapter \@ref(ExtractTransformLoad).

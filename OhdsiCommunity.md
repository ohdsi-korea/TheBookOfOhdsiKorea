\mainmatter

# (PART) The OHDSI Community {-}

# The OHDSI Community {#OhdsiCommunity}

*Chapter leads: Patrick Ryan & George Hripcsak*

> 함께 모이면 시작되고, 함께 지내면 진보하고, 함께 일하면 성공한다. -헨리 포드

## 데이터에서 근거로의 여정 (The Journey from Data to Evidence)

의료 연구 기관 및 사설 의료 기관, 규제 기관 및 의료 제품 제조업체, 보험 회사 및 정책 기관, 그리고 환자와 의료 제공자 간의 모든 상호관계를 포함하는 전 세계 보건 의료의 어느 곳에서나 공통적인 과제가 있다. 어떻게 우리가 과거에서 배운 것을 토대로 미래를 위해 더 나은 결정을 내릴 수 있을 것인가?

10년이 넘도록, 많은 사람들이 **보건의료 체계 학습(learning healthcare system)** 의 비전에 대해서 논의해 왔다. "그것은, 환자와 의료 제공자의 협력적인 보건 의료 선택에 있어 최상의 근거를 생성하고 적용하기 위함입니다. 또한 환자 치료의 자연스러운 발전을 도모하고, 보건의료의 혁신, 질, 안전 및 가치를 보장하기 위함입니다." [@olsen2007learning] 이 원대한 계획의 주요한 요소는 일상적인 임상 치료 과정에서 수집된 환자 수준(patient-level) 데이터를 분석하여 **실세계 근거(real-world evidence)** 를 생성할 수 있으며, 의료 시스템에 전파되어 실제의 임상에 정보를 제공 할 수 있으리라는 흥미로운 전망에 있다. 의학 연구소(Institute of Medicine) 의 근거 중심 의학 원탁회(Roundtable on Evidence-Based Medicine) 가 발간한 2007년 보고서에서 "2020년까지 90%의 임상 결정이 정확하고, 시기 적절하고, 최신의 임상 정보에 의해 뒷받침 될 것이며, 그것은 가능한 최선의 근거를 반영할 것이다."라고 예측했다. [@olsen2007learning] 비록 여러가지면에서 엄청난 발전이 있었지만, 우리는 여전히 이 위대한 열망에는 한참 미치지 못하고 있다.

무엇때문인가? 부분적으로는 환자 수준의 데이터에서 신뢰할만한 근거까지의 여정이 몹시 고되기 때문일 것이다. 데이터로부터 근거를 생성하는데에는 정해진 하나의 길이 없으며, 어떠한 지도도 그 길을 안내해주지 않는다. 사실, "데이터(data)" 가 무엇인지, 그리고 "근거(evidence)"가 무엇인지에 대한 통일된 관념도 존재하지 않는다.

<div class="figure" style="text-align: center">
<img src="images/OhdsiCommunity/datajourney.png" alt="The journey from data to evidence" width="100%" />
<p class="caption">(\#fig:datajourney)The journey from data to evidence</p>
</div>

원본 시스템에서 다양한 환자 수준의 데이터를 수집하는 여러 유형의 관찰 데이터베이스(observational database)가 있다. 이 데이터베이스는 서로 다른 의료 시스템 내부의 인구, 치료 설정 및 데이터 수집 프로세스의 이질성만큼 다양하다. 의사 결정에 도움이 될 수있는 다양한 유형의 근거가 있으며, 환자 특성 분석(clinical characterization), 인구 수준 추정(population-level estimation) 및 환자 수준 예측(patient-level prediction) 으로 분류할 수 있다. 모집단 수준 영향 추정 및 환자 수준 예측의 분석 사용 사례로 분류 할 수 있습니다. 출발지 (원본 데이터) 및 원하는 목적지 (근거)와는 별도로, 여정을 수행하는 데 필요한 광범위한 임상, 과학 및 기술 역량들은 문제를 더욱 복잡하게 만든다. 보험 청구나 진료 과정이 데이터로 수집되면서 보건 정책이나 보험 환급과 관련된 행동 동기들로 인해 데이터 수집 및 정제 과정에서 발생할 수 있는 편향을 비롯하여, 환자와 의료 제공자간의 접점으로부터 원본 데이터가 발생하는 전반적인 과정에 대한 철저한 이해도 필요하다.  임상적 의문을 관련 해답을 도출하는 데 적합한 관찰 연구 설계으로 변환하기 위해선  역학 원칙과 통계적 방법을 숙지해야 한다. 수백만 명의 환자의 수년간의 종적 추적에 걸친 수십억 건의 임상 관찰을 가진 데이터셋에 대해 계산적으로 효율적인 데이터 과학 알고리즘을 구현하고 실행할 수 있는 기술적 능력 역시 필요하다. 관찰형 연구 통해 습득한 내용을 다른 종류의 근거와 통합하고, 이 새로운 지식이 건강 정책 및 임상 관행에 어떤 영향을 미칠지 결정하기 위해 임상 지식 또한 필요하다. 따라서, 한 개인이 데이터에서 근거를 성공적으로 만들어 내는 데 필요한 기술과 자원을 모두 보유하는 것은 매우 드문 일이다. 그보다는 이용 가능한 최선의 데이터를 가장 적절한 방법으로 분석하여 모든 이해당사자들이 의사결정 과정에 신뢰하고 사용할 수 있는 근거를 생산하는, 데이터에서 근거까지의 이 여정을 위해서는 보통 여러 개인과 조직의 협력이 필요하다.

## 오몹 (Observational Medical Outcomes Partnership, OMOP)

협력 관찰형 연구 모델로써 주목할만한 예시로 오몹 (Observational Medical Outcomes Partnership, OMOP)이 있었다. 오몹은 미국의 식품의약국(FDA)이 주관하고, 미국 국립 보건원(National Institutes of Health) 관리 하에 학술 연구자 및 보건 데이터 파트너와 협력하는 제약 회사의 컨소시엄로 구성되었으며, 관찰형 보건의료 데이터를 이용하여 능동적 의료 제품 안전성 감시의 발전을 꾀하는 민관 협력체였다. [@stang2010omop] OMOP은 다수의 이해관계자 간의 거버넌스 구조를 확립했고, 다수의 청구자료 및 전자 의무 기록 데이터베이스에 적용하여 진정한 약물 안전성 연관성과 거짓 양성 소견을 식별할 수 있는 대안적인 역학 설계 및 통계 방법의 성능을 경험적으로 검증하는 일련의 방법론적 실험을 설계하였다. 분산되어 있는 관찰형 데이터 베이스를 통해 연구릴 진행함에 있어 기술적인 난제를 인식하고, 연구진들은 데이터의 구조, 내용 및 용어를 표준화하여 하나의 통계 분석 코드가 모든 데이터 파트너에서 사용될 수 있도록, OMOP 공통 데이터 모델(Common Data Model, CDM) 을 설계하였다. [@overhage2012cdm] OMOP 실험은 공통 데이터 모델과 표준화된 어휘를 확립하는 것이 가능하다는 것을 증명했다. 이는 서로 다른 관리 설정으로부터, 다른 용어 체계를 통해 다른 데이터 유형을 수용하고 하여  기관 간 협업과 효율적인 분석을 용이하게 할 수 있는 방식으로 구현되었다.

OMOP는 처음부터 연구 설계, 데이터 표준, 분석 코드, 경험적 결과 등 모든 작업 제품을 공공에 배포하여 투명성을 증진하고, OMOP가 수행하고 있는 연구에 대한 신뢰도를 쌓을 뿐 아니라, 또한 다른 이들의 연구 목적을 위하여 발전할 수 있도록 개방형 과학(open science) 정책을 채택하였다. OMOP의 원래 초점은 약물 안전성이었지만, OMOP-CDM은 의료 처치와 보건 시스템 정책의 비교 효과성을 포함한 확대된 분석 사용 사례를 지원하기 위해 지속적으로 발전했다.

비록 OMOP이 대규모의 경험적 실험을 완성하는 데 성공하였고, [@ryan2012omop; @ryan2013omop] 방법론적인 혁신을 만들고, [@schuemie_2014] 관찰형 데이터를 이용하여 안정성에 관련되어 의사결정에 유용한 지식 생성을 위한 적절한 방법론을 제시하였지만,  [@madigan_2013; @madigan2013design] 이제 OMOP의 유산은 OHDSI 커뮤니티의 형성에 동기를 부여한 자극과 개방형 과학 원칙을 조기에 채택한 것으로 더 기억될 수 있다.

OMOP 프로젝트가 FDA의 능동 감시에 도움을 줄 숭 있는 관찰론적 연구를 완료하고 종료된 이후, 사람들은 OMOP 여정의 끝이, 새로운 여정의 시작이 되어야 된다고 생각했다. OMOP의 방법론적 연구가 관찰 데이터에서 생성되는 근거의 품질을 명시적으로 개선할 수 있는 과학적 모범 사례에 대한 가시적 통찰력을 제공함에도 불구하고, 그러한 모범 사례의 채택은 느렸다. 몇 가지 장애물들이 있었는데, 1) 방법론적의 혁신 이전에 관찰형 데이터 품질에 대한 근본적인 우려 2) 방법론적 문제와 해결책에 대한 불충분한 개념적 이해 3) 개별 데이터 파트너의 로컬 환경 내에서 솔루션을 독립적으로 구현할 수 없다는 점 4) 이러한 접근방식이 그들의 관심 임상 문제에 적용 가능한지에 대한 불확실성 등이었다. 이러한 모든 장애물에 대한 하나의 공통된 실마리는 한 사람만이 스스로 변화를 만드는 데 필요한 모든 것을 가지고 있지는 않지만, 여러 사람이 협력하면 이러한 문제들을 극복할 수 있다는 것이었다. 

- 기초 데이터 품질에 대한 신뢰도를 높이며 구조, 콘텐츠 및 의미론의 일관성을 촉진하여 표준화된 분석이 가능하도록 개방형 커뮤니티(open community)의 데이터 구조, 어휘 및 추출 변환 적재(Extract-Transform-Load, ETL)의 표준 규약 구축을 위한 협업
- 약물 안전성 연구 외에도 clinical characterization, population-level effect estimation, patient-level prediction을 위한 보다 광범위한 모범 사례(best practice)를 확립하기 위한 협업. 방법론적 연구를 통해 입증된 과학적 모범 사례 구현을 코드화하고 연구자들이 쉽게 채택할 수 있는 오픈 소스 분석 소프트웨어 개발에 대한 협업
- 데이터에서 근거로의 여정을 인도해줄, 주요한 보건 문제에 대한 공동체  공통의 질문에 대한 임상적 적용에 대한 협업

이러한 통찰을 통해, 오딧세이 (OHDSI)가 태어났다. 


## 개방형 협업 공동체로서의 오딧세이 (OHDSI as an Open-Science Collaborative)

OHDSI(Observational Health data Sciences and Informatics, 오딧세이) 는 보다 더 나은 의료 결정과 더 나은 보건 관리를 촉진할 수 있는 과학적 근거를 공동으로 생성하도록 함으로써 보건 수준을 향상시키는 것을 목표로 하는 개방형 과학 공동체다. [@Hripcsak2015] OHDSI는 관찰 건강 데이터의 적절한 사용에 대한 과학적 모범 사례를 확립하기 위한 방법론적 연구를 수행하고, 이러한 연구방법론을 일관되고 투명하며 재현 가능한 솔루션으로 코드화하는 오픈 소스 분석 소프트웨어를 개발하여, 보건의료 정책 및 환자 치료에 도움이 될 수 있는 임상적 근거를 마련하는 데에 적용할 수 있도록 노력한다. 

### OHDSI의 사명 (Our Mission)

참여 공동체의 상호협력 하에 의료 발전을 촉진하는 근거를 생성하는 능력을 부여한다.

> To improve health by empowering a community to collaboratively generate the evidence that promotes better health decisions and better care. \index{mission}

### OHDSI의 이상 (Our Vision)

의료 빅데이터의 분석을 통해 세계에 건강과 질병에 대한 포괄적인 이해를 제공한다.

> A world in which observational research produces a comprehensive understanding of health and disease. \index{vision}

### OHDSI의 핵심 가치 (Our Objectives)

* **혁신성 Innovation**: 우리는 적극적으로 의료 빅데이터 분석 및 연구에 대한 혁신적인 방법론과 접근법을 찾고 격려한다.

> Observational research is a field which will benefit greatly from disruptive thinking. We actively seek and encourage fresh methodological approaches in our work.

* **재현성 Reproducibility**: 우리는 보건 증진을 위하여 정확하고, 재현 가능하며, 잘 보정된 근거를 찾도록 노력한다.

> Accurate, reproducible, and well-calibrated evidence is necessary for health improvement.

* **공동체 정신 Community**: 우리는 모든 참여자들을 환영하며 동등하게 우리의 활동에 참여할 수 있도록 돕는다.

> Everyone is welcome to actively participate in OHDSI, whether you are a patient, a health professional, a researcher, or someone who simply believes in our cause.

* **개방성 Openness**: 우리는 의사 결정 과정의 투명성을 지향하며, 우리의 진보 및 우리가 생성한 방법론, 소프트웨어, 근거를 가능한 공개적으로 접근 가능하게 한다.

> We strive to make all our community’s proceeds open and publicly accessible, including the methods, tools and the evidence that we generate.

* **협력 정신 Collaboration**: 우리는 참여자들의 실제적 요구를 우선적으로 다루고, 그것을 위해 공동으로 노력한다.

> We work collectively to prioritize and address the real world needs of our community’s participants.

* **선행의 정신 Beneficence**: 우리는 고통 받는 환자를 비롯하여 참여자 및 참여기관의 권리를 보호하기 위해 노력한다.

> We seek to protect the rights of individuals and organizations within our community at all times.

\index{objectives}

## 오딧세이의 진척 (OHDSI's Progress)

OHDSI는 2014년 설립된 이래 성장을 지속하여 컴퓨터 과학, 역학, 통계, 생물 의학 정보학, 보건 정책 및 임상 의학 등 다양한 분야를 대표하는 학계, 의료 제품 산업, 규제 기관, 정부, 보험자, 기술 제공자, 의료 시스템, 임상의사 및 환자 집단 2,500명 이상의 다양한 이해관계자이 온라인 포럼에서 활동하고 있다. OHDSI 협력체로써 자발적으로 보고한 기관 및 데이터베이스의 리스트는 OHDSI 웹사이트에서 확인할 수 있다. [^collaboratorUrl] 오딧세이 협력 지도 (Figure \@ref(fig:collaboratormap)) 는 폭넓은 국제 공동체로써의 다양성을 상기시킨다.

[^collaboratorUrl]: https://www.ohdsi.org/who-we-are/collaborators/

<div class="figure" style="text-align: center">
<img src="images/OhdsiCommunity/mapOfCollaborators.png" alt="2019년 8월 현재 OHDSI 협력자 지도" width="100%" />
<p class="caption">(\#fig:collaboratormap)2019년 8월 현재 OHDSI 협력자 지도</p>
</div>
 OHDSI는 OMOP-CDM이라는 개방형 공동체 데이터 표준 기반으로 2019년 8월 기준으로 20여개국, 100개 이상의 의료 데이터베이스들로 구성된 분산형 연구망(distributed research network, DRN)을 구축했다. 분산형 연구망이란 환자 수준의 데이터를 개인이나 조직 간에 공유할 필요가 없다는 것을 의미한다. 분산연구망에서는, 데이터를 기관 폐쇄망 안에 두고 연구자는 프로토콜 형태의 분석코드/프로그램을 공유한다. 데이터 파트너들은 연구자의 요청에 따라 기관 안에서 연구 프로토콜을 실행해 자동으로 생성되는 요약 집합정보(평균, 합, 표준편차, 오즈비, 위험도 등)만 연구자에게 회신하는 방식으로, 연구자는 폐쇄망 안에 있는 환자의 개별 정보를 보거나 취득하지 않는다. OHDSI 분산망에서 각 데이터 파트너는 환자 수준 데이터의 사용에 대한 완전한 자율성을 유지하고, 각 기관의 데이터 거버넌스 정책을 지속적으로 준수한다. 

OHDSI 개발자 커뮤니티는 3가지의 사용 사례를 지원하기 위해 OMOP CDM 위에 다음 3가지의 강력한 오픈 소스 분석 소프트웨어 라이브러리를 구축하였는데 이는 다음과 같다. 1) Clinical characterization: 질병의 자연 경과, 치료 행태 및 질 향상을 위한 임상 특성 분석 2) Population-level effect estimation: 의약품 안전성 감시 및 비교 효과 연구에서의 인과성 분석 3) Patient-level prediction: 머신러닝 알고리즘을 활용한 정밀 의학 또는 의료 개입. OHDSI 개발자들은 또한 OMOP CDM의 채택, 데이터 품질 평가, OHDSI 네트워크 연구의 촉진을 지원하는 애플리케이션을 개발했다. 이러한 소프트웨어에는 R과 Python에 내장된 백엔드 통계 패키지 및 HTML과 Javascript로 개발된 프론트엔드 웹 어플리케이션이 포함된다. 모든 OHDSI 소프트웨어들은 오픈 소스 정책을 채택하여 Github을 통해 공개된다. [^GitUrl]

[^GitUrl]: https://github.com/OHDSI

오픈 소스 소프트웨어들과 함께, OHDSI의 개방형 과학 공동체적 접근은 관찰형 연구의 발전을 가능하게 했다. 첫번째 OHDSI 네트워크 연구는 당뇨, 우울증, 고혈압의 3가지 만성 질병에 대한 치료 패턴을 분석하는 것이었다. PNAS(Proceedings of the National Academy of Science) 에 출판된 연구는, 그 때까지 수행된 최대 규모의 관찰형 연구로써 11개의 데이터베이스에서 2억 5천만명의 환자 데이터를 이용하여 이전에 보고된 적 없는 치료 패턴의 지역적 차이 및 환자별 치료선택에 대한 이질성에 대해 발표하였다. [@Hripcsak7329] OHDSI는 교란변수를 통제하는 새로운 통계적 방법론을 제시하였고, [@tian_2018] 인과성 검증 능력에 대해 검증하였고, [@schuemie_2018] 이러한 방법론을 뇌전증 약제의 개별 안전성 연구 [@duke_2017] 및 당뇨병의 이차 약제의 비교 효과 연구 [@vashisht_2018] 및 우울증 치료의 대규모 비교 효과 연구 [@schuemie_2018b]에 활용하였다. OHDSI 공동체는 또한 관찰형 보건의료 데이터의 머신러닝 알고리즘을 활용 프레임 워크를 구축 [@reps2018] 하여 다양한 치료 분야에 활용하였다. [@johnston_2019; @cepeda_2018; @reps_2019]

## Collaborating in OHDSI

OHDSI는 근거를 생성하기 위해 협업을 강화하는 것을 목표로 하는 공동체인데, OHDSI 참가자가 된다는 것은 무엇을 의미하는가? 만약 당신이 OHDSI의 사명을 믿고 데이터에서 근거에 이르는 여정의 어디든지 기여를 하는 데 관심이 있다면, OHDSI는 당신을 위한 공동체가 될 수 있다. OHDSI 참가자는 보건 의료 데이터에 접근이 가능하고, 이를 활용해 의학적 근거를 생성하고 싶은 개인일 수 있다. OHDSI 참가자는 과학적 모범 사례를 수립하고 대안적 접근법을 평가하는 데 관심이 있는 방법론 연구자일 수 있다. OHDSI 참가자는 OHDSI의 타 연구자들이 사용할 수 있는 도구를 만들기 위해 프로그래밍 기술을 적용하는 데 관심이 있는 소프트웨어 개발자일 수 있다. OHDSI 참가자는 중요한 의학보건학적 질문을 가지고 있고 논문 발표 등을 통해 그러한 질문들에 대한 근거를 보다 더 큰 의료 커뮤니티에 제공하고자 하는 임상 연구자일 수 있다. OHDSI 참가자는 공공 보건을 위해 이러한 공통적인 사명과 가치를 믿고 해당 지역의 공동체가 OHDSI 관련 교육과 심포지엄 개최를 포함하여, 그 임무를 지속할 수 있도록 자원을 제공하는 개인 또는 단체일 수도 있다. 당신의 배경이나 소속과 관계없이, OHDSI는 개개인이 공통의 목적을 위해 함께 일할 수 있는 공동체가 되기를 추구하고 있으며, 각 개인이 공동으로 의료 서비스를 발전시킬 수 있는 기여를 하고 있다. 이 여정에 함께하고 싶다면, \@ref(WhereToBegin)장("Where To Begin")을 통해 어떻게 시작하는 지 배울 수 있다.

## 한국 오딧세이의 역사
아주대학교 박래웅 교수가 아주대 병원의 전자의무기록을 이용하여 2014년 OMOP-CDM 도입을 시작하였고, 2015년 첫 연례 심포지엄에서 활용 결과를 발표하면서 한국의 OHDSI 참여가 시작되었다. 이후 계속적으로 한국에서 OMOP-CDM, OHDSI 전파를 위해 노력하였고, 2016년부터는 최초로 국제 OHDSI committee에서 개별 국가를 위한 포럼 [Korean chapter](http://forums.ohdsi.org/c/For-collaborators-wishing-to-communicate-in-Korean)을 개설하고, 한국의 OHDSI 참여를 독려하였다.
첫 한국 국제 오딧세이 심포지엄은 2017년 3월 아주대학교에서 튜토리얼, 리더십 미팅을 포함하여 3일간 개최되었다.

<div class="figure">
<img src="images/OhdsiCommunity/DSC01956.png" alt="2017년 한국에서의 OHDSI 국제 심포지엄" width="80%" />
<p class="caption">(\#fig:OHDSIInternationalSymposium2017inKorea1)2017년 한국에서의 OHDSI 국제 심포지엄</p>
</div><div class="figure">
<img src="images/OhdsiCommunity/DSC01861.png" alt="2017년 한국에서의 OHDSI 국제 심포지엄" width="80%" />
<p class="caption">(\#fig:OHDSIInternationalSymposium2017inKorea1)2017년 한국에서의 OHDSI 국제 심포지엄</p>
</div>

<div class="figure">
<img src="images/OhdsiCommunity/DSC02166.png" alt="2017년 한국에서의 OHDSI 국제 심포지엄 튜토리얼" width="80%" />
<p class="caption">(\#fig:OHDSIInternationalSymposium2017inKorea2)2017년 한국에서의 OHDSI 국제 심포지엄 튜토리얼</p>
</div>
한국 OHDSI 네트워크에 참여를 희망하는 병원 관계자들과 함께 2017년 3월 7일 첫번째 리더십 미팅을 가진 후 현재까지 2달마다 전국의 의과대학/병원을 순회하며 한국 OHDSI 리더십 미팅을 개최하며 OHDSI 전파 및 상호 협력을 꾀하고 있다.

## 요약

\BeginKnitrBlock{rmdsummary}<div class="rmdsummary">- OHDSI의 사명은 참여 공동체의 상호협력 하에 의료 발전을 촉진하는 근거를 생성하는 능력을 부여하는 것이다. 

- OHDSI의 이상은 혁신성, 재현성, 공동체 정신, 개방성, 협력 정신, 선행의 정신을 바탕으로 의료 빅데이터의 분석을 통해 세계에 건강과 질병에 대한 포괄적인 이해를 제공하는 것이다. 

- OHDSI 참가자들은 개방형 공동체로서의 데이터 표준, 방법론 연구, 오픈소스 분석 소프트웨어 개발 및 임상적 적용을 통해 데이터로부터 근거로의 여정을 발전시키고자 노력한다.
</div>\EndKnitrBlock{rmdsummary}

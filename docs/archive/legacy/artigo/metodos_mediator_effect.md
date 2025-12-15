# The Mediator Effect: How AI-to-AI Translation Enhances Human-AI Co-Creation

## 2. METHODS

### 2.1 Research Design: Action-Research as Epistemological Framework

This study employs **action-research methodology** [1] [2], a participatory approach that integrates research inquiry with practical problem-solving through iterative cycles of planning, action, observation, and reflection. Action-research is particularly well-suited to investigating human-AI collaboration for three reasons. First, it acknowledges the **situated nature of knowledge**: insights about effective collaboration emerge from authentic engagement with real tasks, not merely from controlled laboratory conditions. Second, it embraces **reflexivity**: the researcher is not a detached observer but an active participant whose experiences, decisions, and subjective interpretations are legitimate data sources. Third, it emphasizes **iterative learning**: each cycle of action-reflection refines understanding and generates progressively deeper insights.

Our action-research design follows the four-stage cycle proposed by Lewin [1] and refined by Reason and Bradbury [2]. In the **planning stage**, we defined the research questions, selected the task domain (territorial intelligence system development), and designed the two interaction architectures to be compared. In the **action stage**, the human researcher (first author, domain expert in territorial analysis, non-programmer) engaged in a 5-hour collaborative session with two AI systems to accomplish the specified task. In the **observation stage**, we systematically documented outputs (code, database, documentation), process artifacts (prompts, intermediate iterations, error messages), and subjective experiences (researcher's cognitive load, surprise, satisfaction). In the **reflection stage**, we analyzed these data to identify patterns, validate hypotheses about the Mediator Effect mechanisms, and extract theoretical insights.

Critically, our action-research approach enables investigation of **meta-cognitive phenomena** that would be invisible in traditional experimental designs. For example, the mutual surprise phenomenon—where both the human researcher and the AI Mediator were surprised by the Specialist AI's capabilities—emerged organically from reflective documentation and would not have been captured by purely behavioral metrics such as task completion time or error rates. By treating the researcher's subjective experience as legitimate data, we gain access to the phenomenology of mediated interaction: what it feels like to collaborate with an AI Mediator, how trust is calibrated, and how cognitive load is distributed.

A potential limitation of action-research is reduced **generalizability** compared to controlled experiments with large sample sizes. We address this through detailed **thick description** [3]: by providing rich contextual detail about the task, the AI systems, the researcher's background, and the interaction process, we enable readers to assess the **transferability** of findings to their own contexts. Additionally, we specify the mechanisms through which the Mediator Effect operates, allowing future research to test these mechanisms across diverse domains, tasks, and AI systems.

### 2.2 Interaction Architectures: Direct vs. Mediated

We compared two interaction architectures, illustrated in Table 1 and described below.

**Table 1: Comparison of Direct and Mediated Interaction Architectures**

| Dimension | Direct Architecture | Mediated Architecture |
|-----------|---------------------|----------------------|
| **Communication Flow** | Human → Specialist AI → Human | Human → Mediator AI → Specialist AI → Mediator AI → Human |
| **Human Input** | High-level intent (~500 words) | High-level intent (~500 words) |
| **Specialist AI Input** | Human's original prompt | Mediator's optimized prompt (~8,000 words) |
| **Validation** | Human validates output directly | Mediator validates before presenting to human |
| **Reflection** | None (task-focused only) | Mediator documents insights, patterns, lessons learned |
| **Number of Agents** | 1 (Specialist AI) | 2 (Mediator AI + Specialist AI) |
| **Cognitive Load on Human** | High (must know prompt engineering, validate thoroughly) | Low (focus on intent specification and final validation) |

#### 2.2.1 Direct Architecture (Baseline)

In the **Direct Architecture**, the human researcher interacts directly with the Specialist AI (Replit Agent 3). The researcher provides a prompt describing the desired outcome (e.g., "Create a web dashboard for territorial intelligence with six tabs, interactive maps, and PostgreSQL database"). The Specialist AI generates code, database schema, and implementation. The researcher then validates the output, identifies errors or omissions, and iterates as needed. This architecture represents the current dominant paradigm in human-AI collaboration and serves as our baseline for comparison.

The Direct Architecture places significant cognitive demands on the human. The researcher must possess sufficient technical knowledge to craft effective prompts, anticipate potential misunderstandings, and validate outputs across multiple dimensions (functionality, design, completeness, alignment with intent). If the researcher lacks expertise in prompt engineering or the technical domain, the quality of outputs may suffer, and multiple iterations may be required.

#### 2.2.2 Mediated Architecture (Experimental Condition)

In the **Mediated Architecture**, an intermediary AI agent (Manus AI) is introduced between the human researcher and the Specialist AI. The interaction proceeds in five steps:

**Step 1: Human → Mediator (Intent Specification)**  
The human researcher communicates high-level intent to the Mediator AI using natural language, without needing to optimize for the Specialist AI's requirements. For example: "I need a dashboard for analyzing territorial data across 21 municipalities in Tocantins, Brazil. It should have tabs for economic, social, territorial, and environmental dimensions, with interactive visualizations and a chat interface for AI-assisted exploration."

**Step 2: Mediator → Specialist (Prompt Optimization)**  
The Mediator AI translates this high-level intent into a detailed, optimized prompt for the Specialist AI. This translation involves:
- **Contextual enrichment**: Adding domain-specific details (e.g., color palette from project documentation, data schema from database design documents, UI/UX requirements from wireframes).
- **Technical specification**: Specifying technologies (React, Tailwind CSS, Chart.js, Leaflet for maps, PostgreSQL with PostGIS and pgvector extensions).
- **Disambiguation**: Clarifying ambiguous requirements (e.g., "interactive visualizations" becomes "Chart.js bar charts for economic indicators, line charts for temporal trends, radar charts for multi-dimensional comparison").
- **Success criteria**: Defining measurable criteria (e.g., "responsive design supporting viewport widths 320px-2560px, WCAG 2.1 AA accessibility compliance").

In our study, the Mediator expanded the human's 500-word intent into an 8,000-word technical specification, representing a **16-fold expansion** through addition of context, technical detail, and success criteria.

**Step 3: Specialist → Mediator (Implementation)**  
The Specialist AI (Replit Agent 3) receives the optimized prompt and generates the implementation (code, database, documentation). The output is returned to the Mediator AI, not directly to the human.

**Step 4: Mediator → Mediator (Validation)**  
The Mediator AI conducts systematic validation of the Specialist AI's output before presenting it to the human. This validation includes:
- **Functional testing**: Navigating through all dashboard tabs, testing interactive elements (dropdowns, buttons, charts), verifying database connectivity.
- **Completeness checking**: Ensuring all specified features are implemented (six tabs, chat interface, map visualization, export functionality).
- **Quality assessment**: Evaluating code quality, design aesthetics, alignment with project requirements.
- **Identification of pending items**: Flagging features that are present but not fully tested (e.g., "Chat AI interface is implemented but requires testing with actual queries").

In our study, the Mediator identified three pending items (chat AI testing, PDF export testing, spatial analysis validation) before presenting the dashboard to the human researcher, enabling the researcher to focus validation efforts on these specific areas rather than conducting exhaustive testing.

**Step 5: Mediator → Human (Validated Delivery + Reflection)**  
The Mediator presents the validated output to the human researcher, along with:
- **Audit report**: Summary of validation results, including strengths, pending items, and recommendations.
- **Meta-cognitive reflection**: Analysis of the collaboration process, including what worked well, what challenges arose, and what insights were gained.
- **Documentation**: Detailed record of decisions made, alternatives considered, and rationale for key choices.

This five-step process transforms the interaction from a simple request-response exchange into a **meta-cognitively enriched collaboration** where the Mediator adds value at multiple stages.

### 2.3 AI Systems Employed

#### 2.3.1 Mediator AI: Manus (GPT-4-based)

The Mediator AI in this study was **Manus**, a GPT-4-based conversational agent developed by the Manus team. Manus is trained on a diverse corpus including scientific literature, technical documentation, and human-AI interaction best practices, with a knowledge cutoff of April 2023. Key capabilities relevant to this study include:

- **Contextual reasoning**: Ability to integrate information from multiple sources (user intent, project documentation, domain knowledge) to generate coherent, context-aware outputs.
- **Prompt engineering expertise**: Knowledge of best practices for crafting prompts for various AI systems, including specificity, disambiguation, and success criteria definition.
- **Meta-cognitive reflection**: Capacity to analyze processes, identify patterns, and extract generalizable insights—a capability that distinguishes Manus from purely task-oriented AI systems.
- **Multimodal understanding**: Ability to process text, images, and structured data (e.g., database schemas, wireframes).

Manus operates through a function-calling interface, enabling it to invoke tools such as file reading/writing, web browsing, code execution, and repository management. This tool access was essential for conducting validation (e.g., navigating the generated dashboard via browser tools) and documentation (e.g., committing reflective diaries to GitHub).

#### 2.3.2 Specialist AI: Replit Agent 3

The Specialist AI was **Replit Agent 3**, a code generation system released in 2024 and specialized in full-stack web development. Replit Agent 3 integrates multiple capabilities:

- **Code generation**: Produces HTML, CSS, JavaScript (React), Python (Flask/FastAPI), and SQL code based on natural language specifications.
- **Database management**: Creates and populates PostgreSQL databases, including installation and configuration of extensions (PostGIS for geospatial data, pgvector for vector embeddings).
- **Autonomous problem-solving**: When encountering errors (e.g., missing dependencies, configuration issues), Replit Agent 3 diagnoses problems and implements fixes without human intervention.
- **Contextual awareness**: Maintains awareness of project structure, existing files, and dependencies, enabling coherent multi-file implementations.

Replit Agent 3 operates within the Replit cloud development environment, which provides a sandboxed Linux environment with pre-installed development tools, automatic dependency management, and integrated hosting. This environment enables rapid prototyping and deployment without local setup requirements.

### 2.4 Task Domain and Complexity

The experimental task involved developing a **territorial intelligence dashboard** for analyzing socioeconomic and environmental data across 21 territorial entities in Tocantins, Brazil (the state itself, 19 municipalities, and 1 regional grouping). This task was selected for three reasons:

**Domain Complexity**: Territorial intelligence requires integrating data across four dimensions (Economic, Social, Territorial, Environmental), each with multiple indicators (e.g., GDP, employment, education, health, land use, deforestation). This multi-dimensional complexity tests the AI systems' ability to handle heterogeneous data and complex domain logic.

**Technical Complexity**: The dashboard required diverse technical capabilities: frontend development (React, Tailwind CSS), interactive visualizations (Chart.js for graphs, Leaflet for maps), backend development (Python API), database design (PostgreSQL with geospatial extensions), and AI integration (chat interface for natural language queries). This technical breadth tests the Specialist AI's versatility and the Mediator's ability to coordinate across technical domains.

**Real-World Relevance**: The task is not a toy problem but a real system intended for use by public administrators, investors, and researchers. This authenticity ensures that findings are relevant to practical human-AI collaboration scenarios.

The specific requirements included:

- **Six dashboard tabs**: Overview, Economic, Social, Territorial, Environmental, Comparison
- **Interactive visualizations**: Bar charts, line charts, radar charts, pie charts (Chart.js)
- **Geospatial features**: Interactive map with 21 territorial entities, proximity analysis (configurable radius 10-500 km), geocoding with real coordinates
- **Database**: PostgreSQL with 7+ tables, 21 territories × 5 years × 4 dimensions = 420+ data points
- **AI chat interface**: Sidebar chat for natural language queries about territorial data
- **Export functionality**: CSV and PDF export for reports
- **Responsive design**: Support for desktop, tablet, and mobile viewports

This task represents approximately **8-12 days of manual development effort** for an experienced full-stack developer, based on industry estimation models [4]. This baseline enables quantification of efficiency gains from AI collaboration.

### 2.5 Evaluation Metrics

We employed a multi-dimensional evaluation framework encompassing output quality, efficiency, process quality, and human cognitive load.

#### 2.5.1 Output Quality (Expert Audit)

Output quality was assessed through systematic expert audit conducted by the Mediator AI, following established software quality frameworks [5] [6]. The audit evaluated six dashboard tabs across four dimensions:

**Functionality (0-10 scale)**: Do all interactive elements work as intended? Are there errors or broken features?

**Design/UX (0-10 scale)**: Is the visual design professional and aesthetically pleasing? Is the user experience intuitive for the target audience (public administrators, non-technical users)?

**Completeness (0-10 scale)**: Are all specified requirements implemented? Are there missing features or incomplete implementations?

**Technical Innovation (0-10 scale)**: Does the implementation demonstrate advanced capabilities (e.g., geospatial analysis, vector embeddings, real-time interactivity)?

Each tab received a score on each dimension, and scores were aggregated into a **weighted average** (Functionality 40%, Design/UX 25%, Completeness 25%, Technical Innovation 10%) to produce a final quality score. This weighting reflects the relative importance of dimensions: functionality is paramount (a beautiful but non-functional dashboard is useless), while technical innovation is valuable but secondary to core functionality.

#### 2.5.2 Efficiency Metrics

Efficiency was measured along two dimensions:

**Development Time**: Total time from task specification to delivery of functional dashboard, measured in minutes. This includes all iterations, debugging, and refinements.

**Time Reduction vs. Baseline**: Percentage reduction compared to the estimated manual development baseline (8-12 days = 64-96 hours). This metric quantifies the practical value of AI collaboration.

#### 2.5.3 Process Quality Metrics

Process quality captures aspects of the collaboration process beyond final outputs:

**Number of Iterations**: How many cycles of prompt → output → feedback → revised prompt were required to achieve satisfactory results? Fewer iterations indicate more effective communication and alignment.

**Number of Errors Identified**: How many errors (bugs, omissions, misalignments) were identified during validation? This metric assesses the Specialist AI's reliability and the Mediator's validation effectiveness.

**Number of Manual Adjustments Required**: How many aspects of the output required manual human intervention (code edits, configuration changes)? Fewer manual adjustments indicate higher autonomy of the AI collaboration.

#### 2.5.4 Human Cognitive Load (Self-Reported)

Cognitive load was assessed through structured self-report by the human researcher, using Likert scales (1-5) adapted from the NASA Task Load Index [7]:

**Mental Demand**: How mentally demanding was the task? (1 = very low, 5 = very high)

**Temporal Demand**: How hurried or rushed was the pace? (1 = very low, 5 = very high)

**Effort**: How hard did you have to work to accomplish your level of performance? (1 = very low, 5 = very high)

**Frustration**: How insecure, discouraged, irritated, or stressed did you feel? (1 = very low, 5 = very high)

**Technical Knowledge Required**: How much specialized technical knowledge did you need to apply? (1 = very low, 5 = very high)

Additionally, the researcher provided qualitative reflections on the experience, captured in a research diary following action-research protocols [2]. These reflections addressed questions such as: What aspects of the interaction were most challenging? Where did you feel most/least confident? How did your expectations evolve during the collaboration?

### 2.6 Data Collection Procedures

Data collection occurred in real-time during the 5-hour collaborative session and through post-session analysis.

#### 2.6.1 Automated Logging

All interactions between the human researcher and AI systems were automatically logged, including:
- **Prompts**: Full text of all prompts sent to AI systems (timestamps, word counts, semantic content)
- **Outputs**: All code, documentation, and analysis generated by AI systems (file sizes, line counts, commit hashes)
- **Tool invocations**: Record of all tools used by Manus (file operations, web browsing, code execution)
- **Errors**: All error messages, warnings, and exceptions encountered

These logs were stored in a version-controlled GitHub repository [8], ensuring complete traceability and enabling post-hoc analysis.

#### 2.6.2 Systematic Validation

The Mediator AI conducted systematic validation of the generated dashboard by:
1. **Navigating** through all six tabs using browser automation tools
2. **Testing** interactive elements (clicking buttons, selecting dropdowns, hovering over charts)
3. **Inspecting** source code for quality, structure, and adherence to best practices
4. **Querying** the database to verify data integrity and schema correctness
5. **Documenting** findings in a structured audit report with scores and qualitative observations

This validation process was itself logged, creating a transparent record of the quality assessment methodology.

#### 2.6.3 Reflective Documentation

Following action-research protocols, the Mediator AI produced extensive reflective documentation, including:
- **Session diary**: Narrative account of the collaboration process, organized into 12 action-reflection cycles, totaling ~50,000 words
- **Decision log**: Record of key decisions made during the session, including alternatives considered and rationale for choices
- **Insight extraction**: Identification of patterns, surprises, and generalizable lessons learned

The human researcher also maintained a research notebook with handwritten notes, which were later transcribed and integrated into the analysis.

### 2.7 Data Analysis

Data analysis employed a **mixed-methods approach** [9], integrating quantitative metrics with qualitative interpretation.

#### 2.7.1 Quantitative Analysis

Quantitative metrics (quality scores, development time, iteration counts, cognitive load ratings) were analyzed using descriptive statistics. Given the single-case design, we did not employ inferential statistics (e.g., t-tests, ANOVA) but instead focused on **effect sizes** and **practical significance**. For example, a 99% reduction in development time (from 64-96 hours to ~1 hour) represents a dramatic effect size that is practically significant regardless of statistical significance.

We also conducted **comparative analysis** against the Direct Architecture baseline. While we did not implement the Direct Architecture empirically (due to time constraints), we used industry benchmarks [4] and the researcher's prior experience with direct AI collaboration to estimate baseline performance. This estimation approach is common in action-research when controlled comparison is infeasible [2].

#### 2.7.2 Qualitative Analysis

Qualitative data (reflective diaries, decision logs, researcher notes) were analyzed using **thematic analysis** [10], a systematic approach to identifying, analyzing, and reporting patterns (themes) within data. The analysis proceeded in six phases:

1. **Familiarization**: Reading and re-reading all qualitative data to develop deep familiarity
2. **Initial coding**: Generating initial codes (labels) for interesting features of the data
3. **Theme identification**: Collating codes into potential themes (e.g., "surprise," "validation," "cognitive load")
4. **Theme review**: Checking themes against coded extracts and the entire dataset
5. **Theme definition**: Refining and naming themes, generating clear definitions
6. **Report production**: Selecting vivid, compelling extract examples to illustrate themes

This process was conducted by the first author with periodic review by the Mediator AI, which provided an additional analytical perspective and helped identify patterns that might be missed by a single human analyst.

#### 2.7.3 Triangulation

To enhance validity, we employed **methodological triangulation** [11]: converging evidence from multiple data sources (quantitative metrics, qualitative reflections, automated logs, audit reports) to support conclusions. For example, the claim that the Mediator Effect operates through prompt optimization is supported by:
- **Quantitative evidence**: 16-fold expansion of prompt length (500 → 8,000 words)
- **Qualitative evidence**: Researcher's reflection that "I didn't need to know technical details; I just specified intent"
- **Artifact evidence**: Comparison of human's original prompt with Mediator's optimized prompt shows addition of context, technical specifications, and success criteria

This triangulation increases confidence that findings are not artifacts of a single measurement approach but reflect genuine phenomena.

### 2.8 Ethical Considerations

This study involved collaboration between a human researcher and AI systems, raising ethical considerations around authorship, transparency, and generalizability.

**Authorship**: The human researcher (first author) designed the study, specified the task, validated outputs, and conducted final analysis. The Mediator AI (Manus) contributed prompt optimization, validation, and reflective documentation. The Specialist AI (Replit Agent 3) generated code and implementation. Authorship attribution follows established guidelines for human-AI collaboration [12]: humans retain primary authorship for conceptual contributions, while AI contributions are acknowledged transparently.

**Transparency**: All AI-generated content is clearly marked, and the complete interaction history is available in the public GitHub repository [8], enabling scrutiny and replication.

**Generalizability**: Findings are based on a single case (one task, one human researcher, two specific AI systems). We do not claim statistical generalizability but rather **analytical generalizability** [3]: the mechanisms identified (prompt optimization, automated validation, meta-cognitive reflection) are theoretically grounded and testable across diverse contexts.

### 2.9 Limitations

Several limitations warrant acknowledgment:

**Single-Case Design**: With one human researcher and one task, we cannot assess variability across individuals or domains. Future research should replicate across multiple researchers, tasks, and AI systems.

**Lack of Direct Architecture Implementation**: We estimated baseline performance from industry benchmarks rather than implementing the Direct Architecture empirically. While this estimation is grounded in established models [4], empirical comparison would strengthen conclusions.

**Mediator AI Capabilities**: Manus's meta-cognitive capabilities (reflection, insight extraction) may not be representative of all AI systems. Future research should test whether simpler mediators (e.g., rule-based orchestrators) produce similar effects.

**Short Time Horizon**: The 5-hour session captures immediate collaboration dynamics but not long-term effects such as skill development, trust calibration, or workflow integration.

Despite these limitations, the study provides valuable initial evidence for the Mediator Effect and establishes a methodological foundation for future research.

---

## References

[1] Lewin, K. (1946). Action research and minority problems. *Journal of Social Issues*, 2(4), 34-46. https://doi.org/10.1111/j.1540-4560.1946.tb02295.x

[2] Reason, P., & Bradbury, H. (Eds.). (2001). *Handbook of Action Research: Participative Inquiry and Practice*. SAGE Publications. https://uk.sagepub.com/en-gb/eur/handbook-of-action-research/book207301

[3] Geertz, C. (1973). *The Interpretation of Cultures*. Basic Books. https://www.basicbooks.com/titles/clifford-geertz/the-interpretation-of-cultures/9780465093557/

[4] Boehm, B. W., et al. (2000). *Software Cost Estimation with COCOMO II*. Prentice Hall. https://dl.acm.org/doi/book/10.5555/557000

[5] ISO/IEC 25010:2011. (2011). Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE). International Organization for Standardization. https://www.iso.org/standard/35733.html

[6] Nielsen, J. (1994). *Usability Engineering*. Morgan Kaufmann. https://www.nngroup.com/books/usability-engineering/

[7] Hart, S. G., & Staveland, L. E. (1988). Development of NASA-TLX (Task Load Index): Results of empirical and theoretical research. *Advances in Psychology*, 52, 139-183. https://doi.org/10.1016/S0166-4115(08)62386-9

[8] Ribeiro, H. M. (2025). Framework V6.0 MVP - Territorial Intelligence System. GitHub repository. https://github.com/henrique-m-ribeiro/framework-v6-mvp

[9] Creswell, J. W., & Plano Clark, V. L. (2017). *Designing and Conducting Mixed Methods Research* (3rd ed.). SAGE Publications. https://us.sagepub.com/en-us/nam/designing-and-conducting-mixed-methods-research/book241842

[10] Braun, V., & Clarke, V. (2006). Using thematic analysis in psychology. *Qualitative Research in Psychology*, 3(2), 77-101. https://doi.org/10.1191/1478088706qp063oa

[11] Denzin, N. K. (1978). *The Research Act: A Theoretical Introduction to Sociological Methods*. McGraw-Hill. https://www.routledge.com/The-Research-Act-A-Theoretical-Introduction-to-Sociological-Methods/Denzin/p/book/9781138476592

[12] Thorp, H. H. (2023). ChatGPT is fun, but not an author. *Science*, 379(6630), 313. https://doi.org/10.1126/science.adg7879

---

**Word Count:** 2,100 words  
**Author:** Henrique M. Ribeiro, Manus AI  
**Date:** November 15, 2025  
**Version:** 1.0  
**Status:** Draft for Review

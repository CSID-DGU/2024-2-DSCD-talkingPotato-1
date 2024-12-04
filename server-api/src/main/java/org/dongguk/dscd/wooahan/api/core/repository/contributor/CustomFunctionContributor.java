package org.dongguk.dscd.wooahan.api.core.repository.contributor;

import org.hibernate.boot.model.FunctionContributions;
import org.hibernate.boot.model.FunctionContributor;
import org.hibernate.type.StandardBasicTypes;

public class CustomFunctionContributor implements FunctionContributor {

    private static final String ARTICLE_FULL_TEXT_SEARCH_FUNCTION_NAME = "article_full_text_search";
    private static final String ARTICLE_FULL_TEXT_SEARCH_FUNCTION_DEFINITION = "MATCH (?1, ?2) AGAINST (?3 IN NATURAL LANGUAGE MODE)";
    private static final String QUESTION_FULL_TEXT_SEARCH_FUNCTION_NAME = "question_full_text_search";
    private static final String QUESTION_FULL_TEXT_SEARCH_FUNCTION_DEFINITION = "MATCH (?1) AGAINST (?2 IN NATURAL LANGUAGE MODE)";


    @Override
    public void contributeFunctions(FunctionContributions functionContributions) {
        functionContributions
                .getFunctionRegistry()
                .registerPattern(
                        ARTICLE_FULL_TEXT_SEARCH_FUNCTION_NAME,
                        ARTICLE_FULL_TEXT_SEARCH_FUNCTION_DEFINITION,
                        functionContributions.getTypeConfiguration().getBasicTypeRegistry().resolve(StandardBasicTypes.DOUBLE)
                );

        functionContributions
                .getFunctionRegistry()
                .registerPattern(
                        QUESTION_FULL_TEXT_SEARCH_FUNCTION_NAME,
                        QUESTION_FULL_TEXT_SEARCH_FUNCTION_DEFINITION,
                        functionContributions.getTypeConfiguration().getBasicTypeRegistry().resolve(StandardBasicTypes.DOUBLE)
                );
    }
}
#include <gmock/gmock.h>
#include <facter/facts/external/text_resolver.hpp>
#include <facter/facts/collection.hpp>
#include <facter/facts/scalar_value.hpp>
#include "../../fixtures.hpp"

using namespace std;
using namespace facter::facts;
using namespace facter::facts::external;

TEST(facter_facts_external_text_resolver, default_constructor) {
    text_resolver resolver;
}

TEST(facter_facts_external_text_resolver, can_resolve) {
    text_resolver resolver;
    ASSERT_FALSE(resolver.can_resolve("foo.json"));
    ASSERT_TRUE(resolver.can_resolve("foo.txt"));
    ASSERT_TRUE(resolver.can_resolve("FoO.TxT"));
}

TEST(facter_facts_external_text_resolver, resolve_nonexistent_text) {
    text_resolver resolver;
    collection facts;
    ASSERT_THROW(resolver.resolve("doesnotexist.txt", facts), external_fact_exception);
}

TEST(facter_facts_external_text_resolver, resolve_text) {
    text_resolver resolver;
    collection facts;
    resolver.resolve(LIBFACTER_TESTS_DIRECTORY "/fixtures/facts/external/text/facts.txt", facts);
    ASSERT_TRUE(!facts.empty());
    ASSERT_NE(nullptr, facts.get<string_value>("txt_fact1"));
    ASSERT_EQ("value1", facts.get<string_value>("txt_fact1")->value());
    ASSERT_NE(nullptr, facts.get<string_value>("txt_fact2"));
    ASSERT_EQ("", facts.get<string_value>("txt_fact2")->value());
    ASSERT_EQ(nullptr, facts.get<string_value>("txt_fact3"));
    ASSERT_NE(nullptr, facts.get<string_value>("txt fact.4"));
    ASSERT_EQ(nullptr, facts.get<string_value>("TXT Fact.4"));
    ASSERT_EQ("value2", facts.get<string_value>("txt fact.4")->value());
}

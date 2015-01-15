#include <gmock/gmock.h>
#include <facter/facts/external/windows/powershell_resolver.hpp>
#include <facter/facts/collection.hpp>
#include <facter/facts/scalar_value.hpp>
#include <facter/util/string.hpp>
#include "../../../fixtures.hpp"

using namespace std;
using namespace facter::facts;
using namespace facter::util;
using namespace facter::facts::external;

TEST(facter_facts_external_windows_powershell_resolver, default_constructor) {
    powershell_resolver resolver;
}

TEST(facter_facts_external_windows_powershell_resolver, can_resolve) {
    powershell_resolver resolver;
    ASSERT_FALSE(resolver.can_resolve(LIBFACTER_TESTS_DIRECTORY "/fixtures/facts/external/windows/powershell/not_executable"));
    ASSERT_TRUE(resolver.can_resolve(LIBFACTER_TESTS_DIRECTORY "/fixtures/facts/external/windows/powershell/facts.ps1"));
}

TEST(facter_facts_external_windows_powershell_resolver, resolve_failed_execution) {
    powershell_resolver resolver;
    collection facts;
    ASSERT_THROW(resolver.resolve(LIBFACTER_TESTS_DIRECTORY "/fixtures/facts/external/windows/powershell/failed.ps1", facts), external_fact_exception);
}

TEST(facter_facts_external_windows_powershell_resolver, resolve_execution) {
    powershell_resolver resolver;
    collection facts;
    resolver.resolve(LIBFACTER_TESTS_DIRECTORY "/fixtures/facts/external/windows/powershell/facts.ps1", facts);
    ASSERT_TRUE(!facts.empty());
    ASSERT_NE(nullptr, facts.get<string_value>("ps1_fact1"));
    ASSERT_EQ("value1", facts.get<string_value>("ps1_fact1")->value());
    ASSERT_NE(nullptr, facts.get<string_value>("ps1_fact2"));
    ASSERT_EQ("", facts.get<string_value>("ps1_fact2")->value());
    ASSERT_EQ(nullptr, facts.get<string_value>("ps1_fact3"));
    ASSERT_NE(nullptr, facts.get<string_value>("ps1 fact.4"));
    ASSERT_EQ(nullptr, facts.get<string_value>("PS1 fact.4"));
    ASSERT_EQ("value2", facts.get<string_value>("ps1 fact.4")->value());
}

#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: sh referral_message.sh [options]

Generate a LinkedIn outreach message based on the current resume profile.

Options:
  -r, --recipient NAME        Name to greet in the message (optional)
  --company NAME              Company or hiring organization (optional)
  --role NAME                 Role being applied for (required when job link is present)
  --job-link URL              Job posting link (optional)
  -h, --help                  Show this help

Examples:
  sh referral_message.sh \
    --recipient "Tim" \
    --company "Google" \
    --role "Staff Software Engineer" \
    --job-link "https://google.com/jobs/staff-sde-remote/"
EOF
}

recipient=""
company=""
role=""
job_link=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -r|--recipient)
      recipient="${2:-}"
      shift 2
      ;;
    --company)
      company="${2:-}"
      shift 2
      ;;
    --role)
      role="${2:-}"
      shift 2
      ;;
    --job-link)
      job_link="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$recipient" ]]; then
  greeting="Hello,"
else
  greeting="Hi ${recipient},"
fi

job_section=""
invitation_line="I see that there are no public openings at ${company:-your company}. But if there are any openings on your company's intranet, would you be open to sharing my attached Resume and Cover Letter?"

if [[ -n "$job_link" ]]; then
  if [[ -z "$role" ]]; then
    echo "Role should not be empty when a job link is provided." >&2
    exit 1
  fi
  invitation_line="Would you be open to sharing my attached Resume and Cover Letter with the hiring team for the \"${role}\" role?"
  job_section="Job Link: ${job_link}"
fi

message_parts=(
  "$greeting"
  ""
  "I'm Parth, a Technical Team Lead with 5+ years of experience at VoerEir-AB, architecting AI and Telecom infrastructure benchmarking solutions for global clients such as Google, AWS, Red Hat, and Vodafone. Expert in AI-native Development, LangGraph, Django, Python, Linux, Docker and Kubernetes. Additionally, I often conduct interviews, mentor associates and engage with high value customers."
  ""
  "$invitation_line"
  ""
  "I believe my experience in backend engineering, technical leadership, cloud-native architecture, and AI-enabled product development would be valuable to ${company:-your organization}."
)

if [[ -n "$job_section" ]]; then
  message_parts+=("" "$job_section")
fi

message_parts+=(
  ""
  "I am looking forward to working with you. But In any case, Thank you so much, I know It was a long message😅, PFA."
)

message=$(printf '%s\n' "${message_parts[@]}")

printf '%s\n' "$message"
